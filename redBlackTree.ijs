projects_home=:> (<1 1){UserFolders_j_
load projects_home,'/Algorithms/binarySearchTree.ijs'

rotl=:<@:(''&({.@:>@:{:@:]`(<:@:#@:])`]})) , }.@:>@:{: NB. rotate left
rotr=:}:@:>@:{. , <@:(''&({:@:>@:{.@:]`0:`]})) NB. rotate right
enc=:}:@:] , <@:[ , {:@:] NB. encolour
c=:>@:(3&{) NB. colour
RED=:s:<'RED'
BLACK=:s:<'BLACK'
iNoRepair=:(RED&enc)@:[ i ] NB. insert without repair

pathToNodeInstructions=:(([: < '{.'"1) , [ $: >@:{.@:])`([: < ']'"1)`(([: < '{:'"1) , [ $: >@:{:@:])@.(>:@:*@:(- k))`('notfound'"1)@.(#@:] <: 1:)
pathToNode=:|.@:}:@:,@:([ ,"0 <@:])&'>'@:pathToNodeInstructions

NB. Really ought to be built in as a form of evoke gerund...
composeGerund=:4 : '(x , (<@:((,''0'') ,&:< ])) y)`:6'

gp=:(5&}.)@:pathToNode composeGerund ] NB. grandparent
uncle=:[ >@:(({:@:])`({.@:])@.([ >: k@:])) gp NB. uncle

NB. EXAMPLE TREE
tree=:25 19 21 9 12 4 3 _4 2 5 p 'abcdefghij'

