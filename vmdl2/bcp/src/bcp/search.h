/*Rules : 

1. every atom is represented in the collision list of its cell by
a boundary-crossing collision (coll_type=0).

2. Two atoms may have their collision listed in the collision list of
the cell where the atom with smallest number belongs to.

3. If the collision is of internal type it is always listed.

4. If the collision is of external type it is listed if and only if
its time is smaller than both of the times of leaving the cell for each
atom.

5. collision has t -time, p 1-st atom, q 2-nd atom , c type of collision;

6. matrix of collisions shows the types of external colisions for atom
pairs which are not represented in collision table. External collisions
can be of finite energy. Historically, for private use, if their energy 
is positive , it means attraction (gain of kinetic energy) For public
use we use conventional negative potential energies for attraction.
The numbers of external collisions are numbered from 0 to nen1.
From 0 to nen-1 - collisions with finite energies;
from nen to nen0-1 collisions with infinite energy: ellastic repulsions)
from nen0 to nen1-1 collisions of bonded pairs. 
the numbers of internal collisions are the same + INTERN  
the numbers of stable collisions are the same + STABLE. 
It is a triangular array of short ** excoll

7. In squeeze1 we scan the collision lists search.inpt[] for 27
neighboring cells and construct an array collp[] and collq[] which
originally filled with -1 indicating that an atom is not present in
the cells. While scanning inpt we delete the collisions in which given
atoms (p or q) take part and put the values of collisions in the collp
or collq memorizing the values of atoms into arrays atomp and atomq
and amounts nq and np of colliding atoms. If a wall collision is found
in the list , and the corresponding element in collq and collq is -1,
such element of collp collq is filled with excoll[][] of atoms
type. These values are ovewritten by a type of particle collision if
it is found later.  */
typedef struct {
  double t;
  short p;
  short q;
  short ct;
} tab;
typedef struct
{ 
tab dt;
void *pt;
} tlist;
/**********************************************************************
 * The structure for effective search of minimal collision            *
 * each cell has its collision linklist " tlist **inpt". The nodes of *
 * these lists are kept in "storage". To indicate which of            *
 * nodes are free index array "begin" and a current free address      *
 * "free" is used. The champions of each cell "inpt[i]" (i<maxadd,    *
 * the number of cells in the system) form an olympic table "olymp"   *
 * containing the cell numbers who win in the levels from zero to     *
 * final. If the cell is empty, it has inpt[i]=NULL. Local            *  
 * championships  are held by bubble sort.                            * 
 **********************************************************************/  
typedef struct
{
size_al ** olymp;
tlist **begin;
tlist **free;
tlist **inpt;
tlist * storage;
long maxfree;
long nch;
long x;
long y;
long z;
short * atomp;
short * atomq;
short * collp;
short * collq;
size_al * change;
short final;
short np;
short nq;
short n;
} tsearch;
extern int allocsearch(long n);
extern void initsearch(void);
extern int init_tables(void);
extern void set_maxfree(long a);
extern long get_maxfree(void);
extern long get_free(void);
extern void find_atoms(long p1);
extern void squeeze2(long p1);
extern short squeeze1(long p1, short * collp, short * atomp);
extern void update_table(long p1,long q1, long ct1);
extern long squeeze_table(long * p1, long * q1, double * timea);
extern long bubble(tab tb);
extern int check_atoms(long add);
extern short bond(short i, short j);
extern int find_neighbors(int p, short * neib);

  
extern short * get_collp(void);
extern short * get_collq(void);
extern short * get_atomp(void);
extern short * get_atomq(void);
extern short get_np(void);
extern short get_nq(void);
extern long pairs(int (*)(short,short,short));
