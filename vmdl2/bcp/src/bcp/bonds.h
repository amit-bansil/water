#define NBONDS (12)
typedef int bond_type; 

extern int allocBonds(int n,int numbond,int nrt,int ltb);
extern int setBond(int friend1, int friend2);
extern int  breakBond(int friend1, int friend2);
extern void setNewBonds(int value);
extern int getNewBonds(void);
extern int isFriend(bond_type atomNumber, bond_type friendNumber);
extern bond_type nextFriend(int atomNumber, int * index);
extern int getMaxBonds(void);
extern void setNewTypes(int value);
