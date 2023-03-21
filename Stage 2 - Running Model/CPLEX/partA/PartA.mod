/*********************************************
 * OPL 20.1.0.0 Model
 * Author: yagiz
 * Creation Date: 10 Nis 2021 at 22:16:22
 *********************************************/
 
 // Parameters
 
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

// Decision Variables

dvar int x[C][C][T] ;
dvar boolean y[C][T];
dvar boolean O[C][T];

// Objective Function

minimize sum(t in T,i in C) F[t]*y[i][t] + sum(i in C,j in C, t in T)x[i][j][t]*Dist[i][j]*c+ sum(i in C,t in T) (OC)*O[i][t];
subject to{

// Constraint 1. Demand for every district should be met
	forall(j in C)  sum(i in C, t in T) x[i][j][t] >= D[j]; 
	
	// Constraint 2. Constraint for 5M Migros
	forall(j in C) sum(i in C) n[i][j]*y[i][4] <= M*(1-y[j][4]);
	forall(j in C)  1-y[j][4] <= sum(i in C) n[i][j]*y[i][4];
	
	// Constraint 3. Difference between 3M and Jet
		sum(i in C) y[i][1] - sum(i in C)y[i][3] <= K;
		sum(i in C) y[i][3] - sum(i in C)y[i][1] <= K;
  
  // Constraint 4. After observing demand values Migros concludes that district 4 and 8 have similar demand behaviours.
	forall(t in T)  y[4][t]-y[8][t] == 0;
		
	// Constraint 5. Range Constraint
	forall(i in C, j in C, t in T)   (1- S[t][i][j])*x[i][j][t] <= 0;
		
	// Constraint 6. Capacity Constraint
	forall(i in C, t in T)   sum(j in C)  x[i][j][t]  <= y[i][t]*cap[t] + (0.1)*O[i][t]*cap[t]  ;
		
	// Constraint 7. Relating the variables
	forall (i in C, j in C, t in T)   x[i][j][t] <= y[i][t]*M ;
			
	// Constraint 8. Relating the variables
	forall(i in C, t in T)   O[i][t] <= y[i][t] ;
	
	// Constraint 9. Nonnegativity of x
	forall(i in C, j in C, t in T) x[i][j][t] >= 0;
			
}