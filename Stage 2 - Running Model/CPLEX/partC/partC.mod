/*********************************************
 * OPL 20.1.0.0 Model
 * Author: yagiz
 * Creation Date: Apr 10, 2021 at 11:56:28 PM
 *********************************************/
 
  // 1. parameter addition to Part A
 
 int ST = 1;
 

 
 //////////
int nCities =...;
int nTypes=...;
range T = 1..nTypes ;
range C = 1..nCities ;
float c = ... ;
int OC = ...;
int K = ... ;
int M =...;
int D[C] = ... ;
int Dist[C][C] = ...;
int F[T] = ...;
int cap[T] = ...;
int r[T] = ...;
int n[C][C] = ... ;
int S[T][C][C] = ...;
dvar int x[C][C][T] ;
dvar boolean y[C][T];
dvar boolean O[C][T];

 // 2. Additinal dv to PartA which is z_ijt = 1 if store that has type t is opened in district i serves j, 0 ow
 
dvar boolean z[C][C][T];

minimize sum(t in T,i in C) F[t]*y[i][t] + sum(i in C,j in C, t in T)x[i][j][t]*Dist[i][j]*c+ sum(i in C,t in T) (OC)*O[i][t];
subject to{


	forall(j in C)  sum(i in C, t in T) x[i][j][t] >= D[j]; 
	
	forall(j in C) sum(i in C) n[i][j]*y[i][4] <= M*(1-y[j][4]);
		
	forall(j in C)  1-y[j][4] <= sum(i in C) n[i][j]*y[i][4];
	
		sum(i in C) y[i][1] - sum(i in C)y[i][3] <= K;
		sum(i in C) y[i][3] - sum(i in C)y[i][1] <= K;
  
	forall(t in T)  y[4][t]-y[8][t] == 0;
		
	forall(i in C, j in C, t in T)   (1- S[t][i][j])*x[i][j][t] <= 0;
		
	forall(i in C, t in T)   sum(j in C)  x[i][j][t]  <= y[i][t]*cap[t] + (0.1)*O[i][t]*cap[t]  ;
		
	forall (i in C, j in C, t in T)   x[i][j][t] <= y[i][t]*M ;
			
	forall(i in C, t in T)   O[i][t] <= y[i][t] ;
	
	forall(i in C, j in C, t in T) x[i][j][t] >= 0;
	
	// addition constraint 1 - Relating variables
	
	forall(i in C, j in C, t in T) x[i][j][t] <= M*z[i][j][t];
	
	// addition constraint 2 - The served districts cannot exceed treshhold
	
	forall( j in C, t in T) sum(i in C) z[i][j][t] <= ST;
	
			
}
 
 