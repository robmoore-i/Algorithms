// Minimise   Z   = c*x
// Subject to A$x = b

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
  obj:sum cB*bs;
  nB:#I;
  nN:#nI;
  objRow:"f"$,/1,(nB#0),(-:r),obj;
  id:"f"$0=(2#nB)#!1+nB;
  cnsRows:"f"$(nB#0),'id,'((!B)$N),'(!B)$b;
  fpe (,objRow),cnsRows}

respace:{updateSpacing[x;0;&:'x=\:" "]}
updateSpacing:{[txt;row;M]
  row:0;
  n:#*M;
  while[row<n;
    txt:(r#'txt),'((d:max[r]-r)#\:" "),'(r:M@\:row)_'txt;
    M:(row#/:M),'d+'row_/:M;
    row+:1];
  withHeader:((,txt[0]),,:(#*txt)#"-"),1_txt;
  @[;*M;:;"|"]'withHeader}

// Given a simplex tableau t with index set I, adds column/row labels and
// prints it nicely.
annotate:{[I;t]
  n:#*t;
  notI:1+e@&~:max$["b"](-1+I)=\:e:!-2+#*t
  colLabels:" "/:("BV";,"Z"),("x",/:$I,notI),(,"RHS");
  rowLabels:"Z","x",/:$I;
  respace (,colLabels),(rowLabels,\:" "),'" "/:'$t}

// Example:
A:2 8#2 -1 3 2 3 2 1 0 3 4 2 2 3 0 0 1f
b:4 2f
c:6 3 4 2 -3 4 0 0f
I:4 3
t:tableau[I;A;c;b]
