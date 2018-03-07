#include "uni_ext.h"
#include <stdio.h>
#include <math.h>
#include <float.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "bcp.h"
#include "controls.h"
#include "movie.h"
#include "make_system.h"
#include "cluster.h"
#include "search.h"
#include "corr_func.h" 
#include "rms.h"
#include "bonds.h"
//external variables------------------------------
const char *JAVA_FILENAME;
const char *SAVE_FILENAME;

extern long coll_type,p1,ct1,q1;
extern double  corr_2,timea,timeb,corr,timec,timed;
extern char *text_name;
extern int is_open,m_is_open;
extern FILE *echo_path,*movie_path,*text_path;
extern atom *a;
//protypes
void doParameterValueUpdate();
//-----------------------------------------------------------------
//nothing to do when binding/closing
void bindDLL(){}
void unbindDLL(){}
//change---------------------------------------------------------
#define FALSE 0
#define TRUE 1
//notice how flags are chained
int CHANGE_LOAD=FALSE,CHANGE_FRAME=FALSE,CHANGE_REACTION=FALSE,
	CHANGE_LINK=FALSE,CHANGE_PARAMS=FALSE;
void reset(){
	CHANGE_FRAME=FALSE;
	CHANGE_PARAMS=FALSE;
	
	CHANGE_REACTION=FALSE;
	CHANGE_LOAD=FALSE;
	CHANGE_LINK=FALSE;
}
int isChanged(){return CHANGE_FRAME|CHANGE_PARAMS;}

int isParametersChanged(){return CHANGE_LINK;}
int isParameterValuesChanged(){return CHANGE_FRAME;}
int getFirstParameterChanged(){
	if(CHANGE_LOAD) return 0;
	if(CHANGE_REACTION) return 0;
	if(CHANGE_PARAMS) return 0; //getNat();
}		
int isInputParameterDescriptionsChanged(){return CHANGE_LINK;}
int isNumAtomsChanged(){ return CHANGE_LOAD; }
int isBScanSizeChanged(){ return CHANGE_LOAD; }
int isBondTypesChanged(){ return CHANGE_LOAD; }
int isAtomTypesChanged(){ return CHANGE_REACTION; }
int isPositionsChanged(){return CHANGE_FRAME; }
int isVelocitiesChanged(){return CHANGE_FRAME; }
int isBondsChanged(){return CHANGE_REACTION;}

int getLastAtomNumChanged(){return getNumAtoms()-2;}
int getFirstAtomNumChanged(){return 0;}
int getFirstBondNumChanged(){return 0;}
int getLastBondNumChanged(){return getNumAtoms()-2;}
int isMaxBondsChanged(){ return CHANGE_LOAD;}
int isMaxAtomsChanged(){return CHANGE_LOAD;}

int isSizeChanged(){return CHANGE_FRAME;}
int getFirstBondNumTypeChanged(){return 0;}
int getLastBondNumTypeChanged(){return getNumAtoms()-2;}
int getFirstAtomNumTypeChanged(){return 0;}
int getLastAtomNumTypeChanged(){return getNumAtoms()-2;}
int isTypeDescriptionsChanged(){return CHANGE_LOAD;}//expensive
//------------------------------------------------------------------
#define SCALE_FACTOR 1.0f;
int ABORT=FALSE;
float TIME_ADVANCE=0;
float boxSize[3];
int bondCount;

void loadSim(const char *fileName,const char*){
	long ares;
	int i=0;
	dimensions* sze;
	
	JAVA_FILENAME=fileName;
	
	
  	if((ares=startup())<1){
  		printf("ares %i\n",ares);
  		if(!ares)StopAlert(FILE_ALRT);
  		send_error_up("startup error");
  		return;
  	}else if(ares>MOVIE){
  		ares-=MOVIE;
  		text_error_dialog(ares);
  		send_error_up("movie error");
  		return;
  	}

	if(ares!=MOVIE)
	  	ct1=squeeze_table(&p1,&q1,&timea); 
	else
	  	send_error_up("squeeze table");
	
	sze=get_bounds();
	for(i=0;i<3;i++)
    	boxSize[i]=(float)sze[i].length*SCALE_FACTOR;
	
  	bondCount=0; TIME_ADVANCE=0;
  	
  	 fclose(text_path);//note
  	
  	initPValues();
  	
	CHANGE_LOAD=CHANGE_FRAME=CHANGE_REACTION=CHANGE_PARAMS=TRUE;
}
//rem to save input parameters if possible
void saveSim(const char *fileName,const char*){
	writetext((char *)fileName);
}
void closeSim(){
	
 	if(is_open){fclose(echo_path);}
 	if(m_is_open)closemovie(movie_path);
 	close_corr_func();
 	close_rms();
 	bondCount=0; TIME_ADVANCE=0;
	CHANGE_LOAD=CHANGE_FRAME=CHANGE_REACTION=CHANGE_PARAMS=TRUE;
}
void abort(){
	ABORT=TRUE;
}

void step(float maxTime){
	double t;
	int nBs=0,nTs=0,i;
	
	dimensions* sze;
	CHANGE_FRAME=TRUE;
	t=get_time();
	maxTime+=TIME_ADVANCE;
	while ( (((timec+timed)+(timea-timeb)/corr<=t+maxTime)||coll_type)
		&&!ABORT 
		){
		/*      long ticks=clock(); */
		coll_type=collision();//only save when coll_type (collision type) is != 1

		update_table(p1,q1,ct1);

		rms();
		if((corr_2>1.0e1)||(corr_2<1.0e-1))
			if(!coll_type){
				printf("!coltype\n");
				if(!cleanup())break;
			}
		if(getnewBonds()){
			CHANGE_REACTION=TRUE;
		}
		if(getnewTypes()){
			CHANGE_REACTION=TRUE;
		}
		
		ct1=squeeze_table(&p1,&q1,&timea);//determines time of next collision
		/*    totaltime+=clock()-ticks;*/
	}

	TIME_ADVANCE=(float)(maxTime-(get_time()-t));
	
	sze=get_bounds();
	
	for(i=0;i<3;i++)
    	boxSize[i]=(float)sze[i].length*SCALE_FACTOR;
	ABORT=FALSE;
	CHANGE_PARAMS=TRUE;
	
	doParameterValueUpdate();
}

void linkInterpreter(){
	CHANGE_LINK=CHANGE_LOAD=CHANGE_FRAME=CHANGE_REACTION=
		CHANGE_PARAMS=TRUE;
}
void unlinkInterpreter(){}

//display parameters---------------------------------------------
char* parameterNames[4]={"temperature","avePot","mesTime","temp"};
double parameterValues[4];
char* parameterGroups[4]={"system","system","time","time.test"};
void doParameterValueUpdate(){
  parameterValues[0]=get_temperature();
  parameterValues[1]=get_avePot();
  parameterValues[2]=get_mes_time();
  parameterValues[3]=get_temp();
}
char** getParameterGroups(){
	return parameterGroups;
}
char** getParameterNames(){
	return parameterNames;
}
int getNumParameters(){
	return 4;
}
double* getParameterValues(){
	return parameterValues;
}

//input parameters-------------------------------------------------
char* inputNames[3]={"temperature","temperature","coefficient"};
char* inputGroups[3]={"system","heat bath","heat bath"};
char* inputParameterNames[3]={"value","value","value"};

long parameterCounts[3]={1,1,1};

char **getInputNames(){return inputNames;}
char **getInputGroups(){return inputGroups;}
long *getInputCounts(){return parameterCounts;}
char **getInputParameterNames(){return inputParameterNames;}
int getInputParameterNamesCount(){return 3;}
int getNumInput(){return 3;}

double pValues[3];
void call(int fnum,int numParams,double* parameters){

	pValues[fnum]=parameters[0];//ffix
	switch(fnum){
		case 0:
			set_temp(parameters[0]);
			break;
		case 1:
			set_temp_limit(parameters[0]);
			break;
		case 2:
			set_coeff(parameters[0]);
			break;
		default:
			send_error_up("unknown function");
	}
	CHANGE_PARAMS=TRUE;
	doParameterValueUpdate();
}
int initPValues(){
    pValues[0]=get_temp();
	pValues[1]=get_temp_limit();
	pValues[2]=get_coeff();
}
double *getInputParameterValues(){
	return pValues;
}
//positions/velocities/bonds------------------------------------------

void getPositions(int,int,float *positions){
	const int numAtoms=get_atom_number();
    register int i,j;
    const register float _TIME_ADVANCE=TIME_ADVANCE;
    const register float _corr=(float)corr;
    const register float _timeb=(float)timeb;
    const register atom* _a=a;
    const register float tx=-(get_bounds()[0].length/2.0f),
    					ty=-(get_bounds()[1].length/2.0f),
    					tz=-(get_bounds()[2].length/2.0f);
    
    for(i=0,j=0;i<numAtoms;i++){
        positions[j+0]=(((float)(_a[i].r.x+((_TIME_ADVANCE/_corr+(_timeb-_a[i].t))*_a[i].v.x)))+tx)*SCALE_FACTOR;
        positions[j+1]=(((float)(_a[i].r.y+((_TIME_ADVANCE/_corr+(_timeb-_a[i].t))*_a[i].v.y)))+ty)*SCALE_FACTOR;
        positions[j+2]=(((float)(a[i].r.z+((_TIME_ADVANCE/_corr+(_timeb-_a[i].t))*_a[i].v.z)))+tz)*SCALE_FACTOR;
        
        j+=3;
    }
}
void getVelocities(int,int,float *velocities){
	const int numAtoms=get_atom_number();
    register int i,j;
    const register float _corr=(float)corr;
    const register atom* _a=a;
    
    for(i=0,j=0;i<numAtoms;i++){
        velocities[j+0]=((float)_a[i].v.x/_corr)*SCALE_FACTOR;
        velocities[j+1]=((float)_a[i].v.y/_corr)*SCALE_FACTOR;
        velocities[j+2]=((float)_a[i].v.z/_corr)*SCALE_FACTOR;
        
        j+=3;
    }
}

void getBonds(int,int,long *bonds){
	register int i,k,j=0,m;
	int index;
	const int scan=getBScanSize();
	const int total=get_atom_number()*scan;
	dimensions* sze=get_bounds();
	const register mx=sze[0].length/2.0f;
	const register my=sze[1].length/2.0f;
	const register mz=sze[2].length/2.0f;
	
    /* list of bonds */
    for (i=0;i<total;i+=scan){ 
	   	index=-1;
	    for(k=0;k<scan;k++){
	        m=nextFriend(j,&index);
	        bonds[i+k]=m;
	        if(index<0){bonds[i+k]=-1; break;}

	        if(fabs(a[j].r.x-a[m].r.x)>mx){bonds[i+k]=-1; break;}
	        if(fabs(a[j].r.y-a[m].r.y)>my){bonds[i+k]=-1; break;}
	        if(fabs(a[j].r.z-a[m].r.z)>mz){bonds[i+k]=-1; break;}
	  	}
	  	j++;
	}
}
int getNumAtoms(){
	return get_atom_number();
}
int getBScanSize(){
	return 12;
}
int getMaxAtoms(){
	return get_atom_number();
}
int getNumDimensions(){
	return get_dimension();
}

int isNumDimensionsChanged(){
	return CHANGE_LOAD;
}
float* getSize(){
	return boxSize;
}
double getCurrentTime(){
	return (double)(timec+timed);
}
//size
float colorMap[26][3]={
{255,0	,0	},
{255,64	,0	},
{255,128,0	},
{192,128,0	},
{128,128,0	},
{128,192,0	},
{128,255,0	},
{64	,255,0	},
{0	,255,0	},
{0	,255,64	},
{0	,255,128},
{0	,192,128},
{0	,128,128},
{0	,128,192},
{0	,128,255},
{0	,64	,255},
{0	,0	,255},
{64	,0	,255},
{128,0	,255},
{128,0	,192},
{128,0	,128},
{192,0	,128},
{255,0	,128},
{255,0	,64	},
{255,255,255}};

//it is a fatal error for an atom to be outside these dimensions
//atoms go are located from -size/2 to size/2, centered about 0,0,0

//only uptoNumAtoms/numBonds will be drawn
//---------------------------------------------------------------------
//typedata
//notice numAtoms/numBonds can be changed without modifying these arrays
float cmap(float f){
	return ((f/256.0f));
}
void getBondTypes(int beginBondNum,int endBondNum,long *data){
	int i;
	for(i=beginBondNum*2;i<(endBondNum+1)*2;i++) data[i]=0;
}
void getAtomTypes(int beginAtomNum,int endAtomNum,long *data){
	int i;
	for(i=beginAtomNum;i<endAtomNum+1;i++)
		data[i]=a[i].c-1;
}

int getNumAtomTypeDescriptions(){return getNat();}
ATOM_TYPE_DESCRIPTION getAtomTypeDescription(int num){
	ATOM_TYPE_DESCRIPTION atm;
	int cnum=(int)((float)num*(24.0f/(float)getNat()));
	if(cnum>25) cnum=25;
	atm.r=cmap(colorMap[cnum][0]);
	atm.g=cmap(colorMap[cnum][1]);
	atm.b=cmap(colorMap[cnum][2]);
	atm.radius=get_sample_atoms()[num+1].s*SCALE_FACTOR;
	if(atm.radius==0) atm.radius=-.01f;

	atm.description="default atom";
	atm.e1=' ';
	atm.e2=' ';
	return atm;
} 

int getNumBondTypeDescriptions(){return 1;}
BOND_TYPE_DESCRIPTION getBondTypeDescription(int num){
	BOND_TYPE_DESCRIPTION b;
	b.r=.5f;
	b.g=.5f;
	b.b=.5f;
	b.order=.2*SCALE_FACTOR;
	b.radius=0;
	return b;
}
//---------------------------------------------------------------------

