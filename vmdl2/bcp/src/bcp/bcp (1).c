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


extern char *JAVA_FILENAME; //added 8/27 AB

char* text_name="junk_bcp.txt";
int text_no=10000;
FILE  * echo_path , * movie_path, * text_path;
int done,is_open,m_is_open,t_is_open;
long mticks=20;
long p1,q1,ct1;
long n_p_mes;

int xyz[4];
long n,n1,n2,n3,nen,nen0,nen1,ll,llp,coll_type=0,deltall;
long nrt;
double timeb,timec,delta,delta1,delta2,delta3,delta4,delta5,delta6,
dticks,timep,deltap,timed;
double vvm,corr,corr_2,timea,ts,virial;
double pressure,temperature,volume,dim,vvmtime;
double mes_time,temp_limit,coeff,avpres,avtemp; 
double dblarg1,dblarg2; 
/*double tballtime=0;
double totaltime=0;*/
double potential;
double avePot, potTime, avpot; 
atom *a;
well_type ** ecoll;
well_type ** icoll;

well_type * collp;
well_type * collq;

CollisionData *coll;
ReactionData *react;
dimensions bound[3];
crd o={0.0,0.0,0.0};
static    int px;
static    int py;
static    int pz;
static    double lx;
static    double ly;
static    double lz;


/* inpt - the pointer to the record with the next collision time.
*p1,q1,timea are the numbers of the particles next to collide and their
collision time, they are determined by the squeezetable which kill all
the records that contain the particles from the table. If q1>=n1, number of
atoms, (n is the number of atoms -1) 
it denotes the collision with the wall: q1-n is the direction
of the wall: x=1,y=2,z=3. twall defines with which wall it collides first,
newloc defines to which box the particle will go by means of reading
a triad r,v,i from a correct place of the atom structure. i is the
box number in each direction which is integer, but define as union with
double in order to maintaine the same length as velocity and position in
order to be able to read the triad by shifting. */

double next_double(double x)
{
  int y;
  double z=x;
  z=frexp(z,&y)+ldexp(DBL_EPSILON,-1);
  z=ldexp(z,y); 
  return z;
}
double prev_double(double x)
{
  int y;
  double z=x;
  z=frexp(z,&y)-ldexp(DBL_EPSILON,-1);
  z=ldexp(z,y); 
  return z;
}


void set_new_bounds(double *L, double maxrb,int ndim)
{     
  double ccell=maxrb;
  int i,y;
  ccell=next_double(ccell);
  dim=ndim;
  for(i=0;i<ndim;i++)
    {
      bound[i].period=L[i]/ccell;
      
      if(bound[i].period<3)
	{
	  bound[i].period=3;
	  bound[i].dl=ccell;
	  bound[i].length=ccell*3;
	}
      else
	{
	  bound[i].dl=L[i]/bound[i].period;
	  bound[i].length=bound[i].dl*bound[i].period;
          if((bound[i].dl<=maxrb)||(bound[i].length<L[i]))
	    {
	      bound[i].dl=next_double(bound[i].dl);
	    }
	  bound[i].length=bound[i].dl*bound[i].period;
	}
    printf("%d %lf %d %lf\n",i,bound[i].length,bound[i].period,bound[i].dl);
    }
if (ndim==2)
bound[2].length=bound[2].dl=bound[2].period=1;
}

void init_parameters(void)
{      
  corr_2=0;
  corr=0;
  timea=0; 
  timeb=0;
  timec=0;
  timed=0;
  ts=0;
  ll=0;
  m_is_open=is_open=t_is_open=0;
  return;
} 
void init_update_param(int * is_x)
{  
  int i;
  double mvx=0,mvy=0,mvz=0,mass=0;
  px=bound[0].period-1;
  py=bound[1].period-1;
  pz=bound[2].period-1;
  lx=bound[0].length;
  ly=bound[1].length;
  lz=bound[2].length;

      
  n2=n+2;
  n3=n+3;
  vvm=0.0;   
  printf("init update param");
   for(i=0;i<=n;i++)
    {
      if(a[i].r.x>=lx) a[i].r.x-=lx;
      if(a[i].r.x<0) a[i].r.x+=lx;
      if(a[i].r.y>=ly) a[i].r.y-=ly;
      if(a[i].r.y<0) a[i].r.y+=ly;
      if(a[i].r.z>=lz) a[i].r.z-=lz;
      if(a[i].r.z<0) a[i].r.z+=lz;
      a[i].i.x.i=a[i].r.x/bound[0].dl;
      a[i].i.y.i=a[i].r.y/bound[1].dl;
      a[i].i.z.i=a[i].r.z/bound[2].dl;            
      a[i].add=a[i].i.x.i+(a[i].i.y.i+a[i].i.z.i*bound[1].period)*bound[0].period;
      a[i].t=timeb;
      mvx+=a[i].m*a[i].v.x;
      mvy+=a[i].m*a[i].v.y;
      mvz+=a[i].m*a[i].v.z;
      mass+=a[i].m;
    }
  mvx/=mass;
  mvy/=mass;
  mvz/=mass;
  for(i=0;i<=n;i++)
    {
      a[i].v.x-=mvx;
      a[i].v.y-=mvy;
      a[i].v.z-=mvz;
      vvm+=a[i].m*dist(a[i].v,o);
    }
  printf("%lf %lf %lf \n",mvx,mvy,mvz);
  vvm*=0.5;
  if(!corr_2){corr_2=1;corr=sqrt(corr_2);}
  delta2=0;
  delta4=0;
  delta6=0;
  delta1=1000;
  delta3=1000;
  delta5=1000;
  dticks=60;
  xyz[0]=1;
  xyz[2]=2;
  xyz[3]=3;
  xyz[1]=1;
  deltall=n1;
  if(deltall<DELTALL)deltall=DELTALL;
  potential=0;
  pressure=dblarg1;
  temperature=dblarg1;
  avePot=dblarg1;
  mes_time=dblarg1;
  coeff=0;
  temp_limit=0;
  timep=0;
  vvmtime=0;
  virial=0;
  volume=1;
  dim=0;
  for(i=0;i<3;i++)
  if(is_x[i])
  {
  volume*=bound[i].length;
  dim++;
  }
  if(!is_x[2])bound[2].period=1;
  return; 
 } 
int cleanup(void)
{  
  int i;
  double mvx=0,mvy=0,mvz=0,mass=0;
  double vvm1;
  double corr1=1/corr;
  px=bound[0].period-1;
  py=bound[1].period-1;
  pz=bound[2].period-1;
  lx=bound[0].length;
  ly=bound[1].length;
  lz=bound[2].length;
  printf("cleanup");
  update_atoms();
  moveatoms();
  for( i=0;i<n1;i++)
    {
      a[i].v.x*=corr1;
      a[i].v.y*=corr1;
      a[i].v.z*=corr1;
    }
  reset_colldata();
  vvm/=corr_2;    
  corr_2=corr=1;
  timed+=timec;
  timec=timeb=0;
   for(i=0;i<=n;i++)
    {
      if(a[i].r.x>=lx) a[i].r.x-=lx;
      if(a[i].r.x<0) a[i].r.x+=lx;
      if(a[i].r.y>=ly) a[i].r.y-=ly;
      if(a[i].r.y<0) a[i].r.y+=ly;
      if(a[i].r.z>=lz) a[i].r.z-=lz;
      if(a[i].r.z<0) a[i].r.z+=lz;
      a[i].i.x.i=a[i].r.x/bound[0].dl;
      a[i].i.y.i=a[i].r.y/bound[1].dl;
      a[i].i.z.i=a[i].r.z/bound[2].dl;            
      a[i].add=a[i].i.x.i+(a[i].i.y.i+a[i].i.z.i*bound[1].period)*bound[0].period;
      a[i].t=timeb;
      mvx+=a[i].m*a[i].v.x;
      mvy+=a[i].m*a[i].v.y;
      mvz+=a[i].m*a[i].v.z;
      mass+=a[i].m;
    }
  mvx/=mass;
  mvy/=mass;
  mvz/=mass;
  vvm1=0.0;

  stop_atoms((moved_iatom*)a,n1); 
  for(i=0;i<=n;i++)
    {
      a[i].v.x=a[i].u.x;
      a[i].v.y=a[i].u.y;
      a[i].v.z=a[i].u.z;
      vvm1+=a[i].m*dist(a[i].v,o);
    }
  /*
  for(i=0;i<=n;i++)
    {
      a[i].v.x-=mvx;
      a[i].v.y-=mvy;
      a[i].v.z-=mvz;
      vvm1+=a[i].m*dist(a[i].v,o);
    }
  */
  printf("%lf %lf %lf \n",mvx,mvy,mvz);
  vvm1*=0.5;
  printf("%lf %lf\n",vvm1,vvm);
  if(!vvm1)return 0;
  vvm1=sqrt(vvm/vvm1);
  for(i=0;i<=n;i++)
    {
      a[i].v.x*=vvm1;
      a[i].v.y*=vvm1;
      a[i].v.z*=vvm1;
    }
  potential=0;
  pressure=dblarg1;
  temperature=dblarg1;
  avePot=dblarg1;
  mes_time=dblarg1;
  timep=0;
  vvmtime=0;
  virial=0;
  i=init_tables();
  if(i!=1)return 0;
  return 1; 
 } 


void add_potential(long ct)
{
  long k=ct; 
  potential+=coll[k].etot;
} 

long get_delta_ll(void)
{
  return deltall;
}

void set_delta_ll(long new_deltall)
{
  deltall=new_deltall;
}

double get_mes_time(void)
{
  if (mes_time!=dblarg1)
    return mes_time+timed;
  else 
    return timec+timed;
}

double get_temperature(void)
{
  if (temperature!=dblarg1)
  return temperature;
  else if(timep)
    return 2*vvmtime/(n1*dim*timep*corr_2);
  else 
    return 2*vvm/(n1*dim*corr_2);
}

double get_avePot(void)
{
  if (avePot!=dblarg1)
  return avePot;
  else if(timep)
    return potTime/timep;
  else 
    return potential;
}

void set_temp(double temp)
{ int i;double vvmo;
  vvmo=(temp*n1*dim)/2;
  corr_2=vvm/vvmo;
  for (i=0;i<nen;i++)
    {
      coll[i].e=coll[i].eo*corr_2;
      coll[i].edm=coll[i].edmo*corr_2;
    }
  corr=sqrt(corr_2);
  llp=0;
  virial=0;
  vvmtime=0;
  timep=0;
}

double get_temp(void)
{return 2*vvm/(n1*dim*corr_2);}


void rescale(void)
{ int i;
  double temp0=get_temperature();
  if (coeff)
    {
      double coeff1=coeff*timep*corr;
      if(coeff1>1)coeff1=1;
      corr_2*=temp0/(temp0*(1.0-coeff1)+temp_limit*coeff1);  
      for (i=0;i<nen;i++)
	{
	  coll[i].e=coll[i].eo*corr_2;
	  coll[i].edm=coll[i].edmo*corr_2;
	}
      corr=sqrt(corr_2);
    }
  llp=0;
  virial=0;
  vvmtime=0;
  potTime=0;
  timep=0;
}

void set_temp_limit(double t)
{
  temp_limit=t;
}

double get_temp_limit(void)
{
  return temp_limit;
}

void set_coeff(double c)
{
  coeff=c;
}

double get_coeff(void)
{
  return coeff;
}

double get_rate(void)
{return delta5;}

void set_rate(double rate)
{delta5=rate;delta6=0;}
/*
double get_rate(void)
{return 3600/(double)dticks;}

void set_rate(double rate)
{ 
 if (rate<3600/2000000000.0) dticks=2000000000;
 else dticks=3600/rate;
}
*/
int open_echo_file(int is_open,  char * fname)
{
  long nbyte,i,lmax;
  unsigned char s[512]; 
  int fErr=noErr;


  if(is_open)
    fErr=fclose(echo_path);
  if(fErr!=noErr)return 0;

  do
    {
      printf("open echo file? y/n\n");
      scanf("%s",fname);
      if(!strcmp(fname,"n"))return 0;
    }
  while(strcmp(fname,"y"));
  printf("what is echo file name ?\n");
  scanf("%s",fname);
  echo_path=fopen(fname,"wb");
  if(!echo_path)return 0;
  n_p_mes=0;
  avpres=0;
  avtemp=0;
  avpot=0;
  nbyte=sprintf(s,
		"     time \t      temperature \t  energy \t       radius \t     pressure \n");
  if(nbyte<=0){ fclose(echo_path);return 0;}
  if(fwrite(&s[0],1,nbyte,echo_path)!=nbyte){fclose(echo_path);return 0;}
  else return 1;
  
}

int set_text_name(int is_open,  char * fname)
{
  long nbyte;
  unsigned char s[512]; 
  int fErr=noErr;

  do
    {
      printf("open text file? y/n\n");
      scanf("%s",fname);
      if(!strcmp(fname,"n"))return 0;
    }
  while(strcmp(fname,"y"));
  printf("what is text file name ?\n");
  scanf("%s",fname);

  text_name=fname;
  return 1;

}


int open_movie_file(int is_open, char * fname)
{
 int fErr=noErr;
 
 if(is_open)
   fErr=closemovie(movie_path);
 if(fErr!=noErr)return 0;
 do
   {
     printf("open movie file? y/n\n");
     scanf("%s",fname);
     if(!strcmp(fname,"n"))return 0;
   }
 while(strcmp(fname,"y"));
 printf("what is movie file name ?\n");
 scanf("%s",fname);
 movie_path=fopen(fname,"wb");
 if(!movie_path)return 0;
 if(write_movie_header(movie_path))return 1;
 return 0;			
}




int write_echo(void)
{ long nbyte;
  unsigned char s[512];
  double time=get_mes_time();
  double energy=countenergy();
  double temp=n_p_mes ? avtemp/n_p_mes: get_temperature();
  double pot=n_p_mes ? avpot/n_p_mes: get_avePot();
  double gr=get_gr();
  double pressure=n_p_mes ? avpres/n_p_mes: get_pressure();
  /*  printf("%ld\n",n_p_mes);*/
  n_p_mes=0;
  avtemp=0;
  avpres=0;
  avpot=0;
  pot=-pot;
  printf("%lf\n",time); 
  nbyte=sprintf(&s[0],"%12.3lf\11%12.3lf\11%12.3lf\11%17.10lf\11%17.10lf\n"
		,time,temp,pot,gr,pressure);
  if(nbyte<=0){ fclose(echo_path);return 0;}
  if(fwrite(&s[0],1,nbyte,echo_path)!=nbyte){fclose(echo_path);return 0;}
  else 
    return 1;
  
}



void set_time(double time)
{
timec=time;
}
double get_time(void){
	return (double)(timec+timed);
}

void set_frate(double frate)
{
  delta1=frate;
  delta2=0;
}
double get_frate(void)
{return delta1;}
void set_mfrate(double frate)
{
delta3=frate;
delta4=0;
}
double get_mfrate(void)
{return delta3;}


void vp(crd * a, crd * b, crd * c)
{
  c->x=a->y*b->z-a->z*b->y;
  c->y=a->z*b->x-a->x*b->z;
  c->z=a->x*b->y-a->y*b->x;
}
double dist(crd r,crd s)
{
double x1,y1,z1;
x1=r.x-s.x;
y1=r.y-s.y;
z1=r.z-s.z;
return(y1*y1+x1*x1+z1*z1);
}





long reaction (atom *a,long i1,long i2, long ct1,double sc,double x,double y,double z)
{  
  int ct=ct1;
  int rtype;
  int revers;
  if(sc<0)
    {
      rtype=coll[ct1].react;
      if(rtype<=0)return -1;
      revers=0;
    }
  else
    {
      ct=coll[ct1].prev;
      rtype=~coll[ct].react;
      if(rtype<=0)return -1;
      revers=1;
    }
  {
    long out,i,j,ix,iy,iz;//everying except i is unused
    double ab1,ab2,vx,vy,vz,ab,di,ed;
    atom *a1,*a2;
    double old_pot=coll[ct1].etot;
    double du,duc,new_pot=0;
    long ct_new;
    short np=get_np();  
    short nq=get_nq();  
    short * ap=get_atomp();  
    short * aq=get_atomq();  
    short * cp=get_collp();  
    short * cq=get_collq();
    int bond,iq,ip;
    int old1,old2,new1,new2;  
    double m1,m2;
    a1=a+i1;
    a2=a+i2;
    old1=a1->c;
    old2=a2->c;
    m1=a1->m;
    m2=a2->m;
    if(!revers)
      {
	if(old1==react[rtype].old1)
	  {
	    new1=react[rtype].new1;
	    new2=react[rtype].new2;
	  }
	else 
	  {
	    new1=react[rtype].new2;
	    new2=react[rtype].new1;
	  }
      }
    else
      {
	if(old1==react[rtype].new1)
	  {
	    new1=react[rtype].old1;
	    new2=react[rtype].old2;
	  }
	else 
	  {
	    new1=react[rtype].old2;
	    new2=react[rtype].old1;
	  }
      }



    if(revers)
      ct_new=react[rtype].out;
    else
      ct_new=react[rtype].in;

    new_pot+=coll[ct_new].etot;
    if(old1!=new1)
      {
	a1->c=new1;
	for(i=0;i<np;i++)
	  {
	    ip=ap[i];
	    if(ip!=i2)
	      {
		old_pot+=coll[cp[ip]].etot;
		moveatom(a+ip);
		bond=is_bond(cp[ip]);
		collp[ip]=after_type(i1,ip,&bond,cp[ip]);
		if(collp[ip]<0)return -1;
		new_pot+=new_pot+coll[collp[ip]].etot;
		if(bond)collp[ip]=~(collp[ip]);
	      }
	  }
      }
    if(old2!=new2)
      {
	a2->c=new2;
	for(i=0;i<nq;i++)
	  {
	    iq=aq[i];
	    if(iq!=i1)
	      {
		old_pot+=coll[cq[iq]].etot;
		moveatom(a+iq);
		bond=is_bond(cq[iq]);
		collq[iq]=after_type(i2,iq,&bond,cq[iq]);
		if(collq[iq]<0)return -1;
		new_pot+=coll[collq[iq]].etot;
		/* we remember that bonds was broken storing negatives in collq */ 
		if(bond)collq[iq]=~(collq[iq]);
	      }
	  }
      }
    /* we are done with defininig new_pot and old_pot */
    du=new_pot-old_pot;
    if(!react[rtype].bond)du+=react[rtype].eo;
    duc=du*corr_2;
    ed=2*duc/(m1*m2*coll[ct].dm);
    di=1.0+ed/(sc*sc);
    if(di<=0)
      {
	
	/*	when ed is large negative, it is
		unsuccessfull attempt to escape: 
		reaction do not happen */   
	ab=-2.0*sc*coll[ct].dm;
	a1->c=old1;
	a2->c=old2;
	if(!revers)return -1;           
	ct_new=ct1;
      }
    else
      {
	ab=sc*coll[ct].dm*(sqrt(di)-1.0);
	vvm+=duc;
	potential+=du;
	if((react[rtype].old1!=react[rtype].new1)||(react[rtype].old2!=react[rtype].new2))
	  setNewTypes(1);
	if(revers)
	  breakBond(i1,i2);
        else if(react[rtype].bond)
	  setBond(i1,i2);
	if(new2!=old2)
	for(i=0;i<nq;i++)
	  {
	    iq=aq[i];
            if(iq!=i1)
	      {
		if(collq[iq]<0)
		  {
		    breakBond(i2,iq);
		    cq[iq]=~collq[iq];
		  }
		else
		  cq[iq]=collq[iq];
	      }
	  }
	if(new1!=old1)
	for(i=0;i<np;i++)
	  {
	    ip=ap[i];
            if(ip!=i2)
	      {
		if(collp[ip]<0)
		  {
		    breakBond(i1,ip);
		    cp[ip]=~collp[ip];
		  }
		else
		  cp[ip]=collp[ip];
	      }
	  }
	cp[i2]=ct_new;

      }
/*    fprintf(tail,"%d %d %d\n",rtype,(int)(potential*1000),i1);*/    
    ab1=ab*m2;
    ab2=-ab*m1;
    virial+=ab1*m1*coll[ct].dd;
    a1->v.x+=x*ab1;
    a1->v.y+=y*ab1;
    a1->v.z+=z*ab1;
    a2->v.x+=x*ab2;
    a2->v.y+=y*ab2;
    a2->v.z+=z*ab2;
    return ct_new; 
  }
}

long newvel (atom *a,long i1,long j1, long ct1)
{  
  long out,i,j,ix,iy,iz;
  double ab1,ab2,vx,vy,vz,x,y,z,ab,sc,di,ed;
  atom *a1,*a2;
  long k, ct=ct1;
  if(i1<j1)
    {
      i=i1;
      j=j1;
    }
  else
    {
      i=j1;
      j=i1;
    }



  a1=a+i;
  a2=a+j;
  moveatom(a1);
  moveatom(a2);
  vx=a1->v.x-a2->v.x;
  vy=a1->v.y-a2->v.y;
  vz=a1->v.z-a2->v.z;
  x=a1->r.x-a2->r.x;
  y=a1->r.y-a2->r.y;
  z=a1->r.z-a2->r.z;
  ix=a1->i.x.i-a2->i.x.i;
  iy=a1->i.y.i-a2->i.y.i;
  iz=a1->i.z.i-a2->i.z.i;
  if (ix>1)x-=bound[0].length;
  else if (ix<-1)x+=bound[0].length;
  if (iy>1)y-=bound[1].length;
  else if (iy<-1)y+=bound[1].length;
  if (iz>1)z-=bound[2].length;
  else if (iz<-1)z+=bound[2].length;
  sc=vx*x+vy*y+vz*z;

if(nrt)
    {
long ctr;

      ctr=reaction(a,i,j,ct1,sc,x,y,z);

      if(ctr>-1){return ctr;}


    }

  k=ct;
  ed=coll[k].edm;
  /*  k=ct&UNSTABLE;  type of collision */

  if(sc>=0)
    {
/*if sc>=0 the atoms are moving away, we should take outer parameters of the outer well */
      k=coll[k].prev;
      ed=-coll[k].edm;  /* depth of potential well */
      /* attempt to escape from the well; external collisions are 
	 sometimes with finite energy; then the energy is taken with
	 negative sign in oppose to the case when the attoms are jumping 
	 in the well. coll[k].e is the depth of well is positive for
	 attraction */ 
    }
  if(coll[k].e==-dblarg1)
    {
 /* energy as dblarg1 always means ellastic repulsion */
      ab=-2.0*sc*coll[k].dm;
/*      if(sc>=0.0) 
	ct|=STABLE; */
    }
  else 
    {
      di=1.0+ed/(sc*sc);
      if(di<=0)
	{

/*	when ed is large negative, it is
    unsuccessfull attempt to escape: 
    ellastic collision */   
	  ab=-2.0*sc*coll[k].dm;
/*	  if(sc>=0.0) 
	    ct|=STABLE; */
	}
      else
	{
	  ab=sc*coll[k].dm*(sqrt(di)-1.0);
	  if (sc>=0.0) 
	    {
/*	   atoms jumped out of the well and move to a previous well*/  
	      ct=k;
	      vvm-=coll[k].e;
	      potential-=coll[k].eo;
	    }
	  else 
	    {
	      /* atoms jumed into the next well */
	      vvm+=coll[k].e;
	      potential+=coll[k].eo;
	      ct=coll[k].next;
	    }
	}
    }
  ab1=ab*a2->m;
  ab2=-ab*a1->m;
  virial+=ab1*a1->m*coll[k].dd;
  a1->v.x+=x*ab1;
  a1->v.y+=y*ab1;
  a1->v.z+=z*ab1;
  a2->v.x+=x*ab2;
  a2->v.y+=y*ab2;
  a2->v.z+=z*ab2;
  return ct; 

}

/* i1 atom number
   j1 is wall number :
      n+1 for x
      n+2 for y
      n+3 for z   */
newloc (atom *a,long i1,long j1)
{  
  long xy,i;
  atom *a1;
  triad *b;
  double *aa;
  dimensions *bound1;
  long address,step,period;
  a1=a+i1;
  moveatom(a1);
  aa=(double *)a1;
  xy=j1-n1;
/*xy determine the place from which to take coordinates */ 
  aa+=xy;
  b=(triad *)aa;
  bound1=&bound[xy];
/* take the old box number of the atom 
and decrease or increase it accordingly */
  i=b->i.i;
  if(b->v>0)
    {
      i++;
      if (i==bound1->period)
	{
	  i=0;
	  b->r-=bound1->length;
	}
    }
  else
    {      
      i--;
      if (i==-1)
	{
	  i+=bound1->period;
	  b->r+=bound1->length;
	}	
    }
  b->i.i=i;
  address=a1->i.x.i+bound[0].period*(a1->i.y.i+bound[1].period*a1->i.z.i);
  a1->add=address;
  find_atoms(i1);
 }

long twall(long i, double * t1)

{
  double s, x ,d ,y,z,rx ,ry,rz,vx,vy,vz,hry,wrx,drz,vv;
  atom *pt;
  double t;
  long q;
  pt=a+i;
  q=n3;
  y=dblarg1;
  x=dblarg1;
  z=dblarg1;

  rx=pt->r.x;
  ry=pt->r.y;
  rz=pt->r.z;

  vx=pt->v.x;
  vy=pt->v.y;
  vz=pt->v.z;

  wrx=pt->i.x.i*bound[0].dl;
  hry=pt->i.y.i*bound[1].dl;
  drz=pt->i.z.i*bound[2].dl;

  rx-=wrx;
  ry-=hry;
  rz-=drz;

  wrx=bound[0].dl-rx;
  hry=bound[1].dl-ry;
  drz=bound[2].dl-rz;
  
  if (vx<0) 
    x=-rx/vx;
  if (vx>0)
    x=wrx/vx;
  if (vy<0)
    y=-ry/vy;
  if (vy>0)
    y=hry/vy;
  if (vz<0)
    z=-rz/vz;
  if (vz>0)
    z=drz/vz;

  t=z;

  if ((x<z)||(y<z))
    {
      t=y;
      q=n2;
      if(x<y)
	{
	  t=x;
	  q=n1;
	}
    }
  if(t<dblarg1)t+=pt->t;
  pt->w=t;

  *t1=t;
  return q;
}


long tball(long i,long j,long ct, double * t1)
{
  long k,ix,iy,iz;
/*  long ticks=clock();*/
  atom *a1,*a2;
  double t=dblarg1;
  long q=0;
  double ab,sc,di,de,x,y,z,u,dd,v,w,dt;
  a1=a+i;
  a2=a+j;
/*  k=ct&UNSTABLE; */
  k=ct;
  moveatom(a1);
  moveatom(a2);

  u=a2->v.x-a1->v.x;
  v=a2->v.y-a1->v.y;
  w=a2->v.z-a1->v.z;
  ab=u*u+v*v+w*w;
  if (ab)
    {
      x=a2->r.x-a1->r.x;
      y=a2->r.y-a1->r.y;
      z=a2->r.z-a1->r.z;
      ix=a2->i.x.i-a1->i.x.i;
      iy=a2->i.y.i-a1->i.y.i;
      iz=a2->i.z.i-a1->i.z.i;
      if (ix>1)x-=bound[0].length;
      if (ix<-1)x+=bound[0].length;
      if (iy>1)y-=bound[1].length;
      if (iy<-1)y+=bound[1].length;
      if (iz>1)z-=bound[2].length;
      if (iz<-1)z+=bound[2].length;

      sc=u*x+v*y+w*z;
      de=(x*x+y*y+z*z)*ab-sc*sc;
        
      if (sc<0.0)
	{
	  di=ab*coll[k].dd-de;
	  if (di>0.0)
	    t=(-sc-sqrt(di))/ab;
	}
      if((t==dblarg1)&&(coll[k].prev>-1))
	{ 
	  t=(-sc+sqrt(ab*coll[coll[k].prev].dd-de))/ab;
	}   
 
    } 
    if (t<dblarg1)t+=a1->t;
    if((coll[k].prev>-1)||((t<=a1->w)&&(t<=a2->w)))	  q=1;

  *t1=t;
/*  ticks=clock()-ticks;
  if(ticks)printf("%ld\n",ticks);
  tballtime+=ticks; */ 
  return q;
}


int collision_type(int i, int k)
{  
  short ic=a[i].c;
  double rx,ry,rz,dr;
  int ia,ky,kz;
  int link_err=isFriend(k,i);
  int kc=a[k].c;
  int ie=ecoll[ic][kc];
  int ix=a[i].i.x.i;
  int iy=a[i].i.y.i;
  int iz=a[i].i.z.i;
  int kx=ix-a[k].i.x.i;
  int ct=ie;
  ia=abs(kx);
  if((ia>1)&&(ia!=px))goto far_away;
  ky=iy-a[k].i.y.i;
  ia=abs(ky);
  if((ia>1)&&(ia!=py))goto far_away;
  kz=iz-a[k].i.z.i;
  ia=abs(kz);
  if((ia>1)&&(ia!=pz))goto far_away;
  rx=a[i].r.x-a[k].r.x;
  ry=a[i].r.y-a[k].r.y;
  rz=a[i].r.z-a[k].r.z;
  if(kx<-1)rx+=lx;
  if(kx>1)rx-=lx;
  if(ky<-1)ry+=ly;
  if(ky>1)ry-=ly;
  if(kz<-1)rz+=lz;
  if(kz>1)rz-=lz;
  dr=rx*rx+ry*ry+rz*rz;
  if(link_err)
    {
      int ii=icoll[ic][kc];
      if(ii>-1)
	{
	  if(dr<coll[ii].dd)
	    { 
	      for(ii=coll[ii].next;ii>-1;ii=coll[ii].next)
		{
		  if(dr>coll[ii].dd)
		    {
		      link_err=0;
		      ct=ii;
		      goto far_away;
		    }
		}
	    }
	}
    }

  while(ie>-1)
    {
      if(dr>=coll[ie].dd)
	{
	  ct=ie;
          goto far_away;
	}
      ie=coll[ie].next;
    }
  too_close_dialog(k,i);
  return -3;
 far_away:
  if(link_err)breakBond(i,k);
  return ct;
}	

int after_type(int i, int k, int * link_err,int old_ct)
{  
  short ic=a[i].c;
  int prev=coll[old_ct].prev;
  double rx,ry,rz,dr;
  int ia,ky,kz;
  int kc=a[k].c;
  int ie=ecoll[ic][kc];
  int ix=a[i].i.x.i;
  int iy=a[i].i.y.i;
  int iz=a[i].i.z.i;
  int kx=ix-a[k].i.x.i;
  int ct=ie;
  ia=abs(kx);
  if((ia>1)&&(ia!=px))return ct;
  ky=iy-a[k].i.y.i;
  ia=abs(ky);
  if((ia>1)&&(ia!=py))return ct;
  kz=iz-a[k].i.z.i;
  ia=abs(kz);
  if((ia>1)&&(ia!=pz))return ct;
  rx=a[i].r.x-a[k].r.x;
  ry=a[i].r.y-a[k].r.y;
  rz=a[i].r.z-a[k].r.z;
  if(kx<-1)rx+=lx;
  if(kx>1)rx-=lx;
  if(ky<-1)ry+=ly;
  if(ky>1)ry-=ly;
  if(kz<-1)rz+=lz;
  if(kz>1)rz-=lz;
  dr=rx*rx+ry*ry+rz*rz;
  if(dr<=coll[old_ct].dd)
    {
      dr=next_double(coll[old_ct].dd);
     }
  if(prev>-1)
    {
      if(dr>=coll[prev].dd)
	dr=prev_double(coll[old_ct].dd);
     }

  if(*link_err)
    {
      int ii=icoll[ic][kc];
      if(ii>-1)
	{
	  if(dr<coll[ii].dd)
	    { 
	      for(ii=coll[ii].next;ii>-1;ii=coll[ii].next)
		{
		  if(dr>coll[ii].dd)
		    {
		      *link_err=0;
		      ct=ii;
		      return ct;
		    }
		}
	    }
	}
    }

  while(ie>-1)
    {
      if(dr>=coll[ie].dd)
	{
	  ct=ie;
          return ct;
	}
      ie=coll[ie].next;
    }
  return -1;
}	



moveatom( atom *pt)
{ double delta=timeb-pt->t;
  if(delta)
  {
      pt->r.x=pt->r.x+pt->v.x*delta;
      pt->r.y=pt->r.y+pt->v.y*delta;
      pt->r.z=pt->r.z+pt->v.z*delta;
      pt->t=timeb;
   }
}
void moveatoms(void)
{ double delta;
  atom *pt;
  for (pt=a;pt->c!=0;pt++)
    { 
      delta=timeb-pt->t;    
      pt->q.x=pt->r.x+pt->v.x*delta;
      pt->q.y=pt->r.y+pt->v.y*delta;
      pt->q.z=pt->r.z+pt->v.z*delta;
    }
}

void update_atoms(void)
{ double delta;
  atom *pt;
  for (pt=a;pt->c!=0;pt++)
    { 
      delta=timeb-pt->t;    
      pt->r.x=pt->r.x+pt->v.x*delta;
      pt->r.y=pt->r.y+pt->v.y*delta;
      pt->r.z=pt->r.z+pt->v.z*delta;
      pt->t=timeb;
    }
}

void reset_colldata(void)
{
  int i;
      for (i=0;i<nen;i++)
	{
	  coll[i].e=coll[i].eo;
	  coll[i].edm=coll[i].edmo;
	}
      return;
}

void corr_vel(void)
{
  int i;
  double corr1=1/corr;
  for( i=0;i<n1;i++)
    {
      a[i].u.x=a[i].v.x*corr1;
      a[i].u.y=a[i].v.y*corr1;
      a[i].u.z=a[i].v.z*corr1;
    }
}

double countenergy(void)
{
  return -potential;
}

double get_pressure(void)
{ 
  if (pressure!=dblarg1)
  return pressure;
  else if(timep)
  return (virial+vvmtime+vvmtime)/(volume*dim*timep*corr_2);
  else 
  return dblarg1;
}

int collision()
{ long i,k;
  int coll_type=0;
  double vvm0,t2,corrt1;
  t2=timea-timeb;
  timeb=timea;
  ts++;
  corrt1=t2*corr;
  timec+=corrt1;
  timep+=t2;
  vvmtime+=t2*vvm;
  potTime+=t2*potential;
  delta2+=corrt1;
  delta4+=corrt1;
  if(t_is_open)delta6+=corrt1;
  if (q1>=n1)
    newloc(a,p1,q1);
  else 
    {
      coll_type=1;
      ll++;
      llp++;
      ct1=newvel (a,p1,q1,ct1); /*virial is computed inside newvel*/
      if(llp==deltall)
	{
	  pressure=(virial+vvmtime+vvmtime)/(volume*dim*timep*corr_2);
	  temperature=2*vvmtime/(n1*dim*timep*corr_2);
          avePot=potTime/timep;
	  mes_time=timec;
	  if(is_open)
	    {
	      n_p_mes++;
	      avpres+=pressure;
	      avtemp+=temperature;
              avpot+=avePot;
	    }
	  if(m_is_open)add_movie_param(temperature,-avePot,
temperature*0.5*dim*n1-avePot,pressure);
	  rescale();
	}
    }
  
  if (delta2>delta1)
    {
      delta2-=delta1;
      if(is_open)
	{
	  is_open=write_echo();
	}     
    }
  if (delta4>delta3)
    {
      delta4-=delta3;
      if(m_is_open)m_is_open=write_movie_frame();
    }
  if (delta6>delta5)
    {
      if(!coll_type)
	{
	  delta6-=delta5;
	  writetext(text_name);
	}
    }

  corr_func(corrt1);
  return coll_type;
}


int writetext (char* fname)
{
  /*char * dig="0123456789";
  char * newname;*/
  long fErr=0;
  FILE * path;
  /*int i,k,j=text_no;
  int name_length=strlen(fname);
  newname=malloc(name_length+5);
  for(i=0;i<name_length;i++)
    newname[i]=fname[i];
  name_length+=4;
  newname[name_length]=(char)0;
  for(i=name_length-1;i>=name_length-4;i--)
    {
      k=j % 10;
      newname[i]=dig[k];
      j=j/10;
    }*/
  path=fopen(/*new*/fname,"wb");//newname->fname
  //free(/*new*/fname);/*caused access violation amit 7 4 02*/
  if(!path)return 1;
  fErr=write_key_coord(path);
  if(fErr==noErr)
    {
      fflush(path);
      fclose(path);
      text_no++;
      return 0;
    }
  else 
    return 1;			
}

void stop_atoms(moved_iatom * a, int n)
{    
  double  rx,sx,dx,sm;
  long i,j,k;
  double A[3][3];
  double W[3],W1[3],M[3];
  double I,smax,norm;
  double corr1=1/corr;
  printf("stop atoms");
  sm=0; 
  for(i=0;i<n;i++)
    sm+=a[i].m;
  
  for(j=0;j<3;j++)
    {
      rx=a[0].r[j];
      a[0].r[j]=0;
      sx=0;
      for(i=1;i<n;i++){ 
	dx=a[i].r[j]-rx;
	if(dx+dx<-bound[j].length)dx+=bound[j].length;
	if(dx+dx>bound[j].length)dx-=bound[j].length;
	rx=a[i].r[j];
	a[i].r[j]=a[i-1].r[j]+dx;
	sx+=a[i].r[j]*a[i].m;
      }
      sx/=sm;
      for(i=0;i<n;i++)
	a[i].r[j]-=sx;
    }

    for(j=0;j<3;j++)
      {
	sx=0;
	for(i=0;i<n;i++){ 
	  sx+=a[i].v[j]*a[i].m;
	}
	sx/=sm;
	for(i=0;i<n;i++)
	  a[i].u[j]=(a[i].v[j]-sx)*corr1;
      }

  I=0;
  for(i=0;i<3;i++)
    {
      for(j=0;j<3;j++)
	{
	  double  rij=0;
	  for(k=0;k<n;k++)
	    {
	      rij+=a[k].r[i]*a[k].r[j]*a[k].m;
	    }
	  A[i][j]=rij;
	}
      I+=A[i][i];
      M[i]=0;
    }
  if(!I) return;
  for(k=0;k<n;k++)
    {
    M[2]+=(a[k].r[0]*a[k].u[1]-a[k].r[1]*a[k].u[0])*a[k].m;
    M[0]+=(a[k].r[1]*a[k].u[2]-a[k].r[2]*a[k].u[1])*a[k].m;
    M[1]+=(a[k].r[2]*a[k].u[0]-a[k].r[0]*a[k].u[2])*a[k].m;
  }
    printf("%lf %lf %lf\n",M[0],M[1],M[2]);
norm=0;
  for(i=0;i<3;i++)
    {
      for(j=0;j<3;j++)
	{
	  A[i][j]/=I;
	  /*	  printf("%lf ",A[i][j]);*/
	}
      /* printf("\n"); */
      M[i]/=I;
      W[i]=M[i];
      norm+=M[i]*M[i];
    }
  k=0;
  norm*=1.0e-32;
  do{
    smax=0;
    for(i=0;i<3;i++)
      {
	double s=0;
	for(j=0;j<3;j++)
	  s+=A[i][j]*W[j];
	W1[i]=s;
      }
    for(i=0;i<3;i++)
      {double s1=W1[i]+M[i];
       double s=s1-W[i];
       smax+=s*s; 
      W[i]=s1;
     }
    /*    printf("%le\n",smax);*/
    k++;
if(k==1000)break;
  }while(smax>norm);


    for(k=0;k<n;k++)
      {
	a[k].u[2]-=W[0]*a[k].r[1]-W[1]*a[k].r[0];
	a[k].u[0]-=W[1]*a[k].r[2]-W[2]*a[k].r[1];
	a[k].u[1]-=W[2]*a[k].r[0]-W[0]*a[k].r[2];
      }
    /*    
  for(j=0;j<3;j++)
    M[j]=0;
  for(k=0;k<n;k++)
    {
      M[2]+=(a[k].r[0]*a[k].u[1]-a[k].r[1]*a[k].u[0])*a[k].m;
      M[0]+=(a[k].r[1]*a[k].u[2]-a[k].r[2]*a[k].u[1])*a[k].m;
      M[1]+=(a[k].r[2]*a[k].u[0]-a[k].r[0]*a[k].u[2])*a[k].m;
    }
   printf("%le %le %le\n",M[0],M[1],M[2]);
    */   
  for(j=0;j<3;j++)
    {
      sx=bound[j].length*0.5;
      for(i=0;i<n;i++) 
	a[i].r[j]+=sx;
    }
  /*
	printf("%lf %lf %lf\n%d\n",
bound[0].length,bound[1].length,bound[2].length,n);
  for(i=0;i<n;i++)
    {
	printf("%d %d ",i+1,a[i].c);
      for(j=0;j<3;j++)
	printf("%lf ",a[i].r[j]);
      for(j=0;j<3;j++)
	printf("%lf ",a[i].u[j]);
      printf("\n");
    }
  */

  return;

}



main()
{ long ares;
/*  tail=fopen("junk","w");*/
  if((ares=startup())<1){if(!ares)StopAlert(FILE_ALRT);return;}
  else if(ares>MOVIE){ares-=MOVIE;text_error_dialog(ares);return;}
  if(ares!=MOVIE)
  ct1=squeeze_table(&p1,&q1,&timea); 
  else
  return;
  event_loop(options_dialog());
/*printf("%lf %lf\n",totaltime,tballtime);*/
  writetext(text_name); 
  if(is_open){fclose(echo_path);}
  if(m_is_open)closemovie(movie_path);
  close_corr_func();
  close_rms();
/*fclose(tail);*/

}
event_loop(double maxtime)
/* Wait for events from the user, and respond to them.  Exit if the functions
   handling the events set the done variable to true. */
{
  while ((get_time()<maxtime)||coll_type) 
    {
      /*      long ticks=clock(); */
      coll_type=collision();
      update_table(p1,q1,ct1);
      rms();
      if((corr_2>1.0e1)||(corr_2<1.0e-1))
	if(!coll_type)
	  if(!cleanup())break;
	
      ct1=squeeze_table(&p1,&q1,&timea);
      /*    totaltime+=clock()-ticks;*/
    }
}

int readfile (void)
{
  
  long fErr,ares;
  long nbyte;
  int filetype;
  FILE  *path;
  unsigned char * s;
  char *fname;
  int nn;
  //printf("what is file name ?\n");
  //scanf("%s",fname);
  fname=JAVA_FILENAME;//Modified 8/27 AB to avoid using sio
  path=fopen(fname,"rb");
  if(!path) return 0;
  text_path=path;return TEXT;
}  

atom * get_atom(void){return a;}
int get_atom_number(void){return n1;}
int get_dimension(void){return (int)dim;}
dimensions * get_bounds(void){return &bound[0];}
double get_movie_dt(void){return delta3;}
int is_reaction(well_type k){int i=coll[k].react;return i>-1?i:~i;}
int is_bond(well_type k){int i=coll[k].react;return (int)(i<0);} 
int is_internal(well_type k){return coll[k].prev==-1?0:1;} 
double etot(well_type k){return coll[k].etot;}
double get_corr(void){return 1/corr_2;}
long get_ll(void){return ll;}
