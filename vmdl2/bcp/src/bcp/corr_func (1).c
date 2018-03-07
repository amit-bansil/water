#include <math.h>
#include <float.h>
#include <stdlib.h>
#include <stdio.h>
#include "bcp.h"
#include "bonds.h"
#include "controls.h"
#include "corr_func.h"

static moved_atom * a;
static dimensions * bound;
static short nAtoms;
static double * gr=0;
static double dim;
static long maxl;
static FILE * path;
static long n_mes=1;
static long i_mes;
static double delta1=1000; 
static double delta2;
static double bin=1.0;
static int good;

void init_gr(void)
{
  int i;
  if(good)
    for(i=0;i<maxl;i++)
      gr[i]=0;
  return;
}

int init_corr_func(void)
{
  char fname[80];
  int i;
  a=(moved_atom *)get_atom();
  bound =get_bounds();
  nAtoms=get_atom_number();
  dim=get_dimension();
  if(bound[2].period==1)
    dim=2;
  else 
    dim=3;
  do{
    close_corr_func();
    printf("Compute correlation function\n");
    if(!yes())return good;
    
    printf("What is file name?\n");
    scanf("%s",fname);
    path=fopen(fname,"w");
    if(!path)return good;
    
    printf("Radial bin= %lf\n",bin);
    if(!yes())
      {
	printf("Radial bin= ?\n");
	scanf("%lf",&bin);
      }
    
    maxl=bound[0].length/(2*bin);
    gr =(double *)malloc((long)maxl*sizeof(double));
    if(!gr)return good;
    for(i=0;i<maxl;i++)
      gr[i]=0;
    
    printf("time between measurements= %lf\n",delta1);
    if(!yes())
      {
	printf("time between measurements= ?\n");
	scanf("%lf",&delta1);
      }
    
    printf("number of measurements= %ld\n",n_mes);
    if(!yes())
      {
	printf("number of measurements= ?\n");
	scanf("%ld",&n_mes);
      }
    
    printf("File name for corr. func. =%s?\n",fname);
    printf("Radial bin= %lf\n",bin);
    printf("time between measurements= %lf\n",delta1);
    printf("number of measurements= %ld\n",n_mes);
  }while(!yes());
  
  delta2=0;
  i_mes=0;    
  good=1;
  return good;

}

void compute_gr(void)
{
  long i,j;
  double lx=bound[0].length;
  double ly=bound[1].length;
  double lz=bound[2].length;
  double lx2=lx/2;
  double ly2=ly/2;
  double lz2=lz/2;
  long maxl=lx/2;
  moveatoms(); 
  for(i=0;i<nAtoms;i++)
    { 
      for(j=0;j<nAtoms;j++)
        if(j!=i)
	  { 
	    double rx,ry,rz;
            long dd;
	    rx=a[i].r.x-a[j].r.x;
	    ry=a[i].r.y-a[j].r.y;
	    rz=a[i].r.z-a[j].r.z;
	    if(rx<-lx2)rx+=lx;
	    if(rx>lx2)rx-=lx;
	    if(ry<-ly2)ry+=ly;
	    if(ry>ly2)ry-=ly;
	    if(rz<-lz2)rz+=lz;
	    if(rz>lz2)rz-=lz;
	    dd=(long)(sqrt(rx*rx+ry*ry+rz*rz)/bin);
            if(dd<maxl)
	      gr[dd]++;
	  }
    }
}


void corr_func(double delta)
{
  if(good)
    {
      delta2+=delta;
      if (delta2>delta1)
	{
	  delta2-=delta1;
	  compute_gr();
	  i_mes++;
	  if(i_mes==n_mes)
	    {
	      i_mes=0;
              fprintf(path,"\n%lf %lf\n",get_time(),delta1);
	      good=write_gr();
	      init_gr();
	    }      
	}
    }
}

int write_gr(void)
{
  long nbyte;
  unsigned char s[512];
  long i; 
  int fErr=noErr;
  double pi;
  pi=4*atan((double)1);
  for(i=1;i<maxl;i++)
    {
      double dummy;
      if(dim>2)dummy=gr[i]/((4*i*(i+1)+1.3333333333)*pi*n_mes*nAtoms);
      else dummy=gr[i]/((2*i+1)*pi*n_mes*nAtoms);
      nbyte=sprintf(&s[0],"%lf %le \n",i*bin,dummy);
      if(nbyte<=0){fclose(path);free(gr); return 0;}
      fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);
      if(fErr){fclose(path);free(gr);return 0;}
    }
  return 1;
}


void close_corr_func(void)
{
  if(good)
    {
      good=0;
      free(gr);
      fclose(path);
      return;
    }
}

