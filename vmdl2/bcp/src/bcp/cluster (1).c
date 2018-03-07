#include <math.h>
#include <float.h>
#include <stdlib.h>
#include "bcp.h"
#include "bonds.h"
#include "controls.h"
#include "rms.h"
#include "cluster.h"

static moved_atom * a;
static dimensions * bound;
static crd * r;
static short nAtoms;
static short n0;
static short burnNumber;
static short clNumber;
static short * burn;
static short * mols;
static int good;
static double threshold;

double sx,sy,sz,ssx,ssy,ssz,mass;

void resetAll(int k)
{
  sx=0;
  sy=0;
  sz=0;
  ssx=0;
  ssy=0;
  ssz=0;
  mass=a[k].m;
  r[k].x=0;
  r[k].y=0;
  r[k].z=0;
}
  
void sumAll(int k)  
{
  sx+=r[k].x*a[k].m;
  sy+=r[k].y*a[k].m;
  sz+=r[k].z*a[k].m;
  ssx+=r[k].x*r[k].x*a[k].m;
  ssy+=r[k].y*r[k].y*a[k].m;
  ssz+=r[k].z*r[k].z*a[k].m;
  mass+=a[k].m;
  return; 
}  


void newCoord(int i,int j)
{  
  short ix,iy,iz;
  double x, y, z; 
  moved_atom * a2=a+i; 	
  moved_atom * a1=a+j;    
  x=a1->r.x-a2->r.x;
  y=a1->r.y-a2->r.y;
  z=a1->r.z-a2->r.z;
  ix=a1->i.x.i-a2->i.x.i;
  iy=a1->i.y.i-a2->i.y.i;
  iz=a1->i.z.i-a2->i.z.i;
  if (ix>1)x-=bound[0].length;
  if (ix<-1)x+=bound[0].length;
  if (iy>1)y-=bound[1].length;
  if (iy<-1)y+=bound[1].length;
  if (iz>1)z-=bound[2].length;
  if (iz<-1)z+=bound[2].length;
  r[j].x=r[i].x+x;
  r[j].y=r[i].y+y;
  r[j].z=r[i].z+z; 
}

int init_clusters(void)
{ 
  a=(moved_atom *)get_atom();
  bound =get_bounds();
  nAtoms=get_atom_number();
  good=0;
  threshold=0;
  if(!(r=(crd *) malloc(nAtoms*sizeof(crd))))return good;
  if(!(burn=(short *) malloc((nAtoms+1)*sizeof(short))))return good;
  if(!(mols=(short *) malloc((nAtoms+1)*sizeof(short))))return good;
  printf("Compute gyration radius\n");
  if(!yes())return good;
    printf("Minimal Molecular Mass= %lf\n",threshold);
   if(!yes())
     {
       printf("Minimal Molecular Mass= ?\n");
       scanf("%lf",&threshold);
     }
    printf("Minimal Molecular Mass= %lf\n",threshold);
  n0=0;
  if(is_rms())
      {
	nAtoms=n_rms();
        n0=n0_rms();
	a+=n0; 
      }
  good=1;
  return good;
}

double get_gr(void)
{ 
  int i,index, atomIndex,friendIndex; 
  double gr, totalMass;
  if(!good)return (double)get_ll();
  moveatoms();
  for(i = 0; i <= nAtoms; i++)
    mols[i] = -1;
  gr=0;
  totalMass=0;
  clNumber = 0;
  index = 0;
  while(index < nAtoms)
    {
      while(mols[index] >= 0)
	index++;
      if(index >= nAtoms)
	break;
      
      burnNumber = 1;
      clNumber++;
      mols[index] = clNumber;
      burn[0] = index;
      resetAll(index);
      
      while(burnNumber > 0)
	{
	  burnNumber--;
	  atomIndex = burn[burnNumber];
	  i=-1;
	  do
	    {
	      friendIndex = nextFriend(atomIndex+n0,&i)-n0;
              if(i==-1)break;
              if((friendIndex>=0)&&(friendIndex<nAtoms))
		{
		  if(mols[friendIndex]==-1)
		    {
		      burn[burnNumber] = friendIndex;
		      mols[friendIndex] = clNumber;
		      burnNumber++;  
		      newCoord(atomIndex,friendIndex);
		      sumAll(friendIndex);
		    }
		}
	    }
	  while(i>-1);
	}
      if(mass>=threshold)
	{
	  gr+=ssx +ssy +ssz-(sx*sx+sy*sy+sz*sz)/mass;
	  totalMass+=mass;
	}
    }
  if(totalMass)   
    gr=sqrt(gr/totalMass);
  else
    gr=0;
  return gr;
} 


  
  
  
  
  
  
  
  
  
  
  
  
