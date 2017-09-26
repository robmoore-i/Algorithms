projects_home=:> (<1 1){UserFolders_j_
load projects_home,'/Algorithms/binarySearchTree.ijs'

rotl=:<@:(''&({.@:>@:{:@:]`(<:@:#@:])`]})) , }.@:>@:{: NB. rotate left
rotr=:}:@:>@:{. , <@:(''&({:@:>@:{.@:]`0:`]})) NB. rotate right
RED=:s:<'RED'
BLACK=:s:<'BLACK'
enc=:(3&{.@:] , <@:[ , {:@:])`]@.(#@:] <: 1:) NB. encolour
c=:((>@:(3&{))`(BLACK"1))@.(# <: 1:) NB. colour
iNoRepair=:(RED&enc)@:[ i ] NB. insert without repair

pathToNodeInstructions=:(([: < '{.'"1) , [ $: >@:{.@:])`([: < ']'"1)`(([: < '{:'"1) , [ $: >@:{:@:])@.(>:@:*@:(- k))`('notfound'"1)@.(#@:] <: 1:)
pathToNode=:|.@:}:@:,@:([ ,"0 <@:])&'>'@:pathToNodeInstructions
pathToParent=:(3&}.)@:pathToNode
pathToGrandparent=:(5&}.)@:pathToNode

NB. Really ought to be built in as a form of evoke gerund...
composeGerund=:4 : '(x , (<@:((,''0'') ,&:< ])) y)`:6'

NB. These are UNDEFINED for nodes too high up the tree to have a gp/p/uncle
gp=:pathToGrandparent composeGerund ] NB. grandparent
parent=:pathToParent composeGerund ]
uncle=:[ (]`>)@.(*@:#@:>)@:({:@:]`({.@:])@.([ >: k@:])) gp

iRBcase1=:(BLACK&enc)@:iNoRepair
iRBcase2=:iNoRepair

enblackChildren=:(BLACK&enc&.>)@:({. , {:)
replaceChildren=:({.@:[ , 1 2 3&{@:] , {:@:[)
iRBcase3=:(k@:[ RED&enc@:(enblackChildren replaceChildren ])@:gp iNoRepair) ([ iRB (k@:[ dropBranch ]))

redSide=:I.@:(RED&=)@:>@:(c&.>)@:({. , {:) NB. 0 => left, 1 => right
selectRotation=:({&(]`rotl`rotr))@:(redSide@:parent (]`(0:)@.=) redSide@:(k@:parent gp ]))
rotatedParent=: 4 : '(((x (k@:[ selectRotation ]) y)`:6) (k x) parent y)'
rChildL=:<@:[ , }.@:]
rChildR=:}:@:] , <@:[
childReplacementSelector=:({&(rChildL`rChildR))@:(k@:[ redSide@:gp ])
iRBcase4step1=:4 : '(x rotatedParent y) (x childReplacementSelector y)`:6] (k x) gp y'
iRBcase4step2=:3 : '(({&(rotr`rotl))@:redSide y)`:6 (RED&enc)@:(enblackChildren replaceChildren ]) y'
iRBcase4=:([ iRBcase4step2@:iRBcase4step1 iNoRepair) i ((k@:[ k@:gp iNoRepair) dropBranch ])

iRB=:BLACK&enc@:((iRBcase4`iRBcase3@.(*./@:(RED&=)@:>@:(c&.>)@:({. , {:)@:((k@:[) gp iNoRepair)))`iRBcase2@.(k@:[ BLACK&=@:c@:parent iNoRepair)`iRBcase1@.(*./@:(a:&=)@:]))
