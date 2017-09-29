NB. Input matrix: denoted X
NB.   row per minibatch
NB.   col per feature

NB. Weight matrix: From layer i to j is denoted Wij
NB.   nth column of the mth row represents the weight from the
NB.   nth neuron of previous layer to the mth neuron of next layer.

NB. Bias list: For layer i, denoted Bi
NB.   nth element represents bias in the nth neuron of layer i

mmu=:+/ .*
softmax=:^ % +/@:^
sigmoid=:((^ % >:@:^)`((* 1&-)~)) D. 1

layer=:>@:{~ NB. 'nn layer 0' Gets the weights and biases of the first hidden layer.
w=:>@:(0&{) NB. weights. Call on the result of 'layer'
b=:>@:(1&{) NB. biases.  Call on the result of 'layer'

S=:mmu w NB. Weight/bias products
Z=:sigmoid@:(S + b@:]) NB. Activations

quadraticCost=:(+/"1)@:-:@:*:@:(-"1)

eta=:0.1 NB. Learning rate

mutation=: 3 : '(? % 100&*) 1000' NB. Returns a random value between 0 and 0.01

activationDelta=:* (sigmoid D. 1) NB. Delta component from activation
outputDelta=:- activationDelta [  NB. Delta component from final output
updateTranspose=:- |:@:(eta&*)@:(mutation + ])
updateInshape=:- (eta&*)@:(mutation + ])
updateBias=:updateInshape

NB. W is weights
NB. X is input
NB. C is cost
NB. H is the activation of the hidden layer

backpropOutputWeights=:4 : 0
  'W C H'=.x;y
  times=.((*/)`(*"1))@.(*@:<:@:#@:$@:]) NB. Accounts for rank issues from unit size minibatches
  W updateTranspose C times H
)

backpropHiddenWeights=:4 : 0
  'W delta H X'=.x;y
  W updateInshape delta * (X activationDelta H)
)

trainSingleMinibatch=:4 : 0
  'X T'=.x
  'W01 B1 W12 B2'=.,@:> y
  H=.X Z y layer 0
  Y=.H Z y layer 1
  C=.Y outputDelta T
  newW12=.W12 backpropOutputWeights C;H
  newB1=.B1 updateBias C
  delta=.W12 mmu C
  newW01=.W01 backpropHiddenWeights delta;H;X
  newB2=.B2 updateBias delta
  <"1 (newW01;newB1),:(newW12;newB2)
)

trainThroughSet=: (]`(}.@:[ $: ({.@:[ trainSingleMinibatch ])))@.(*@:#@:[)

NB. Trains the network under the trainingSet, then shows the output of running the
NB. given inputs through the trained network.
showLearningResults=: 4 : 0
  'modelInputs modelOutputs trainingSet'=.y
  trainedNet=.trainingSet trainThroughSet x
  untrainedFeedforward=.((Z&(x layer 1))@:(Z&(x layer 0))"1) modelInputs
  trainedFeedforward=.((Z&(trainedNet layer 1))@:(Z&(trainedNet layer 0))"1) modelInputs
  untrainedCosts=.untrainedFeedforward (<"0)@:(quadraticCost"0) modelOutputs
  trainedCosts=.trainedFeedforward (<"0)@:(quadraticCost"0) modelOutputs
  headers=:;:'input target untrained_output untrained_cost trained_output trained_cost'
  headers , (<"1 modelInputs) ,. (<"0 modelOutputs) ,. (<"0 untrainedFeedforward) ,. untrainedCosts ,. (<"0 trainedFeedforward) ,. trainedCosts
)

NB. x = possible inputs, y = size of set, u = target function applied to each input
generateTrainingSet=:1 : 0
:
  x (] ,. (u L:0))@:((<"1)@:([ ({~ ?) (# #)~)) y
)
NB. Example: An XOR training set
size=:1000
booleanCombinations=:4 2 $ 0 0 0 1 1 0 1 1
targetFunction=:{. ~: {:
trainingSet=:booleanCombinations (targetFunction generateTrainingSet) size

NB. Example: XOR network results:
XOR_NET=:<"1 ((2 2 $ 0.15 0.25 0.20 0.3);(0.35 0.35)),:((0.4 0.5);(0.6))
r=:XOR_NET showLearningResults booleanCombinations;(0 1 1 0);<trainingSet
