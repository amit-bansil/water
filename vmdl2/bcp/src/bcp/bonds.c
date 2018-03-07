#include <stdio.h>
#include <math.h>
#include <float.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include "bonds.h"

static bond_type *friend;
static bond_type *next;
static bond_type *freeInd;
static bond_type *first;
static bond_type nAtom;
static bond_type nFriend;
static bond_type nTotal;
static bond_type freeCount;
static bond_type newBonds; extern bond_type getnewBonds(){ return newBonds; }
static bond_type newTypes; extern bond_type getnewTypes(){ return newTypes; } /*fix it 6*/


int allocBonds(int n, int numbond,int nrt,int lbt)
{
  int i;
  nAtom=n;
  if(!nrt)
    nFriend=2*numbond;
  else
    {
      nFriend=NBONDS*nAtom;
      if(lbt)
	nFriend=lbt;
    }
  nTotal=nFriend+nAtom;
  next =(bond_type *)malloc((nTotal)*sizeof(bond_type));
  if(!(next))return 0; 
  first=next+nFriend;
  for(i = 0; i <nAtom ; i++)
    first[i] = -1;
  freeCount=nFriend;
  if(!freeCount)return 1;
  friend =(bond_type *)malloc(nFriend*sizeof(bond_type));
  if(!(friend))return 0;
  freeInd =(bond_type *)malloc(nFriend*sizeof(bond_type));
  if(!(freeInd))return 0;

  for(i = 0; i <freeCount ; i++)
    {
      freeInd[i] = i;
      friend[i]=-1;
    }
  return 1;
}
int setBond(int friend1, int friend2)
{ 
  int i;
  bond_type index;
  bond_type newindex;
  bond_type newfriend;
  int found;
  int res=0;
  if (friend1==friend2)return 0;
  for(i=0;i<2;i++)
    {
      if(i)
	{
	  index=friend1+nFriend;
	  newfriend=friend2;
	}
      else
	{
	  index=friend2+nFriend;
	  newfriend=friend1;
	}
      found=0;
      while(next[index]>=0)
	{
	  index=next[index];
	  if(friend[index]==newfriend){found=1;break;}
	}
      if(!found)
	{
	  if(!(freeCount))return -1;
	  (freeCount)--;
	  newindex=freeInd[freeCount];
	  next[index]=newindex;
	  next[newindex]=-1;
	  friend[newindex]=newfriend;
	  res++;
	}
    }
  if(res>0)newBonds=1;
  return res;
}

int breakBond(int friend1, int friend2)
{ 
  int i;
  bond_type index;
  bond_type oldindex;
  bond_type oldfriend;
  int found;
  int res=0;
  for(i=0;i<2;i++)
    {
      if(i)
	{
	  index=friend1+nFriend;
	  oldfriend=friend2;
	}
      else
	{
	  index=friend2+nFriend;
	  oldfriend=friend1;
	}
      found=0;
      while(next[index]>=0)
	{
	  oldindex=next[index];
	  if(friend[oldindex]==oldfriend)
	    {
	      res++;
              next[index]=next[oldindex];
              next[oldindex]=-1;
              friend[oldindex]=-1;
              freeInd[freeCount]=oldindex;
              freeCount++;
	      break;
	    }
	  index=oldindex;
	}
    }
  if(res>0)newBonds=1;
  return res;
}

	
void setNewBonds(int value)
{
  newBonds = value;
}

void setNewTypes(int value)
{
  newTypes = value;
}

int getNewBonds(void)
{
  return (int)newBonds;
}

int getNewTypes(void)
{
  return (int)newTypes;
}
    
int isFriend(bond_type atomNumber, bond_type friendNumber)
{
  bond_type index=nFriend+atomNumber;
  if(atomNumber == friendNumber)
    return 1;
  while(next[index]>=0)
    {
      index=next[index];
      if(friend[index]==friendNumber)return 1;
    }
  return 0;
}

bond_type nextFriend(int atomNumber, int * index)
{
  bond_type newindex;
  if(index[0]==-1)
    newindex=nFriend+atomNumber;
  else
    newindex=index[0];
  if((newindex<0)||(newindex>=nTotal)){index[0]=-1;return -1;}
  
  newindex=next[newindex];
  if(newindex<0)
    {index[0]=-1;return -1;}
  else
    {index[0]=newindex;return friend[newindex];}
}

int getMaxBonds(void)
{return (int)(nFriend>>1);}






