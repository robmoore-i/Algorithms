// Minimise   Z   = c*x
// Subject to A$x = b

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
