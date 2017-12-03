// Minimise   Z   = c*x
// Subject to A$x = b

// You must by hand convert the problem to standard form.
// Recall that an LP is in standard form if:
// => Objective is a minimisation
// => Constraints are linear equalities
// => RHS of every constraint is non-negative
// => All decision variables are non-negative.

// Swaps rows Y and Z in matrix X.
swapRows:{tmp:x[y];x[y]:x[z];x[z]:tmp;x}

// Given a matrix of floats, amends all values sufficiently close to 0 with 0
fpe:{((#x);(#*x))#@[rx;&abs[rx:,/x]<0.0001;:;0f]}

// Given an index set I, constraints A,b and objective c, produces a tableau.
tableau:{[I;A;c;b]
  B:A@\:bI:-1+I;
  N:A@\:nI:e@&~:max$["b"]bI=\:e:!#*A;
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
  fpe (,zRow),cRows}

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
annotate:{[I;t]
  n:#*t;
  notI:1+e@&~:max$["b"](-1+I)=\:e:!-2+#*t
  colLabels:" "/:("BV";,"Z"),("x",/:$I,notI),(,"RHS");
  rowLabels:"Z","x",/:$I;
  withLabels:(,colLabels),(rowLabels,\:" "),'" "/:'$t;
  pipeSpace withLabels}

checkBFS:{[A;b;I;x]
  isSolution:$[b~+/'A*\:x;"";"non-"],"solution";
  isBasic:$[min 0=x a@&~(a:(!#x)) in -1+I;"";"non-"],"basic";
  isFeasible:$[min 0<x;"";"in"],"feasible";
  isBasic," ",isFeasible," ",isSolution}

// Example:
A:2 8#2 -1 3 2 3 2 1 0 3 4 2 2 3 0 0 1f
b:4 2f
c:6 3 4 2 -3 4 0 0f
I:4 3
t:tableau[I;A;c;b]
ta:annotate[I;t]
