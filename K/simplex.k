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
  isFeasible:$[min 0<X;"";"in"],"feasible";
  isBasic," ",isFeasible," ",isSolution}

// Given a tableau t and index set I, will return the corresponding basic
// solution.
readBasicSolution:{[t;I]@[(#*{-1_1_x}'t)#0f;-1+I;:;last'1_t]}

// Given a p∈ I and a q∉ I
// ...

// Example:
A:2 8#2 -1 3 2 3 2 1 0 3 4 2 2 3 0 0 1f
b:4 2f
c:6 3 4 2 -3 4 0 0f
I:4 3
t:tableau[A;b;c;I]
ta:showTableau[t;I]
bs:readBasicSolution[t;I]
bfs:showBFS[A;b;I;bs]
