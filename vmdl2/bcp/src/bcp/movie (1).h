extern int write_movie_header(FILE * path);
extern int write_movie_frame(void);
extern int closemovie(FILE * movie_file);
extern char * write_java(char * s,void * input,int nbyte,int order);
extern void add_movie_param(double dat0,double dat1,double dat2,double dat3);
extern void init_movie_param(void);
