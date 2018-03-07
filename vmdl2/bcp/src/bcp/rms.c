#include <stdio.h> /* standart input,output */
#include <ctype.h> /* for charachter recognition */
#include <stdlib.h> /* for conversion from char to dec */
//#include <strings.h> REMOVED 8/22/01 AB
#include <math.h>
#include "bcp.h"
#include "controls.h"
#include "search.h"
#include "rms.h"

static moved_atom *a;
static  dimensions *bound;

static double last_time=0;
static double delta1=1000;
static long n_mes=1;
static long i_mes;
static int nucleus;
static double **x;
static double *dr;
static double **y;
static double box;
static int nn,n0,n01,nn1;
static int ncont;
static int **cont;
static double **contE;
static double E_min,E_max;
static FILE * when_file;
static FILE * echo_path;
static char cont_file_name[80];
static long * nuc1, * nuc2;
static long nnuc;
static int good=0;
static double gr;

extern int is_nucleus(void)
{
  return nucleus;
}

int nonnative(short p, short q, short ct)
{
  int  nnn=0;
  well_type k=ct;
  if((p>-1)&&(q>-1)&&(is_internal(k))&&(!is_bond(k))) 
    {
     if(etot(k)<0)nnn++;
    }
return nnn;    
} 	   


void close_rms(void)
{
  if(good)
    {
      good=0;
      fclose(echo_path);
      if(x)
	{
	  free(x[0]);
	  free(y[0]);
	  free(x);
	  free(y);
	  free(dr);
	}
    }
return;
}

extern int init_rms(void)
{
  FILE * infile;
  char name[100];
  double box2;
  int i,j,k;
  good=0;
  a=(moved_atom *)get_atom();
  bound =get_bounds();
  printf("We do not compute rms\n");
  if(yes())return good;

  i_mes=0;    

  printf("What is rms file name?\n");
  scanf("%s",name);
  if(!open_rms_file(name))return good;

  printf("What is contact outputfile\n");
  scanf("%s",cont_file_name);

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


  infile=0;
  printf("We do not use native file\n");
  if(!yes())
    {
      printf("native file name?\n");
      scanf("%s",name);
      infile=fopen(name,"r");
    }
  printf("E_max?\n");
  scanf("%lf",&E_max);
  printf("E_min?\n");
  scanf("%lf",&E_min);
  when_file=0; 
  printf("We do not use when file\n");
  if(!yes())
    {
      printf("when file name?\n");
      scanf("%s",name);
      when_file=fopen(name,"r");
    }
  if(infile){
    fscanf(infile,"%ld %ld %lf",&nn,&n01,&box);
    n0=n01-1;
    box2=box/2;
    x=(double **)malloc(nn*sizeof(double*));
    if(!x)return 0;
    x[0]=(double *)malloc(nn*3*sizeof(double));
    if(!x[0])return 0;
    y=(double **)malloc(nn*sizeof(double*));
    if(!y)return 0;
    y[0]=(double *)malloc(nn*3*sizeof(double));
    if(!y[0])return 0;
    dr=(double *)malloc(nn*sizeof(double));
    if(!dr)return 0;
    dr[0]=0;
    for(i=1;i<nn;i++)
      {
	dr[i]=0;
	y[i]=y[i-1]+3;
	x[i]=x[i-1]+3;
      }

    for(i=0;i<nn;i++)
      for(j=0;j<3;j++)
	{
	  fscanf(infile,"%lf",&(x[i][j]));
	  if(feof(infile)){fclose(infile);return 0;}
	}
    fclose(infile);
    
    for(i=1;i<nn;i++)
      for(j=0;j<3;j++)
	{
	  if(x[i][j]-x[i-1][j]>box2)x[i][j]-=box;
	  if(x[i][j]-x[i-1][j]<-box2)x[i][j]+=box;
	}
    
    for(i=0;i<3;i++)
      {
	double ax=0;
	for(k=0;k<nn;k++)
	  { 
	    ax+=x[k][i];
	  }
	ax/=nn;
	for(k=0;k<nn;k++)
	  { 
	    x[k][i]-=ax;
	  }
      }
  }
  else
    {
      x=0;
      y=0;
      dr=0;
      box=0;
      printf("start to write from ?\n");
      scanf("%ld",&n01);
      n0=n01-1;
      printf("what is number atoms?\n");
      scanf("%ld",&nn);
    }
  nn1=nn-1;
  ncont=(nn1*nn)>>1;
  cont=(int **)malloc(nn*sizeof(int*));
  if(!cont)return 0;
  cont[0]=(int *)malloc(ncont*sizeof(long));
  if(!cont[0])return 0;
  for(i=0;i<nn-1;i++)
    cont[i+1]=cont[i]+i;
  for(i=0;i<ncont;i++)
    cont[0][i]=0;

  contE=(double **)malloc(nn*sizeof(double*));
  if(!cont)return 0;
  contE[0]=(double *)malloc(ncont*sizeof(double));
  if(!contE[0])return 0;
  for(i=0;i<nn-1;i++)
    contE[i+1]=contE[i]+i;
  for(i=0;i<ncont;i++)
    contE[0][i]=0;

  good=nn;
  nnuc=0;
  printf("No nucleus file is opened\n");
  if(yes())return good;
  printf("nucleous file name?\n");
  scanf("%s",name);
  infile=fopen(name,"r");
  if(!infile)return good;
  fscanf(infile,"%ld",&nnuc);
  if(nnuc<=0){fclose(infile);nnuc=0;return good;}
  nuc1=(long *)malloc(nnuc*sizeof(long));
  if(!nuc1){fclose(infile);nnuc=0;return good;}
  nuc2=(long *)malloc(nnuc*sizeof(long));
  if(!nuc2){fclose(infile);nnuc=0;return good;}
  for(i=0;i<nnuc;i++)
    {
      fscanf(infile,"%ld %ld",&(nuc1[i]),&(nuc2[i]));
      if(feof(infile)){fclose(infile);nnuc=i;return good;}
    }
  return good;

}


double get_T(void)
{
  int i,j;
  double T=0;
  double v;
  for(i=0;i<nn;i++)
    for(j=0;j<3;j++)
      {
	v=((iatom *)a)[n0+i].v[j];
	T+=v*v*a[n0+i].m;
      }
  T=T/(2*nn);
return T;
}

/* given two arrays x and y (x original coordinates),
which are globals
y new coordinates) makes Kabash transformations of
the new coordinates and computes rms */ 

double get_rms(double energy)
{
  double r[3][3], rr[3][3], mu[3], p[4],q[4];
  double aa[3][3], b[3][3], u[3][3];
  int i,j,n,m,k;
  double sum=0;
  int save=0;
  moveatoms();
/* computing only if energy in a given range or
if time is at right place (defined by when_file) */
  if((energy>=E_min)&&(energy<=E_max))save=1;
  if(energy<-1000000.0)save=1;
  if(when_file)
    {
      int save1;
      fscanf(when_file,"%d",&save1);
      save&=save1;
/* reading when_file if it is opened */
      if(feof(when_file))
	{
	  fclose(when_file);
	  when_file=0;
	}
    }

/* computation of contact map */
  if(save)
    {
      int contCount=0;
      for(i=1;i<nn;i++)
      for(j=0;j<i;j++)
	{
          int dummy=contact(j+n0,i+n0);
          contCount+=dummy;
	  cont[i][j]+=dummy;
          contE[i][j]-=energy*dummy;
	}
      printf("%d %lf\n",contCount,energy);
  }
      nucleus=0;
      for(i=0;i<nnuc;i++)
	if(contact(nuc1[i]+n0,nuc2[i]+n0))nucleus++;

  if(!y)return 0;

/* the polymer is not the entire system it is the atoms
from n_0 to n_0 + nn-1 */
  for(i=0;i<nn;i++)
      for(j=0;j<3;j++)
	y[i][j]=((moved_iatom *)a)[n0+i].r[j];

    
  /* taking into account periodic boundaries */
  for(i=1;i<nn;i++)
    for(j=0;j<3;j++)
      {
	if(y[i][j]-y[i-1][j]>bound[j].length*0.5)y[i][j]-=bound[j].length;
	if(y[i][j]-y[i-1][j]<-bound[j].length*0.5)y[i][j]+=bound[j].length;
      }
  
  
  for(i=0;i<3;i++)
    {
      double ay=0;
      for(k=0;k<nn;k++)
	{ 
	  ay+=y[k][i];
	}
      ay/=nn;
      /* shifting the origin of y coordinates into cenetr of mass */
      for(k=0;k<nn;k++)
	{ 
	  y[k][i]-=ay;
	}
    }
  gr=0;
  for(i=0;i<3;i++)
    for(k=0;k<nn;k++)
      gr+=y[k][i]*y[k][i];

  gr=sqrt(gr/nn);
  
  for(i=0;i<3;i++)
    for(j=0;j<3;j++)
      {
	double  rij=0;
	for(k=0;k<nn;k++)
	  {
	    rij+=y[k][i]*x[k][j];
          
	  }
	r[i][j]=rij;
      }

  
  for(i=0;i<3;i++)
    for(j=0;j<3;j++)
      {
	double  rij=0;
	for(k=0;k<3;k++)
	  {
	    rij+=r[k][i]*r[k][j];
	  }
	rr[i][j]=rij;
      }
  /* charcteristic third order polinomial p(mu)= det|rr -mu^2I| */
  
  p[0]=1;
  p[1]=-(rr[0][0]+rr[1][1]+rr[2][2]);
  p[2] =rr[1][1]*rr[2][2]-rr[1][2]*rr[2][1];
  p[2]+=rr[2][2]*rr[0][0]-rr[2][0]*rr[0][2];
  p[2]+=rr[1][1]*rr[0][0]-rr[1][0]*rr[0][1];
  p[3] =rr[0][0]*(rr[1][1]*rr[2][2]-rr[1][2]*rr[2][1]);
  p[3]-=rr[0][1]*(rr[1][0]*rr[2][2]-rr[1][2]*rr[2][0]);
  p[3]+=rr[0][2]*(rr[1][0]*rr[2][1]-rr[1][1]*rr[2][0]);
  p[3]=-p[3];

  /*  for(i=0;i<=3;i++)
      printf("%lf\n",p[i]);*/
  
  {
    double z=-p[1];
    for(i=2;i<4;i++)
      if(z<fabs(p[i]))z=fabs(p[i]);
    k=3;
    /* solution of the characteristic equation for eigenvalues */
    for(i=0;i<2;i++)
      {
	double q1;
	double dz;
	do 
	  {
	    q[0]=p[0];
	    q1=p[0];
	    for(j=1;j<k;j++)
	      {
		q[j]=q[j-1]*z+p[j];
		q1=q1*z+q[j];
	      }
	    q[k]=q[k-1]*z+p[k];
	    dz=q[k]/q1;
	    z=z-dz;
	  }while(dz>1.0e-14*z);
	p[k]=z;
	for(j=0;j<k;j++)
	  p[j]=q[j];
	k--;
      }
    p[1]=-p[1]/p[0];
  }
  /*
    for(i=0;i<=3;i++)
    printf("%lf\n",p[i]);
    */
  for(k=0;k<nn;k++)
    for(i=0;i<3;i++)
      sum+=x[k][i]*x[k][i]+ y[k][i]*y[k][i]; 
  
  sum*=0.5;
  
  for(i=0;i<3;i++)
    {
      mu[i]=sqrt(p[i+1]);
      sum-=mu[i];
    }    
  /*rms is equal to the hulf of the sum of the squares of coordinates 
    y and x minus sum of kabash eigenvalues mu 
    */
  
  
  for(k=0;k<3;k++)
    {
      int imax;
      double bmax;
      for(i=0;i<3;i++)
	{
	  for(j=0;j<3;j++)
	    b[i][j]=rr[i][j];
	  b[i][i]-=p[k+1];
	}
      bmax=0;
      imax=-1;
      for(j=0;j<3;j++)
	if(fabs(b[j][0])>bmax)
	  {
	    bmax=fabs(b[j][0]);
	    imax=j;
	  }
      if(bmax)
	{
	  if(imax)
	    for(i=0;i<3;i++)
	      {
		double c=b[0][i];
		b[0][i]=b[imax][i];
		b[imax][i]=c;  
	      }
	  
	  for(i=1;i<3;i++) 
	    {
	      bmax=-b[i][0]/b[0][0];       
	      for(j=0;j<3;j++)
		b[i][j]+=bmax*b[0][j];        
	    }
	  bmax=0;
	  imax=-1;
	  for(j=1;j<3;j++)
	    if(fabs(b[j][1])>bmax)
	      {
		bmax=fabs(b[j][1]);
		imax=j;
	      }
	  if(bmax)
	    {
	     aa[2][k]=1;
             aa[1][k]=-b[imax][2]/b[imax][1];
	    }
	  else
	    {
	      aa[2][k]=0;
	      aa[1][k]=1;
	    }
	  aa[0][k]=-(aa[1][k]*b[0][1]+aa[2][k]*b[0][2])/b[0][0];
	}
      else
	{
	  aa[0][k]=1;
	  bmax=0;
	  imax=-1;
	  for(j=0;j<3;j++)
	    if(fabs(b[j][1])>bmax)
	      {
		bmax=fabs(b[j][1]);
		imax=j;
	      }
	  if(bmax)
	    {
	      aa[2][k]=1;
	      aa[1][k]=-b[imax][2]/b[imax][1];
	    }
	  else
	    {
	      aa[2][k]=0;
	      aa[1][k]=1;
	    }
	}
    }

  for(k=0;k<3;k++)
    {
 	  double ak=0;
	  for(j=0;j<3;j++)
	    ak+=aa[j][k]*aa[j][k];
	  ak=1/sqrt(ak);
	  for(j=0;j<3;j++)
	    aa[j][k]*=ak;
    }


  for(k=0;k<3;k++)
    {
      for(i=0;i<3;i++)
	{
	  double bki=0;
	  for(j=0;j<3;j++)
	    bki+=r[i][j]*aa[j][k];
	  b[i][k]=bki/mu[k];
	}
    }


  for(i=0;i<3;i++)
    {
      for(j=0;j<3;j++)
	{
	  double uij=0;
	  for(k=0;k<3;k++)
	    uij+=b[i][k]*aa[j][k];
	  u[i][j]=uij;
	}
    }

  if(save)
/* is rotatation matrix : x'=ux */
/* such that rms(x'-y) is minimal */

    for(k=0;k<nn;k++)
      {
	for(j=0;j<3;j++)
	  {
	    double ykj=0;
	    for(i=0;i<3;i++)
	      ykj+=u[j][i]*x[k][i];
	    dr[k]+=(ykj-y[k][j])*(ykj-y[k][j]);
	  }
      }
/* dr[k] accumulates rms for k-yh atom from many calls of
this function  the rotated coordinates x are ykj , k
goes from 0 to nn-1, j is 0(x), 1(y), or 2(z). */
  if(save)return sum;
 else return -sum;
}



int save_rms(void)
{
  long nbyte;
  unsigned char s[512];
  long i,j; 
  int fErr=noErr;
  long maxl=bound[0].length/2;
  long n_mes1=i_mes;
  FILE * path;
  path=fopen(cont_file_name,"wb");
  if(!path)return 1;  
    if(n_mes1 && dr)
	{
	  nbyte=sprintf(&s[0],"//rms time=%lf\n",get_time());
	  if(nbyte<=0){fclose(path); return 1;}
	  fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);
	  if(fErr){fclose(path);return 1;}
	  for(i=0;i<nn;i++)
	    {
	      nbyte=sprintf(&s[0],"%ld %le \n",i+n01,dr[i]/n_mes1);
              dr[i]=0;
	      if(nbyte<=0){fclose(path); return 1;}
	      fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);
	      if(fErr){fclose(path);return 1;}
	    };
	}
  if(n_mes1)
    {
      nbyte=sprintf(&s[0],"//contacts \n");
      if(nbyte<=0){fclose(path); return 1;}
      fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);
      if(fErr){fclose(path);return 1;}
      for(i=1;i<nn;i++)
	for(j=0;j<i;j++)
	  {
	    nbyte=sprintf(&s[0],"%ld %ld %le %le \n",
			  j+n01,i+n01,(double)cont[i][j]/(double)n_mes1,
			  contE[i][j]/(double)n_mes1);
            cont[i][j]=0;
            contE[i][j]=0;
	    if(nbyte<=0){fclose(path); return 1;}
	    fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);
	    if(fErr){fclose(path);return 1;}
	  }
    }
  fclose(path);
  return 1;
}

int is_rms(void)
{return good;}

int n_rms(void)
{return nn;}

int n0_rms(void)
{return n0;}


int contact(long i, long j)
{
  well_type ct=bond((short)i,(short)j);
  if(ct<0)return 0;
  if((!is_bond(ct))&&is_internal(ct))
    { 
      if(etot(ct)>0)return 1;
      else return -1;
    }
  return 0;
}

int open_rms_file(char * fname)
{
  long nbyte,i,lmax;
  unsigned char s[512]; 
  int fErr=noErr;
  last_time=get_time();
  if(good)
     close_rms(); 
  echo_path=fopen(fname,"wb");
  if(!echo_path)return 0;

  nbyte=sprintf(s,
		"     time \t      temperature \t  energy \t nn \t rms \t       radius \t T \t nuc\n");
  if(nbyte<=0){ fclose(echo_path);return 0;}
  if(fwrite(&s[0],1,nbyte,echo_path)!=nbyte){fclose(echo_path);return 0;}
  else return 1;
  
}


int write_rms_echo(void)
{ long nbyte;
  unsigned char s[512];
  moveatoms();  
{
  long nnn=pairs(nonnative);
  double time=get_mes_time();
  double energy=countenergy();
  double temp=get_temp();
  double rms=get_rms(energy);
  double T=2*get_T()*get_corr()/3;
  int nucleus=is_nucleus();
    nbyte=sprintf(&s[0],"%12.4lf\11%10.4lf\11%10.3lf\11%4ld\11%10.3lf\11%10.3lf\11%12.5lf %1d\n"
		  ,time,temp,energy,nnn,rms,gr,T,nucleus); 
  if(nbyte<=0){ fclose(echo_path);return 0;}
  if(fwrite(&s[0],1,nbyte,echo_path)!=nbyte){fclose(echo_path);return 0;}
  else 
    return 1;
}
}

void rms(void)
{
  if(good)
    {
      double new_time=get_time(); 
      if (new_time-last_time>delta1)
	{
	  last_time=new_time;
	  good=write_rms_echo();  
	  i_mes++;
	  if(i_mes==n_mes)
	    {
	      good=save_rms();
	      i_mes=0;
	    }      
	}
    }
}






