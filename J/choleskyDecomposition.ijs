NB. Uses the Cholesky-Banachiewicz algorithm

initialiseL=:($ $ %:@:{.@:{. , (<:@:*:@:# # 0:))

NB. L_ij
reciprocalOfL_jj =: 1 : 0 
  m %@:(<@:(2: # [) { ]) y
)
ijrowProductsSum =: 2 : 0
  (m;n) +/@:({. * +@:{:)@:(>@:[ { ]) y
)
L_ij =: 2 : 0
:
  (n reciprocalOfL_jj y) * (((<m,n) { x) - (m ijrowProductsSum n) y)
)

NB. L_jj
jjrowProductsSum =: 1 : 0
  m +/@:([ * +)@:([ {. [ { ]) y
)
L_jj=: 1 : 0
:
  %: (((<2#m) { x) - (m jjrowProductsSum) y)
)

nextIdxs =: 13 : '((x>y) { ((>:x),0) ,: (x,(>:y)))'

choleskyRecurse =: 2 : 0
:
  if. m >: (#y) do.
    y
  else.
    f=.(m>n) { (m L_jj)`(m L_ij n)
    L=.(x (f`:6) y) (m <@:, n)} y
    nidxs=.m nextIdxs n
    x (({. nidxs) choleskyRecurse ({: nidxs)) L
  end.
)

NB. Takes a symmetric matrix, which may be complex.
cholesky =: 3 : 0
  A=.y
  L=.initialiseL A
  A (1 choleskyRecurse 0) L
)
