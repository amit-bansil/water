#include <stdio.h>
#include <math.h>
#include <float.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include "bcp.h"
#include "controls.h"
#include "movie.h"
#include "make_system.h"
#include "search.h"
#include "bonds.h"
#include "corr_func.h"
#include "cluster.h"
#include "rms.h"

extern  FILE * text_path;
extern  long n,n1,nen,nen1;
extern  long nrt;
extern  double dticks;
extern  double dblarg1;
extern  double dblarg2;
extern  atom *a;
extern  CollisionData *coll;
extern  ReactionData *react;
extern  dimensions bound[3];
extern  crd o;
extern  tab tb,tw ;
extern  double dim;


static  atom * sam;
static int nat; extern int getNat(){return nat;}
extern  well_type ** ecoll;
extern  well_type ** icoll;
extern  well_type * collp;
extern  well_type * collq;
static  line_number;
static  unsigned char **keywords; 
static int n_keywords;
static int *keyfound;
static unsigned char * endbuf;
static well_type ntot;
static int write_start;
static int write_finish;
static int write_n1;
static int write_stop;

void set_write_param(int n0,int n1,int yes)
{
  write_start=n0;
  write_finish=n0+n1;
  write_n1=n1;
  write_stop=yes;
}

init_coll( well_type j, well_type prev, well_type next, double mi,double mj ,double en,double diam,int react)
{ 
/*  printf("%d",j);*/
  coll[j].e=-en;
  coll[j].eo=-en;
  coll[j].dd=diam*diam;
  coll[j].dm=1/((mi+mj)*coll[j].dd);
  if(en!=dblarg1)
    coll[j].edm=2*coll[j].e/(mi*mj*coll[j].dm);
  else
    coll[j].edm=0;
  coll[j].edmo=coll[j].edm;
  coll[j].prev=prev;
  coll[j].next=next;
  coll[j].react=react;
/*printf(" well\n");*/
}

int allocReact(ReactionData * react1, int nrt1, ReactionData * react0, int nrt0)
{
  if(nrt0+nrt1==0)
    return 0;  
  if(!nrt0)
    {
      react=react1;
      return nrt1;
    }
  if(!nrt1)
    {
      react=react0;
      return nrt0;
    }
  if((nrt1>0)&&(nrt0>0))
    {
      int i,j,k,ntr;
      k=0;
      for(i=1;i<=nrt0;i++)
	{
	  for(j=1;j<=nrt1;j++)
	    {
	    if(react1[j].bond)
	      {
		if(((react0[i].new1==react1[j].new1)&&(react0[i].new2==react1[j].new2))||
		   ((react0[i].new1==react1[j].new2)&&(react0[i].new2==react1[j].new1)))
		  {
		    react0[i].old1=0;
		    k++;
                    break;
		  }
	      }
	  if(((react0[i].old1==react1[j].old1)&&(react0[i].old2==react1[j].old2))||
	     ((react0[i].old1==react1[j].old2)&&(react0[i].old2==react1[j].old1)))
	    {
	      react0[i].bond=-1;
	      break;
	    }
	  }
	}
      nrt=nrt1+nrt0-k;
      react=(ReactionData *)malloc((nrt+1)*sizeof(ReactionData));
      if(!react){StopAlert (MEMORY_ALRT);return -1;}      
      for(i=1;i<=nrt1;i++)
	react[i]=react1[i];
      k=nrt1;
      for(i=1;i<=nrt0;i++)
	if(react0[i].old1>0)
	  {
	    k++;
	    react[k]=react0[i];
	  }
      free(react1);
      free(react0);
      for (i=1;i<=nrt;i++)
	printf("%d %d %d %d %d %lf %lf\n",react[i].old1,react[i].old2,
	       react[i].new1,react[i].new2,react[i].bond,react[i].dd,react[i].eo);
      return nrt;
    }
}

int write_key_coord(FILE * path)
{
   long nbyte;
   unsigned char s[512];
   long i,j,k; 
   int fErr=noErr;
   long free=get_free();
   double dlmin=bound[0].dl;
   double corr=get_corr();
   double mf=get_maxfree();
   moved_atom * a=(moved_atom *)get_atom();
   moveatoms();
   if(bound[1].dl<dlmin)dlmin=bound[1].dl;
   if(bound[2].dl<dlmin)dlmin=bound[2].dl;
   nbyte=sprintf(&s[0],
		 "//(simulation time %lf)\n//length of search table ( %ld current length)\n//corr=%le\n//ll=%ld\n",
get_time(),free,corr,get_ll());
   if(nbyte<=0) fErr=-1;    
   if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);
   if(fErr==noErr)
     {
       if(dim<3)     
	 nbyte=sprintf(&s[0],"%s\n%.7lf %.7lf\n%s\n%ld\n",
		       keywords[SYS_SIZE],bound[0].length,bound[1].length,
		       keywords[2],write_n1);
       else
	 nbyte=sprintf(&s[0],"%s\n%.7lf %.7lf %.7lf\n%s\n%ld\n",
		       keywords[1],bound[0].length,bound[1].length,bound[2].length,keywords[NUM_ATOMS],write_n1);
     }
   if(nbyte<=0) fErr=-1;    
   if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);
   if(fErr==noErr)
     nbyte=sprintf(&s[0],"%s\n//type,mass,ellastic radius,interaction radius\n",
		   keywords[TYPE_ATOMS]);
   if(nbyte<=0) fErr=-1;    
   if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);	 
   if(fErr==noErr) 
     for(k=1;k<=nat;k++)
       {
	 nbyte=sprintf(&s[0],"%ld %lf %lf %lf\n",k,sam[k].m,sam[k].s,sam[k].b);
	 if(nbyte<=0) fErr=-1;
	 if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);
	 if(fErr!=noErr)break;
       }


   

   if(fErr==noErr)
     nbyte=sprintf(&s[0],"%s\n//pair types, repulsive dist, interaction distance, energy\n"
		   ,keywords[NONEL_COL]);
   if(nbyte<=0) fErr=-1;    
   if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);	 
   if(fErr==noErr) 
     for(i=1;i<=nat;i++)
       for(j=1;j<=i;j++)
	 {
	   k=ecoll[i][j];
	   if(coll[k].next>-1)
	     {
	       double dd, en;
               int sbyte=0;
	       while(coll[k].next>-1)
		 k=coll[k].next;
	       dd=sqrt(coll[k].dd);
	       nbyte=sprintf(&s[0],"%d %d %lf \n",i,j,dd);
               sbyte+=nbyte-1; 
	       if(nbyte<=0) 
		 fErr=-1;
	       else
		 while(coll[k].prev>-1)
		   {
		     k=coll[k].prev;
		     dd=sqrt(coll[k].dd);
		     en=-coll[k].eo;
		     nbyte=sprintf(&s[sbyte],"%lf %lf \n",dd,en);
		     sbyte+=nbyte-1; 
		     if(nbyte<=0){fErr=-1;goto hell;}
		   } 
	       sbyte++;
	       if(fErr==noErr)fErr=(fwrite(&s[0],1,sbyte,path)!=sbyte);
	       if(fErr!=noErr)goto hell;
	     }
	 }

  if(fErr==noErr)
  nbyte=sprintf(&s[0],"%s\n//pair types, repulsive dist\n",keywords[EL_COL]);
  if(nbyte<=0) fErr=-1;    
  if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);	 
  if(fErr==noErr) 

   if(fErr==noErr) 
     for(i=1;i<=nat;i++)
       for(j=1;j<=i;j++)
	 {
	   k=ecoll[i][j];
	   if(coll[k].next<0)
	     {
	       double dd;
	       dd=sqrt(coll[k].dd);
	       nbyte=sprintf(&s[0],"%d %d %lf\n",i,j,dd);
	       if(nbyte<=0) 
		 {fErr=-1;goto hell;}
	       if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);
	       if(fErr!=noErr)goto hell;
	     }
	 }

   nbyte=sprintf(&s[0],"%s\n//pair types, repulsive dist, attractive distance\n",
		 keywords[LINK_PAIRS]);
   if(nbyte<=0) fErr=-1;    
   if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);	 	   	 


   if(fErr==noErr) 
     for(i=1;i<=nat;i++)
       for(j=1;j<=i;j++)
	 {
	   k=icoll[i][j];
	   if(k>-1)
	     {
	       double dd, en;
               int sbyte=0;
	       while(coll[k].next>-1)
		 k=coll[k].next;
	       dd=sqrt(coll[k].dd);
	       nbyte=sprintf(&s[0],"%d %d %lf \n",i,j,dd);
               sbyte+=nbyte-1; 
	       if(nbyte<=0) 
		 fErr=-1;
	       else
		 while(coll[k].prev>-1)
		   {
		     k=coll[k].prev;
		     dd=sqrt(coll[k].dd);
		     en=-coll[k].eo;
                     if(en!=dblarg1)
		       nbyte=sprintf(&s[sbyte],"%lf %lf \n",dd,en);
		     else
		       nbyte=sprintf(&s[sbyte],"%lf \n",dd);
		     sbyte+=nbyte-1; 
		     if(nbyte<=0){fErr=-1;goto hell;}
		   } 
	       sbyte++;
	       if(fErr==noErr)fErr=(fwrite(&s[0],1,sbyte,path)!=sbyte);
	       if(fErr!=noErr)goto hell;
	     }
	 }

   if(fErr==noErr)
     nbyte=sprintf(&s[0],"%s\n//old1,old2,new1,new2,bond,radius energy\n",keywords[REACT]);
   if(nbyte<=0) fErr=-1;    
   if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);	 
   if(fErr==noErr) 
     for(k=1;k<=nrt;k++)
       {
	 nbyte=sprintf(&s[0],"%d %d %d %d %d %lf %lf\n",
		       react[k].old1,
		       react[k].old2,
		       react[k].new1,
		       react[k].new2,
		       react[k].bond,
		       sqrt(react[k].dd),
		       react[k].eo);
	 if(nbyte<=0) fErr=-1;
	 if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);
	 if(fErr!=noErr)break;
       }

  if(fErr==noErr)
  nbyte=sprintf(&s[0],"%s\n//number, type, x, y, z, Vx, Vy, Vz\n",keywords[LIST_ATOMS]);
  if(nbyte<=0) fErr=-1;    
  if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);	 	   
  if(fErr==noErr)
    if(write_stop)stop_atoms((moved_iatom *)(a+write_start),write_n1);
    else corr_vel(); 	 
  for(i=write_start;i<write_finish;i++)
  {
    double x=a[i].r.x;
    double y=a[i].r.y;
    double z=a[i].r.z;
    if(x<0)x+=bound[0].length;
    if(y<0)y+=bound[1].length;
    if(z<0)z+=bound[2].length;
    if(x>bound[0].length)x-=bound[0].length;
    if(y>bound[1].length)y-=bound[1].length;
    if(z>bound[2].length)z-=bound[2].length;
    nbyte=sprintf(&s[0],"%4ld %4d %18.13lf %18.13lf %18.13lf %18.13lf %18.13lf %18.13lf\n",
    i+1-write_start,a[i].c,x,y,z,
    a[i].u.x,a[i].u.y,a[i].u.z);
    if(nbyte<=0) fErr=-1;  
    if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);
    if(fErr!=noErr)break;
  }
   
   if(fErr==noErr)
    nbyte=sprintf(&s[0],"%s\n//number1,number2\n",keywords[LIST_BONDS]);
   if(nbyte<=0) fErr=-1;    
   if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);	 	   
   if(fErr==noErr) 	 
    for(i=0;i<n1;i++)
	{ 
	  int index=-1;
	  do
	    {
	      j=nextFriend(i,&index);
	      if(index==-1)break;
	      if((j>i)&&(i>=write_start)&&(j<write_finish))
		{
		  nbyte=sprintf(&s[0],"%4ld %4ld\n",
				i+1-write_start,j+1-write_start);
		  if(nbyte<=0) fErr=-1;  
		  if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);
		  if(fErr!=noErr)break;
		}
	    }while(index>-1);
	}
 hell:
   if(fErr!=noErr)fclose(path);
   return fErr;
 }





unsigned char * get_buffer(long * file_length) 
{   
  int fErr; 
  long file_size;
  unsigned char * buf;
  
  
  /* fErr=GetEOF(text_path,&file_size);*/
  fErr=fseek(text_path,0,SEEK_END);
  if(fErr==noErr)file_size=ftell(text_path);
  if(file_size<=0)fErr=-1;
  if(fErr==noErr)fErr=fseek(text_path,0,SEEK_SET);
   if(fErr!=noErr){fclose(text_path); return NULL;}
   buf=(unsigned char *)malloc(file_size+2);
   if(!buf){StopAlert (MEMORY_ALRT);fclose(text_path);return NULL;}
   buf[0]='\n';
   fErr=(fread(buf+1,1,file_size,text_path)!=file_size);
   if(fErr!=noErr){fclose(text_path);free(buf); return NULL;}
   endbuf=buf+file_size+1;
   file_length[0]=file_size;
   return buf;
   }

/* finds the first line that does not begin with '/' */

unsigned char * next_line1(unsigned char * s)
{ unsigned char * t=s;
 
  do{
  while ((*t)!='\n')
  {
  if ((*t)=='\0')*t=' ';
  else if((*t)==(unsigned char)'\377')return NULL;
  t++;
  }
  *t='\0';t++;line_number++;
  }while ((*t)=='/');
  return t; 
 }

 /* Finds the first non-spaces charachter after at least one '\n'
which is before '/'.
Fills all preceedings characters between '/' and '\n' with 
spaces and all preceeding '\n' with '\0' and all
preceeding '\0' and '/' with spaces */   

unsigned char * next_line(unsigned char * s)
{ 
  unsigned char * t=s;
  int first=1;
  int slash=0;
  do
    {
      while ((*t)!='\n')
	{
	  if(t==endbuf)return NULL;
	  if ((*t)=='\0')*t=' ';
	  
	  if (!slash)
	    {
	      if ((*t)=='/'){*t=' ';slash=1;}
	      else if(!isspace(*t))
		{if(!first) return t;}
	    }
	  else
	    *t=' ';
	  t++;
	}
      line_number++;
      *t='\0';
      first=0;
      slash=0;
      if(t==endbuf)return NULL;
      t++;
    }while (1);
}
int isparam(unsigned char * datfile)
{
return 0;
}
int iskeyword(unsigned char * datfile)
{
/* Keywords should go in a specific order.
important keys are:
SYS_SIZE
NUM_ATOMS
TYPE_ATOMS
LIST_ATOMS
If a keyword is found twice
it is a bug. 
Returns key_word number; 
returns -1 if error; 
returns 0 if not a keyword */
  size_t l;
  int i,j,k;
  unsigned char * t;
  for(i=1;i<=n_keywords;i++)
    {  
      l=strlen(keywords[i]);
      t=datfile+l;
      if(strncmp(keywords[i],datfile,l))continue;
      for(j=i;j<=n_keywords;j++)
	if(keyfound[j])return -1;
      keyfound[i]=1;
      k=i; 
      if(k>3)k=3;
      for(j=1;j<=k;j++)
	if(!keyfound[j])return -1;
      if((i>LIST_ATOMS)&&(!keyfound[LIST_ATOMS]))return -1;
      while (isspace(*t))
	{ 
	  if((*t)=='\0')return i;
	  t++;
	}
      if((*t)=='\0')return i;
      else return -1;
    }
  return 0;
}

  
unsigned char * next_word(unsigned char * s)
{ 
  unsigned char * t=s;
  while (isspace(*t))
  { 
    if((*t)=='\0')return NULL;
    t++;
  }
  while(!isspace(*t))
  {
   if ((*t)=='\0')return NULL;
   t++;
   }
  return t; 
  }

int is_word(unsigned char * s)
{ 
  unsigned char * t=s;
  while (isspace(*t))
  { 
    if((*t)=='\0')return 0;
    t++;
  }
  if((*t)=='\0')return 0;
    else return 1;

}

int dimensionality( int * is_x)
{ 
  int i,j,k=0;
  iatom * b=(iatom *)a;
  for(i=0;i<3;i++)
  {
  is_x[i]=0;
  for(j=0;j<n1;j++)
  if ((b[j].r[i])||(b[j].v[i])) {is_x[i]=1;break;}
  k+=is_x[i];
  }
  return k; 
}

int make_tables(int isfile)
{  
  int err;
  int is_x[3];
  if(!dimensionality(is_x))return 0;
  init_update_param(is_x);
  if(!allocsearch(n1)){StopAlert (MEMORY_ALRT);return -1;}
  err=init_tables();
  if(err!=1)return err;
  //init_rms(); ALL REMOVED AB
  //init_clusters();
  //init_corr_func();
  dticks=10000;
  return 1;
}

int init_keywords()
{ 
  int i;   
  keywords=(unsigned char **)malloc(20*sizeof(unsigned char *));
  if(!keywords) return 0;
  keyfound=(int *)malloc(20*sizeof(int));
  if(!keyfound) return 0;
  n_keywords=12; 
  keywords[SYS_SIZE]="A.SYSTEM SIZE";
  keywords[NUM_ATOMS]="B.NUMBER OF ATOMS";
  keywords[TYPE_ATOMS]="C.TYPES OF ATOMS";
  keywords[NONEL_COL]="D.NON-ELASTIC COLLISIONS";
  keywords[EL_COL]="E.ELASTIC COLLISIONS";
  keywords[LINK_PAIRS]="F.LINKED PAIRS";
  keywords[REACT]="G.REACTIONS";
  keywords[LIST_ATOMS]="H.LIST OF ATOMS";
  keywords[LIST_BONDS]="I.LIST OF BONDS";
  keywords[NUM_BONDS]="J.BOND TABLE LENGTH";
  keywords[LIST_PARAM]="K.LIST OF PARAMETERS";
  keywords[COL_TABLE]="COLLISION TABLE LENGTH";
  for(i=0;i<=n_keywords;i++)
  keyfound[i]=0;
  return 1;
}

long startup(void)
{
  int isfile,err,i;
  double file_type;
  
  if(!init_keywords())return -4;
  dblarg1=DBL_MAX*0.5e-10;
  dblarg2=DBL_MAX*10e-10;
  isfile=readfile();
  if(isfile==TEXT)
    {   
      long file_length;
      unsigned char * buf=get_buffer(&file_length);
      unsigned char * datfile, *nextline= buf;;   
      if(!buf)return -4; 
      
      line_number=MOVIE-1;
      nextline=next_line(nextline);
      
      datfile=nextline;if(!(nextline=next_line(datfile)))return line_number;
      /*      What is window size */
      i=iskeyword(datfile);
      
      if(i>0) err=make_key_system(i,nextline,file_length);
      else return line_number;
      
      
      
      if(err!=1)return err;
      free(buf);
      init_parameters();
    }
  return make_tables(isfile);
}

int make_bonds(int numbond, double * bonds)
{
int i;
int actual_number=0;
int res;
int friend1, friend2;
for (i=0;i<numbond;i++)
  {
    friend1=*bonds;
    bonds++;
    friend2=*bonds;
    bonds++;
    res=setBond(friend1,friend2);
    if(res<0)
      {return -1;}
    if(res==1)
      {return -1;}
    actual_number+=res;
  }
return actual_number;   
}
void printwells(well_type **icoll, long nat)
{
  int i,j,next;
  CollisionData x;
  for(i=1;i<=nat;i++)
    for(j=1;j<=i;j++)
      {
	next=icoll[i][j];
	while(next>-1)
	  {
	    x=coll[next];
	    printf("%d %d %d %d %d %d %lf %le %le\n",i,j,next, (int)x.next,(int)x.prev,(int)x.react,x.dd,x.eo,x.etot);
	    next=x.next;
	  }
      }
  printf("%d %d\n",nen,nen1);
}
int make_wells(
double *** coldata,int numwell,
double *** bonddata,int numbondwell,
double * bonds,int numbond,atom * a,int nAtom,atom * sam,int nat)
{

/* nen is number of wells with finite energy barrier */
/* values larger or equal than nen1 are wells with infinite energy*/
  int i,j,k,l,nat2,unstable;
  well_type num,next,prev;
  double en;
  ntot=numwell+numbondwell+nrt;
  for(i=1;i<=nat;i++)
    for(j=1;j<=i;j++)
	if(!coldata[i][j])ntot++;
  for(k=0;k<numbond;k++)
    {
      i=bonds[2*k];
      j=bonds[2*k+1];
      i=a[i].c;
      j=a[j].c;
      if(j>i){l=i;i=j;j=l;}
      if(!bonddata[i][j])
	{
	  bonddata[i][j]=bonds+2*k;
	  ntot+=2;
	}
    }
/*  printf("%d\n",ntot);*/
  nat2=(nat+1)*(nat+1);
  coll=(CollisionData *)malloc(ntot*sizeof(CollisionData));
  if(!coll)return 0; 
  ecoll=(well_type **)malloc((nat+1)*sizeof(well_type *));
  if(!ecoll){StopAlert (MEMORY_ALRT);return line_number;}
  ecoll[0]=(well_type *)malloc(nat2*sizeof(well_type));
  if(!ecoll[0]){StopAlert (MEMORY_ALRT);return line_number;}
  for(i=0;i<nat;i++)
    ecoll[i+1]=ecoll[i]+nat+1;
  for(i=0;i<nat2;i++)
    ecoll[0][i]=-1;

  icoll=(well_type **)malloc((nat+1)*sizeof(well_type *));
  if(!icoll){StopAlert (MEMORY_ALRT);return line_number;}
  icoll[0]=(well_type *)malloc(nat2*sizeof(well_type));
  if(!icoll[0]){StopAlert (MEMORY_ALRT);return line_number;}
  for(i=0;i<nat;i++)
    icoll[i+1]=icoll[i]+nat+1;
  for(i=0;i<nat2;i++)
    icoll[0][i]=-1;

  nen=0;
  nen1=ntot;
  for(i=1;i<=nat;i++)
    for(j=1;j<=i;j++)
      {
	if(coldata[i][j])
	  {
	    l=coldata[i][j][0];
            next=-1;
	    for(k=1;k<l;k+=2)
	      {
		if(k==1)
		  {
                    nen1--;
                    num=nen1;
		  }
                else
		  {

		    num=nen;
		    nen++;
		  }
		if(k==l-2)
		  prev=-1;
                else
		  prev=nen;
		init_coll(num,prev,next,sam[i].m,sam[j].m,coldata[i][j][k+1],coldata[i][j][k],0);
		next=num;
	      }
	    ecoll[i][j]=next;
            ecoll[j][i]=next;
	  }
	else
	  {
	    nen1--;
            ecoll[i][j]=nen1;
            ecoll[j][i]=nen1;
            init_coll(nen1,-1,-1,sam[i].m,sam[j].m,dblarg1,sam[i].s+sam[j].s,0);
	  }
      }

  for(i=1;i<=nat;i++)
    for(j=1;j<=i;j++)
      if(bonddata[i][j])
	{
	  if(bonddata[i][j]<bonds)
	    {
	      l=bonddata[i][j][0];
	      unstable=l&1;
	      l=l|1;
	      next=-1;
	      for(k=1;k<l;k+=2)
		{
		  if((k==1)||((k==l-2)&&(!unstable)))
		    {
		      nen1--;
		      num=nen1;
		    }
		  else
		    {
		      
		      num=nen;
		      nen++;
		    }
		  
		  if(k==l-2)
		    {
		      prev=-1;
		      if(unstable)
			en=bonddata[i][j][k+1];
		      else
			en=dblarg1;
		    }
		  else
		    {
		      en=bonddata[i][j][k+1];
		      prev=nen;
		    }
		  if((k==l-4)&&(!unstable))
		    prev=nen1-1;
		  init_coll(num,prev,next,sam[i].m,sam[j].m,en,bonddata[i][j][k],-1);
		  next=num;
		}
	      icoll[i][j]=next;
	      icoll[j][i]=next;
	    }
	  else
	    {
	      nen1--;
	      init_coll(nen1,nen1-1,-1,sam[i].m,sam[j].m,dblarg1,sam[i].s+sam[j].s,-1);
	      nen1--;
	      icoll[i][j]=nen1;
	      icoll[j][i]=nen1;
	      init_coll(nen1,-1,nen+1,sam[i].m,sam[j].m,dblarg1,sam[i].b+sam[j].b,-1);
/* bond collision types has -1 in reaction field even if now reaction happen */
	    }
	}

  for(i=1;i<=nat;i++)
    for(j=1;j<=i;j++)
      {
	next=ecoll[i][j];
        coll[next].etot==0;//????is this an error
	next=icoll[i][j];
	  if(next>-1)
	    coll[next].etot=0;
      }
/*scanf("%d",&i);*/
  for(k=1;k<=nrt;k++)
    if(react[k].bond>=0)
      {
	i=react[k].new1;
	j=react[k].new2;
	num=icoll[i][j];
	if(num<0)react[k].bond=0;
	if(react[k].bond)
	  {
	    if(react[k].dd>coll[num].dd)
	      react[k].bond=0;
	    else
	      {
		next=coll[num].next;
		while(next>-1)
		  {
		    if(react[k].dd>coll[next].dd)
		      {

			react[k].in=next;
			break;
		      }
		    next=coll[next].next;  
		  }
		if(next<0)react[k].bond=0;
		else
		  {
		    
		    if(coll[num].eo==-dblarg1)
		      coll[num].etot=-react[k].eo;
		    else
		      {
			coll[num].react=-k-1; /* reverese reaction happens if .react is less then -1 */
			next=ecoll[react[k].old1][react[k].old2];
			while(next>-1)
			  {
			    if(coll[num].dd >=coll[next].dd)
			      {
				react[k].out=next;
				break;
			      }
			    next=coll[next].next;
			  }
		      }
		  }
	      }
	  }
	if((react[k].in>-1)||(!(react[k].bond)))
	  {
	    i=react[k].old1;
	    j=react[k].old2;
	    next=ecoll[i][j];
	    while(next>-1)
	      {
		if(react[k].dd>=coll[next].dd)
		  {
		    if(react[k].dd>coll[next].dd)
		      {
			prev=coll[next].prev;
			num=nen;
			nen++;
			init_coll(num,prev,next,sam[i].m,sam[j].m,(double)0,sqrt(react[k].dd),0);
			if(!react[k].bond)react[k].in=next;
			coll[next].prev=num;
			if(prev==-1)
			  {
			    ecoll[i][j]=num;
			    ecoll[j][i]=num;
			    coll[num].etot=0;
			  }
			else
			  {
			    coll[prev].next=num;
			  }
		      }
		    else
		      {
			num=next;
			next=coll[next].next;
			if(next<=-1){printf("error\n");return 0;}			
			if(!react[k].bond)react[k].in=next;
			
		    }
		    coll[num].react=k;
		    break;
		  }
		next=coll[next].next;
	      }
	  }
      }
    else /* irreversible reactions of breaking bonds created when bond is breakable 
	    but no bond-forming reaction corresponing to input types is specified */
      {
	react[k].bond=1;
	num=icoll[react[k].new1][react[k].new2];
	coll[num].react=-k-1; /* reverese reaction happens if .react is less then -1 */
	next=ecoll[react[k].old1][react[k].old2];
	while(next>-1)
	  {
	    if(coll[num].dd >=coll[next].dd)
	      {
		react[k].out=next;
		break;
	      }
	    next=coll[next].next;
	  }
      }



/*printf("step1\n");*/
  for(i=1;i<=nat;i++)
    for(j=1;j<=i;j++)
      {
	num=ecoll[i][j];

	while(num>-1)
	  {		
	    next=coll[num].next;
	    if(next>-1)
	      {
		  coll[next].etot=coll[num].etot+coll[num].eo;
/*	printf("%d %lf\n",num,coll[num].etot);*/
	      }
		num=next;
	  }
      }
/*printf("step2\n");*/  
  for(i=1;i<=nat;i++)
    for(j=1;j<=i;j++)
      {
	num=icoll[i][j];
	while(num>-1)
	  {
	    next=coll[num].next;
	    if(next>-1)
	      {
		en=coll[num].eo;
		if(en==-dblarg1)en=0;
		coll[next].etot=coll[num].etot+en;
	      }
	    num=next;
	  }
	num=icoll[i][j];
	if(num>-1)coll[num].etot=0;
      }
/*printf("step3\n");*/
}

make_key_system(int first_key, unsigned char * buf,long file_length)
{  
  unsigned char * datfile, *nextline= buf;
  long i,i1,i2,i3,j,k,ix,iy,iz,lbr,lbw,l,l0,ares,nneib,k1; //more unused variables
  double r0,d,dx,dy,dz,vel0,vv;//????none used
  double enr,enw,maxrb;//????? unused
  long nr,nc,nl,lp,lo,no,ls,ns,nw,istart; //???? none of these are used
  long err; //?????also no used
  double ccell, L[3];
  int ndim;
  int current_key=first_key;
  int numcol;
  int numwell=0;
  int numbondwell=0;
  int numunstable=0;
  int numword;
  int numbond=0;//8/27 ACTUAL NUMBER OF BONDS AB
  int next_key;
  int lbt=0;/*length of bond table*/
  int lct=0;/*length of collision table*/
  double *storage, *top, *dummy, *bonds=0;
  double ***coldata;
  double ***bonddata;
  double coord_shift[3]={0.0,0.0,0.0};
  ReactionData * react0;
  ReactionData * react1;
  //printf("dx,dy,dz=?\n"); 9/1 REMOVED AB
 // scanf("%lf %lf %lf",coord_shift,coord_shift+1,coord_shift+2);
  nrt=0;
  storage=(double *)malloc(file_length*sizeof(double));
  if(!storage){StopAlert (MEMORY_ALRT);return line_number;}
  dummy=storage;
  while(current_key)
    {
      switch (current_key){
	case SYS_SIZE :
	  {
	    printf("%s\n",keywords[current_key]);
	    datfile=nextline;if(!(nextline=next_line(datfile)))return line_number;
	    /*     What is system size */
	    ndim=0;
	      
		while(is_word(datfile))
		  {
		    sscanf(datfile,"%lf",storage+ndim);
                    ndim++;
		    if(!(datfile=next_word(datfile)))break;
		  }
	    if((ndim<2)||(ndim>3))return line_number;
	    for(i=0;i<ndim;i++)
	      {
		if(dummy[i]<=0)return line_number;
                L[i]=dummy[i];
		printf("%lf\n",L[i]);
	      }
	    datfile=nextline;
	    if(!(nextline=next_line(datfile)))return line_number;
	    next_key=iskeyword(datfile);
	    if(next_key<=0)return line_number;
	    else current_key=next_key;
            break;
	  }
	case NUM_ATOMS:
	  {
	    printf("%s\n",keywords[current_key]);
	    datfile=nextline;if(!(nextline=next_line(datfile)))return line_number;
            /* what is number of atoms */
	    sscanf(datfile,"%lf",dummy);
            n1=dummy[0];
            if((n1<1)||(n1!=dummy[0]))return line_number;
	    datfile=nextline;
	    if(!(nextline=next_line(datfile)))return line_number;
	    next_key=iskeyword(datfile);
	    if(next_key<=0)return line_number;
	    else current_key=next_key;
	    if(!(a=(atom *)malloc((n1+1)*sizeof(atom))))
	      {StopAlert (MEMORY_ALRT);return line_number;}
	      for(i=0;i<n1;i++)
		a[i].c=0;
	    printf("NUM_ATOMS=%d\n",n1);
	    set_write_param(0,n1,0); /* setting parameters for text writing */
	    n=n1-1;
            break;
	  }
	case TYPE_ATOMS: 
	  {
	    printf("%s\n",keywords[current_key]);
            nat=0;
	    maxrb=0;
            do
	      {
		numword=0;
		datfile=nextline;if(!(nextline=next_line(datfile)))return line_number;
		next_key=iskeyword(datfile);
		if(next_key<0)return line_number;
                if((next_key>0)&&(!nat))return line_number;
                if(!next_key)
		  {
		    /* what is type, mass, small radius , big radius */
		    numword=0;
		    while(is_word(datfile))
		      {
			sscanf(datfile,"%lf",dummy+nat+numword);
			numword++;
			if(!(datfile=next_word(datfile)))break;
		      }
		    if((numword<3)||(numword>4))return line_number;
		    if(dummy[nat]!=(int)dummy[nat])return line_number;
		    if(numword==3)dummy[nat+3]=dummy[nat+2];
		    if(dummy[nat+3]<dummy[nat+2])return line_number;
		    nat+=4;
		  }
                
	      }while(!next_key);
            nat/=4;
	    if(!(sam=(atom *)malloc((nat+1)*sizeof(atom))))
	      {StopAlert (MEMORY_ALRT);return line_number;}
	    for(i=1;i<=nat;i++) /*fix it later 4*/
	      sam[i].c=0;

	    for (i=1;i<=nat;i++)
	      {
		j=dummy[(i-1)*4];
		if((j>nat)||(j<1))return line_number; /*fix it later 4*/
                if(sam[j].c)return line_number; /*fix it later 4*/
		sam[j].m=dummy[(i-1)*4+1];
		sam[j].s=dummy[(i-1)*4+2];
		sam[j].b=dummy[(i-1)*4+3];
		sam[j].c=i;
		sam[i].r=o;
		sam[i].v=o;
		sam[i].t=0.0;
		sam[i].i.x.i=0;
		sam[i].i.y.i=0;
		sam[i].i.z.i=0;
		if(sam[i].b>maxrb)maxrb=sam[i].b;
	      }
            maxrb*=2; 
	    for (i=1;i<=nat;i++)
	      printf("%d %d %lf %lf %lf\n",i,sam[i].c,sam[i].m,sam[i].s,sam[i].b);

            coldata=(double ***)malloc((nat+1)*sizeof(double **));
	    if(!coldata){StopAlert (MEMORY_ALRT);return line_number;}
            numcol=nat*(nat+1)/2;
            coldata[0]=(double **)malloc((numcol+1)*sizeof(double *));
	    if(!coldata[0]){StopAlert (MEMORY_ALRT);return line_number;}
            
	    for(i=0;i<nat;i++)
            coldata[i+1]=coldata[i]+i;

	    for(i=0;i<=numcol;i++)
            coldata[0][i]=0;

            bonddata=(double ***)malloc((nat+1)*sizeof(double **));
	    if(!coldata){StopAlert (MEMORY_ALRT);return line_number;}
            bonddata[0]=(double **)malloc((numcol+1)*sizeof(double *));
	    if(!coldata[0]){StopAlert (MEMORY_ALRT);return line_number;}
            
	    for(i=0;i<nat;i++)
            bonddata[i+1]=bonddata[i]+i;

	    for(i=0;i<=numcol;i++)
            bonddata[0][i]=0;
            top=storage;


	    current_key=next_key;
            break;
	  }
	case NONEL_COL:
	case EL_COL:
	  {
	    printf("%s\n",keywords[current_key]);
	    do
	      {
		datfile=nextline;if(!(nextline=next_line(datfile)))return line_number;
		next_key=iskeyword(datfile);
		if(next_key<0)return line_number;
                if(!next_key)
		  {
                    double a=0;
		    numword=0;
/* type1 type2 hard_core1 [softcore1 energy1[softcore 2 energy2...]] */
		    while(is_word(datfile))
		      {
			sscanf(datfile,"%lf",top+numword);
			numword++;
			if(!(datfile=next_word(datfile)))break;
		      }
		    if((numword<3)||(!(numword&1)))return line_number;
                    if((current_key==EL_COL)&&(numword>3))return line_number;
		    i=top[0];
		    if(i!=top[0])return line_number;
		    j=top[1];
                    if(j!=top[1])return line_number;
		    if(j>i){k=i;i=j;j=k;}
		    if(coldata[i][j])return line_number;
		    coldata[i][j]=top;
                    top[0]=numword;
		    top[1]=top[2];
		    top[2]=dblarg1;
                    for(k=1;k<numword;k+=2)
		      {
			if(top[k]<=a)return line_number;
			a=top[k];
		      }
		    if(maxrb<a)maxrb=a;
		    top+=numword;
                    bonds=top;
		    numwell+=numword>>1;
		  }
	      }while(!next_key);
	  current_key=next_key;
	  break;
	  }
	case LINK_PAIRS:
	  {
	    printf("%s\n",keywords[current_key]);
	    do
	      {
		datfile=nextline;if(!(nextline=next_line(datfile)))return line_number;
		next_key=iskeyword(datfile);
		if(next_key<0)return line_number;
                if(!next_key)
		  {
                    double a=0;
		    numword=0;
/* type1 type2 hard_core1 [softcore1 energy1[softcore 2 energy2...]] hardcore2 [energy of breaking] */
		    while(is_word(datfile))
		      {
			sscanf(datfile,"%lf",top+numword);
			numword++;
			if(!(datfile=next_word(datfile)))break;
		      }
		    if(numword<4)return line_number;
		    i=top[0];
		    if(i!=top[0])return line_number;
		    j=top[1];
                    if(j!=top[1])return line_number;
		    if(j>i){k=i;i=j;j=k;}
		    if(bonddata[i][j])return line_number;
		    bonddata[i][j]=top;
                    top[0]=numword;
		    top[1]=top[2];
		    top[2]=dblarg1;
                    for(k=1;k<numword;k+=2)
		      {
			if(top[k]<=a)return line_number;
			a=top[k];
		      }
/* if the bond is breakable it should be longer than the hardcore */
                    if((numword&1)&&(a<coldata[i][j][1]))return line_number;
		    if(maxrb<a)maxrb=a;
		    top+=numword;
                    bonds=top;
		    numbondwell+=numword>>1;
                    numunstable+=numword&1;
		  }
	      }while(!next_key);
	    if(numunstable)
	      {
		react0=(ReactionData *)malloc((numunstable+1)*sizeof(ReactionData));
		k=0;
		for(i=1;i<=nat;i++)
		  for(j=1;j<=i;j++)
		    if(bonddata[i][j])
		      {
			numword=bonddata[i][j][0];
			if(numword&1)
			  {
			    k++;
			    react0[k].old1=i;
			    react0[k].old2=j;
			    react0[k].new1=i;
			    react0[k].new2=j;
			    react0[k].bond=1;
			    react0[k].dd=bonddata[i][j][numword-2];
			    react0[k].dd*=react0[k].dd;
			    react0[k].eo=bonddata[i][j][numword-1];
			    react0[k].in=-1;
			    react0[k].out =-1;
			  }
		      }
	      }
	    current_key=next_key;
	    break;
	  }
	case REACT:
	  {
	    printf("%s\n",keywords[current_key]);
	    dummy=top;
            nrt=0;
            do
	      {
		numword=0;
		datfile=nextline;if(!(nextline=next_line(datfile)))return line_number;
		next_key=iskeyword(datfile);
		if(next_key<0)return line_number;
                if(!next_key)
		  {
/* old1 old2 new1 new2 [bond [radius [energy]]] */
		    int old1,old2,new1,new2;
		    numword=0;
		    while(is_word(datfile))
		      {
			sscanf(datfile,"%lf",dummy+nrt+numword);
			numword++;
			if(!(datfile=next_word(datfile)))break;
		      }
		    if((numword<4)||(numword>7))return line_number;
                    if(numword==4)dummy[numword]=0;
                    for(i=0;i<5;i++)
		      if(dummy[nrt+i]!=(int)dummy[nrt+i])return line_number;
		    old1=i=dummy[nrt];
		    old2=j=dummy[nrt+1];
                    new1=dummy[nrt+2];
                    new2=dummy[nrt+3];
                    if(sam[old1].m!=sam[new1].m)return line_number;
                    if(sam[old2].m!=sam[new2].m)return line_number;
		    if(j>i){k=i;i=j;j=k;}
		    /* by default, reaction radius and energy are taken from the
		       external non-ellastic collision, or from sam.b */
		    if((numword==5)||(numword==6))
		      {
			if((!coldata[i][j])||((coldata[i][j])&&(coldata[i][j][0]==3)))
			  {
			    dummy[nrt+6]=0;
			    if(numword==5)dummy[nrt+5]=sam[i].b+sam[j].b;
			  }
			else
                          {
			    int k=coldata[i][j][0];
			    dummy[nrt+6]=coldata[i][j][k-1];
			    if(numword==5)dummy[nrt+5]=coldata[i][j][k-2];
			  }
		      }
		    if(numword>=6)
		      {

			/* if radius of reaction is smaller than hardcore, reaction cannot happpen */
			if(coldata[i][j])
			  {
			    if(dummy[nrt+5]<=coldata[i][j][1])return line_number;
			  }
			else if(dummy[nrt+5]<=sam[i].s+sam[j].s)return line_number;
		      }
		    nrt+=7;
		  }
	      }while(!next_key);
	    nrt/=7;
	    react1=(ReactionData *)malloc((nrt+1)*sizeof(ReactionData));
	    if(!react1){StopAlert (MEMORY_ALRT);return line_number;}      
	    for (i=1;i<=nrt;i++)
	      {
		react1[i].old1=dummy[(i-1)*7];
		react1[i].old2=dummy[(i-1)*7+1];
		react1[i].new1=dummy[(i-1)*7+2];
		react1[i].new2=dummy[(i-1)*7+3];
		for(j=1;j<i;j++)
		  if(((react1[j].old1==react1[i].old1)&&(react1[j].old2==react1[i].old2))
		     ||((react1[j].old1==react1[i].old2)&&(react1[j].old2==react1[i].old1)))
		    {
		      printf("Multiple Definition of Reaction %d+%d->\n",react1[j].old1,react1[j].old2);
		      return line_number;
		    }
		react1[i].bond=dummy[(i-1)*7+4];
		react1[i].dd=dummy[(i-1)*7+5];
                if(maxrb<react1[i].dd)maxrb=react1[i].dd;
		react1[i].dd*=react1[i].dd;
		react1[i].eo=dummy[(i-1)*7+6];
                react1[i].in=-1;
                react1[i].out =-1;
	      }
	    for (i=1;i<=nrt;i++)
	      printf("%d %d %d %d %d %lf %lf\n",react1[i].old1,react1[i].old2,
		     react1[i].new1,react1[i].new2,react1[i].bond,react1[i].dd,react1[i].eo);

	    current_key=next_key;
            break;
	  }

	case LIST_ATOMS:
	  {
	    int na=0;
	    printf("%s\n",keywords[current_key]);
	    set_new_bounds(L,maxrb,ndim);
	    dummy=top;
            do
	      {

                int nd=3;
                iatom * b;

		numword=0;
		if(!nextline)
		  {if(na==n1)goto finish;
		  else return line_number;}
		
		datfile=nextline;
		nextline=next_line(datfile);
if(line_number==278)
printf("at 278\n");
		next_key=iskeyword(datfile);
		if(next_key<0)return line_number;
                if((next_key>0)&&(n1!=na))return line_number;
                if(!next_key)
		  {
/* number type x y [z] v_x v_y [v_z]  */
                    if(na==n1)return line_number;
		    numword=0;
		    while(is_word(datfile))
		      {
			sscanf(datfile,"%lf",dummy+numword);
			numword++;
			if(!(datfile=next_word(datfile)))break;
		      }
		    if(!(((numword==6)&&(ndim==2))||(numword==8)))return line_number;
                    i=dummy[0];
		    if(dummy[0]!=i)return line_number;
                    j=dummy[1];
		    if(dummy[1]!=j)return line_number;
                    i--;
		    if((i<0)||(i>=n1)||a[i].c)return line_number;
		    if((j<1)||(j>nat))return line_number;
                    a[i]=sam[j];
                    a[i].c=j;
                    b=(iatom *)(a+i); 
                    if(numword==6)nd=2;
		    for(k=0;k<ndim;k++)
		      {
			b->r[k]=dummy[2+k]+coord_shift[k];
			if(b->r[k]>bound[k].length)b->r[k]-=bound[k].length;
			if(b->r[k]<0)b->r[k]+=bound[k].length;
			if(b->r[k]>bound[k].length)return line_number;
			if(b->r[k]<0)return line_number;
			b->i[k].i=(long)(b->r[k]/bound[k].dl);
			b->v[k]=dummy[2+nd+k];
		      }		    
		  }
		na++;
	      }while(!next_key);
	    current_key=next_key;
	    break;
	  }
	case LIST_BONDS:
	  {
	    printf("%s\n",keywords[current_key]);
	    numbond=0;
	    do
	      {
		if(!nextline)goto finish;
		datfile=nextline;
		nextline=next_line(datfile);
		next_key=iskeyword(datfile);
		if(next_key<0)
		  return line_number;
                if(!next_key)
		  {
                    double a=0;
		    numword=0;
		    /* atom1  atom2 */
		    while(is_word(datfile))
		      {
			sscanf(datfile,"%lf",top+numword);
			numword++;
			if(!(datfile=next_word(datfile)))break;
		      }
		    if(numword<2)return line_number;
		    i=top[0];
		    if(i!=top[0])return line_number;
		    for(k=numword-1;k>=1;k--)
		      {
			j=top[k];
			if(j!=top[k])return line_number;                  
			if((i<1)||(i>n1)||(j<1)||(j>n1))return line_number;
                        top[2*k-2]=i-1;
			top[2*k-1]=j-1;
			numbond++;
		      }
			top+=2*(numword-1);
		  }
	      }while(!next_key);
	  current_key=next_key;
	  break;
	  }
	case NUM_BONDS:
	  {
	    dummy=top;
	    printf("%s\n",keywords[current_key]);
	    if(!nextline)goto finish;	    
	    datfile=nextline;
	    nextline=next_line(datfile);
            /* what is maximal number of bonds */
	    sscanf(datfile,"%lf",dummy);
            lbt=dummy[0];
            if((lbt<1)||(lbt!=dummy[0]))return line_number;
	    if(!nextline)goto finish;	    
	    datfile=nextline;
	    nextline=next_line(datfile);
	    next_key=iskeyword(datfile);
	    if(next_key<=0)return line_number;
	    else current_key=next_key;
            break;
	  }
	case LIST_PARAM:
	  {
	    dummy=top;
	    printf("%s\n",keywords[current_key]);
	    do
	      {
		if(!nextline)goto finish;
		datfile=nextline;
		nextline=next_line(datfile);
		next_key=iskeyword(datfile);
		if(next_key<0)return line_number;
                if(!next_key)
		  {
		    isparam(datfile);
		  }
	      }while(!next_key);
	  current_key=next_key;
	  break;
	  }

	  
	case COL_TABLE:
	  {
	    dummy=top;
	    printf("%s\n",keywords[current_key]);
	    if(!nextline)goto finish;	    
	    datfile=nextline;
	    nextline=next_line(datfile);
            /* what is maximal number of bonds */
	    sscanf(datfile,"%lf",dummy);
            lct=dummy[0];
            if((lct<1)||(lct!=dummy[0]))return line_number;
	    if(!nextline)goto finish;	    
	    datfile=nextline;
	    nextline=next_line(datfile);
	    next_key=iskeyword(datfile);
	    if(next_key<=0)return line_number;
	    else current_key=next_key;
            break;
	  }

	default:
	  {
	    printf("%s\n",keywords[current_key]);
	    return line_number;
	  }
       }/* switch */


    }/* while (current_k) */
	finish:
	  if(nrt||numunstable)
	    {
	      collp=(well_type *)malloc(n1*sizeof(well_type));
	      if(!collp){nrt=numunstable=0;}
	      collq=(well_type *)malloc(n1*sizeof(well_type));
	      if(!collq){nrt=numunstable=0;}
	    }

  nrt=allocReact(react1,nrt,react0,numunstable);
  if(nrt<0)return line_number;
  if(!allocBonds(n1, numbond,nrt,lbt)){StopAlert (MEMORY_ALRT);return line_number;}

  if((make_bonds(numbond,bonds))<0)printf("error in bonds\n");
  else       
    printf("number of bonds= %d\n",numbond);
  printf("%ld %ld %ld %ld\n", (long)storage, (long)bonds, file_length,(long)top); 

 make_wells(coldata,numwell,bonddata,numbondwell,
	     bonds,numbond,a,n1,sam,nat);
/*  printwells(icoll,nat);*/
/*  printwells(ecoll,nat);*/
  free(storage);
  free(bonddata[0]);
  free(bonddata);  
  free(coldata[0]);
  free(coldata);  
return 1;
}
atom * get_sample_atoms(){return sam;}
int get_atom_types(){return nat;}
