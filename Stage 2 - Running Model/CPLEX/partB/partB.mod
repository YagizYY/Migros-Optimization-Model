/*********************************************
 * OPL 20.1.0.0 Model
 * Author: yagiz
 * Creation Date: 10 Nis 2021 at 22:53:56
 *********************************************/

 int nDistricts = ... ;
 range D = 1..nDistricts ;
 
 
 // served : 1 if district i has a store according to the results of part(a), 0 ow
 
 int Served[D] = ... ;
 
 //Dist_ij : Distance between district i and warehouse j
 
 int dist[D][D] = ... ;
			   
// t : The maximum distance a truck has to travel in a single journey
dvar int t ;

// x_ij : 1 if district j is being served by warehouse in district i, 0 ow
dvar boolean x[D][D] ;

// y_i : 1 f a warehouse is opened in district i, 0 ow
dvar boolean y[D] ;

// objective function
minimize t;

subject to{

//	1. min of max constraint

	forall(i in D, j in D)  t >= dist[i][j]*x[i][j]; 
	
// 	2. 4 warehouses should be opened
	 sum(i in D) y[i] == 4;
		
//  3. Districts with stores should be served with a single warehouse
	
		forall(j in D)   sum(i in D) x[i][j] == Served[j];
		
//  4.  Relating variables
  
	forall(i in D, j in D)  y[i] >= x[i][j];
		

			
}





			   
			   
 
 