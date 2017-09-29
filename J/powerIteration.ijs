dot=:+/ . *
rq=:(dot dot ]) % (dot~)@:] NB. Rayleigh quotient - 'M rq v'

NB. Dyadic : 'matrix (numIterations powerIteration) initialGuess'
NB. Monadic: initialGuess defaults to (1 1)
powerIteration=: 1 : 0
  y (m powerIteration) 1 1
:
  x ([ (<@:] , <@:rq) (,&1)@:(%/)@:(dot^:m)) y
)
