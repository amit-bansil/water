enum keys {SYS_SIZE=1,NUM_ATOMS,TYPE_ATOMS,NONEL_COL,EL_COL,LINK_PAIRS,REACT,LIST_ATOMS,LIST_BONDS,NUM_BONDS,LIST_PARAM,COL_TABLE};


extern int write_key_coord(FILE *path);
extern int writebonds(FILE * path);
extern long startup(void);
extern atom * get_sample_atoms();
extern int get_atom_types();
extern void set_write_param(int n0,int n1,int yes);
