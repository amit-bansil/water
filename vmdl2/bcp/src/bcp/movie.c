#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "bcp.h"
#include "controls.h"
#include "bonds.h"
#include "make_system.h"
#include "rms.h"




static int bo=0;
static moved_iatom * a=NULL;
static moved_iatom * sam=NULL;
static dimensions * bound;
static int dim;
static short nat;/* number of atom types */
static double scale_factor[3];
static char * movie_buffer=NULL;
static short n;
static int n0;
static int n1;
static short version=0;
static short * length;
static FILE * path;
static int frame;
static int max_bonds;
static int buffer_length;
static int fErr;
static char * password="BCPkina";
static short param_number=4;
static char * param_names [4]={
"Temperature", 
"Potential Energy", 
"Total Energy",
"Pressure"
};
static int n_mes;
static double param[4];
 
void add_movie_param(double dat0,double dat1,double dat2,double dat3)
{
  param[0]+=dat0;
  param[1]+=dat1;
  param[2]+=dat2;
  param[3]+=dat3;
  n_mes++;
  return;
}

void init_movie_param(void)
{
  param[0]=0;
  param[1]=0;
  param[2]=0;
  param[3]=0;
  n_mes=0;
  return;
}

char * write_java(char * s,void * input,int nbyte,int order)
{
  int i;
  char * s1;
  if(s+nbyte>movie_buffer+buffer_length){fErr=1;return s;}
  if(bo||order)
    {
      s1=(char *)input;
      for(i=0;i<nbyte;i++)
	s[i]=s1[i];
    }
  else
    {
      s1=((char *)input) + nbyte-1;
      for(i=0;i<nbyte;i++)
	s[i]=s1[-i];
    }
  return s+nbyte;
}



extern int write_movie_header( FILE * movie_path)
{

  long nbyte;
  short s_dummy;
  double dummy;
  char * s;
  int i,j;
  bo=byte_order();
  a= (moved_iatom *)get_atom();
  n1= get_atom_number();
  sam=(moved_iatom *)get_sample_atoms();
  nat=get_atom_types();
  path=movie_path;
  dim=get_dimension();
  bound=get_bounds();
  max_bonds=getMaxBonds();
  init_movie_param();
  n0=1;
  n=n1;
  if(is_rms())
    {
      n=n_rms();
      n0=n0_rms()+1;
    }
  do{
    printf("number of atoms in the movie %d\n",n);
    printf("start to write from %d\n",n0);
    printf("number of parameters%d\n",param_number);
    if(!yes())
      {
	printf("start to write from ?\n");
	scanf("%d",&n0);
	printf("what is number of atoms?\n");
	scanf("%hd",&n);
	printf("what is number of parameters?\n");
	scanf("%hd",&param_number);
      }
    if(n0<1)n0=1;
    if(n0>n1)n0=n1;
    if(n<1)n=1;
    if(n>n1-n0+1)n=n1-n0+1;
    printf("start to write from %d\n",n0);
    printf("number of atoms=%hd\n",n);
  }while(!yes());
  n0--;
  a+=n0;  
  n1=n0+n;
  printf("change write parameters for text files?\n");
  if(yes())set_write_param(n0,n,1); /* setting parameters for text writing */
  if(!strcmp(password,"BCPkina"))
    {
      version=1;
      printf("version 1\n");
    }
  buffer_length=(n*(dim+1)+nat+100)*sizeof(short)+
    max_bonds*sizeof(short)+
      (4+nat+100)*sizeof(double)+
	1024;/*text size*/

  if(!movie_buffer)movie_buffer=(char *)malloc(buffer_length*sizeof(char));
  if(!movie_buffer)
    {
      StopAlert(MEMORY_ALRT);
      fclose(path);
      return 0;
   }
  fErr=0;
  s=movie_buffer;

/*password*/
  nbyte=strlen(password);
  s=write_java(s,password,nbyte,1);

/*leave space for frame number*/
  s_dummy=0;
  s=write_java(s,&s_dummy,sizeof(s_dummy),0);
  
/* system size components */
  for(i=0;i<3;i++)
    {
      dummy=bound[i].length;
      if(i>=dim)dummy=0;
      s=write_java(s,&dummy,sizeof(dummy),0);
    }

/* delta T */
  dummy=get_movie_dt();
  s=write_java(s,&dummy,sizeof(dummy),0);

/* number of diff. types */
  s=write_java(s,&nat,sizeof(nat),0);

/* types of atoms */
  for (i=1;i<=nat;i++)
    {
      s_dummy=sam[i].c;
      s=write_java(s,&s_dummy,sizeof(s_dummy),0);
    }

/* radius */
  for (i=1;i<=nat;i++)
    {
      dummy=sam[i].s;
      s=write_java(s,&dummy,sizeof(dummy),0);
    }

/*number of atoms*/
   s=write_java(s,&n,sizeof(n),0);

/*list of atoms types */
  for (i=0;i<n;i++)
    {   
      s_dummy=a[i].c;
      s=write_java(s,&s_dummy,sizeof(s_dummy),0);
    }

/* list of bonds */
  for (i=n0;i<n1;i++)
    { 
      int index=-1;
      s_dummy=i-n0;
      s=write_java(s,&s_dummy,sizeof(s_dummy),0);
      do
	{
	  j=nextFriend(i,&index);
	  if(index==-1)break;
	  if((j>i)&&(j<n1))
	    {
	      s_dummy=j-n0;
	      s=write_java(s,&s_dummy,sizeof(s_dummy),0);
	    }
	}while(index>-1);
      s_dummy=i-n0;
      s=write_java(s,&s_dummy,sizeof(s_dummy),0);
    }

  /* number of params */ 
  s_dummy=param_number;/* fix it 5*/
  s=write_java(s,&s_dummy,sizeof(s_dummy),0);
  for(i=0;i<param_number;i++)
    {
      nbyte=strlen(param_names[i]);
      s_dummy=nbyte;
      s=write_java(s,&s_dummy,sizeof(s_dummy),0);
      s=write_java(s,param_names[i],nbyte,1);
    }

 for(i=0;i<3;i++)
   {
     scale_factor[i]=((double)65536)/bound[i].length; 
   } 
  nbyte=s-movie_buffer;
  fErr=((nbyte!=fwrite(movie_buffer,1,nbyte,path))||fErr);
  setNewTypes(0);
  setNewBonds(0);
  if(fErr!=noErr){fclose(path);return 0;}
  frame=0;
  return 1;
}


extern int write_movie_frame(void)
{ 
  int i,j;
  char * s=movie_buffer;
  unsigned short s_dummy;
  double dummy;
  int nbyte;
  moveatoms(); 
  frame++;
/* do we have any changes in types of atoms?*/
/* after reaction type of atoms can be diff.*/
/*list of atoms types */
  s[0]=(char)getNewTypes();

/* iff we have any type changes then write * 	
/* list of atoms types */
  if(s[0])
    {
      s++;
      for (i=0;i<n;i++)
	{   
	  s_dummy=a[i].c;
	  s=write_java(s,&s_dummy,sizeof(s_dummy),0);
	}
    }
  else
    s++;

/* do we have any changes in the list of bonds?*/
/* after reaction it can change.*/
  s[0]=(char)getNewBonds();

/* iff we have any bonds changes then write */ 	
/* list of bonds */
  if(s[0])
  {
    s++;
    /* list of bonds */
    for (i=n0;i<n1;i++)
      { 
	int index=-1;
	s_dummy=i-n0;
	s=write_java(s,&s_dummy,sizeof(s_dummy),0);
	do
	  {
	    j=nextFriend(i,&index);
	    if(index==-1)break;
	    if((j>i)&&(j<n1))
	      {
		s_dummy=j-n0;
		s=write_java(s,&s_dummy,sizeof(s_dummy),0);
	      }
	  }while(index>-1);
	s_dummy=i-n0;
	s=write_java(s,&s_dummy,sizeof(s_dummy),0);
      }
  }
  else 
    s++;
/* coords */

    for(i=0;i<n;i++)
      for(j=0;j<dim;j++)
	{
	  if(version==1)
	    {
	      s_dummy=(unsigned short)(a[i].r[j]*scale_factor[0]);
	      s=write_java(s,&s_dummy,sizeof(s_dummy),0);
	    }
	  else
	    {
	      s_dummy=(unsigned short)a[i].r[j];
	      s=write_java(s,&s_dummy,sizeof(s_dummy),0);
	    }
	}
/*params */
for(i=0;i<param_number;i++){
dummy=n_mes? param[i]/n_mes:0;
/* printf("%le\n",dummy); */
s=write_java(s,&dummy,sizeof(dummy),0);
}
init_movie_param();

  s_dummy=0;
  s=write_java(s,&s_dummy,sizeof(s_dummy),0);
  nbyte=s-movie_buffer;  
  fErr=(nbyte!=fwrite(movie_buffer,1,nbyte,path))||fErr;
  if(!fErr){return 1;}
  closemovie(path);
  return 0;


}




int byte_order(void)
{ unsigned short i=1;
  unsigned char * s;
  s=(char*)&i;
  if(s[1]>s[0])return 1;
  return 0;
}

int closemovie(FILE * movie_file)
{
  int nbyte;
  int l_pass=strlen(password);           
  unsigned short s_dummy;
  char * s=movie_buffer;
  fseek(movie_file,l_pass,SEEK_SET);
  s_dummy=frame;
  s=write_java(s,&s_dummy,sizeof(s_dummy),0);
  nbyte=s-movie_buffer;
  fErr=(nbyte!=fwrite(movie_buffer,1,nbyte,movie_file))||fErr;
  fErr=fclose(movie_file)||fErr;
  return fErr; 
}

