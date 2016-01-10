set nodos ordered;		
param n := card {nodos};	
set SS := 0 .. (2**n - 1); 
set RST {k in SS} := {i in nodos: (k div 2**(ord(i)-1)) mod 2 = 1};
set arcos := {i in nodos, j in nodos: ord(i) < ord(j)};

param Dist {arcos} >= 0;
var X {arcos} binary;

minimize FUNOBj: sum {(i,j) in arcos} Dist[i,j] * X[i,j];

subj to Tur {i in nodos}: 
   sum {(i,j) in arcos} X[i,j] + sum {(j,i) in arcos} X[j,i] = 2;

subj to Subtur {k in SS diff {0,2**n-1}}: 
   sum {i in RST[k], j in nodos diff RST[k]: (i,j) in arcos} X[i,j] +
   sum {i in RST[k], j in nodos diff RST[k]: (j,i) in arcos} X[j,i] >= 2;
