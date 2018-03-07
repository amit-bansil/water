void send_message_up(char *msg);//the simulation can send messages to java
void send_error_up(char *msg);//use this for errors, the simulation will be prompted to restart

//called when the library is bound, most implementations can ignore
void bindDLL();
//called when the dll is unbound, most implementations can ignore
void unbindDLL();
//called on creation and destrution of interpreter class
void linkInterpreter(); 
void unlinkInterpreter();

//------------------------------------------------------------------
//control methods, return true if successful
//sometimes everyhing may need to be return changed after initialize
//however when reloading a config less
//must gaurantee that for anyFilename is the same
//steps are preformed the same data will be returned
//might be open when initialize is called
//data will only be queiried after initialize
void loadSim(const char *fileName,const char* additionalData);//close handle to file as soon possible
//save the state-remember to also save inputParameters
//for now additionalData=0
void saveSim(const char *fileName,const char* additionalData);
//should unallocate everthing
//data will not be quieried after close
void closeSim();
//abnormal termination during a step
void abort();
//advances time, should keep track of any remainder and stay as close to
//amount of time as possible
//i.e. calling step(2.5), step(2.5) should advace time by 5 units
void step(float amountOfTime);

//must be very fast
void reset();//all flags should return false after reset
int isChanged();//optimization,fewer checks, see getChanged()

//display parameters---------------------------------------------
int getNumParameters();
char** getParameterNames();
char** getParameterGroups();
double* getParameterValues();
int isParametersChanged();//very expensive
int isParameterValuesChanged();//light //returns index first parameter changed
int getFirstParameterChanged();

//input parameters-------------------------------------------------
char **getInputNames();
char **getInputGroups();
long *getInputCounts();
char **getInputParameterNames();
int getInputParameterNamesCount();
int getNumInput();
double *getInputParameterValues();
void call(int fnum,int numParams,double* parameters);

//positions/velocities/bonds------------------------------------------
//return the number of elements changed
int isPositionsChanged();//light //this is the atom #

int isVelocitiesChanged();//light //this is the atom #
//use -1 for nochange
int isBondsChanged();//light //this is the bond #


//begin updateing at index start and return the last index (NOT atom/bond#)
//changed
//should be in the format [atom#0.x,atom#0.y,atom#0.z,atom#1.x...
void getPositions(int start,int end,float *positions);
void getVelocities(int start,int end,float *velocities);
int getLastAtomNumChanged();
int getFirstAtomNumChanged();

//format [bond#0.atomFrom#,bond#0.atomTo#.bond#1.atomFrom...
void getBonds(int start,int end,long *bonds);//..
int getFirstBondNumChanged();
int getLastBondNumChanged();

int getBScanSize();
int getNumAtoms();
int isNumAtomsChanged();//light
int isBScanSizeBondsChanged();


//maxes
int getMaxBondsN();
int getMaxAtoms();
int getNumDimensions();

int isNumDimensionsChanged(); //very expensive,numDimensions is assumed to be three for now
int isMaxAtomsChanged();//very expensive

//size
int isSizeChanged();//light
float* getSize();
//it is a fatal error for an atom to be outside these dimensions
//atoms go are located from -size/2 to size/2, centered about 0,0,0

//only uptoNumAtoms/numBonds will be drawn
//---------------------------------------------------------------------
//typedata
//notice numAtoms/numBonds can be changed without modifying these arrays
int isBondTypesChanged();//expensive

int isAtomTypesChanged();//expensive


//fill beginning at start-array set methods must be well behaved
void getBondTypes(int beginBondNum,int endBondNum,long *);//returns the last value changed
int getFirstBondNumTypeChanged();
int getLastBondNumTypeChanged();
void getAtomTypes(int beginAtomNum,int endAtomNum,long *);//..
int getFirstAtomNumTypeChanged();
int getLastAtomNumTypeChanged();
//note that these will have to fill up to max atom/bond num

//typedescriptions
//if the count of a type description is zero, drawing will be faster
typedef struct _ATOM_TYPE_DESCRIPTION{
  float r,g,b;//color 0-1
  char e1,e2;//element use ' ' for a blank, use ' ',' ' for unknown element
  float radius;//use 0 for a dot and -1 for invisible
  char* description;
}ATOM_TYPE_DESCRIPTION;

int getNumAtomTypeDescriptions();
ATOM_TYPE_DESCRIPTION getAtomTypeDescription(int num);
typedef struct _BOND_TYPE_DESCRIPTION{
  int order;//use 0 for h
  float r,g,b;
  float radius;//use o for line and -1 for invisible
}BOND_TYPE_DESCRIPTION;

int getNumBondTypeDescriptions();
BOND_TYPE_DESCRIPTION getBondTypeDescription(int num);
int isTypeDescriptionsChanged();//expensive
//---------------------------------------------------------------------

