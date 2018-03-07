#include <math.h>
#include <stdio.h>
#include "bcp.h"
#include "search.h"
#include "controls.h"


extern atom * a;
extern char * text_name;
extern dimensions bound[3];
extern well_type ** ecoll;

extern double dblarg2;
static tsearch search;

void initsearch(void)
{ 
  tlist * inpt;
  long i;
  long n=search.n;
  tlist * tc=search.storage;
  tlist ** ptc=search.begin;
  for (i=0;i<n;i++)
    search.collp[i]=-1;
  for (i=0;i<n;i++)
    search.collq[i]=-1;
  search.np=0;
  search.nq=0;
  for(i=0;i<search.maxfree;i++)ptc[i]=&tc[i];
  ptc[search.maxfree]=NULL;
  search.free=(search.begin)+1;
  inpt=*(search.begin);
  for(i=0;i<=search.z;i++)
    search.inpt[i]=inpt;
  inpt->dt.t=dblarg2;
  inpt->dt.p=-1;
  inpt->dt.q=-1; 
  inpt->pt=NULL;
}   


int allocsearch(long n)
{
 long i,j,k,level;
 tlist * tc,** ptc;
 long maxadd;
 search.x=bound[0].period;
 search.y=search.x*bound[1].period;
 search.z=search.y*bound[2].period;
 maxadd=search.z;
 search.n=n;     
 if(maxadd>MAXADD)return 0;
 
 if(!(search.collp=(short *)malloc(n*sizeof(short))))return 0;
 if(!(search.collq=(short *)malloc(n*sizeof(short))))return 0;
 
 if(!(search.atomp=(short *)malloc(n*sizeof(short))))return 0;    
 if(!(search.atomq=(short *)malloc(n*sizeof(short))))return 0;
 
 
 if(!(ptc=(tlist **)malloc((maxadd+1)*sizeof(tlist *))))return 0;
 search.inpt=ptc;
 if(!search.maxfree)search.maxfree=NFREE;
 if(!(tc =(tlist *)malloc(search.maxfree*sizeof(tlist))))return 0;
 search.storage=tc;

 if(!(ptc=(tlist **)malloc((search.maxfree+1)*sizeof(tlist *))))return 0;
 search.begin=ptc;
 
 k=0;
 j=maxadd;
 level=0;
 
 do
 { j=(j>>1)+(j&1);
   k+=j;
   level++;
  }while(j>1);
  
  search.final=level;
  search.olymp=(size_al **)malloc((level+1)*sizeof(size_al *));
  if(!(search.olymp))return 0;
  search.olymp[0]=(size_al *)malloc((k+1)*sizeof(size_al));
    if(!(search.olymp[0]))return 0;
  j=maxadd;
  level=0;
  
  while(j>1)
  {
   j=(j>>1)+(j&1);
   search.olymp[level+1]=search.olymp[level]+j;
   level++;
   }
  
   search.change=(size_al *)malloc(46*sizeof(size_al));
    if(!(search.change))return 0;
 return 1;
}
void find_atoms(long p1)
{ 
 tlist * inpt;
 long np=search.np;
 long i,j,k,i1,j1,k1,i2,j2,k2,address;
 long addressz,addressy;
  
  i1=a[p1].i.x.i-1;
  j1=(a[p1].i.y.i-1)*search.x;
  i2=i1+2;
  j2=j1+(search.x<<1);
  if(search.z==search.y)
  {k1=a[p1].i.z.i*search.y;k2=k1;}
  else
  {k1=(a[p1].i.z.i-1)*search.y;k2=k1+(search.y<<1);}
  
  for(k=k1;k<=k2;k+=search.y)
    { 
      addressz=k;
      if(addressz<0)addressz+=search.z;
      if(addressz==search.z)addressz=0;
      for(j=j1;j<=j2;j+=search.x)
	{ 
	  addressy=j; 
	  if(addressy<0)addressy+=search.y;
	  if(addressy==search.y)addressy=0;
	  addressy+=addressz;
	  for(i=i1;i<=i2;i++)
	    { 
	      address=i; 
	      if(address<0)address+=search.x;
	      if(address==search.x)address=0;
	      address+=addressy;
	      for(inpt=search.inpt[address];inpt;inpt=inpt->pt)
	      {
	   
	   if(p1==inpt->dt.p)
	    { 
	     short p2=inpt->dt.q;
	     if(p2<search.n)
	     {
	     if(search.collp[p2]==-1)search.atomp[np++]=p2;
	     search.collp[p2]=-2;
	   
	      }
	    } 
	   if(p1==inpt->dt.q)
	    { 
	     short p2=inpt->dt.p;
	     if(search.collp[p2]==-1)search.atomp[np++]=p2;
	     search.collp[p2]=-2;
/* if an atom did know about our atom their collision should not be recalculated
in the update table this fact is indicated by the -2 type of collision*/
	     
	    }
	   if(inpt->dt.q>=search.n) /* those atoms who sit there but 
				    did not know about our atom aquire external collision type */
	    { short p2=inpt->dt.p;
	      if((search.collp[p2]==-1)&&(p2!=p1))
	      {
	      	search.collp[p2]=ecoll[a[p2].c][a[p1].c];
	       search.atomp[np++]=p2;
	      } 
	     }
	   }  
	  }
    }
  }  
 search.np=np;
 return;
}

/* find atoms in ajacent cells to a given atom; 
returns number of such atoms*/
int find_neighbors(int p, short * neib)
{ 
 tlist * inpt;
 int nn=0;
 long i,j,k,i1,j1,k1,i2,j2,k2,address;
 long addressz,addressy;
  
  i1=a[p].i.x.i-1;
  j1=(a[p].i.y.i-1)*search.x;
  i2=i1+2;
  j2=j1+(search.x<<1);
  if(search.z==search.y)
  {k1=a[p].i.z.i*search.y;k2=k1;}
  else
  {k1=(a[p].i.z.i-1)*search.y;k2=k1+(search.y<<1);}
  
  for(k=k1;k<=k2;k+=search.y)
    { 
      addressz=k;
      if(addressz<0)addressz+=search.z;
      if(addressz==search.z)addressz=0;
      for(j=j1;j<=j2;j+=search.x)
	{ 
	  addressy=j; 
	  if(addressy<0)addressy+=search.y;
	  if(addressy==search.y)addressy=0;
	  addressy+=addressz;
	  for(i=i1;i<=i2;i++)
	    { 
	      address=i; 
	      if(address<0)address+=search.x;
	      if(address==search.x)address=0;
	      address+=addressy;
	      for(inpt=search.inpt[address];inpt;inpt=inpt->pt)
		if(inpt->dt.q>=search.n)
		    neib[nn++]=inpt->dt.p;
	    } 
	}  
    }
 return nn;
}  
/* list atoms in a certain cell, returns number of atoms in a cell */
short list_atoms(size_al address,short * atomx)
{ 
	short i=0;
	tlist *inpt1;
	for( inpt1=search.inpt[address];inpt1;inpt1=inpt1->pt)
 	if(inpt1->dt.q>=search.n)
 	{ atomx[i++]=inpt1->dt.p;}
 return i;	
}
/* find length of collision table of a cell */
int check_atoms(long address)
{ 
	short i=0;
	short p,q,c;
	double t;
	tlist *inpt1;
	for( inpt1=search.inpt[address];inpt1;inpt1=inpt1->pt)
 	{
 	  p=inpt1->dt.p;
 	  q=inpt1->dt.q;
 	  c=inpt1->dt.ct;
 	  t=inpt1->dt.t;
 	  if((p>-1)&&(q>-1))
 	  i++;
 	  }
 return i;	
}
short bond(short i, short j)
{   
    tlist *inpt1;
	for( inpt1=search.inpt[a[i].add];inpt1;inpt1=inpt1->pt)
	if((i==inpt1->dt.p)&&(j==inpt1->dt.q)) return inpt1->dt.ct;
	return -ecoll[a[i].c][a[j].c];
}

int init_tables(void)
{
long i0,j0,k0,address,ix,iy,iz,level;
  long i,j,k,i1,j1,k1,i2,j2,k2;
  long maxadd=search.z;
  size_al address1;
  size_al address2;
  short n=search.n-1;
  short n1=n+1;
  tab tb;
   
  long addressz,addressy; 
  
  initsearch();
  for(i=0;i<=n;i++)
    {
      tb.p=i;
      tb.ct=-1;
      tb.q=twall(i,&(tb.t));
      bubble(tb);
    }


  a[n1].c=0;
  for (k0=0;k0<maxadd;k0++)
  if(search.np=list_atoms(k0,search.atomp))
  {
   i0=search.atomp[0];
   i1=a[i0].i.x.i-1;
   i2=i1+2;
   j1=(a[i0].i.y.i-1)*search.x;
   j2=j1+(search.x<<1);
  if(search.z==search.y)
  {k1=a[i0].i.z.i*search.y;k2=k1;}
  else
  {k1=(a[i0].i.z.i-1)*search.y;k2=k1+(search.y<<1);}
   for(k=k1;k<=k2;k+=search.y)
   { 
     addressz=k;
     if(addressz<0)addressz+=search.z;
     if(addressz==search.z)addressz=0;
     for(j=j1;j<=j2;j+=search.x)
	 { 
	  addressy=j; 
	  if(addressy<0)addressy+=search.y;
	  if(addressy==search.y)addressy=0;
	  addressy+=addressz;
	  for(i=i1;i<=i2;i++)
	  { 
	   short iq;
	   short ip;
	   address=i; 
	   if(address<0)address+=search.x;
	   if(address==search.x)address=0;
	   address+=addressy;
 	   search.nq=list_atoms(address,search.atomq);
 	   for (iq=0;iq<search.nq;iq++)
 	   for (ip=0;ip<search.np;ip++)
 	   {
  	    i0=search.atomp[ip]; 
  	    j0=search.atomq[iq];
	    if(i0<j0)
	    {

	     long ct=collision_type(i0,j0);
	     if(ct<0) return (int) ct;
	     if(tball(i0,j0,ct,&(tb.t))) 
	     {
	      tb.p=i0;
	      tb.q=j0;
	      tb.ct=ct;
	      }
	      else
	     {
	      tb.p=-1;
	      tb.q=-1;
	      tb.ct=-1;
	      }  
	     bubble(tb);
	     add_potential(ct);
	     }
	    }
	   }
	  }
	 }
    }
k=maxadd;
k=(k>>1)+(k&1);
for(i=0;i<k;i++)
{
address1=i<<1;
address2=address1+1;
search.olymp[0][i]=address1;
if((address2<maxadd)&&(search.inpt[address1]->dt.t>search.inpt[address2]->dt.t))
search.olymp[0][i]=address2;
}

for(level=1;level<search.final;level++)
{ j=(k>>1)+(k&1);
  for(i=0;i<j;i++)
  {
  size_al i1=i<<1;
  size_al i2=i1+1;
  search.olymp[level][i]=search.olymp[level-1][i1];
  if(i2<k)
  {
    address1=search.olymp[level-1][i1];
    address2=search.olymp[level-1][i2];
   	if(search.inpt[address1]->dt.t>search.inpt[address2]->dt.t)
   	 search.olymp[level][i]=address2;
  }
 }
  k=j;
}  
 return 1;  
}

long bubble (tab tb)
{
  tlist *npt,*pt,*pt1,*inpt,**free;
  double dtt;
 long address;
  
  if (tb.p>=0)
    {
      address=a[tb.p].add;
      inpt=search.inpt[address];
      npt=*(search.free);
      if(!npt){writetext(text_name);exit(0);}
      search.free++;
      npt->dt=tb;
      dtt=tb.t;
      if(inpt->dt.t >= dtt)
	{
	  npt->pt=inpt;
	  search.inpt[address]=npt;
	  return address;
	}
      else 
	{
	  pt=inpt->pt;
          pt1=inpt;
	  while ( pt->dt.t<dtt)
	    {
	      pt1=pt;
	      pt=pt->pt;
	    }
         pt1->pt=npt;
         npt->pt=pt;
	}
    }
    return MAXADD;
}


void olymp_sort(void)
{
  size_al *change=search.change;
  size_al * curr, *next, *prev;
  size_al i,j,k,address1,address2;
  long ch,nch1,nch=search.nch;
  short level;
  nch1=0;
  curr=search.olymp[0];
  next=search.olymp[1];
  for(ch=0;ch<nch;ch++)
   {
    i=change[ch];
    address1=i<<1;
    address2=address1+1;
    curr[i]=address1;
    if((address2<search.z)&&(search.inpt[address1]->dt.t>search.inpt[address2]->dt.t))
      curr[i]=address2;
    j=i>>1;
    if(next[j]<MAXADD)
    {
      next[j]=MAXADD;
      change[nch1]=j;
      nch1++;
    } 
   }
 nch=nch1;
 k=search.z; 
 for(level=2;level<search.final;level++) 
  { 
   k=(k>>1)+(k&1);
   nch1=0;
   prev=curr;
   curr=next;
   next=search.olymp[level];
   for(ch=0;ch<nch;ch++)
    { 
     i=change[ch];
     address1=i<<1;
     address2=address1+1;
     address1=prev[address1];
     curr[i]=address1;
     if(address2<k)
      { 
      	address2=prev[address2];
        if(search.inpt[address1]->dt.t>search.inpt[address2]->dt.t)
  	      curr[i]=address2;
  	   }
     j=i>>1;
     if(next[j]<MAXADD)
      {
        next[j]=MAXADD;
        change[nch1]=j;
        nch1++;
      } 
       
    }  
   nch=nch1;
 } 
 next[0]=(search.inpt[curr[0]]->dt.t>search.inpt[curr[1]]->dt.t) ? curr[1]:curr[0];
 
 return;  
}

long get_free(void)
{
return (long)(search.free-search.begin);
}
long get_maxfree(void)
{
return search.maxfree;
}
void set_maxfree(long a)
{
search.maxfree=a;
}


void update_table(long p1, long q1, long ct1)
{
  long i,p2,ct;
  long add;
  long nch=search.nch;
  tab tb;
  size_al * change=search.change;
  if((search.n<=search.np)||(search.n<=search.nq))
  {long error=1;}
  tb.p=p1;
  tb.ct=-1;
  tb.q=twall(p1,&(tb.t));
  if((add=bubble(tb))<MAXADD)
  { 
    size_al ch=add>>1;
    if(search.olymp[0][ch]<MAXADD)
    { 
      search.olymp[0][ch]=MAXADD;/* means that the local champion changes*/
      change[nch]=ch;
      nch++;
     }
   }
  search.collp[p1]=-1;    
  if (q1<search.n)
    {
      search.collp[q1]=ct1; /*to make sure that we compute 
the collision of atoms p1 and q1, when we will look through atomq 
which is different from the old type ct1 in the list collq */
      search.collq[p1]=-1;
      search.collq[q1]=-1;
        tb.p=q1;
        tb.ct=-1;
        tb.q=twall(q1,&(tb.t));
       if((add=bubble(tb))<MAXADD)
         { 
           size_al ch=add>>1;
           if(search.olymp[0][ch]<MAXADD)
            { 
             search.olymp[0][ch]=MAXADD;
             change[nch]=ch;
             nch++;
            }
        }   
    }
  for(i=0;i<search.np;i++)
    {
      p2=search.atomp[i];
      ct=search.collp[p2];
      search.collp[p2]=-1; 
      if(ct>=0) /* the collision is not recalculated if ct is -2
		   which means that the atoms will collide as before */
	if(tball(p2,p1,ct,&(tb.t)))
	  { 
	    tb.ct=ct;if(p1<p2){tb.p=p1;tb.q=p2;}else{tb.p=p2;tb.q=p1;}   
	    if((add=bubble(tb))<MAXADD)
              { 
		size_al ch=add>>1;
		if(search.olymp[0][ch]<MAXADD)
		  { 
		    search.olymp[0][ch]=MAXADD;
		    change[nch]=ch;
		    nch++;
		  }
              }   
	  }
    }
  
 if (q1<search.n)
   {
     
     for(i=0;i<search.nq;i++)
       {
	 p2=search.atomq[i];
	 ct=search.collq[p2];
	 search.collq[p2]=-1; 
	 if(ct>=0)
	   if(tball(p2,q1,ct,&(tb.t)))
	     {
	       tb.ct=ct;if(q1<p2){tb.p=q1;tb.q=p2;}else{tb.p=p2;tb.q=q1;}   
	       if((add=bubble(tb))<MAXADD)
		 { 
		   size_al ch=add>>1;
		   if(search.olymp[0][ch]<MAXADD)
		     { 
		       search.olymp[0][ch]=MAXADD;
		       change[nch]=ch;
		       nch++;
		     }
		 }   
	     }
       }
  }
search.nch=nch;    
olymp_sort();
}

void squeeze2(long p1)
{ 
  tlist *pt, *pt1,*inpt;
  tlist **free=search.free;
  short * atomp=search.atomp;
  short * collp=search.collp;
  short np=0;
  size_al *change=search.change;
  long nch=search.nch;
  long address=a[p1].add;
  inpt=search.inpt[address];
	   if(p1==inpt->dt.p)
	    { 
	     size_al ch=address>>1;
	     if(search.olymp[0][ch]<MAXADD)
	      {
	       search.olymp[0][ch]=MAXADD;
	       change[nch]=ch;
	       nch++;
	      }
         while(p1==inpt->dt.p)
          {
         short p2=inpt->dt.q;
	     if(p2<search.n)
	     {
	     if(collp[p2]<0)atomp[np++]=p2;
	     collp[p2]=inpt->dt.ct;

	      }
           *(--free)=inpt;
           inpt=inpt->pt;
          }
         search.inpt[address]=inpt;   
	    }
	   pt1=inpt;
       while((pt1->pt)!=NULL)
        { 
        pt=pt1->pt;
        while((p1==pt->dt.p))
	      { 
	     short p2=pt->dt.q;
	     if(p2<search.n)
	     {
	    if(collp[p2]<0)atomp[np++]=p2;
	    collp[p2]=pt->dt.ct;
	  
	      } 
	       *(--free)=pt;
	       pt=pt->pt;
	     
	      } 
        pt1->pt=pt;
        pt1=pt;
        }
 search.free=free;
 search.nch=nch;
 search.np=np;
 
}

/*short check(tlist *inpt,long p1,short * collp,short * atomp,short  np1)
{	   
  short np=np1;
      if(p1==inpt->dt.p)
	    { 
	     short p2=inpt->dt.q;
	     if(p2<search.n)
	     {
	     collp[p2]=inpt->dt.ct;
	     atomp[np++]=p2;
	      }
	    }
	   else  
	   if(p1==inpt->dt.q)
	    { 
	     short p2=inpt->dt.p;
	     collp[p2]=inpt->dt.ct;
	     atomp[np++]=p2;
	    }
	   else 
	   if(inpt->dt.q>=search.n)
	    { short p2=inpt->dt.p;
	      if(collp[p2]<0)
	      {
	       collp[p2]=ecoll[a[p2].c][a[p1].c];
	       atomp[np++]=p2;
	      } 
	     }
return np;
}*/

short squeeze1(long p1, short * collp, short * atomp)
{ 
 tlist *pt, *pt1,*inpt;
 tlist **free=search.free;
 short p2;
 size_al *change=search.change;
 long nch=search.nch;
 short np=0;
  long i,j,k,i1,j1,k1,i2,j2,k2,address;


  long addressz,addressy;
  
  i1=a[p1].i.x.i-1;
  j1=(a[p1].i.y.i-1)*search.x;
  i2=i1+2;
  j2=j1+(search.x<<1);
  
	if(search.z==search.y){
  		k1=a[p1].i.z.i*search.y;
  		k2=k1;
  	}
  	else{
		k1=(a[p1].i.z.i-1)*search.y;
 		k2=k1+(search.y<<1);
  	}
 	
 	for(k=k1;k<=k2;k+=search.y){ 
		addressz=k;
      	if(addressz<0)
      		addressz+=search.z;
      	if(addressz==search.z)
      		addressz=0;
     	
     	for(j=j1;j<=j2;j+=search.x){ 
	  		addressy=j; 
	  		if(addressy<0)
	  			addressy+=search.y;
	  		if(addressy==search.y)
	  			addressy=0;
	  		addressy+=addressz;
	  	
	  		for(i=i1;i<=i2;i++){ 
	      		address=i; 
	      		if(address<0)
	      			address+=search.x;
	      		if(address==search.x)
	      			address=0;
	      		address+=addressy;
	   			
	   			inpt=search.inpt[address];
	   
	   			if((p1==inpt->dt.p)||(p1==inpt->dt.q)){ 
			    	size_al ch=address>>1;
	     			if(search.olymp[0][ch]<MAXADD){
			    		search.olymp[0][ch]=MAXADD;
	       				change[nch]=ch;
	       				nch++;
	      			}
	      
	     			while((p1==inpt->dt.p)||(p1==inpt->dt.q)){
        				if(p1==inpt->dt.p){ 
					    	p2=inpt->dt.q;
	     					if(p2<search.n){
	     					if(collp[p2]<0)atomp[np++]=p2;
	     						collp[p2]=inpt->dt.ct;
	     						
	      					}
	     				}
	   					else{ 
	     					p2=inpt->dt.p;
	     					if(collp[p2]<0)atomp[np++]=p2;
	     					collp[p2]=inpt->dt.ct;
	     			
	    				} 
           				*(--free)=inpt;
           				inpt=inpt->pt;
          			}
         	
         			search.inpt[address]=inpt;   
	    		}
	    	
	   			pt1=inpt;
       			while((pt1->pt)!=NULL){ 
        			p2=pt1->dt.p;
	      			if(collp[p2]<0){
				    	collp[p2]=ecoll[a[p2].c][a[p1].c];
	       				atomp[np++]=p2;
/* any atom in priciple can collide with our atom hence if collp is yet
empty (-1) we put there external collision type which whill be overwritten if
the collision with that atom will be find later. */
	      			} 
        			pt=pt1->pt;
        			while((p1==pt->dt.p)||(p1==pt->dt.q)){ 
	       				if(p1==pt->dt.p){ 
	     					p2=pt->dt.q;
	     					if(p2<search.n){
	     					if(collp[p2]<0)atomp[np++]=p2;
	    						 collp[p2]=pt->dt.ct;
	/* always put the information from the collision list, not only
           if collp is negative, thus it overwrites the old value which for
           security was assign to be ecoll */   							 
	      					}
	     				}
	   					else{ 
					    	p2=pt->dt.p;
					    	if(collp[p2]<0)atomp[np++]=p2;
	     					collp[p2]=pt->dt.ct;
	     					
	    				}  
	       				*(--free)=pt;
	      				pt=pt->pt;
	     
	      			} 
        			pt1->pt=pt;
        			pt1=pt;
        		}
     	    
	  }
    }
  }  
 search.free=free;
 search.nch=nch;
 return np;
}
long squeeze_table(long * p1, long * q1, double * timea)
{ 
  tlist *inpt=search.inpt[search.olymp[search.final-1][0]];
  search.nch=0;
  *timea=inpt->dt.t;
  *p1=inpt->dt.p;
  *q1=inpt->dt.q;
  if((*q1)>=search.n)
  {
   squeeze2(*p1);
   return (long)(inpt->dt.ct);
  }
 search.np=squeeze1(*p1,search.collp, search.atomp);
 search.nq=squeeze1(*q1,search.collq, search.atomq);
  return (long)(inpt->dt.ct);
}

  
short * get_collp(void){return search.collp;}
short * get_collq(void){return search.collq;}
short * get_atomp(void){return search.atomp;}
short * get_atomq(void){return search.atomq;}
short get_np(void){return search.np;}
short get_nq(void){return search.nq;}

long pairs(int (*do_something)(short,short,short))
{ 
  long n_bonds=0;
  long address;
  tlist *inpt1;
  for (address=0;address<search.z;address++)
    for( inpt1=search.inpt[address];inpt1;inpt1=inpt1->pt)
      if(inpt1->dt.q<search.n)
/* the old statement (inpt1->dt.ct>=INTERN)  
is equivalent to is_internal(inpt1->dt.ct) and is removed */
 	n_bonds+=do_something(inpt1->dt.p,inpt1->dt.q,inpt1->dt.ct);	
return n_bonds;
}  
