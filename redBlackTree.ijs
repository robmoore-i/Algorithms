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

NB. Really ought to be built in as a form of evoke gerund...
composeGerund=:4 : '(x , (<@:((,''0'') ,&:< ])) y)`:6'

NB. These are UNDEFINED for nodes too high up the tree to have a gp/p/uncle
gp=:(5&}.)@:pathToNode composeGerund ] NB. grandparent
parent=:(3&}.)@:pathToNode composeGerund ]
uncle=:[ (]`>)@.(*@:#@:>)@:({:@:]`({.@:])@.([ >: k@:])) gp

iRBcase1=:(BLACK&enc)@:iNoRepair
iRBcase2=:iNoRepair

enblackChildren=:(BLACK&enc&.>)@:({. , {:)
replaceChildren=:({.@:[ , 1 2 3&{@:] , {:@:[)
iRBcase3=:(k@:[ RED&enc@:(enblackChildren replaceChildren ])@:gp iNoRepair) ([ iRB (k@:[ dropBranch ]))

iRB=:BLACK&enc@:(iRBcase3`iRBcase2@.(k@:[ BLACK&=@:c@:parent iNoRepair)`iRBcase1@.(*./@:(a:&=)@:]))
