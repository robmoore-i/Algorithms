// Minimise   Z   = c*x
// Subject to A$x = b

// You must by hand convert the problem to standard form.
// Recall that an LP is in standard form if:
// => Objective is a minimisation
// => Constraints are linear equalities
// => RHS of every constraint is non-negative
// => All decision variables are non-negative.

// Swaps elements Y and Z in list X.
swap:{tmp:x[y];x[y]:x[z];x[z]:tmp;x}

// Given a matrix of floats, amends all values sufficiently close to 0 with 0
fpe:{((#x);(#*x))#@[rx;&abs[rx:,/x]<0.0001;:;0f]}

// Given constraints A,b, objective c, and index set I: produces a tableau.
tableau:{[A;b;c;I]
  B:A@\:bI:-1+I;
  N:A@\:nI:e@&~:max bI=\:e:!#*A;
  cB:c@bI;
  cN:c@nI;
  r:cN-(+N)$(+!B)$cB;
  bs:(!B)$b;
  Z:sum cB*bs;
  nB:#I;
  nN:#nI;
  zRow:"f"$,/1,(nB#0),(-:r),Z;
  id:"f"$0=(2#nB)#!1+nB;
  cRows:"f"$(nB#0),'id,'((!B)$N),'(!B)$b;
  allRows:fpe (,zRow),cRows;
  swap[;1+!#I;I]'allRows}

// Aligns the whitespace separated columns represented in the lines of TXT,
// then adds pipe separators between the columns.
pipeSpace:{[txt]
  row:0;
  n:#*M:&:'txt=\:" ";
  while[row<n;
    txt:(r#'txt),'((d:max[r]-r)#\:" "),'(r:M@\:row)_'txt;
    M:(row#/:M),'d+'row_/:M;
    row+:1];
  @[;*M;:;"|"]'txt}

// Given a simplex tableau t with index set I, adds column/row labels and
// prints it nicely.
showTableau:{[t;I]
  colLabels:" "/:("BV";,"Z"),("x",/:$1+!-2+#*t),(,"RHS");
  rowLabels:"Z","x",/:$I;
  withLabels:(,colLabels),(rowLabels,\:" "),'" "/:'$t;
  pipeSpace withLabels}

// Given the constraints A, b, the index set I and a candidate vector X,
// will print some text containing whether X is in fact a solution to the
// constraints, if it is basic and if it is feasible.
showBFS:{[A;b;I;X]
  isSolution:$[b~+/'A*\:X;"";"non-"],"solution";
  isBasic:$[min 0=X a@&~(a:(!#X)) in -1+I;"";"non-"],"basic";
  isFeasible:$[(8=#isSolution)&min 0<X;"";"in"],"feasible";
  isBasic," ",isFeasible," ",isSolution}

// Given a tableau t and index set I, will return the corresponding basic
// solution.
readBasicSolution:{[t;I]@[(#*{-1_1_x}'t)#0f;-1+I;:;last'1_t]}

// Given a tableau t, a p∈ I and a q∉ I, perform a pivot on (p, q) such that
// xp leaves the basis and xq enters the basis, returning the resulting
// pivoted tableau.
pivot:{[t;p;q]t-t[p]*/:@[A2@\:q;p;:;0]}

// Example 1:
A1:2 8#2 -1 3 2 3 2 1 0 3 4 2 2 3 0 0 1f
b1:4 2f
c1:6 3 4 2 -3 4 0 0f
I1:4 3
t1:tableau[A1;b1;c1;I1]
ta1:showTableau[t1;I1]
bs1:readBasicSolution[t1;I1]
bfs1:showBFS[A1;b1;I1;bs1]

// Example 2:
A2:4 8#1 0 0 0 1 2 1 1 0 1 0 0 1 1 -1 5 0 0 1 0 2 -3 1 3 0 0 0 1 -1 2 -1 -1
I2:1 2 3
