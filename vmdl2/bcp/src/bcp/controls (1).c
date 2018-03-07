#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include "bcp.h"
#include "controls.h"
#include "cluster.h"
#define FIRST_TRY (1000)

static double rate;
static double frate;
static double mfrate;
static double temp;
static double temperature;
static double mes_time;
static double temp_limit;
static double coeff;
static double pressure;
static double time;
static double energy;
static double gr;
static long deltall;


extern int t_is_open;
extern int is_open;
extern int m_is_open;
static char echo_name[80];
static char text_name[80];
static char movie_name[80];

int yes (void)
{
  char reply[80];
  do
    { 
      printf("Is This OK ? (y/n) \n");
      reply[0]=(char)0;
      scanf("%s",&reply);
    }
  while(strcmp(reply,"y")&&strcmp(reply,"n"));
  if(!strcmp(reply,"y"))
    return 1;
  else 
    return 0;
}
extern double options_dialog (void)
{
  int reply;
  double old_temp;
  int must_open;
  coeff=get_coeff();
  temp_limit=get_temp_limit();
  deltall=get_delta_ll();
  pressure=get_pressure();
  temp=get_temp();
  old_temp=temp;		 
  rate=get_rate();
  frate=get_frate();
  mfrate=get_mfrate();	
  time=get_time();
  gr=get_gr();
  energy=countenergy();

  do
    {
      if(!t_is_open)
	printf("I am not saving text\n");
      else
	{
	  printf("I am saving text to the file\n");
	  printf("%s\n",text_name);
	  printf("Text update rate=%lf \n",rate);
	}
      if(!is_open)
	printf("I am not saving data\n");
      else
	{
	  printf("I am saving data to the file\n");
	  printf("%s\n",echo_name);
	  printf("File update rate=%lf \n",frate);
	}
      
      if(!m_is_open)
	printf("I am not saving movie\n");
      else
	{
	  printf("I am saving movie to the file\n");
	  printf("%s\n",movie_name);
	  printf("Movie update rate=%lf \n",mfrate);
	}
      printf("Simulation time=%lf \n",time);
      printf("Instant Temperature=%lf \n",temp);
      printf("Instant Potential energy=%lf \n",energy);
      printf("Largest molecule radius=%lf \n",gr);


      printf("Termal coefficient=%lf \n",coeff);
      if(coeff)printf("Temperature limit=%lf \n",temp_limit);
      reply=yes();
      if(!reply)
	{
	  
	  if(!t_is_open)
	    printf("I am not saving text\n");
	  else
	    {
	      printf("I am saving text to the file\n");
	      printf("%s\n",text_name);
	    }
	  if(!yes())t_is_open=set_text_name(t_is_open,text_name);
	  if(t_is_open)
	    {
	      printf("Text update rate=%lf \n",rate);
	      if(!yes())
		{  
		  printf("What is new rate ?\n");
		  scanf("%lf",&rate);
		}
	    }

	  if(!is_open)
	    printf("I am not saving data\n");
	  else
	    {
	      printf("I am saving data to the file\n");
	      printf("%s\n",echo_name);
	    }
	  if(!yes())is_open=open_echo_file(is_open,echo_name);
	  if(is_open)
	    {
	      printf("File update rate=%lf \n",frate);
	      if(!yes())
		{  
		  printf("What is new rate ?\n");
		  scanf("%lf",&frate);
		}
	    }
	  
	  if(!m_is_open)
	    printf("I am not saving movie\n");
	  else
	    {
	      printf("I am saving movie to the file\n");
	      printf("%s\n",movie_name);
	    }
          must_open=0;
	  if(!yes())must_open=1;
	  if(m_is_open||must_open)
	    {
	      printf("Movie update rate=%lf \n",mfrate);
	      if(!yes())
		{  
		  printf("What is new rate ?\n");
		  scanf("%lf",&mfrate);
		  set_mfrate(mfrate);
                  must_open=1;
		  if(m_is_open)m_is_open=open_movie_file(m_is_open,movie_name);
		}
	    }
	  if(must_open)m_is_open=open_movie_file(m_is_open,movie_name);

	  printf("Simulation time=%lf \n",time);
	  if(!yes())
	    {  
	      printf("What is new time ?\n");
	      scanf("%lf",&time);
	    }
	  
	  printf("Temperature=%lf \n",temp);
	  if(!yes())
	    {  
	      printf("What is new temperature ?\n");
	      scanf("%lf",&temp);
	    }

	  printf("Termal coefficient=%lf \n",coeff);
	  if(!yes())
	    {  
	      printf("What is new coeff. ?\n");
	      scanf("%lf",&coeff);
	    }
	  if(coeff)
	    {
	      printf("Limiting Temperature=%lf \n",temp_limit);
	      if(!yes())
		{  
		  printf("What is Lim. Temp. ?\n");
		  scanf("%lf",&temp_limit);
		}
	      printf("delta_ll=%ld \n",deltall);
	      if(!yes())
		{  
		  printf("What is delta ll ?\n");
		  scanf("%ld",&deltall);
		}
	    }
	}
    }

  while(!reply);
  set_rate(rate);
  if(old_temp!=temp)set_temp(temp);
  set_frate(frate);
  set_time(time);
  set_coeff(coeff);
  if (coeff)
    {
      set_temp_limit(temp_limit);
      set_delta_ll(deltall);
    }  
  {
    double maxtime;
    printf("What is maxtime?\n");
    scanf("%lf",&maxtime);
    return maxtime;
  }

}


extern void too_close_dialog (int i, int j)
{
  printf("Atoms %d and %d are too close\n",i+1,j+1);
  return;
}

extern void text_error_dialog (long i)
{
  printf("Wrong format at line %ld\n",i);
  return;
}			  			  
extern void StopAlert(int i)
{
  switch (i)
    {
    case FILE_ALRT:
      printf("File has wrong format\n");
      break;
    case MEMORY_ALRT:
      printf("Not enough memory\n");
      break;
    case TEMP_ALRT:
      printf("Temperature should be positive\n");
      break;
    case VALUE_ALRT:
      printf("Wrong value\n");
      break;
    }
}



