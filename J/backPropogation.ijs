NB. 2-2-2 ANN

NB. Input matrix: denoted X
NB.   row per minibatch
NB.   col per feature

NB. Weight matrix: From layer i to j is denoted Wij
NB.   nth column of the mth row represents the weight from the
NB.   nth neuron of previous layer to the mth neuron of next layer.

NB. Bias list: For layer i, denoted Bi
NB.   nth element represents bias in the nth neuron of layer i

NB. S1 = X mmu W01
NB. Z1 = sigmoid B1 +"1 S1
NB. Sj = Zi mmu Wij
NB. Zj = sigmoid Bj +"1 Sj

layersizes=:2 2 2
IN =:0.05 0.1
W01=:2 2 $ 0.15 0.25 0.20 0.3
B1 =:0.35 0.35
W12=:2 2 $ 0.4 0.5 0.45 0.55
B2 =:0.6 0.6
nn=:<"1 (W01;B1),:(W12;B2)

T=:0.01 0.99 NB. Target

mmu=:+/ .*
softmax=:^ % +/@:^
sigmoid=:((^ % >:@:^)`((* 1&-)~)) D. 1

layer=:>@:{~ NB. 'nn layer 0' Gets the weights and biases of the first hidden layer.
w=:>@:(0&{) NB. weights. Call on the result of 'layer'
b=:>@:(1&{) NB. biases.  Call on the result of 'layer'

S=:mmu w
Z=:sigmoid@:(S + b@:])

feedThroughLayer=:Z nn&layer
feedThroughNetwork=:(feedThroughLayer&1)@:(feedThroughLayer&0)

cost=:(+/"1)@:-:@:*:@:(-"1)

eta=:0.5

activationDelta=:* (sigmoid D. 1)
outputDelta=:- activationDelta [
weightDelta=:[: (+/"1) (*"1)
updateOutputWeights=:- |:@:(eta&*)
updateHiddenWeights=:- eta&*
hiddenLayerActivation=:feedThroughLayer&0

NB. W is weights
NB. X is input
NB. C is cost
NB. H is the activation of the hidden layer

backpropOutputWeights=:4 : 0
  'W C H'=.x;y
  times=.((*/)`(*"1))@.(*@:<:@:#@:$@:]) NB. Accounts for rank issues from unit size minibatches
  W updateOutputWeights C times H
)
NB. e.g. W12 backpropOutputWeights ((Y outputDelta T);hiddenLayerActivation X)

backpropHiddenWeights=:4 : 0
  'Wthis Wprev C H X'=.x,y
  Wthis updateHiddenWeights (Wprev weightDelta C) * (X activationDelta H)
)
NB. e.g. (W01;W12) backpropHiddenWeights ((Y outputDelta T);(hiddenLayerActivation X);X)

trainSingleMinibatch=:4 : 0
  'X T'=.x
  'W01 B1 W12 B2'=.,@:> y
  H=.X Z nn layer 0
  Y=.H Z nn layer 1
  C=.Y outputDelta T
  newW12=.W12 backpropOutputWeights C;H
  newW01=.(W01;W12) backpropHiddenWeights C;H;X
  <"1 (newW01;B1),:(newW12;B2)
)

randomInput=:3 : '(2&? % ]) 100'
input=:(randomInput"0) 100#0
target=:+/"1 input
trainingSet=:(<"1 input) ,. (<"0 target)

NB. (1{trainingSet) trainSingleMinibatch (0{trainingSet) trainSingleMinibatch nn
NB. Needs automation for going through the set.
