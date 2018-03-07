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
extern long coll_type,p1,ct1,q1;
extern double  corr_2,timea,timeb,corr,timec,timed;
extern char *text_name;
extern int is_open,m_is_open;
extern FILE *echo_path,*movie_path,*text_path;
extern atom *a;


//actions------------------------------------------

//advances simulation by an amount of time t less than max time
//returns the actual amount of time by which simulation is advanced
float step(float maxTime){
    float t=get_time();

    while ((timec+timed+(timea-timeb)*corr<t+maxTime)||coll_type){//!!!is this correct?
      /*      long ticks=clock(); */

      coll_type=collision();//only save when coll_type (collision type) is != 1

      update_table(p1,q1,ct1);

      rms();
      if((corr_2>1.0e1)||(corr_2<1.0e-1))
			if(!coll_type)
	  			if(!cleanup())break;

      ct1=squeeze_table(&p1,&q1,&timea);//determines time of next collision
      /*    totaltime+=clock()-ticks;*/
   }

   return get_time()-t;
}

void save(char *fname){//saves current state as a text file,fname
  writetext(fname);
}

void finish(){//closes the simulation,called once,no other functions are called afterwared
 fclose(text_path);
 if(is_open){fclose(echo_path);}
 if(m_is_open)closemovie(movie_path);
 close_corr_func();
 close_rms();
}

//initializes simulation, called once,called before all other funcions
//returns 1 if successful, 0 if it fails
bool init(){
  long ares;
  
  if((ares=startup())<1){printf("ares %i\n",ares); if(!ares)StopAlert(FILE_ALRT);return 0;}
  else if(ares>MOVIE){ares-=MOVIE;text_error_dialog(ares);return 0;}

  if(ares!=MOVIE)
      ct1=squeeze_table(&p1,&q1,&timea); 
  else
      return 0;
      
  return 1;
}
//options-------------------------------------------

void setTemperature(double d){
  set_temp(d);
}
double getTemperature(){
  return get_temp();
}

void setCoeff(double d){//sets heat exchange coefficient,zero is used when heat bath is off
  set_coeff(d);
}
double getCoeff(){//gets heat exchange coefficient
  return get_coeff();
}
void setTempLimit(double d){//sets heat bath temperature
  set_temp_limit(d);
}
double getTempLimit(){//gets heat bath temperature
  return get_temp_limit();
}


//contants---------------------------------------------
//these variables cannot change during a simulation

//below are the maximum and minimum values that the heat
//bath options can be set too,delete ones that are unimportant
double getCoefMax(){ 
    return 1000;
}
double getCoefMin(){
    return 0;
}
double getTempLimitMin(){
    return 0.0001;
}
double getTempLimitMax(){
    return 10000;
}
double getTempMax(){
    return 10000;
}
double getTempMin(){
    return 0.0001;
}

int getNDim(){//number of dimesnsion 2 or 3
}
int getMaxBonds(){//the maximum number of bonds in the simulation
}
int getNumAtoms(){//this is NOT the number of visible atoms,but the total number of atoms in the simulation-1
    return get_atom_number();
}
//frame data-------------------------------------------
//these variables are checked and copied into java every time step is called if need
//dimension an integer 0 corresonding to x, 1 to y,2 to z, only x and y will be requested in 2d simulations
//I will rewrite many of these methods for better performance because they are used so much

//returns coordinate of an atom timeAdvance time from
//current simulation time
float getPosition(int atom,int dim,float timeAdvance){
	switch(dim){
	case 0:
	return a[atom].r.x+timeAdvance*getVelocity(atom,dim);
	case 1:
	return a[atom].r.y+timeAdvance*getVelocity(atom,dim);
	case 2:
	return a[atom].r.z+timeAdvance*getVelocity(atom,dim);
	}
}

//returns  an atoms velocity at the current simulation time
float getVelocity(int atom, int dim){
	switch(dim){
	case 0:
	return a[atom].v.x/corr;
	case 1:
	return a[atom].v.y/corr;
	case 2:
	return a[atom].v.z/corr;
	}
}
//the size of the enclosing box drawn around sample
float getBoxSize(int dim){
    return get_bounds()[dim].length;
}
//the distance an atom is moved when it "jumps" a periodic boundry
float getPeriodicSize(int dim){
}
//parameters--------------------------------------------
//only parameters specified in the simulaion will be queried
//these and ONLY these values are displayed to the user
//they are not used in any calculations done by the interface
float getPTemp(){//temperature
}
float getPVol(){//volume
}
float getPDens(){//density
}
int[] getPTypeCounts(){//type counts 
}
int[] getPPressure(){//pressure
}
//add ANY other parameters (potential energy,kinetic energy,total energy,avg. collision time, etc.) here!!!!!!!!!!


//type information---------------------------------------
//this is assumed to be constant unless isTypesChanged=true
//there should always at least be a type zero.i.e. Number of Types>=1
boolean isTypesChanged(){//see above
    getnewTypes();
}
int getNumberOfTypes(){//number of different types of atoms-1
    return getNat();
}
int getTypeCount(int type){//nuber of atoms of given type
//for now i am calculating this in the java code
}
float getTypeRadii(int type){//radius of given type, types with radius=0 will no be drawn
	return get_sample_atoms()[type].s
}
int getAtomType(int atom){//type (must be <number of different types of atoms-1) of a given atom
   	return a[atom].c;
}
//bond information------------------------------------------
//this is assumed to be contants unless isBondsChanged=true
boolean isBondsChanged(){
    return getnewBonds();
}
/*bonds are determined as follows-
int bondCount=0;//total number of bonds in simulation-1
int[] bonds;//an array of the format
//{bond 1 from atom index,
//bond 1 to atom index,
//bond 2 from atom index, 
//bond 2 to atom index, bond 3...

for (i=0;i<numAtoms;i++){ 
   	index=-1;
    do{
        j=nextFriend(i,&index);
        if(index==-1)break;
        if(j>i){
        	bonds[k+0]=i;
 			bonds[k+1]=j;
 			k+=2;
 			bondCount++;
      	}
  	}while(index>-1);
}
*/	

