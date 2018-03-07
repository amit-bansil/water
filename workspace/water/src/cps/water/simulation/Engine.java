package cps.water.simulation;

import cps.jarch.util.collections.ArrayFinal;

/**
 * Computational engine for performing actual molecular dynamics simulation.
 * Port of a large C code originally written by Germans in FORTRAN. Accessed
 * through EngineWrapper.
 */
final class Engine {
	/** * Constants ** */

	private static final double avogadro = 6.02205e2d;

	static final double epsilon = 0.6501696d; /* kJ/mol */

	static final double sigma = 0.3165555d; /* nm */

	private static final double boltk = 8.314e-3d;

	private static final double waits = 18.016d;

	private static final double deltr = 200.0d;

	private static final double amyq = 0.3336179212d;

	private static final double rone = 0.2016d;

	private static final double rtwo = 0.31287d;

	// private static final double roc = 0.08d ; /* roc = .15 a */ //never read
	// locally
	private static final double roh = 0.09572d; /* roh = .9572 a */

	private static final double eta = 109.47122d; /* hoh bond angle */

	// private static final double tlp = 0.7439759d ; /* tlp = 1-2*el */ //never
	// read locally
	private static final double el = 0.1280121d; /*
	 * el =
	 * roc/(2*roh*cos(th/2))
	 */

	private static final double pi = 3.1415926535898d;

	static final double scfacq = 0.54122341177d; /* from initial */

	// private static final double eins = 1.0d ; /* one */ //never read locally
	private static final double drei = 3.0d; /* three */

	// private static final double oxygenscale =0.31d; //never read locally
	// private static final double hydrogenscale =0.2d; //never read locally
	/** * In-lines ** */

	private static final double sign2(double a, double b) {
		if (b >= 0) return a;
		else return -a;
	}

	private static final double s(double A, double B, double C, double D) {
		return ((A - B) * (A - B)) * (C - A) / D;
	}

	private static final double t(double A, double B, double C, double D) {
		return 3.0d * (A - B) * (C - A) / (A * D);
	}

	private static final double max(double a, double b) {
		if (a >= b) return a;
		else return b;
	}

	private static final double min(double a, double b) {
		if (a <= b) return a;
		else return b;
	}

	// never used
//	 private static final void clearbuff(double[] b) {
//		int i;
//		for (i = 0; i < b.length; i++)
//			b[i] = 0;
//	} 
//	 
	private static final int MAX_MOLS = 256;

	private static final int MAX_IONS = 2;

	// private static final int MAX_H_BONDS = (MAX_MOLS*4);//never used
	private static final int LAT_RESOLUTION = 20;

// never used
//	private static final double PRIORITY = 1.0d;
//
//	private static final double PI = 3.141592654d;
//
//	private static final int MAX_INTS = 20;
//
//	private static final int WIDTH = 500;
//
//	private static final int HEIGHT = 740;
//
//	private static final int MAX_PROCESSES = 5;
	 
	// !!!private static final int MAX_IONS =2;
	// !!!private static final int MAX_H_BONDS =(MAX_MOLS*4);

	/*
	 * private static final double POT_HIGH = 50.0d; private static final double
	 * POT_LOW = -10.0d; //never used
	 */
	private static final double POT_CUTOFF = 5.0d;

	private static final boolean TRUE = true;

	private static final boolean FALSE = false;

	/*
	 * private static final double distance(double x1,double y1,double z1,
	 * double x2,double y2,double z2) {return
	 * (sqrt((double)((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2)))); }
	 * private static final double sign(double x){ if(x < 0.0) return -1.0; else
	 * return 1.0; } //never used
	 */
	private static final double sqrt(double d) {
		return Math.sqrt(d);
	}

	private static final double fabs(double f) {
		return Math.abs(f);
	}
	
//	never used
//	private static final float fabs(float f) {
//		return Math.abs(f);
//	}
//
//	private static final double abs(double f) {
//		return Math.abs(f);
//	}
//
//	private static final float abs(float f) {
//		return Math.abs(f);
//	}
//
//	private static final int fabs(int f) {
//		return Math.abs(f);
//	}

	private static final int abs(int f) {
		return Math.abs(f);
	}

	private static final double sin(double d) {
		return Math.sin(d);
	}

	private static final double cos(double d) {
		return Math.cos(d);
	}

	private static final double pow(double d, double b) {
		return Math.pow(d, b);
	}

	private static final int INT_MAX = Integer.MAX_VALUE;

	private static final double random() {
		return Math.random();
	}

	private static final void exit(int i)throws ShakeFailException {
		throw new ShakeFailException();
	}

	private static final void printf(String s) {
		System.err.println(s);
	}

	private static final void printf(String s, double a) {
		System.err.printf(s, a);
	}

	//never used
	//	private static final void printf(String s, double a, double b) {
	//		System.err.println(s + "," + a + "," + b);
	//	}
	//
	//	private static final void printf(String s, double a, double b, double c) {
	//		System.err.println(s + "," + a + "," + b + "," + c);
	//	}

	static final boolean numToBool(int n) {
		if (n == 1) return true;
		else return false;
	}

//never used
//	private static final boolean numToBool(double n) {
//		if (n == 1) return true;
//		else return false;
//	}

//never used
//	private static final boolean numToBool(float n) {
//		if (n == 1) return true;
//		else return false;
//	}

	static final int CHLORINE = 0, FLUORINE = 1, SODIUM = 2, LITHIUM = 3, POTASSIUM = 4,
			BROMINE = 5, IODINE = 6, HELIUM = 7, NEON = 8, ARGON = 9, KRYPTON = 10,
			XENON = 11, CESIUM = 12, NONE = 13;

	/* Dynamics variables */

	// char ifile[20],ofile[20],dfile[20],wfile[20],efile[20]; /* i/o file names
	// */
	// FILE *nout,*ndat_in,*ndat_out,*nsav; /* file pointers */
	float tima, acpu, ecpu, cpu; /* timing var's */

	boolean knebg, kdisk, ktape, ktemp, kpres, kgvro, kinpo; /* flags */

	int lnebg, ldisk, ltape, lcrtl, lprot, lrsta, liost;

	int nfi, nacc, natu, nzahl, ngmax, nlist;

	int mols, kmols; /* # of molecules */

	int ldtem, ldpre; /*
	 * temp, pressure var's
	 */

	double dtem, dpre; /* temp., pressure var's */

	double atemp, apres, arho, aeges; /*
	 * actual temp, pressure, density, total
	 * energy
	 */

	double etemp, erho, epres, eeges; /*
	 * desired temp, density, pressure,
	 * total energy
	 */

	double epotav, epotsum; /* average potential energy and the sum */

	double delta; /* time step */

	double taut, taup; /*
	 * temp, pressure rescaling time steps (relaxation
	 * constants)
	 */

	double comp; /* compressibilty */

	double wait[] = new double[3]; /* mass of atoms -> h, h, o */

	double q[] = new double[4]; /* charges of atoms */

	double viria, virira, viriqa; /*
	 * output var's - averages, standard dev.'s,
	 * etc
	 */

	double ekina, ekinra, ekinqa; /*
	 * kinetic energy average, standard dev.,
	 * etc.
	 */

	double eleca; /* average elec energy */

	double egesa, egesra, egesqa; /* total, average, standard dev. of energy */

	double epota, epotra, epotqa; /*
	 * average, standard dev., etc. of potential
	 * energy
	 */

	double ekcma; /*
	 * average kinetic energy of center of mass
	 */

	double tempa, tempra, tempqa; /*
	 * average, standard dev., etc. of
	 * temperature
	 */

	double presa, presra, presqa; /* ditto for pressure */

	double freea; /* average free energy */

	double rhoa, rhora, rhoqa; /* average, standard dev., etc. of density */

	double worka, workra, workqa; /* ditto for thermo dynamic work */

	double tdpqa; /* dipole moment var. */

	double trota, tcmaa; /*
	 * average temperatures of rotation and center of
	 * mass
	 */

	double b, tol, fepa, c, tolb; /* shake algorithm var's */

	double tolc, winvh, winvo, weight; /* ... */

	double qc[] = new double[65], qs[] = new double[65]; /*
	 * structure factor
	 * var's
	 */

	double sqp[] = new double[9], sqa[] = new double[9], sq[] = new double[9]; /* ... */

	int kk[] = new int[65], kx[] = new int[65], ky[] = new int[65], kz[] = new int[65]; /* ... */

	int molpz[] = new int[9]; /* ... */

	double dqm; /* molecule displacement */

	short list[] = new short[95000]; /* list of all possible neighbors */

	int last[] = new int[256]; /* index to last neighbor in 'list' */

	/* for each molecule */

	double rnlast[][] = new double[256][3]; /* position vectors of all molecules */

	/* at last neighbor list calculation */

	double parke[] = new double[4]; /* kinetic energy var's */

	final double ve[][][] = new double[256][3][3]; /* particle velocities */

	final float rn[][][] = new float[256][3][3]; /* particle information -> particle #, */

	/* position, atom (h,h,o) within molecule */

	int ng[] = new int[200]; /* intermediate var's */

	double gn[] = new double[200], gpt[] = new double[200], gkr[] = new double[200];

	double f[][][] = new double[256][3][3]; /* force on all atoms */

	double virial, epoten, elepot; /* output var's */

	double dip[][] = new double[256][3]; /*
	 * dipole moment var for each
	 * molecule
	 */

	double rcm[][] = new double[256][3]; /* center of mass for each molecule */

	double rnq[][][] = new double[256][4][3]; /*
	 * charge positions for all
	 * molecules
	 */

	double tdip[] = new double[4]; /* related to 'dip' */

	double rstart[][] = new double[256][3]; /* initial positions of molecules */

	/* (relative to o atoms) */

	int iv[] = new int[3], jv[] = new int[3]; /* constant vectors */

	double rm[][][] = new double[256][3][3]; /*
	 * coordinate storage for motion
	 * integration
	 */

	double bx, by, bz; /* box length in x, y, z */

	double boxhx, boxhy, boxhz; /*
	 * box is (-boxhx,+boxhx),(-boxhy,+boxhy),
	 */

	/* (-boxhz,+boxhz) in x, y, z respectively */

	double volume; /* volume of box */

	double facgvr, facpot; /* factor var's */

	double wwx, wwy, wwz; /* 2*pi/boxlength */

	double conrep, conatp, conref, conatf; /*
	 * constants in potential and force
	 * calculations
	 */

	double fmols, roneq, rtwoq;

	double facpre, facvir, facden, facwor, facrf; /* factor var's */

	double rang2q, rang2;

	double permit; /* permittable range of molecule movement */

	double range3, rang3h, rangeq, range, rantq, rant;

	double r2mr, r3mr, tr2, tr3, em, factmp[] = new double[2], faceki[] = new double[4],
			qij[][] = new double[4][4];
	ArrayFinal<Ion> ions;
	
	double rp[] = new double[9], r[] = new double[9];

	double eges, egesp, egesrp, egesf; /* total energy var's */

	double temp, tempp, temprp, tempf; /* temperature var's */

	double epot, epotp, epotrp, epotf; /* potential var's */

	double viri, virip, virirp, virif; /* virial var's */

	double ekin, ekinp, ekinrp, ekinf; /* kinetic energy var's */

	double pres, presp, presrp, presf; /* pressure var's */

	double rho, rhop, rhorp, rhof; /* density var's */

	double work, workp, workrp, workf; /* work var's */

	double trot, trotp, tcma, tcmap; /*
	 * temperatures of center of mass,
	 * rotation var's
	 */

	double ekcm, ekcmp, elec, elecp; /* kinetic, elec, etc. energy var's ... */

	double free, freep; /* free energy var's */

	double tdpq, tdpqp, qdip; /* dipole var's */

	int kout;

	/* Additional sim variables for SPC */
	double potH2O[] = new double[MAX_MOLS]; /*
	 * Amit !!! new array for potential
	 * energies of each molecule
	 */

	double xion[] = new double[MAX_MOLS], yion[] = new double[MAX_MOLS],
			zion[] = new double[MAX_MOLS];

	double ttswp[] = new double[MAX_MOLS], ttswit[] = new double[MAX_MOLS], fc;

	double vxx[] = new double[MAX_MOLS], vyy[] = new double[MAX_MOLS],
			vzz[] = new double[MAX_MOLS];

	double vxy[] = new double[MAX_MOLS], vxz[] = new double[MAX_MOLS],
			vyz[] = new double[MAX_MOLS];
	
	double cmx[] = new double[MAX_MOLS], cmy[] = new double[MAX_MOLS],
			cmz[] = new double[MAX_MOLS];

	double virx[] = new double[MAX_MOLS], viry[] = new double[MAX_MOLS],
			virz[] = new double[MAX_MOLS];

	double hyderg[] = new double[MAX_MOLS];

	double unitq; /* internal charge unit */

	double unitl; /* internal length unit */

	double unite; /* internal energy unit */

	double elechg; /* elementary charge */

	double qhy, qox; /* charge distribution according to spc or spc/e model */

	/* double solch; *//* charge of ion (+3,+2,...,-2,-3) */
	double fkj, fkjmol;

	double virwi[] = new double[MAX_IONS], virialwi;

	int infnty, nsavg, nslys, nstap, nsmx, nsscl;

	int konavg, konlys, kontap, konmx, konscl, inxstk, lstscl;

	double prot, roll, runav, rlambw, rlambi;

	double waito, winvt, winvi, wfac;

	double fmoinv, few, fecmw, fei, ftem3, ftem3m, ftem6m, fpr;

	double fdcm, fjin, focta, ftptot, fdi, fcdip, pi2;

	//double frang, frangt, ft2mi, ft3m, ftemi3;

	double vscfac;

	/* Alterations for > 1 ions */

	double fxa[] = new double[MAX_IONS], fya[] = new double[MAX_IONS],
			fza[] = new double[MAX_IONS];

	double fii[][] = new double[3][MAX_IONS], fxi[] = new double[MAX_IONS],
			fyi[] = new double[MAX_IONS], fzi[] = new double[MAX_IONS];

	double xni[] = new double[MAX_IONS],
			yni[] = new double[MAX_IONS], zni[] = new double[MAX_IONS];

	double vxi[] = new double[MAX_IONS], vyi[] = new double[MAX_IONS],
			vzi[] = new double[MAX_IONS];

	double dfxi[] = new double[MAX_IONS], dfyi[] = new double[MAX_IONS],
			dfzi[] = new double[MAX_IONS];

	double eki[] = new double[MAX_IONS];

	double tempi[] = new double[MAX_IONS];

	double fcwi[] = new double[MAX_IONS];

	double potwi[] = new double[MAX_IONS];

	double couii, hydii, corii, polii, fcii, potii, virii, virialww, rii;

	int indxww[][] = new int[MAX_MOLS][3];

	double epbridge;

	double rhonew;

	double pressum, presav, tempsum, tempav;

	int ik, it;

	/* Simulation variables */

	int wsid;

	int currentrep;

	int hbonds; /* Current number of visible O-H bonds */

	boolean scale_density;

	int scale_time;

	int display_time, display_step;

	int quit_sim; /*
	 * If TRUE, simulation is ditched at end of scheduler step
	 */

	/* we need them for structure factor : */

	static int kk_data[] = {0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4,
			4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6,
			7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8};

	static int kx_data[] = {1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, -1, 2, 0, 0, 2, 1, -2,
			-1, 0, 0, 0, 0, 2, 1, -2, -1, 2, 1, 1, -2, -1, -1, 2, 1, 1, 2, 1, 1, 2, 2, 0,
			0, 2, 2, 2, 2, 1, -2, -2, -1, 2, 2, 1, 2, 2, 1, 3, 0, 0, 2, -2, 2, 2};

	static int ky_data[] = {0, 1, 0, 1, -1, 1, 1, 0, 0, 1, 1, -1, 1, 0, 2, 0, 1, 2, 1, 2,
			1, 2, -1, -2, 0, 0, 0, 0, 1, 2, 1, 1, 2, 1, -1, -2, -1, 1, 2, 1, 2, -2, 2, 2,
			0, 0, 2, 1, 2, 2, 1, 2, -2, -1, -2, 2, 1, 2, 0, 3, 0, 2, 2, -2, 2};

	static int kz_data[] = {0, 0, 1, 0, 0, 1, -1, 1, -1, 1, -1, 1, 1, 0, 0, 2, 0, 0, 0,
			0, 2, 1, 2, 1, 1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 1, 2, -1, -1, -2, 0, 0, 2,
			-2, 2, -2, 1, 2, 2, 1, 2, 2, 1, 2, 2, -1, -2, -2, 0, 0, 3, 2, 2, 2, -2};

	/*
	 * Parameters that can be changed by user display step Desired Temperature
	 * NVT (kpres==False) Desired Density (setdensity) NPT (kpres==True) Desired
	 * Pressure (setpressure)
	 * 
	 * 
	 * Ion Number Ion Type Ion x,y,z
	 * 
	 * hidrogen bonds is buggy (two NB per hydrogen when pressure is 500MPa, 27
	 * molecules)
	 * 
	 * DATABLOCK is the main structure, which contains everything about the
	 * simolation
	 * 
	 * natu - number of steps (atomic time units?) nzahl =100000 (maximal number
	 * of steps)
	 * 
	 * flags kpres,ktemp constant pressure, temperature (NPT,NVT) happens in
	 * set_nvt and set_npt in main.c
	 * 
	 * status (RUN, PAUSE)
	 */

	public Engine() {
		//empty block
	}

	public void blockdata() {
		int i, j, k;
		/* begin block data initialization */

		this.iv[0] = 2;
		this.iv[1] = 3;
		this.iv[2] = 1;
		this.jv[0] = 3;
		this.jv[1] = 1;
		this.jv[2] = 2;

		this.ldtem = 10;
		this.ldpre = 0;
		this.dtem = 0.0;
		this.dpre = 0.0;
		this.atemp = 273.13;
		this.apres = 0.0;
		this.arho = 1.0;
		this.aeges = -35.58;

		this.etemp = 273.13;
		/** * is this data overwritten in anfang ??? ** */
		this.erho = 1.0;
		this.epres = 0.0;
		this.eeges = -35.58;
		this.delta = 1.0e-3;
		this.taut = 0.01;
		this.taup = 0.05;
		this.comp = 310.8e-6;

		this.tima = 5950.0f;
		this.acpu = this.ecpu = this.cpu = 0.0f;

		this.knebg = TRUE;
		/** * same here ** */
		this.kdisk = TRUE;
		this.ktape = FALSE;
		this.ktemp = TRUE;
		this.kpres = FALSE;
		this.kgvro = FALSE;
		this.kinpo = TRUE;

		this.lnebg = 1;
		this.ldisk = 10;
		this.ltape = 5;
		this.lcrtl = 2;
		this.lprot = 1;
		this.lrsta = 0;
		this.liost = 1;

		this.wait[0] = this.wait[1] = 1.008;
		this.wait[2] = 16.0;

		/* charges changed from spc to spc/e for better results */
		this.q[0] = this.q[1] = 6.789276; /* spc: q(hydrogen)=6.5682 */
		this.q[2] = -13.578552; /* spc: q(oxygen)=-13.1364 */
		this.q[3] = 0.0;

		this.b = 9.162e-3; /* any of these constant ??? take them out */

		/* ok down to here */

		this.tol = 1.0e-5;
		this.fepa = 1.0e-8;
		this.c = 0.0;
		this.tolb = 2.0e-7;
		this.tolc = 2.0e-5;
		this.winvh = 0.0;
		this.winvo = 0.0;
		this.weight = 0.25;

		this.nfi = this.nacc = this.natu = 0;
		this.nzahl = 100;
		this.mols = 256;
		this.ngmax = 200;
		this.nlist = 95000;
		this.kmols = 0;

		this.viria = this.virira = this.viriqa = this.ekina = this.ekinra = this.ekinqa = this.eleca = this.freea = this.tdpqa = 0.0;

		this.egesa = this.egesra = this.egesqa = this.epota = this.epotra = this.epotqa = this.ekcma = this.trota = this.tcmaa = 0.0;

		this.tempa = this.tempra = this.tempqa = this.presa = this.presra = this.presqa = this.rhoa = this.rhora = this.rhoqa = 0.0;
		this.worka = this.workra = this.workqa = 0.0;

		for (i = 0; i < 65; i++)
			this.qc[i] = this.qs[i] = 0;

		for (i = 0; i < 9; i++)
			this.sqp[i] = this.sqa[i] = this.sq[i] = 0.0;

		this.dqm = 0.0;

		for (i = 0; i < 65; i++) {
			this.kk[i] = kk_data[i];
			this.kx[i] = kx_data[i];
			this.ky[i] = ky_data[i];
			this.kz[i] = kz_data[i];
		}

		this.molpz[0] = 3;
		this.molpz[1] = 6;
		this.molpz[2] = 4;
		this.molpz[3] = 3;
		this.molpz[4] = 12;
		this.molpz[5] = 12;
		this.molpz[6] = 6;
		this.molpz[7] = 15;
		this.molpz[8] = 4;

		for (i = 0; i < 200; i++) {
			this.ng[i] = 0;
			this.gn[i] = this.gpt[i] = this.gkr[i] = 0.0;
		}

		for (i = 0; i < 95000; i++)
			this.list[i] = 0;

		for (i = 0; i < 256; i++)
			this.last[i] = 0;

		this.virial = this.epoten = this.elepot = 0.0;

		for (i = 0; i < 4; i++) {
			this.tdip[i] = 0.0;
			this.parke[i] = 0.0;
		}

		for (i = 0; i < 256; i++)
			for (j = 0; j < 4; j++)
				for (k = 0; k < 3; k++)
					this.rnq[i][j][k] = 0.0;

		for (i = 0; i < 256; i++)
			for (j = 0; j < 3; j++) {
				this.dip[i][j] = 0.0;
				this.rnlast[i][j] = 0.0;
				this.rcm[i][j] = 0.0;
				this.rstart[i][j] = 0.0;
			}

		for (i = 0; i < 256; i++)
			for (j = 0; j < 3; j++)
				for (k = 0; k < 3; k++) {
					this.rm[i][j][k] = 0.0;
					this.rn[i][j][k] = 0.0f;
					this.ve[i][j][k] = 0.0;
					this.f[i][j][k] = 0.0;
				}

		/* end block data initialization */
	}

	/*
	 * :::::::::::::: config.c ::::::::::::::
	 */

	void config() {
		double phi, edrit, ankat, gekat, vfat, bmin, fx, fy, fz;
		double dn, tk;
		int nx = 0, ny = 0, nz = 0, mi = 0, mio = 0, i, j, k, il, jx, jy, jz;
		double unitx, unity, unitz, shiftx, shifty, shiftz;
		double vo, xa, ya, za;
		double tm1, tm2, tm3, om1, om2, om3;
		double rot1, rot2, rot3, rot4, rot5, rot6, rot7, rot8, rot9;
		double alf, bet, gam, vxh, vyh, vzh;
		double csa, sna, csb, snb, csg, sng;

		double rcm[][] = new double[256][3];
		double rms[][][] = new double[256][3][3], vcm[][] = new double[256][3], vm[] = new double[3];
		
		//never used
		//int mf[] = new int[8];

		for (i = 0; i < 256; i++) {
			for (j = 0; j < 3; j++) {
				rcm[i][j] = 0.0;
				vcm[i][j] = 0.0;
				for (k = 0; k < 3; k++)
					rms[i][j][k] = 0.0;
			}
		}

		for (i = 0; i < 3; i++)
			vm[i] = 0.0;

		this.nfi = 0;
		this.arho = this.erho;

		edrit = 1.0 / 3.0;


		phi = (eta * pi) / (180.0 * 2.0);

		ankat = roh * cos(phi);

		gekat = roh * sin(phi);

		this.volume = waits * this.mols / (this.arho * avogadro);

		vfat = pow((this.volume / this.bx / this.by / this.bz), edrit);
		/***********************************************************************
		 * * <<<---- check this !!!!
		 **********************************************************************/

		this.bx *= vfat;
		this.by *= vfat;
		this.bz *= vfat;

		bmin = max(this.bx, 0.0);
		bmin = max(this.by, bmin);
		bmin = max(this.bz, bmin);

		fx = this.bx / bmin;
		fy = this.by / bmin;
		fz = this.bz / bmin;

		for (k = 0; k < this.mols; k++) {
			tk =  k / 5.0;
			nx = (int) (tk * fx);
			ny = (int) (tk * fy);
			nz = (int) (tk * fz);
			mi = nx * ny * nz;
			if (mi > this.mols) break;
			mio = mi;
		}
		if (abs(mio - this.mols) < abs(mi - this.mols)) /** * check abs(...) ** */
		{
			tk = (k - 1) / 5.0;
			nx = (int) (tk * fx);
			ny = (int) (tk * fy);
			nz = (int) (tk * fz);
			mi = nx * ny * nz;
		}

		/*
		 * printf("\n i suggest working with %d molecules %d %d
		 * %d\n",mi,nx,ny,nz);
		 */

		dn = pow(((double) mi / (double) this.mols), edrit);

		this.bx *= dn;
		this.by *= dn;
		this.bz *= dn;

		/*
		 * printf("\n bx = %e, by = %e, bz = %e\n",this.bx,this.by,this.bz);
		 */

		this.mols = mi;

		this.boxhx = this.bx / 2.0;
		unitx = this.bx / nx;
		shiftx = unitx / 2.0;

		this.boxhy = this.by / 2.0;
		unity = this.by / ny;
		shifty = unity / 2.0;

		this.boxhz = this.bz / 2.0;
		unitz = this.bz / nz;
		shiftz = unitz / 2.0;

		/*
		 * *** setzen der geschwindigkeiten auf die angegebene tempratur ***
		 */

		vo = sqrt(3.0 * boltk * this.atemp / waits);/* square root ??? */

		il = 0;

		xa = -(this.boxhx) - shiftx;

		for (jx = 0; jx < nx; jx++) /*******************************************
		 * ***** should these be nested like this
		 * ????
		 ******************************************/
		{
			xa += unitx;
			ya = -(this.boxhy) - shifty;

			for (jy = 0; jy < ny; jy++) {
				ya += unity;
				za = -(this.boxhz) - shiftz;

				for (jz = 0; jz < nz; jz++) /** ********************************************* */
				{
					za += unitz;

					rcm[il][0] = xa;
					rcm[il][1] = ya;
					rcm[il][2] = za;

					/*
					 * printf("\nrcm[%d]: %lf, %lf,
					 * %lf",il,rcm[il][0],rcm[il][1],rcm[il][2]);
					 */

					vcm[il][0] = (2.0 * (random() / INT_MAX) - 1.0)
							* vo; /*
					 * rand must be 0 - 1
					 */
					vcm[il][1] = (2.0 * (random() / INT_MAX) - 1.0)
							* vo;
					vcm[il][2] = (2.0 * (random() / INT_MAX) - 1.0)
							* vo;

					vm[0] += vcm[il][0];
					vm[1] += vcm[il][1];
					vm[2] += vcm[il][2];

					rms[il][0][0] = ankat * this.wait[2] / waits;
					rms[il][1][0] = gekat;
					rms[il][2][0] = 0.0;

					rms[il][0][1] = ankat * this.wait[2] / waits;
					rms[il][1][1] = -gekat;
					rms[il][2][1] = 0.0;

					rms[il][0][2] = -2.0 * this.wait[0] * ankat / waits;
					rms[il][1][2] = 0.0;
					rms[il][2][2] = 0.0;

					il++;
				}
			}
		}

		/*
		 * ************** berechnung der traegheitsmonente *****************
		 */

		tm1 = 2.0 * this.wait[0] * gekat * gekat;
		tm2 = 2.0 * this.wait[0] * this.wait[2] * (ankat * ankat) / waits;
		tm3 = tm1 + tm2;

		/*
		 * ********** berechnung des rotationsvecktors *********************
		 */

		om1 = sqrt((boltk * this.atemp / tm1));
		/** * square root ** */
		om2 = sqrt((boltk * this.atemp / tm2));
		om3 = sqrt((boltk * this.atemp / tm3));

		/*
		 * ********** berechnung der geschwindigkeiten *********************
		 */

		for (i = 0; i < this.mols; i++) {
			vxh = ((random() / INT_MAX) >= 0.5) ? -1.0 : 1.0;
			vyh = ((random() / INT_MAX) >= 0.5) ? -1.0 : 1.0;
			vzh = ((random() / INT_MAX) >= 0.5) ? -1.0 : 1.0;

			/*
			 * ************ vorgabe der eulerwinkel ****************************
			 */

			alf = 2.0 * pi * (random() / INT_MAX);
			bet = 1.0 * pi * (random() / INT_MAX);
			gam = 2.0 * pi * (random() / INT_MAX);

			sna = sin(alf);
			snb = sin(bet);
			sng = sin(gam);

			csa = cos(alf);
			csb = cos(bet);
			csg = cos(gam);

			/*
			 * ******* rotationsmatrix fuer das molekuel ***********************
			 */
			rot1 = csg * csa - sng * sna * csb;
			rot2 = -sng * csa - csg * sna * csb;
			rot3 = sna * snb;

			rot4 = csg * sna + sng * csa * csb;
			rot5 = -sng * sna + csg * csa * csb;
			rot6 = -csa * snb;

			rot7 = sng * snb;
			rot8 = csg * snb;
			rot9 = csb;

			/*
			 * **** umrechnug der eulerwinkel in kartesische koordinaten *******
			 */

			for (k = 0; k < 3; k++) {
				this.rm[i][0][k] = rms[i][0][k] * rot1 + rms[i][1][k] * rot2
						+ rms[i][2][k] * rot3;
				this.rm[i][1][k] = rms[i][0][k] * rot4 + rms[i][1][k] * rot5
						+ rms[i][2][k] * rot6;
				this.rm[i][2][k] = rms[i][0][k] * rot7 + rms[i][1][k] * rot8
						+ rms[i][2][k] * rot9;
			}

			/*
			 * ** berechnung von [omega,r] fuer molekuel i und j ***************
			 */

			for (k = 0; k < 3; k++) {
				this.ve[i][0][k] = vxh
						* (om2 * this.rm[i][2][k] - om3 * this.rm[i][1][k]);
				this.ve[i][1][k] = vyh
						* (om3 * this.rm[i][0][k] - om1 * this.rm[i][2][k]);
				this.ve[i][2][k] = vzh
						* (om1 * this.rm[i][1][k] - om2 * this.rm[i][0][k]);
			}
		}

		/*
		 * ************** berechnung der koordinaten ***********************
		 */

		for (i = 0; i < this.mols; i++) {
			for (j = 0; j < 3; j++) {
				vcm[i][j] = vcm[i][j] - (vm[j] / this.mols);
				for (k = 0; k < 3; k++) {
					this.ve[i][j][k] += vcm[i][j];
					this.rm[i][j][k] += rcm[i][j];
					this.rn[i][j][k] = (float) (this.rm[i][j][k] + (this.ve[i][j][k] * this.delta));
				}
			}
		}
		/*
		 * for(i=0;i<256;i++) printf("\n rn: %lf, %lf,
		 * %lf",this.rn[i][0][2],this.rn[i][1][2],this.rn[i][2][2]);
		 */

	}

	/*
	 * :::::::::::::: anfang.c ::::::::::::::
	 */

	public void anfang() {
		int i, j;

		/*
		 * strcpy(this.ofile,"spc.out"); strcpy(this.dfile,"formatted_restart");
		 * strcpy(dfile2,"spc-ice.dat");
		 * 
		 * printf("\n output file: %s\n",this.ofile); printf("\n read from: %s,
		 * and write to: %s\n",this.dfile,dfile2);
		 * 
		 * if((this.nout = fopen(this.ofile,"w")) == NULL) { printf("\n can't
		 * open output file \'%s\'\n",this.ofile); exit(0); }
		 */

		this.knebg = TRUE;
		this.ktape = FALSE;
		this.kgvro = FALSE;
		this.kinpo = FALSE;
		this.kpres = FALSE;
		this.kdisk = FALSE;
		this.ktemp = TRUE;
		this.lnebg = 1;
		this.ldtem = this.ldpre = 0;
		this.ldisk = 4000;
		this.ltape = 1;

		// !!!printf("What is number of molecules\nMUST have an integer cube
		// root?\n");
		// !!!scanf("%d",&(this.mols));
		this.mols = 27;

		this.lcrtl = 1;
		this.lprot = 100; /* from 1000 */
		this.nzahl = 100000; /* from 6000000 */
		this.etemp = 273.0;
		this.erho = 1.0;
		this.epres = 0.0;
		/* this.delta=1.0e-3; *//* 1 fs */

		this.delta = 5.0e-3; /* 5 fs */

		this.taut = 0.01;
		this.taup = 0.1; /*
		 * this value should not be decreased -> won't work
		 * with ion
		 */
		this.comp = 4.2020e-4;
		this.tima = 1.0e+7f;
		this.bx = this.by = this.bz = 1.93893;

		this.rhonew = 1.0;

//meaningless code
//		if (this.mols == 216) {
//
//		}

		/*
		 * printf("\n mols = %d\n",this.mols);
		 */

		/*
		 * this is for the story file and one should be morec careful for memory
		 */

		if (this.lnebg == 0) /* restart? */
		this.delta = 0.5e-3;

		else {
			config();
			/*
			 * this.kpres = FALSE;
			 */
		}

		if (this.kpres && (this.lnebg != 2)) this.erho = this.rhop;

		if (this.knebg) {
			this.nacc = 0;

			for (i = 0; i < this.mols; i++) {
				for (j = 0; j < 3; j++)
					this.rstart[i][j] = this.rn[i][j][2];
			}
		}
	}

	/*
	 * :::::::::::::: initial.c ::::::::::::::
	 */

	// extern int kk_data[];
	// extern int kx_data[];
	// extern int ky_data[];
	// extern int kz_data[];
	void initial() {
		double bmin, roh1, roh2;
		int i, j, nmax;

		this.lrsta = this.ldisk * this.ltape;

		this.fmols = this.mols;

		/*
		 * printf("\nmols: %d fmols: %lf\n",this.mols,this.fmols);
		 */

		/* print *,' n. molecules',fmols */

		this.nzahl = (int) ((double) this.nzahl / (double) this.lrsta + 0.5) * this.lrsta;

		if (this.nzahl == 0) this.nzahl = this.lrsta;
		if (this.lcrtl == 0) this.lcrtl = 1;

		this.em = el * sqrt(drei) / roh; /* square root */

		for (i = 0; i < 4; i++)
			for (j = 0; j < 4; j++)
				this.qij[i][j] = this.q[i] * this.q[j] * scfacq;

		/* modified for tip4p */
		/* c = 8.0*b/3.0 sqrt(c)=2* sqrt(b)*sin(teta/2) */

		this.c = 4 * this.b * 0.7907964 * 0.7907964;

		this.tolc *= this.c;
		this.winvh = 0.5 * this.wait[2] / waits;
		this.winvo = 0.5 * this.wait[0] / waits;

		this.dtem *= (((double) this.lcrtl * (double) this.ldtem) * (((this.etemp - this.atemp) >= 0.0) ? 1.0
				: -1.0));

		this.dpre *= (((double) this.lcrtl * (double) this.ldpre) * (((this.epres - this.apres) >= 0.0) ? 1.0
				: -1.0));

		this.conrep = 4.0 * epsilon * pow(sigma, 12.0);
		this.conatp = 4.0 * epsilon * pow(sigma, 6.0);
		this.conref = 12.0 * this.conrep;
		this.conatf = 6.0 * this.conatp;

		bmin = min(this.bx, 95000.0);
		bmin = min(this.by, bmin);
		bmin = min(this.bz, bmin);

		bmin /= 2.0;

		this.boxhx = 0.5 * this.bx;
		this.boxhy = 0.5 * this.by;
		this.boxhz = 0.5 * this.bz;
		this.range = 2.50 * sigma + 0.005;

		if (this.range > bmin) this.range = bmin;

		/*
		 * printf("range used: %e\n",this.range);
		 */

		this.rant = 0.95 * this.range;
		this.rang2 = 1.10 * this.range;
		this.range3 = 1.00 / (this.range * this.range * this.range);
		this.rang3h = 0.50 * this.range3;

		this.wwx = 2.00 * pi / this.bx;
		this.wwy = 2.00 * pi / this.by;
		this.wwz = 2.00 * pi / this.bz;

		this.permit = 0.25 * (this.rang2 - this.range) * (this.rang2 - this.range);

		this.rtwoq = rtwo * rtwo;
		this.roneq = rone * rone;
		this.rantq = this.rant * this.rant;
		this.rangeq = this.range * this.range;
		this.rang2q = this.rang2 * this.rang2;

		this.volume = this.bx * this.by * this.bz;

		this.r2mr = 0.5 * (rtwo - rone) * (rtwo - rone) * (rtwo - rone);
		this.tr2 = 0.5 * pow((this.range - this.rant), 3.0);
		this.r3mr = 0.5 * (3.0 * rtwo - rone);
		this.tr3 = 0.5 * (3.0 * this.range - this.rant);

		nmax = ((int) (deltr * this.range + 0.5)) + 1;

		if (this.ngmax > nmax) this.ngmax = nmax;

		this.factmp[0] = 2.0 / (3.0 * boltk);
		this.factmp[1] = 1.0 / (3.0 * boltk);

		/*
		 * printf("\n\n factmp: %.12lf,
		 * %.12lf\n",this.factmp[0],this.factmp[1]);
		 */

		this.faceki[0] = 0.5 * this.wait[0] / this.fmols;
		this.faceki[1] = 0.5 * this.wait[1] / this.fmols;
		this.faceki[2] = 0.5 * this.wait[2] / this.fmols;
		this.faceki[3] = 0.5 / (waits * this.fmols);

		this.facpre = 2.0e+3 * this.fmols / (3.0 * avogadro);
		this.facwor = 1.0e-3 * avogadro / this.fmols;
		this.facvir = 0.5 / this.fmols;

		/*
		 * printf("\n amyq: %lf, range3: %lf, epsilon: %lf, sigma: %lf, pi:
		 * %lf\nfmols: %lf",amyq,this.range3,epsilon,sigma,pi,this.fmols);
		 */

		this.facrf = 0.5 * amyq * this.range3;
		this.facpot = 8.0 * pi * this.range3 * epsilon * this.fmols
				* pow(sigma, 6.0) / (3.0 * this.volume);

		/*
		 * printf("\n facrf: %lf, facpot: %lf\n\n",this.facrf,this.facpot);
		 */

		this.facden = waits * this.fmols / avogadro;
		this.facgvr = deltr * this.volume / (2.0 * pi * this.fmols * this.fmols);

		if (this.kpres || (this.lnebg != 2)) return;

		for (i = 0; i < this.mols; i++) {
			for (j = 0; j < 3; j++) {
				roh1 = this.rn[i][j][0] - this.rn[i][j][2];
				roh2 = this.rn[i][j][1] - this.rn[i][j][2];

				this.rn[i][j][2] = (float) (this.rn[i][j][2] * this.erho / this.arho);
				this.rn[i][j][1] = (float) (this.rn[i][j][2] + roh2);
				this.rn[i][j][0] = (float) (this.rn[i][j][2] + roh1);
			}
		}
		this.arho = this.erho;
	}

	/*
	 * :::::::::::::: motion.c ::::::::::::::
	 */

	// extern double vscale();
	// extern void herman();
	void motion()throws ShakeFailException {
		double alfa, velcm, anperx, anpery, anperz;
		int i, j, k, nperx, npery, nperz;

		alfa = 1.0;
		for (i = 0; i < 4; i++)
			this.parke[i] = 0.0;

		/*
		 * ********************** tempraturkontrolle ***********************
		 */

		if (this.ktemp) alfa = vscale();

		for (i = 0; i < this.mols; i++) {
			for (j = 0; j < 3; j++) {
				velcm = 0.0;
				for (k = 0; k < 3; k++)
					velcm += (this.wait[k] * this.ve[i][j][k]);

				this.parke[3] += (velcm * velcm);
			}
		}

		/*
		 * ***** berechnen der neuen positionen und geschwindigkeiten ******
		 */

		for (i = 0; i < this.mols; i++) {
			for (j = 0; j < 3; j++) {
				for (k = 0; k < 3; k++) {

					this.ve[i][j][k] = (this.ve[i][j][k] + this.f[i][j][k] * this.delta
							/ this.wait[k])
							* alfa;
					this.rm[i][j][k] = this.rn[i][j][k];
					this.rn[i][j][k] = (float) (this.rm[i][j][k] + this.ve[i][j][k]
							* this.delta);
				}
			}
		}

		/* printf("\n ve[1][1][2] : %f\n",this.ve[1][1][2]); */

		/*
		 * ****************** aufruf des shakealgoritmus *******************
		 */

		herman();

		for (i = 0; i < this.mols; i++) {
			for (j = 0; j < 3; j++) {
				for (k = 0; k < 3; k++) {
					this.ve[i][j][k] = (this.rn[i][j][k] - this.rm[i][j][k]) / this.delta;
					this.parke[k] += (this.ve[i][j][k] * this.ve[i][j][k]);
				}
			}
		}

		/*
		 * *************** periodische randbedingungen *********************
		 */
		// periodic boundries???
		// added jumped 11/4
		for (i = 0; i < this.mols; i++) {
			j = 0;
			nperx = (int) (fabs(this.rn[i][j][2]) / this.boxhx);
			anperx = sign2((nperx * this.bx), this.rn[i][j][2]);

			j = 1;
			npery = (int) (fabs(this.rn[i][j][2]) / this.boxhy);
			anpery = sign2((npery * this.by), this.rn[i][j][2]);

			j = 2;
			nperz = (int) (fabs(this.rn[i][j][2]) / this.boxhz);
			anperz = sign2((nperz * this.bz), this.rn[i][j][2]);

			// jump test
			if (anperx != 0) jumped[i][0] = true;
			else jumped[i][0] = false;

			if (anpery != 0) jumped[i][1] = true;
			else jumped[i][1] = false;

			if (anperz != 0) jumped[i][2] = true;
			else jumped[i][2] = false;
			// end jump test

			j = 0;
			this.rn[i][j][0] -= anperx;
			this.rn[i][j][1] -= anperx;
			this.rn[i][j][2] -= anperx;

			j = 1;
			this.rn[i][j][0] -= anpery;
			this.rn[i][j][1] -= anpery;
			this.rn[i][j][2] -= anpery;

			j = 2;
			this.rn[i][j][0] -= anperz;
			this.rn[i][j][1] -= anperz;
			this.rn[i][j][2] -= anperz;
		}

		/*
		 * every 10 steps check drift in momentum
		 */

		if ((this.nacc % 10) == 1) drift();
	}

	// added jumped 11/4
	boolean[][] jumped = new boolean[256][3];

	/*
	 * :::::::::::::: neighborlist.c ::::::::::::::
	 */

	void neighborlist()throws ShakeFailException {
		double rij[] = new double[3];
		int index[] = new int[256], i, j, inl, ind;
		double diffx, diffy, diffz, diffsq = 0, roo;

		for (i = 0; i < 256; i++)
			index[i] = 0;

		for (i = 0; i < this.mols; i++) {
			diffx = fabs(this.rn[i][0][2] - this.rnlast[i][0]);
			diffy = fabs(this.rn[i][1][2] - this.rnlast[i][1]);
			diffz = fabs(this.rn[i][2][2] - this.rnlast[i][2]);

			if (diffx > this.boxhx) diffx -= this.bx;
			if (diffy > this.boxhy) diffy -= this.by;
			if (diffz > this.boxhz) diffz -= this.bz;

			diffsq = diffx * diffx + diffy * diffy + diffz * diffz;

			if (diffsq > this.permit) break;
		}

		if (diffsq > this.permit) {
			inl = 0;

			for (i = 0; i < this.mols; i++) {
				this.rnlast[i][0] = this.rn[i][0][2];
				this.rnlast[i][1] = this.rn[i][1][2];
				this.rnlast[i][2] = this.rn[i][2][2];
			}

			for (i = 0; i < this.mols - 1; i++) {
				for (j = i + 1; j < this.mols; j++) {
					rij[0] = this.rn[i][0][2] - this.rn[j][0][2];
					rij[1] = this.rn[i][1][2] - this.rn[j][1][2];
					rij[2] = this.rn[i][2][2] - this.rn[j][2][2];

					rij[0] = rij[0] - this.bx * ((int) (rij[0] / this.boxhx));
					rij[1] = rij[1] - this.by * ((int) (rij[1] / this.boxhy));
					rij[2] = rij[2] - this.bz * ((int) (rij[2] / this.boxhz));

					roo = rij[0] * rij[0] + rij[1] * rij[1] + rij[2] * rij[2];

					ind = 1;
					/** * <<--- check this index !!!! ** */

					if (roo >= this.rang2q) ind = 0;

					index[j] = ind;
				}

				for (j = i + 1; j < this.mols; j++) {
					this.list[inl] = (short) j;
					inl += index[j];
				}
				this.last[i] = inl - 1;
			}
			if (inl <= this.nlist) return;
			// fprintf(this.nout,"\n array overflow: counter > nlist - program
			// halt.\n");
			exit(0);
		}
	}

	/*
	 * :::::::::::::: allfiv.c ::::::::::::::
	 */

	void allfiv() {
		int i, j;
		double rcmh;

		this.tdip[0] = 0.0;
		this.tdip[1] = 0.0;
		this.tdip[2] = 0.0;
		this.tdip[3] = 0.0;

		for (j = 0; j < 3; j++) {
			for (i = 0; i < this.mols; i++) {
				this.rnq[i][0][j] = this.rn[i][j][2] - this.rn[i][j][0];
				this.rnq[i][1][j] = this.rn[i][j][2] - this.rn[i][j][1];

				this.dip[i][j] = this.rnq[i][0][j] + this.rnq[i][1][j];

				this.tdip[j] = this.tdip[j] + this.dip[i][j];
				this.tdip[3] = this.tdip[3] + (this.dip[i][j] * this.dip[i][j]);
			}
		}

		for (j = 0; j < 3; j++) {
			for (i = 0; i < this.mols; i++) {
				/* lc=iv(j) */
				/* mc=jv(j) */
				/* vecn=(rnq(i,1,lc)*rnq(i,2,mc)-rnq(i,1,mc)*rnq(i,2,lc))*em */

				/*
				 * vec = this.dip[i][j]*el;
				 */

				this.rnq[i][3][j] = 0.0;
				this.rnq[i][2][j] = 0.0;

				this.dip[i][j] = this.dip[i][j] / sqrt(this.tdip[3]);
				/** * sqrt ** */

				rcmh = this.wait[0] * this.rn[i][j][0] + this.wait[1] * this.rn[i][j][1]
						+ this.wait[2] * this.rn[i][j][2];

				this.rcm[i][j] = rcmh / waits;
			}
		}
	}

	/*
	 * :::::::::::::: force-ion-ion.c ::::::::::::::
	 */

	/* this routine calculates the forces between the two ions */

	void forceionion() {
		assert ions.getLength()==2;
		int iax, iay, iaz, i, j;
		double shltap, ft2mi3;
		double qii, es;
		double alj6p, alj6f, blj12p, blj12f;
		double xx, yy, zz, abx, aby, abz;
		double r, rinv, r2inv, r4inv, r6inv, difft = 0, diffr = 0;
		double tswit, tswp;
		double fxii, fyii, fzii;
		double qion[] = new double[2];
		double ecoul, ecore, epoli, sigg, epsn;
		double xninew, yninew, zninew, virxii, viryii, virzii;

		this.couii = this.corii = this.potii = this.polii = this.virii = this.hydii = 0.0;
		this.fcii = virxii = viryii = virzii = 0.0;
		fxii = fyii = fzii = 0.0;

		for (i = 0; i < 3; i++)
			/* x - y - z components */
			for (j = 0; j < 2; j++)
				/* two ions */
				this.fii[i][j] = 0.0; /* force between the two ions */

		shltap = 0.005;
		double frang = 1.0 * this.boxhx;
		double frangt = frang - shltap;
		double ft2mi = 2.0 / ((frang - frangt) * (frang - frangt));
		double ft3m = 0.5 * (3.0 * frang - frangt);
		ft2mi3 = (-3.0) * ft2mi;

		es = 1.6022e-19 / 1.0e-20;

		qion[0] = ions.get(0).solch * es;
		qion[1] = ions.get(1).solch * es;

		qii = qion[0] * qion[1] * scfacq;

		/* mix potentials */
		epsn = sqrt(ions.get(0).eps * ions.get(1).eps );
		sigg = (ions.get(0).sig + ions.get(1).sig) / 2.0;

		alj6p = -4.0 * epsn * pow((sigg), 6.0);
		alj6f = 6.0 * alj6p;

		blj12p = 4.0 * epsn * pow((sigg), 12.0);
		blj12f = 12.0 * blj12p;

		xx = (this.xni[0] - this.xni[1]) / this.boxhx;
		yy = (this.yni[0] - this.yni[1]) / this.boxhy;
		zz = (this.zni[0] - this.zni[1]) / this.boxhz;

		iax = (int) xx + (int) xx;
		iay = (int) yy + (int) yy;
		iaz = (int) zz + (int) zz;

		abx = iax * (this.boxhx);
		aby = iay * (this.boxhy);
		abz = iaz * (this.boxhz);

		xninew = this.xni[0] - abx;
		yninew = this.yni[0] - aby;
		zninew = this.zni[0] - abz;

		xx = xninew - this.xni[1];
		yy = yninew - this.yni[1];
		zz = zninew - this.zni[1];

		r = sqrt(xx * xx + yy * yy + zz * zz);
		rinv = 1.0 / r;
		r2inv = rinv * rinv;
		r4inv = r2inv * r2inv;
		r6inv = r4inv * r2inv;

		tswit = 1.0 - difft * difft * (ft3m - r) * ft2mi;
		if (difft < 0.0) tswit = 1.0;
		if (diffr > 0.0) tswit = 0.0;

		tswp = difft * diffr * ft2mi3 * rinv;
		if (difft < 0.0) tswp = 0.0;
		if (diffr > 0.0) tswp = 0.0;

		ecoul = qii * rinv; /* coulomb interaction */
		this.couii = ecoul * tswit;
		this.hydii = ecoul;

		ecore = r6inv * r6inv * blj12p; /* LJ - 12 part */
		this.corii = ecore * tswit;

		epoli = r6inv * alj6p; /* LJ - 6 part */
		this.polii = epoli * tswit;

		/* force between the two ions */

		this.fcii = r2inv * (ecoul + r6inv * (alj6f + blj12f * r6inv)) * tswit
				+ (ecoul + ecore + epoli + this.hydii) * tswp;

		/* directional forces */
		fxii = this.fcii * xx;
		virxii = fxii;
		this.fii[0][0] = virxii;
		this.fii[0][1] = -virxii;

		fyii = this.fcii * yy;
		viryii = fyii;
		this.fii[1][0] = viryii;
		this.fii[1][1] = -viryii;

		fzii = this.fcii * zz;
		virzii = fzii;
		this.fii[2][0] = virzii;
		this.fii[2][1] = -virzii;

		this.virii = -((virxii * xx) + (viryii * yy) + (virzii * zz));

		this.potii = (this.couii + this.corii + this.polii);

		/*
		 * printf("\n potii : %f \n",this.potii); printf("\n r : %f \n",r);
		 */
	}

	/*
	 * :::::::::::::: force-w-i.c ::::::::::::::
	 */

	void forcewi() {
		assert ions!=null;
		
		int iax, iay, iaz, j, i;
		double shltap, ft2mi3;
		double qqhyio, qqoxio, qion[] = new double[2];
		double alj6p, alj6f, blj12p, blj12f, xnjo, ynjo, znjo;
		double xx, yy, zz;
		double abx, aby, abz, xninew, yninew, zninew;
		double r, rinv, difft, diffr;
		double tswit, tswp;
		double fxih1, fyih1, fzih1;
		double fxih2, fyih2, fzih2, xo, yo, zo, r2inv, r4inv, r6inv;
		double ecoul, ecore, epoli, fxiox, fyiox, fziox;
		double virxx, viryy, virzz, es;
		double sigg, epsn;

		double virwix[] = new double[MAX_IONS], virwiy[] = new double[MAX_IONS], virwiz[] = new double[MAX_IONS];

		shltap = 0.005;
		double frang = 1.0 * this.boxhx;
		double frangt = frang - shltap;
		double ft2mi = 2.0 / ((frang - frangt) * (frang - frangt));
		double ft3m = 0.5 * (3.0 * frang - frangt);
		ft2mi3 = (-3.0) * ft2mi;

		for (i = 0; i < ions.getLength(); i++)
			this.fxi[i] = this.fyi[i] = this.fzi[i] = this.fcwi[i] = this.potwi[i] = this.virwi[i] = 0.0;

		for (i = 0; i < 256; i++)
			this.virx[i] = this.viry[i] = this.virz[i] = 0.0;

		this.virialwi = 0.0;

		for (i = 0; i < 256; i++)
			for (j = 0; j < 3; j++)
				this.f[i][j][0] = this.f[i][j][1] = this.f[i][j][2] = 0.0;

		es = 1.6022e-19 / 1.0e-20;

		for (i = 0; i < ions.getLength(); i++) {
			qion[i] = ions.get(i).solch * es;
		}
		for (i = 0; i < ions.getLength(); i++) {

			for (j = 0; j < 256; j++)
				this.virx[j] = this.viry[j] = this.virz[j] = 0.0;

			virwix[i] = virwiy[i] = virwiz[i] = 0.0;

			double couwi=0, corwi=0, polwi=0;

			qqhyio = qion[i] * this.q[1] * scfacq;
			qqoxio = qion[i] * this.q[2] * scfacq;

			/* mix potentials */

			epsn = sqrt(ions.get(i).eps * epsilon);
			sigg = (ions.get(i).sig + sigma) / 2.0;

			alj6p = -4.0 * epsn * pow((sigg), 6.0);
			alj6f = 6.0 * alj6p;

			blj12p = 4.0 * epsn * pow((sigg), 12.0);
			blj12f = 12.0 * blj12p;

			for (j = 0; j < this.mols; j++) {

				xnjo = this.rn[j][0][2];
				ynjo = this.rn[j][1][2];
				znjo = this.rn[j][2][2];

				xx = (this.xni[i] - xnjo) / this.boxhx;
				yy = (this.yni[i] - ynjo) / this.boxhy;
				zz = (this.zni[i] - znjo) / this.boxhz;

				iax = (int) xx + (int) xx;
				iay = (int) yy + (int) yy;
				iaz = (int) zz + (int) zz;

				abx = iax * (this.boxhx);
				aby = iay * (this.boxhy);
				abz = iaz * (this.boxhz);

				xninew = this.xni[i] - abx;
				yninew = this.yni[i] - aby;
				zninew = this.zni[i] - abz;

				this.xion[j] = xninew;
				this.yion[j] = yninew;
				this.zion[j] = zninew;

				xx = xninew - xnjo;
				yy = yninew - ynjo;
				zz = zninew - znjo;

				r = sqrt(xx * xx + yy * yy + zz * zz);
				rinv = 1.0 / r;

				difft = r - frangt;
				diffr = r - frang;

				tswit = 1.0 - difft * difft * (ft3m - r) * ft2mi;
				if (difft < 0.0) tswit = 1.0;
				if (diffr > 0.0) tswit = 0.0;

				this.ttswit[j] = tswit;

				tswp = difft * diffr * ft2mi3 * rinv;
				if (difft < 0.0) tswp = 0.0;
				if (diffr > 0.0) tswp = 0.0;

				this.ttswp[j] = tswp;

			}

			for (j = 0; j < this.mols; j++) {

				this.fcwi[i] = 0.0;

				xx = this.xion[j] - this.rn[j][0][0];
				yy = this.yion[j] - this.rn[j][1][0];
				zz = this.zion[j] - this.rn[j][2][0];

				r = sqrt(xx * xx + yy * yy + zz * zz);

				rinv = 1.0 / r;
				r2inv = rinv * rinv;

				ecoul = qqhyio * rinv;
				tswit = this.ttswit[j];
				couwi = couwi + ecoul * tswit;

				this.fcwi[i] = ecoul * r2inv * tswit;
				this.hyderg[j] = ecoul;

				fxih1 = this.fcwi[i] * xx;
				this.virx[j] += fxih1;
				this.f[j][0][0] -= fxih1;

				fyih1 = this.fcwi[i] * yy;
				this.viry[j] += fyih1;
				this.f[j][1][0] -= fyih1;

				fzih1 = this.fcwi[i] * zz;
				this.virz[j] += fzih1;
				this.f[j][2][0] -= fzih1;
			}

			for (j = 0; j < this.mols; j++) {
				this.fcwi[i] = 0.0;

				xx = this.xion[j] - this.rn[j][0][1];
				yy = this.yion[j] - this.rn[j][1][1];
				zz = this.zion[j] - this.rn[j][2][1];

				r = sqrt(xx * xx + yy * yy + zz * zz);
				rinv = 1.0 / r;
				r2inv = rinv * rinv;

				ecoul = qqhyio * rinv;
				tswit = this.ttswit[j];
				couwi = couwi + ecoul * tswit;

				this.fcwi[i] = ecoul * r2inv * tswit;
				this.hyderg[j] += ecoul;

				fxih2 = this.fcwi[i] * xx;
				this.virx[j] += fxih2;
				this.f[j][0][1] -= fxih2;

				fyih2 = this.fcwi[i] * yy;
				this.viry[j] += fyih2;
				this.f[j][1][1] -= fyih2;

				fzih2 = this.fcwi[i] * zz;
				this.virz[j] += fzih2;
				this.f[j][2][1] -= fzih2;
			}

			for (j = 0; j < this.mols; j++) {
				this.fcwi[i] = 0.0;

				xo = this.rn[j][0][2];
				yo = this.rn[j][1][2];
				zo = this.rn[j][2][2];

				xx = this.xion[j] - xo;
				yy = this.yion[j] - yo;
				zz = this.zion[j] - zo;

				r = sqrt(xx * xx + yy * yy + zz * zz);
				rinv = 1.0 / r;
				r2inv = rinv * rinv;

				ecoul = qqoxio * rinv;
				tswit = this.ttswit[j];
				couwi = couwi + ecoul * tswit;
				this.hyderg[j] += ecoul;

				r4inv = r2inv * r2inv;
				r6inv = r4inv * r2inv;

				ecore = r6inv * r6inv * blj12p;
				corwi = corwi + ecore * tswit;
				epoli = r6inv * alj6p;
				polwi = polwi + epoli * tswit;

				this.fcwi[i] = r2inv * (ecoul + r6inv * (alj6f + blj12f * r6inv)) * tswit
						+ (ecoul + ecore + epoli + this.hyderg[j]) * this.ttswp[j];

				fxiox = this.fcwi[i] * xx;
				virxx = this.virx[j] + fxiox;
				this.fxi[i] += virxx;
				this.f[j][0][2] -= fxiox;

				fyiox = this.fcwi[i] * yy;
				viryy = this.viry[j] + fyiox;
				this.fyi[i] += viryy;
				this.f[j][1][2] -= fyiox;

				fziox = this.fcwi[i] * zz;
				virzz = this.virz[j] + fziox;
				this.fzi[i] += virzz;
				this.f[j][2][2] -= fziox;

				virwix[i] += (this.xion[j] - this.rcm[j][0]) * virxx;
				virwiy[i] += (this.yion[j] - this.rcm[j][1]) * viryy;
				virwiz[i] += (this.zion[j] - this.rcm[j][2]) * virzz;

			}

			this.potwi[i] = (couwi + corwi + polwi);

			this.virwi[i] = -(virwix[i] + virwiy[i] + virwiz[i]);

		}
		if (ions.getLength() > 1) this.virialwi = this.virwi[0] + this.virwi[1];
		else this.virialwi = this.virwi[0];

	}

	/*
	 * :::::::::::::: forces.c ::::::::::::::
	 */

	// array delerations moved to final blocks for performace 10/8AB
	private final double fqARRAY[][][] = new double[256][3][4],
			foARRAY[][] = new double[256][3];

	// shift apears to only need boolean values!! 10/8AB
	private final byte shiftARRAY[][] = new byte[256][256];

	void forces() {
		double rij[] = new double[3], bbr[] = new double[3], virr[] = new double[3], ccel[] = new double[3];
		final double fq[][][] = fqARRAY, fo[][] = foARRAY;
		double fij[][][] = new double[4][4][3], rnqi[][] = new double[4][3], rnqj[][] = new double[4][3];
		int mfirst, i, j, k, m, jm, ku, mu, n, kl;
		double ro, rq;
		double swp, ele4, elepo, elefo, swi, rb;
		double rhijx, rhijy, rhijz, rsq, rsq3, ccel1;
		double tsn, potdm, ccel3;
		double rh1joiv, rojh1iv, rojh2iv, rh2joiv, rmin;
		double rh1joi[] = new double[3], rh2joi[] = new double[3], rojh1i[] = new double[3], rojh2i[] = new double[3];
		final byte shift[][] = shiftARRAY;

		this.hbonds = 0;

		mfirst = 0;
		this.elepot = this.epoten = 0.0;
		this.virial = 0.0;
		if (ions==null||ions.getLength()==0) {
			for (i = 0; i < 256; i++)
				for (j = 0; j < 3; j++)
					this.f[i][j][0] = this.f[i][j][1] = this.f[i][j][2] = 0.0;
		}
		for (i = 0; i < this.mols; i++)
			this.potH2O[i] = 0;
		// notice shift only needs to be molsxmols and is initialized 10/8AB
		for (i = 0; i < this.mols; i++)
			for (j = 0; j < this.mols; j++)
				shift[i][j] = 2;
		// ""
		for (i = 0; i < 256; i++)
			for (j = 0; j < 3; j++)
				fq[i][j][0] = fq[i][j][1] = fq[i][j][2] = fo[i][j] = 0.0;

		for (i = 0; i < this.mols - 1; i++) {
			if (mfirst <= this.last[i]) {
				for (m = 0; m < 3; m++) {
					rnqi[m][0] = this.rnq[i][m][0];
					rnqi[m][1] = this.rnq[i][m][1];
					rnqi[m][2] = this.rnq[i][m][2];
				}

				for (jm = mfirst; jm < (this.last[i] + 1); jm++) {
					j = this.list[jm];

					rij[0] = this.rn[i][0][2] - this.rn[j][0][2];
					rij[1] = this.rn[i][1][2] - this.rn[j][1][2];
					rij[2] = this.rn[i][2][2] - this.rn[j][2][2];

					bbr[0] = this.bx * ((int) (rij[0] / this.boxhx));
					bbr[1] = this.by * ((int) (rij[1] / this.boxhy));
					bbr[2] = this.bz * ((int) (rij[2] / this.boxhz));

					/* if molecule has been shifted, then don't draw h-bond !! */

					if ((bbr[0] == 0.0) && (bbr[1] == 0.0) && (bbr[2] == 0.0)) shift[i][j] = 1;

					else if ((bbr[0] != 0.0) || (bbr[1] != 0.0) || (bbr[2] != 0.0))

					rij[0] -= bbr[0];
					rij[1] -= bbr[1];
					rij[2] -= bbr[2];

					ro = rij[0] * rij[0] + rij[1] * rij[1] + rij[2] * rij[2];

					rq = 1.0 / ro;

					if (ro < this.rangeq) {
						swp = ele4 = elepo = elefo = virr[0] = virr[1] = virr[2] = 0.0;
						swi = 1.0;

						rb = sqrt(ro);
						/** * square root ** */

						if ((ro > this.rantq) && (ro < this.rangeq)) {
							swi = 1.0 - (s(rb, this.rant, this.tr3, this.tr2));
							swp = -(t(rb, this.rant, this.range, this.tr2));
						}

						for (m = 0; m < 3; m++) {
							rnqj[m][0] = this.rnq[j][m][0] + rij[0];
							rnqj[m][1] = this.rnq[j][m][1] + rij[1];
							rnqj[m][2] = this.rnq[j][m][2] + rij[2];
						}

						for (ku = 0; ku < 3; ku++) {
							for (mu = 0; mu < 3; mu++) {
								rhijx = rnqj[mu][0] - rnqi[ku][0];
								rhijy = rnqj[mu][1] - rnqi[ku][1];
								rhijz = rnqj[mu][2] - rnqi[ku][2];

								rsq = rhijx * rhijx + rhijy * rhijy + rhijz * rhijz;

								rsq3 = sqrt(1.0 / (rsq * rsq * rsq));

								ccel1 = this.qij[mu][ku] * (rsq3 - this.range3) * swi;
								ele4 = ele4 + this.qij[mu][ku] * (rsq3 + this.rang3h)
										* rsq;

								fij[mu][ku][0] = ccel1 * rhijx;
								fij[mu][ku][1] = ccel1 * rhijy;
								fij[mu][ku][2] = ccel1 * rhijz;
							}
						}
						/*
						 * calculation of the distances for the hydrogen-bonds,
						 * this can be included into the upper routine. however
						 * for the sake of testing it was inserted here
						 */
						for (kl = 0; kl < 3; kl++) {
							rh1joi[kl] = rnqj[0][kl] - rnqi[2][kl];
							rh2joi[kl] = rnqj[1][kl] - rnqi[2][kl];
							rojh1i[kl] = rnqj[2][kl] - rnqi[0][kl];
							rojh2i[kl] = rnqj[2][kl] - rnqi[1][kl];
						}

						/* distance-vektor */

						rh1joiv = sqrt(rh1joi[0] * rh1joi[0] + rh1joi[1] * rh1joi[1]
								+ rh1joi[2] * rh1joi[2]);
						rh2joiv = sqrt(rh2joi[0] * rh2joi[0] + rh2joi[1] * rh2joi[1]
								+ rh2joi[2] * rh2joi[2]);
						rojh1iv = sqrt(rojh1i[0] * rojh1i[0] + rojh1i[1] * rojh1i[1]
								+ rojh1i[2] * rojh1i[2]);
						rojh2iv = sqrt(rojh2i[0] * rojh2i[0] + rojh2i[1] * rojh2i[1]
								+ rojh2i[2] * rojh2i[2]);

						for (k = 0; k < 3; k++) {
							virr[0] += (fij[0][k][0] + fij[1][k][0] + fij[2][k][0]);
							virr[1] += (fij[0][k][1] + fij[1][k][1] + fij[2][k][1]);
							virr[2] += (fij[0][k][2] + fij[1][k][2] + fij[2][k][2]);

							fq[i][0][k] += (fij[0][k][0] + fij[1][k][0] + fij[2][k][0]);
							fq[i][1][k] += (fij[0][k][1] + fij[1][k][1] + fij[2][k][1]);
							fq[i][2][k] += (fij[0][k][2] + fij[1][k][2] + fij[2][k][2]);

							fq[j][0][k] -= (fij[k][0][0] + fij[k][1][0] + fij[k][2][0]);
							fq[j][1][k] -= (fij[k][0][1] + fij[k][1][1] + fij[k][2][1]);
							fq[j][2][k] -= (fij[k][0][2] + fij[k][1][2] + fij[k][2][2]);

						}
						elefo = swp * ele4;
						elepo = swi * ele4;
						this.elepot += elepo;

						tsn = rq * rq * rq;
						potdm = tsn * (this.conrep * tsn - this.conatp) + elepo;
						ccel3 = rq * tsn * (this.conref * tsn - this.conatf) - elefo;
						this.epoten += potdm;
						this.potH2O[i] += potdm * 0.5; /* Amit!!! new */
						this.potH2O[j] += potdm * 0.5; /* Amit!!! new */
						/*
						 * energy-check for hydrogen-bond, if potdm less than
						 * epbridge, then draw the bond this.epbridge is - set
						 * to -12kJ/mol for now
						 */
						this.epbridge = -12.0;
						if (potdm <= this.epbridge) {
							if (shift[i][j] == 1) // Amit!!! new REMOVED TO
							// INCLUDE PERIODIC H-BONDS
							{
								rmin = min(rojh1iv, rojh2iv);
								rmin = min(rmin, rh1joiv);
								rmin = min(rmin, rh2joiv);

								if ((rojh1iv - rmin) <= 1e-6) {
									this.indxww[this.hbonds][0] = j;
									this.indxww[this.hbonds][1] = i;
									this.indxww[this.hbonds][2] = 0;
								}

								else if ((rojh2iv - rmin) <= 1e-6) {
									this.indxww[this.hbonds][0] = j;
									this.indxww[this.hbonds][1] = i;
									this.indxww[this.hbonds][2] = 1;
								}

								else if ((rh1joiv - rmin) <= 1e-6) {
									this.indxww[this.hbonds][0] = i;
									this.indxww[this.hbonds][1] = j;
									this.indxww[this.hbonds][2] = 0;
								}

								else if ((rh2joiv - rmin) <= 1e-6) {
									this.indxww[this.hbonds][0] = i;
									this.indxww[this.hbonds][1] = j;
									this.indxww[this.hbonds][2] = 1;
								}

								this.hbonds++;

							}
						}

						ccel[0] = ccel3 * rij[0];
						ccel[1] = ccel3 * rij[1];
						ccel[2] = ccel3 * rij[2];

						fo[i][0] += ccel[0];
						fo[i][1] += ccel[1];
						fo[i][2] += ccel[2];

						fo[j][0] -= ccel[0];
						fo[j][1] -= ccel[1];
						fo[j][2] -= ccel[2];

						virr[0] = (virr[0] + ccel[0])
								* (this.rcm[i][0] - this.rcm[j][0] - bbr[0]);
						virr[1] = (virr[1] + ccel[1])
								* (this.rcm[i][1] - this.rcm[j][1] - bbr[1]);
						virr[2] = (virr[2] + ccel[2])
								* (this.rcm[i][2] - this.rcm[j][2] - bbr[2]);

						this.virial -= (virr[0] + virr[1] + virr[2]);

						n = (int) (deltr * sqrt(ro) + 0.5) + 1;
						/** * square root ** */

						if ((n <= this.ngmax) || (n > 0)) {
							(this.ng[n])++;
							this.gn[n] += (this.facgvr * rq);
							this.gpt[n] += potdm;
							this.gkr[n] += (this.dip[i][0] * this.dip[j][0]
									+ this.dip[i][1] * this.dip[j][1] + this.dip[i][2]
									* this.dip[j][2]);
						}
					}
				}
				mfirst = this.last[i] + 1;
			}
		}

		/*
		 * ***** uebertragen der ladungskraefte auf die masseteilchen ******
		 */

		for (i = 0; i < this.mols; i++) {
			for (j = 0; j < 3; j++) {

				this.f[i][j][0] += (fq[i][j][0]);
				this.f[i][j][1] += (fq[i][j][1]);
				this.f[i][j][2] += (fq[i][j][2] + fo[i][j]);

			}
		}

		/* pressure scaling include the force of ion when solute=true */

		/* for testing purposes */
		this.virialww = this.virial;

		if (ions!=null&&ions.getLength()>0) this.virial = this.virialww + this.virialwi + this.virii;

	}
	

    /*::::::::::::::
    frogi-ions.c
    ::::::::::::::*/


    //extern double vscale();

    /* moves the two ions */

    void frogiions()
    {
        int nperx,npery,nperz,i;
        double anperx,anpery,anperz;
        double alfai=0;
        /*
        leapfrog for velocities :   V(N+1/2)=V(N-1/2)+DELTA/M * F(N)
        simultanious temperature-scaling ?
        waition : weight of ion (is variable depending on charge)
         */


        if(this.ktemp)
        alfai = vscale();


        for(i=0;i<2;i++)
        {

            /* summing up the forces     fxa[i] : water-ion ; fii[0][i] : ion-ion  */
            this.fxa[i]=this.fii[0][i]+this.fxi[i];
            this.fya[i]=this.fii[1][i]+this.fyi[i];
            this.fza[i]=this.fii[2][i]+this.fzi[i];

            this.vxi[i] +=(this.fxa[i]*this.delta/ions.get(i).wait)*alfai;
            this.vyi[i] +=(this.fya[i]*this.delta/ions.get(i).wait)*alfai;
            this.vzi[i] +=(this.fza[i]*this.delta/ions.get(i).wait)*alfai;

            this.xni[i] +=(this.vxi[i]*this.delta);
            this.yni[i] +=(this.vyi[i]*this.delta);
            this.zni[i] +=(this.vzi[i]*this.delta);

            this.dfxi[i] +=this.vxi[i];
            this.dfyi[i] +=this.vyi[i];
            this.dfzi[i] +=this.vzi[i];


            /* apply boundary conditions */
            nperx = (int)(fabs(this.xni[i]/this.boxhx));
            anperx = sign2((nperx*this.bx),this.xni[i]);
            this.xni[i] -= anperx;

            npery = (int)(fabs(this.yni[i]/this.boxhy));
            anpery = sign2((npery*this.by),this.yni[i]);
            this.yni[i] -= anpery;

            nperz = (int)(fabs(this.zni[i]/this.boxhz));
            anperz = sign2((nperz*this.bz),this.zni[i]);
            this.zni[i] -= anperz;

            this.eki[i]=0.0;

            this.eki[i]=0.5*ions.get(i).wait*(this.vxi[i]*this.vxi[i]+this.vyi[i]*this.vyi[i]+this.vzi[i]*this.vzi[i]);

            this.tempi[i]=0.0;
            this.tempi[i]=this.eki[i]/boltk;
        }
    }



    /*::::::::::::::
    support.c
    :::::::::::::: */


    double vscale()
    {
        int i,j,k;
        double temp;

        temp = 0.0;

        for(i=0;i<this.mols;i++)
        {
            for(k=0;k<3;k++)
            {
                for(j=0;j<3;j++)
                temp = temp+this.faceki[k]*this.ve[i][j][k]*this.ve[i][j][k];
            }
        }

        temp *= this.factmp[1];

        return(sqrt(1.0+this.delta*(this.atemp/temp-1.0)/this.taut));

    }

    void shakew(int i)throws ShakeFailException
    {
        boolean ready;
        int iter;
        double xd,yd,zd,diff,xx,yy,zz,rrpr,acor;
        double xcrt,ycrt,zcrt;

        iter = 0;
        ready = FALSE;

        while(iter < 100)
        {
            if (ready)
            return;

            ready = TRUE;

            xd = this.rp[0]-this.rp[3];
            yd = this.rp[1]-this.rp[4];
            zd = this.rp[2]-this.rp[5];

            diff = this.c-xd*xd-yd*yd-zd*zd;

            if (fabs(diff) >= this.tolc)
            {
                xx = this.r[0]-this.r[3];
                yy = this.r[1]-this.r[4];
                zz = this.r[2]-this.r[5];

                rrpr = xx*xd+yy*yd+zz*zd;

                if (rrpr < this.fepa)
                {
                    printf("\n Molecule # %d: coordinate resetting (shakew) not\naccomplished, deviat. too large",i);
                    exit(0);
                }


                acor = this.weight*diff/rrpr;

                xcrt = acor*xx;
                ycrt = acor*yy;
                zcrt = acor*zz;

                this.rp[0] += xcrt;
                this.rp[1] += ycrt;
                this.rp[2] += zcrt;
                this.rp[3] -= xcrt;
                this.rp[4] -= ycrt;
                this.rp[5] -= zcrt;

                ready = FALSE;
            }

            xd = this.rp[0]-this.rp[6];
            yd = this.rp[1]-this.rp[7];
            zd = this.rp[2]-this.rp[8];

            diff = this.b-xd*xd-yd*yd-zd*zd;

            if(fabs(diff) >= this.tolb)
            {
                xx=this.r[0]-this.r[6];
                yy=this.r[1]-this.r[7];
                zz=this.r[2]-this.r[8];

                rrpr=xx*xd+yy*yd+zz*zd;

                if (rrpr < this.fepa)
                {
                    printf("\n Molecule # %d: coordinate resetting (shakew) not\naccomplished, deviat. too large",i);
                    exit(0);
                }

                acor = diff/rrpr;

                xcrt=acor*xx;
                ycrt=acor*yy;
                zcrt=acor*zz;

                this.rp[0] += (xcrt*this.winvh);
                this.rp[1] += (ycrt*this.winvh);
                this.rp[2] += (zcrt*this.winvh);
                this.rp[6] -= (xcrt*this.winvo);
                this.rp[7] -= (ycrt*this.winvo);
                this.rp[8] -= (zcrt*this.winvo);

                ready = FALSE;
            }

            xd=this.rp[3]-this.rp[6];
            yd=this.rp[4]-this.rp[7];
            zd=this.rp[5]-this.rp[8];

            diff=this.b-xd*xd-yd*yd-zd*zd;

            if(fabs(diff) >= this.tolb)
            {
                xx = this.r[3]-this.r[6];
                yy = this.r[4]-this.r[7];
                zz = this.r[5]-this.r[8];

                rrpr=xx*xd+yy*yd+zz*zd;

                if (rrpr < this.fepa)
                {
                    printf("\n Molecule # %d: coordinate resetting (shakew) not\naccomplished, deviat. too large",i);
                    exit(0);
                }

                acor=diff/rrpr;

                xcrt = acor*xx;
                ycrt = acor*yy;
                zcrt = acor*zz;

                this.rp[3] += (xcrt*this.winvh);
                this.rp[4] += (ycrt*this.winvh);
                this.rp[5] += (zcrt*this.winvh);
                this.rp[6] -= (xcrt*this.winvo);
                this.rp[7] -= (ycrt*this.winvo);
                this.rp[8] -= (zcrt*this.winvo);

                ready = FALSE;
            }
            iter++;
        }

        printf("\n Molecule # %d, shake not accomplished - 100 iterations.\n",i);
        exit(0);
    }

    void herman()throws ShakeFailException
    {
        int i,j,k,ii;

        for(i=0;i<this.mols;i++)
        {
            for(k=0;k<3;k++)
            {
                for(j=0;j<3;j++)
                {
                    ii = 3*k+j;
                    this.r[ii] = this.rm[i][j][k];
                    this.rp[ii] = this.rn[i][j][k];
                }
            }

            shakew(i);

            for(k=0;k<3;k++)
            {
                for(j=0;j<3;j++)
                {
                    ii = 3*k+j;
                    this.rn[i][j][k] = (float)this.rp[ii];
                }
            }
        }
    }

    void dscale()
    {
        double beta,roh1,roh2;
        int i,j;


        beta=pow((1.0-this.comp*this.delta*(this.apres-this.pres)/this.taup),(1.0/3.0));

        this.bx *= beta;
        this.by *= beta;
        this.bz *= beta;
        this.boxhx = 0.5*this.bx;
        this.boxhy = 0.5*this.by;
        this.boxhz = 0.5*this.bz;
        this.wwx = 2.0*pi/this.bx;
        this.wwy = 2.0*pi/this.by;
        this.wwz = 2.0*pi/this.bz;

        this.volume = this.bx*this.by*this.bz;
        this.facgvr = deltr*this.volume/(2.0*pi*this.fmols*this.fmols);
        this.facpot =
        8.0*pi*this.range3*epsilon*this.fmols*pow(sigma,6.0)/(3.0*this.volume);

        /*
        sligtly modified from geiger - cm assumed as ox
         */

        for(i=0;i<this.mols;i++)
        {
            for(j=0;j<3;j++)
            {
                roh1 = this.rn[i][j][0]-this.rn[i][j][2];
                roh2 = this.rn[i][j][1]-this.rn[i][j][2];
                this.rn[i][j][2] *= (float)beta;
                this.rn[i][j][1] = this.rn[i][j][2]+(float)roh2;
                this.rn[i][j][0] = this.rn[i][j][2]+(float)roh1;
            }
        }
    }

    void values()
    {
        double flprot,fnacc,epotqp,ekinqp,tempqp;
        double viriqp,presqp,workqp,egesqp,rhoqp;
        double freeh;

        flprot = this.lprot;
        fnacc = this.nacc;

        /*
         ************ berechnung der potentiellen energie *****************
         */

        this.epot = this.epoten/this.fmols-this.facrf-this.facpot;

        this.epota += this.epot;
        this.epotra += this.epot;
        this.epotqa += (this.epot*this.epot);

        this.epotp = this.epota/fnacc;
        this.epotrp = this.epotra/flprot;
        epotqp = this.epotqa/fnacc;
        this.epotf = sqrt(fabs(epotqp-(this.epotp*this.epotp)));

        /*
         **** berechnung der kinetischen energie des molekuels ************
         */

        this.ekin =
        this.faceki[0]*this.parke[0]+this.faceki[1]*this.parke[1]+this.faceki[2]*this.parke[2];

        this.ekina += this.ekin;
        this.ekinra += this.ekin;
        this.ekinqa += (this.ekin*this.ekin);

        this.ekinp = this.ekina/fnacc;
        this.ekinrp = this.ekinra/flprot;
        ekinqp = this.ekinqa/fnacc;
        this.ekinf = sqrt(fabs(ekinqp-(this.ekinp*this.ekinp)));

        /*
         **** berechnung der rotations -und translationstempratur *********
         */

        this.ekcm = this.faceki[3]*this.parke[3];

        this.ekcma += this.ekcm;
        this.ekcmp = this.ekcma/fnacc;

        this.trot = this.factmp[0]*(this.ekin-this.ekcm);

        this.trota += this.trot;
        this.trotp = this.trota/fnacc;

        this.tcma = this.factmp[0]*this.ekcm;

        this.tcmaa += this.tcma;
        this.tcmap = this.tcmaa/fnacc;

        /*
         ***************** berechnung der tempratur ***********************
         */

        this.temp = this.factmp[1]*this.ekin;

        /* average temperature ; timesteps=10 */
        this.it++;
        this.tempsum += this.temp;
        this.epotsum += this.epot;
        if(this.it == 10)
        {
            this.tempav=this.tempsum/10.0;
            this.epotav=this.epotsum/10.0;
            this.it=0;
            this.tempsum=0.0;
            this.epotsum=0.0;
        }
        else if(this.it < 0 || this.it > 10 )
        {
            this.it=0;
            this.tempsum=0.0;
            this.epotsum=0.0;
        }

        this.tempa += this.temp;
        this.tempra += this.temp;
        this.tempqa += (this.temp*this.temp);

        this.tempp = this.tempa/fnacc;
        this.temprp = this.tempra/flprot;
        tempqp = this.tempqa/fnacc;
        this.tempf = sqrt(fabs(tempqp-(this.tempp*this.tempp)));

        /*
         ******************** berechnung des virials **********************
         */

        this.viri = this.facvir*this.virial-2.0*this.facpot;

        this.viria += this.viri;
        this.virira += this.viri;
        this.viriqa += (this.viri*this.viri);

        this.virip = this.viria/fnacc;
        this.virirp = this.virira/flprot;
        viriqp = this.viriqa/fnacc;
        this.virif = sqrt(fabs(viriqp-(this.virip*this.virip)));

        /*
         *********************** berechnung des drucks ********************
         */
        this.pres = this.facpre*(this.ekcm-this.viri)/this.volume;

        /* average pressure ; timesteps=50 */
        this.ik++;
        this.pressum += this.pres;
        if(this.ik == 50)
        {
            this.presav=this.pressum/50.0;

            /*
            printf("\n presav : %f \n",this.presav);
            printf("\n tempav : %f \n",this.tempav);
            printf("\n epotav : %f \n",this.epotav);
            printf("\n epot : %f \n",this.epot);
            printf("\n rii : %f \n",this.rii);
            printf("\n potwi[0] : %f potwi[1] : %f potii : %f
            \n",this.potwi[0],this.potwi[1],this.potii);
            printf("\n virial : %f gesamt_virial : %f \n",this.virialww,this.virial);
            printf("\n virwi[0] : %f virwi[1] : %f virii : %f
            \n",this.virwi[0],this.virwi[1],this.virii);
             */


            this.ik=0;
            this.pressum=0.0;
        }
        else if(this.ik < 0 || this.ik > 50)
        {
            this.ik=0;
            this.pressum=0.0;
        }

        this.presa += this.pres;
        this.presra += this.pres;
        this.presqa += (this.pres*this.pres);

        this.presp = this.presa/fnacc;
        this.presrp = this.presra/flprot;
        presqp = this.presqa/fnacc;
        this.presf = sqrt(fabs(presqp-(this.presp*this.presp)));

        /*
         ****************** berechnung der volumenarbeit ******************
         */

        this.work = this.facwor*this.apres*this.volume;
        this.worka += this.work;
        this.workra += this.work;
        this.workqa += (this.work*this.work);

        this.workp = this.worka/fnacc;
        this.workrp = this.workra/flprot;
        workqp = this.workqa/fnacc;
        this.workf = sqrt(fabs(workqp-(this.workp*this.workp)));

        /*
         ********** berechnung der gesamtenergie des molekuels ************
         */

        this.eges = this.ekin+this.epot;

        if (this.kpres)
        this.eges = this.ekin+this.epot+this.work;

        this.egesa += this.eges;
        this.egesra += this.eges;
        this.egesqa += (this.eges*this.eges);

        this.egesp = this.egesa/fnacc;
        this.egesrp = this.egesra/flprot;
        egesqp = this.egesqa/fnacc;
        this.egesf = sqrt(fabs(egesqp-(this.egesp*this.egesp)));

        /*
         *********************** berechnung der dichte ********************
         */

        this.rho = this.facden/this.volume;

        this.rhoa += this.rho;
        this.rhora += this.rho;
        this.rhoqa += (this.rho*this.rho);

        this.rhop = this.rhoa/fnacc;
        this.rhorp = this.rhora/flprot;
        rhoqp = this.rhoqa/fnacc;
        this.rhof =sqrt(fabs(rhoqp-(this.rhop*this.rhop)));

        /*
         ******************* berechnung der freien energie ****************
         */

        this.free = this.eges;

        if(this.temp == 0)         /*** TAKE THIS OUT ??? ***/
        {
            printf("\n ATTENTION: t = 0 K\n");
            /* print *,' attention t=0 k' */
            /*      t=1.0; */
        }

        freeh = this.free/(boltk*this.temp);

        if (fabs(freeh) > 170.0)
        freeh = sign2(170.0,freeh);

        this.freea += Math.exp(-freeh);
        this.freep = -boltk*this.tempp*Math.log(this.freea/fnacc);

        /*
         ********** berechnung des elektrischen potentials ****************
         */

        this.elec = this.elepot/this.fmols-this.facrf;

        this.eleca += this.elec;
        this.elecp = this.eleca/fnacc;


        this.tdpq=((this.tdip[0]*this.tdip[0])+(this.tdip[1]*this.tdip[1])+(this.tdip[2]*this.tdip[2]))/this.tdip[3];

        this.tdpqa += this.tdpq;
        this.tdpqp = this.tdpqa/fnacc;

        this.qdip = this.tdip[3]*this.qij[2][2]/this.fmols;

        /*
         ********************** druckkontrolle ****************************
         */

        if (this.kpres)
        dscale();

        if((this.nacc%this.lcrtl) == 0)
        {
            if((fabs(this.dtem) >= fabs(this.etemp-this.atemp)) && (this.ldtem !=
            0))
            this.ldtem=0;
            if((fabs(this.dpre) >= fabs(this.epres-this.apres)) && (this.ldpre !=
            0))
            this.ldpre=0;

            if(this.ktemp && (this.ldtem != 0))
            this.atemp += this.dtem;

            if(this.kpres && (this.ldpre != 0))
            this.apres += this.dpre;

            if(this.ktemp && (this.ldtem == 0))
            this.atemp=this.etemp;

            if(this.kpres && (this.ldpre == 0))
            this.apres=this.epres;
        }
        if((this.nacc%this.lprot) != 0)
        return;


        this.presra=this.virira=this.tempra=this.epotra=this.ekinra=this.egesra=this.rhora=this.workra=0.0;
    }

    void structure()
    {
        int i,j,k;
        double qcc,qss,arg,dif;


        for(k=0;k<65;k++)
        {
            qcc=qss=0.0;
            for(i=0;i<this.mols;i++)
            {
                arg =
                this.rn[i][0][2]*(double)(this.kx[k])*this.wwx+this.rn[i][1][2]*(double)(this.ky[k])*this.wwy+this.rn[i][2][2]*(double)(this.kz[k])*this.wwz;
                qcc += cos(arg);
                qss += sin(arg);
            }
            this.qc[k] = qcc;
            this.qs[k] = qss;
        }

        for(i=0;i<9;i++)
        this.sq[i]=0.0;

        for(k=0;k<65;k++)
        {
            j = this.kk[k];
            this.sq[j] =
            this.sq[j]+((this.qc[k]*this.qc[k]+this.qs[k]*this.qs[k])/
            ((this.molpz[j]*(this.mols+1))));
        }

        for(i=0;i<9;i++)
        {
            this.sqa[i] += this.sq[i];
            this.sqp[i] = this.sqa[i]/this.nacc;
        }

        /*
         ********************* quadratic displacement *********************
         */

        this.dqm=0.0;

        for(j=0;j<this.mols;j++)
        {
            i=0;
            dif = fabs(this.rn[j][i][2]-this.rstart[j][i]);
            if(dif > this.boxhx)
            dif -= this.bx;

            this.dqm += (dif*dif);

            i=1;
            dif = fabs(this.rn[j][i][2]-this.rstart[j][i]);
            if(dif > this.boxhy)
            dif -= this.by;

            this.dqm += (dif*dif);

            i=2;
            dif = fabs(this.rn[j][i][2]-this.rstart[j][i]);
            if(dif > this.boxhz)
            dif -= this.bz;

            this.dqm += (dif*dif);
        }

        this.dqm /= this.fmols;

    }

    void drift()
    {
        double p[]=new double[3];
        int l,j,k,i;


        p[0]=p[1]=p[2]=0.0;

        for(k=0;k<this.mols;k++)
        {
            for(j=0;j<3;j++)
            {
                for(l=0;l<3;l++)
                p[l] += (this.wait[j]*this.ve[k][l][j]);
            }
        }

        for(i=0;i<3;i++)
        p[i]=p[i]/(this.mols)/waits;

        for(k=0;k<this.mols;k++)
        {
            for(j=0;j<3;j++)
            {
                for(l=0;l<3;l++)
                this.ve[k][l][j] -= p[l];

            }
        }
    }

    /*::::::::::::::
    denschange.c
    ::::::::::::::*/

    /*
    if the density is changed during the simulation, the size of the
    box (volume,bx,by and bz) has to be rescaled.
    for NVT-ensemble simulation, no (!!) pressure scaling for the time being
     */

    void denschange()
    {
        double edrit,vfat,bmin;
        int i;

        double nmax;

        this.nfi = 0;

        /*
        this.rhonew /= 100.0;

        printf("\n rhonew : %f \n",this.rhonew);
         */

        if(this.rhonew < 0.01)
        this.rhonew = 0.01;
        if(this.rhonew > 1.0)
        this.rhonew = 1.0;

        /* rhonew : desired density */

        for(i=0;i<MAX_IONS;i++)
        {
            this.vxi[i] = 0.0;
            this.vyi[i] = 0.0;
            this.vzi[i] = 0.0;
        }

        edrit=1.0/3.0;

        this.volume = waits*this.mols/(this.rho*avogadro);

        vfat=pow((this.volume/this.bx/this.by/this.bz),edrit);  /*** <<<----
        check this !!!! ***/

        this.bx *= vfat;this.by *= vfat;this.bz *= vfat;

        this.boxhx = this.bx /2.0;
        this.boxhy = this.by /2.0;
        this.boxhz = this.bz /2.0;


        /* initial part */

        this.lrsta = this.ldisk*this.ltape;

        this.fmols = this.mols;

        this.nzahl = (int) ((double)this.nzahl/(double)this.lrsta+0.5)*this.lrsta;

        if (this.nzahl == 0)
        this.nzahl = this.lrsta;
        if (this.lcrtl == 0)
        this.lcrtl = 1;

        this.em = el*sqrt(drei)/roh;            /* square root */

        this.conrep = 4.0*epsilon*pow(sigma,12.0);
        this.conatp = 4.0*epsilon*pow(sigma,6.0);
        this.conref = 12.0*this.conrep;
        this.conatf = 6.0*this.conatp;

        bmin = min(this.bx,95000.0);
        bmin = min(this.by,bmin);
        bmin = min(this.bz,bmin);

        bmin /= 2.0;
        this.range = 2.50*sigma+0.005;

        if (this.range > bmin)
        this.range = bmin;

        this.rant  = 0.95*this.range;
        this.rang2 = 1.10*this.range;
        this.range3 = 1.00/(this.range*this.range*this.range);
        this.rang3h = 0.50*this.range3;

        this.wwx = 2.00*pi/this.bx;
        this.wwy = 2.00*pi/this.by;
        this.wwz = 2.00*pi/this.bz;

        this.permit = 0.25*(this.rang2-this.range)*(this.rang2-this.range);

        this.rtwoq = rtwo*rtwo;
        this.roneq = rone*rone;
        this.rantq = this.rant*this.rant;
        this.rangeq = this.range*this.range;
        this.rang2q = this.rang2*this.rang2;

        this.volume = this.bx*this.by*this.bz;

        this.r2mr = 0.5*(rtwo-rone)*(rtwo-rone)*(rtwo-rone);
        this.tr2 = 0.5*pow((this.range-this.rant),3.0);
        this.r3mr = 0.5*(3.0*rtwo-rone);
        this.tr3 = 0.5*(3.0*this.range-this.rant);

        nmax = ((int)(deltr*this.range+0.5))+1;

        if (this.ngmax > nmax)
        this.ngmax = (int)nmax;

        this.factmp[0] = 2.0/(3.0*boltk);
        this.factmp[1] = 1.0/(3.0*boltk);

        this.faceki[0] = 0.5*this.wait[0]/this.fmols;
        this.faceki[1] = 0.5*this.wait[1]/this.fmols;
        this.faceki[2] = 0.5*this.wait[2]/this.fmols;
        this.faceki[3] = 0.5/(waits*this.fmols);

        this.facpre = 2.0e+3*this.fmols/(3.0*avogadro);
        this.facwor = 1.0e-3*avogadro/this.fmols;
        this.facvir = 0.5/this.fmols;

        this.facrf = 0.5*amyq*this.range3;
        this.facpot =
        8.0*pi*this.range3*epsilon*this.fmols*pow(sigma,6.0)/(3.0*this.volume);

        this.facden = waits*this.fmols/avogadro;
        this.facgvr = deltr*this.volume/(2.0*pi*this.fmols*this.fmols);

        if(this.kpres || (this.lnebg != 2))
        return;
    }

    void setpressure(double value)
    {
        this.kpres=true;
        //Amit 6/04/03 allow pressure below 0
        this.epres=value;
    }

    void setenergy(double value)
    {
        this.ktemp=false;
    }

    void setemperature(double value)
    {
        this.ktemp=true;
        if(value>0)this.etemp=value;
    }

    void setdensity(double value)
    {
        this.kpres=false;

        if(value>0)
        {
            this.rhonew=value;
            if(this.rhonew > (this.rho+0.05)){
                this.scale_density = TRUE;
                this.scale_time = 0;
            }
            else{    /* Otherwise it's safe to scale density down */
                this.erho = this.rhonew;
                this.arho = this.rhonew;
                this.rho  = this.rhonew;
                denschange();
            }
        }
    }

	void remove_ion() {
		ions=null;
	}
	
// ------------------------------------------------------------------------

	double highPotWI = -10000000000000d, lowPotWI = 1000000000000000d;

	/*
	 * public void insert_ion(int[] type,int[] sig,int[] eps,int[] wait,int[]
	 * xni,int[] yni if(potlwi <= POT_CUTOFF) { for(i=0;i<this.numions;i++) {
	 * this.xni[i] = xnli[i]; this.yni[i] = ynli[i]; this.zni[i] = znli[i];
	 * 
	 * this.vxi[i] = 0.0; this.vyi[i] = 0.0; this.vzi[i] = 0.0;
	 * 
	 * 
	 * this.tempi[i] = 273.0; } this.vscfac = 0.0; this.ionpresent = true;
	 * return 1; }
	 */
	void insert_ion2(ArrayFinal<Ion> ions) {
		int i, j;

		int iax, iay, iaz, x, y, z, h;
		double shltap, ft2mi3;
		double qqhyio, qqoxio, qion[] = new double[2];
		double alj6p, blj12p, xnjo, ynjo, znjo;
		double xx, yy, zz;
		double abx, aby, abz, xnlinew, ynlinew, znlinew;
		double r, rinv, difft, diffr;
		double tswit, tswp;
		double xo, yo, zo, r2inv, r4inv, r6inv;
		double ecoul, ecore, epoli;
		double es;
		double sigg, epsn, siggi;
		double latx, laty, latz;
		double xnl, xnli[] = new double[MAX_IONS], ynli[] = new double[MAX_IONS], znli[] = new double[MAX_IONS];
		double potlwi;

		shltap = 0.005; /* orig.-value : 0.005 */
		double frang = 1.0 * this.boxhx;
		double frangt = frang - shltap;
		double ft2mi = 2.0 / ((frang - frangt) * (frang - frangt));
		double ft3m = 0.5 * (3.0 * frang - frangt);
		ft2mi3 = (-3.0) * ft2mi;
		es = 1.6022e-19 / 1.0e-20;
		
		this.ions=ions;
		
		latx = this.by / (2 * LAT_RESOLUTION + 1);
		laty = this.by / (2 * LAT_RESOLUTION + 1);
		latz = this.bz / (2 * LAT_RESOLUTION + 1);

		for (h = 0; h <= 3 * LAT_RESOLUTION; h++) {
			int xmax = h;
			int xmin = -h;
			if (xmax > LAT_RESOLUTION) xmax = LAT_RESOLUTION;
			if (xmin < -LAT_RESOLUTION) xmin = -LAT_RESOLUTION;
			for (x = xmin; x <= xmax; x++) {
				int ymax = h - abs(x);
				int ymin = -h + abs(x);
				if (ymax > LAT_RESOLUTION) ymax = LAT_RESOLUTION;
				if (ymin < -LAT_RESOLUTION) ymin = -LAT_RESOLUTION;
				xnl = x * latx;
				if (ions.getLength() == 1) xnli[0] = xnl;
				else if (ions.getLength() == 2) {
					siggi = (ions.get(0).sig + ions.get(1).sig) / 2.0;
					/*
					 * this can also be added to y- and z-component, if lattice
					 * changes
					 */
					xnli[0] = xnl + ((siggi / 2.0) - 0.01); /*
					 * due to coulomb
					 * attraction
					 */
					xnli[1] = xnl - ((siggi / 2.0) - 0.01); /*
					 * subtract 0.01 nm
					 * for dist
					 */
					/*
					 * apply periodic boundary conditions -> otherwise it won't
					 * work!!!
					 */
					xnli[0] = xnli[0] - 2.0 * this.boxhx * ((int) (xnli[0] / this.boxhx));
					xnli[1] = xnli[1] - 2.0 * this.boxhx * ((int) (xnli[1] / this.boxhx));
				}
				for (y = ymin; y <= ymax; y++) {
					int zmax = h - abs(x) - abs(y);
					int zmin = -h + abs(x) + abs(y);
					int zstep = zmax - zmin;
					if (!numToBool(zstep)) zstep = 1;
					if ((zmax <= LAT_RESOLUTION))
						for (z = zmin; z <= zmax; z += zstep) {
							potlwi = 0;
							for (i = 0; i < ions.getLength(); i++) {
								qion[i] = ions.get(i).sig * es;
								qqhyio = qion[i] * this.q[1] * scfacq;
								qqoxio = qion[i] * this.q[2] * scfacq;

								/* mix potentials */

								epsn = sqrt(ions.get(i).eps * epsilon);
								sigg = (ions.get(i).sig + sigma) / 2.0;

								alj6p = -4.0 * epsn * pow((sigg), 6.0);
								blj12p = 4.0 * epsn * pow((sigg), 12.0);
								znli[i] = latz * z;
								ynli[i] = laty * y;
								
								double couwi, corwi, polwi;
								couwi = corwi = polwi = 0.0;

								for (j = 0; j < this.mols; j++) {
									xnjo = this.rn[j][0][2];
									ynjo = this.rn[j][1][2];
									znjo = this.rn[j][2][2];

									xx = (xnli[i] - xnjo) / this.boxhx;
									yy = (ynli[i] - ynjo) / this.boxhy;
									zz = (znli[i] - znjo) / this.boxhz;

									iax = ((int) (xx)) + ((int) (xx));
									iay = ((int) (yy)) + ((int) (yy));
									iaz = ((int) (zz)) + ((int) (zz));

									abx = ((iax)) * (this.boxhx);
									aby = ((iay)) * (this.boxhy);
									abz = ((iaz)) * (this.boxhz);

									xnlinew = xnli[i] - abx;
									ynlinew = ynli[i] - aby;
									znlinew = znli[i] - abz;

									this.xion[j] = xnlinew;
									this.yion[j] = ynlinew;
									this.zion[j] = znlinew;

									xx = xnlinew - xnjo;
									yy = ynlinew - ynjo;
									zz = znlinew - znjo;

									r = sqrt(xx * xx + yy * yy + zz * zz);
									rinv = 1.0 / r;

									difft = r - frangt;
									diffr = r - frang;

									tswit = 1.0 - difft * difft * (ft3m - r)
											* ft2mi;
									if (difft < 0.0) tswit = 1.0;
									if (diffr > 0.0) tswit = 0.0;

									this.ttswit[j] = tswit;

									tswp = difft * diffr * ft2mi3 * rinv;
									if (difft < 0.0) tswp = 0.0;
									if (diffr > 0.0) tswp = 0.0;

									this.ttswp[j] = tswp;
								}

								for (j = 0; j < this.mols; j++) {
									xx = this.xion[j] - this.rn[j][0][0];
									yy = this.yion[j] - this.rn[j][1][0];
									zz = this.zion[j] - this.rn[j][2][0];

									r = sqrt(xx * xx + yy * yy + zz * zz);

									rinv = 1.0 / r;
									r2inv = rinv * rinv;

									ecoul = qqhyio * rinv;
									tswit = this.ttswit[j];
									couwi = couwi + ecoul * tswit;
								}

								for (j = 0; j < this.mols; j++) {
									xx = this.xion[j] - this.rn[j][0][1];
									yy = this.yion[j] - this.rn[j][1][1];
									zz = this.zion[j] - this.rn[j][2][1];

									r = sqrt(xx * xx + yy * yy + zz * zz);
									rinv = 1.0 / r;
									r2inv = rinv * rinv;

									ecoul = qqhyio * rinv;
									tswit = this.ttswit[j];
									couwi = couwi + ecoul * tswit;
								}

								for (j = 0; j < this.mols; j++) {
									xo = this.rn[j][0][2];
									yo = this.rn[j][1][2];
									zo = this.rn[j][2][2];

									xx = this.xion[j] - xo;
									yy = this.yion[j] - yo;
									zz = this.zion[j] - zo;

									r = sqrt(xx * xx + yy * yy + zz * zz);

									rinv = 1.0 / r;
									r2inv = rinv * rinv;

									ecoul = qqoxio * rinv;
									tswit = this.ttswit[j];
									couwi = couwi + ecoul * tswit;

									r4inv = r2inv * r2inv;
									r6inv = r4inv * r2inv;

									ecore = r6inv * r6inv * blj12p;
									corwi = corwi + ecore * tswit;
									epoli = r6inv * alj6p;
									polwi = polwi + epoli * tswit;

								}
								potlwi += (couwi + corwi + polwi);
							}
							if (potlwi <= POT_CUTOFF) {
								for (i = 0; i < ions.getLength(); i++) {
									this.xni[i] = xnli[i];
									this.yni[i] = ynli[i];
									this.zni[i] = znli[i];

									this.vxi[i] = 0.0;
									this.vyi[i] = 0.0;
									this.vzi[i] = 0.0;

									this.tempi[i] = 273.0;
								}
								this.vscfac = 0.0;
								return;
							}
						}
				}
			}
		}
		this.ions = null;
		return;
	}

	void insert_ion(ArrayFinal<Ion> ions, float x, float y, float z) {
		double dist;
		if(ions.getLength()==1) {
			dist=0;
		}else if(ions.getLength()==2) {
			dist=Ion.getDistance(ions.get(0),ions.get(1));
		}else {
			throw new IllegalArgumentException("only 1 or 2 ions allowed");
		}
		
		this.ions=ions;
		
		int icoef = 1;
		for (int i = 0; i < ions.getLength(); i++) {

			this.xni[i] = ((x * this.bx) + (dist * icoef))
					- (this.bx / 2f);
			this.zni[i] = ((y * this.by))
					- (this.by / 2f);
			this.yni[i] = ((z * this.bz))
					- (this.bz / 2f);
			icoef = -1;

			this.vxi[i] = 0.0;
			this.vyi[i] = 0.0;
			this.vzi[i] = 0.0;

			this.tempi[i] = 273.0;
		}
		this.vscfac = 0.0;

		return;
	}
	boolean insert_ion(ArrayFinal<Ion> ions) {

		int i, j;

		int iax, iay, iaz, x, y, z, h;
		double shltap, ft2mi3;
		double qqhyio, qqoxio, qion[] = new double[2];
		double alj6p, blj12p, xnjo, ynjo, znjo;
		double xx, yy, zz;
		double abx, aby, abz, xnlinew, ynlinew, znlinew;
		double r, rinv, difft, diffr;
		double tswit, tswp;
		double xo, yo, zo, r2inv, r4inv, r6inv;
		double ecoul, ecore, epoli;
		double es;
		double sigg, epsn, siggi;
		double latx, laty, latz;
		double xnl, xnli[] = new double[MAX_IONS], ynli[] = new double[MAX_IONS], znli[] = new double[MAX_IONS];
		double potlwi;
		shltap = 0.005; /* orig.-value : 0.005 */
		double frang = 1.0 * this.boxhx;
		double frangt = frang - shltap;
		double ft2mi = 2.0 / ((frang - frangt) * (frang - frangt));
		double ft3m = 0.5 * (3.0 * frang - frangt);
		ft2mi3 = (-3.0) * ft2mi;
		es = 1.6022e-19 / 1.0e-20;
		
		this.ions=ions;

		latx = this.by / (2 * LAT_RESOLUTION + 1);
		laty = this.by / (2 * LAT_RESOLUTION + 1);
		latz = this.bz / (2 * LAT_RESOLUTION + 1);

		for (h = 0; h <= 3 * LAT_RESOLUTION; h++) {
			int xmax = h;
			int xmin = -h;
			if (xmax > LAT_RESOLUTION) xmax = LAT_RESOLUTION;
			if (xmin < -LAT_RESOLUTION) xmin = -LAT_RESOLUTION;
			for (x = xmin; x <= xmax; x++) {
				int ymax = h - abs(x);
				int ymin = -h + abs(x);
				if (ymax > LAT_RESOLUTION) ymax = LAT_RESOLUTION;
				if (ymin < -LAT_RESOLUTION) ymin = -LAT_RESOLUTION;
				xnl = x * latx;
				if (ions.getLength() == 1) xnli[0] = xnl;
				else if (ions.getLength() == 2) {
					siggi = (ions.get(0).sig + ions.get(1).sig) / 2.0;
					/*
					 * this can also be added to y- and z-component, if lattice
					 * changes
					 */
					xnli[0] = xnl + ((siggi / 2.0) - 0.01); /*
					 * due to coulomb
					 * attraction
					 */
					xnli[1] = xnl - ((siggi / 2.0) - 0.01); /*
					 * subtract 0.01 nm
					 * for dist
					 */
					/*
					 * apply periodic boundary conditions -> otherwise it won't
					 * work!!!
					 */
					xnli[0] = xnli[0] - 2.0 * this.boxhx * ((int) (xnli[0] / this.boxhx));
					xnli[1] = xnli[1] - 2.0 * this.boxhx * ((int) (xnli[1] / this.boxhx));
				}
				for (y = ymin; y <= ymax; y++) {
					int zmax = h - abs(x) - abs(y);
					int zmin = -h + abs(x) + abs(y);
					int zstep = zmax - zmin;
					if (!numToBool(zstep)) zstep = 1;
					if ((zmax <= LAT_RESOLUTION))
						for (z = zmin; z <= zmax; z += zstep) {
							potlwi = 0;
							for (i = 0; i < ions.getLength(); i++) {
								qion[i] = ions.get(i).solch * es;
								qqhyio = qion[i] * this.q[1] * scfacq;
								qqoxio = qion[i] * this.q[2] * scfacq;

								/* mix potentials */

								epsn = sqrt(ions.get(i).eps * epsilon);
								sigg = (ions.get(i).sig + sigma) / 2.0;

								alj6p = -4.0 * epsn * pow((sigg), 6.0);
								blj12p = 4.0 * epsn * pow((sigg), 12.0);
								znli[i] = latz * z;
								ynli[i] = laty * y;
								double couwi,corwi,polwi;
								couwi = corwi = polwi = 0.0;

								for (j = 0; j < this.mols; j++) {
									xnjo = this.rn[j][0][2];
									ynjo = this.rn[j][1][2];
									znjo = this.rn[j][2][2];

									xx = (xnli[i] - xnjo) / this.boxhx;
									yy = (ynli[i] - ynjo) / this.boxhy;
									zz = (znli[i] - znjo) / this.boxhz;

									iax = ((int) (xx)) + ((int) (xx));
									iay = ((int) (yy)) + ((int) (yy));
									iaz = ((int) (zz)) + ((int) (zz));

									abx = ((iax)) * (this.boxhx);
									aby = ((iay)) * (this.boxhy);
									abz = ((iaz)) * (this.boxhz);

									xnlinew = xnli[i] - abx;
									ynlinew = ynli[i] - aby;
									znlinew = znli[i] - abz;

									this.xion[j] = xnlinew;
									this.yion[j] = ynlinew;
									this.zion[j] = znlinew;

									xx = xnlinew - xnjo;
									yy = ynlinew - ynjo;
									zz = znlinew - znjo;

									r = sqrt(xx * xx + yy * yy + zz * zz);
									rinv = 1.0 / r;

									difft = r - frangt;
									diffr = r - frang;

									tswit = 1.0 - difft * difft * (ft3m - r)
											* ft2mi;
									if (difft < 0.0) tswit = 1.0;
									if (diffr > 0.0) tswit = 0.0;

									this.ttswit[j] = tswit;

									tswp = difft * diffr * ft2mi3 * rinv;
									if (difft < 0.0) tswp = 0.0;
									if (diffr > 0.0) tswp = 0.0;

									this.ttswp[j] = tswp;
								}

								for (j = 0; j < this.mols; j++) {
									xx = this.xion[j] - this.rn[j][0][0];
									yy = this.yion[j] - this.rn[j][1][0];
									zz = this.zion[j] - this.rn[j][2][0];

									r = sqrt(xx * xx + yy * yy + zz * zz);

									rinv = 1.0 / r;
									r2inv = rinv * rinv;

									ecoul = qqhyio * rinv;
									tswit = this.ttswit[j];
									couwi = couwi + ecoul * tswit;
								}

								for (j = 0; j < this.mols; j++) {
									xx = this.xion[j] - this.rn[j][0][1];
									yy = this.yion[j] - this.rn[j][1][1];
									zz = this.zion[j] - this.rn[j][2][1];

									r = sqrt(xx * xx + yy * yy + zz * zz);
									rinv = 1.0 / r;
									r2inv = rinv * rinv;

									ecoul = qqhyio * rinv;
									tswit = this.ttswit[j];
									couwi = couwi + ecoul * tswit;
								}

								for (j = 0; j < this.mols; j++) {
									xo = this.rn[j][0][2];
									yo = this.rn[j][1][2];
									zo = this.rn[j][2][2];

									xx = this.xion[j] - xo;
									yy = this.yion[j] - yo;
									zz = this.zion[j] - zo;

									r = sqrt(xx * xx + yy * yy + zz * zz);

									rinv = 1.0 / r;
									r2inv = rinv * rinv;

									ecoul = qqoxio * rinv;
									tswit = this.ttswit[j];
									couwi = couwi + ecoul * tswit;

									r4inv = r2inv * r2inv;
									r6inv = r4inv * r2inv;

									ecore = r6inv * r6inv * blj12p;
									corwi = corwi + ecore * tswit;
									epoli = r6inv * alj6p;
									polwi = polwi + epoli * tswit;

								}
								potlwi += (couwi + corwi + polwi);
							}
							if (potlwi <= POT_CUTOFF) {
								for (i = 0; i < ions.getLength(); i++) {
									this.xni[i] = xnli[i];
									this.yni[i] = ynli[i];
									this.zni[i] = znli[i];

									this.vxi[i] = 0.0;
									this.vyi[i] = 0.0;
									this.vzi[i] = 0.0;

									this.tempi[i] = 273.0;
								}
								this.vscfac = 0.0;
								return true;
							}
						}
				}
			}
		}
		this.ions=ions;
		return false;

	}

	void loadNMolDef(int n) {
		mols = n;
		nfi = nacc = 21271;
		bx = by = bz = 2.4;// 0.80/*2.2*/;/* bx=1.8626128255492771;
		// by=1.8626128255492771; bz=1.8626128255492771; */
		aeges = -35.5799999999999980;
		atemp = 273.0000000000000000;
		apres = 0.0000000000000000;
		arho = 1.0000000000000000;
		delta = 0.0050000000000000;
		rhop = 0.0065765073992221;
		egesp = -0.3126005486570169;
		float pval = 0, pval2 = 0, pval3 = 0;
		for (int i = 0; i < n; i++) {
			this.rn[i][0][0] = (float) -0.1659317612648010 + pval;
			this.rn[i][1][0] = (float) 0.8701542615890503 + pval2;
			this.rn[i][2][0] = (float) 0.5582472085952759 + pval3;
			this.rn[i][0][1] = (float) -0.2419075518846512 + pval;
			this.rn[i][1][1] = (float) 0.7969573736190796 + pval2;
			this.rn[i][2][1] = (float) 0.6668199896812439 + pval3;
			this.rn[i][0][2] = (float) -0.2040653377771378 + pval;
			this.rn[i][1][2] = (float) 0.7850233316421509 + pval2;
			this.rn[i][2][2] = (float) 0.5797123908996582 + pval3;
			for (int y = 0; y < 3; y++) {
				for (int x = 0; x < 3; x++) {
					this.rn[i][y][x] -= 1;
				}
			}
			this.ve[i][0][0] = -0.04608631134033203;
			this.ve[i][1][0] = 0.02178072929382324;
			this.ve[i][2][0] = -0.00059604644775391;
			this.ve[i][0][1] = -0.09874731302261353;
			this.ve[i][1][1] = 0.01184701919555664;
			this.ve[i][2][1] = -0.04306793212890625;
			this.ve[i][0][2] = -0.07486552000045776;
			this.ve[i][1][2] = 0.02545952796936035;
			this.ve[i][2][2] = -0.03479242324829102;
			pval += 0.25f;
			if (pval % 1 == 0) pval2 += .4f;
			if (pval % 1 == 0) pval3 += .4f;
		}
		initial(/* data */);

		this.tempav = this.atemp;
		this.presav = this.apres;
		this.rho = this.arho;
		this.hbonds = 0;
	}

	public void clear() {
		ions=null;
		scale_density = false;
		display_time = 0;
		display_step = 1;
		quit_sim = 0;

		blockdata();
		anfang();
		// raw.initial();

		tempav = etemp;
		presav = epres;
		rho = erho;
	}

	public void step() throws ShakeFailException {
		motion(); /* this has to be up here ! */
		allfiv(); /* define the lp coordinates */
		neighborlist(); /* define the neighboor list */
		if (ions!=null&&ions.getLength()>0) {
			if (ions.getLength() > 1) forceionion();
			forcewi();
		}
		forces(); /* calculate the force and dynamics */
		if (ions!=null&&ions.getLength()>0) frogiions();

		natu++;
		nacc++;
		nfi++;

		values();
		/* calculate the structure factor and thermadynamic data */
		structure();

		cpu = ecpu - acpu;
		acpu = ecpu;

		if (scale_density == true) {
			scale_time++;
			if (scale_time == 5) { /* Rescale every 5 time steps */
				scale_time = 0;
				if (rhonew > (rho + 0.05)) {
					erho = (rho + 0.05);
					arho = (rho + 0.05);
					rho = (rho + 0.05);
				} else {
					scale_density = false;
					erho = rhonew;
					arho = rhonew;
					rho = rhonew;
				}
				denschange();
				/* If scaling density with NVT, change box dimensions, etc. */
			}
		}

		display_time++;
	}
}
