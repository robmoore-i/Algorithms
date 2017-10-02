kv=:(a:"1 , ] , a:"1)@:(; s:@:<) NB. key-value pair - 'key kv value'
k=:>@:(1&{) NB. key
v=:>@:(2&{) NB. value
i=:(<@:([ $: >@:{.@:]) , }.@:])`(}:@:] , <@:([ $: >@:{:@:]))@.(>:&k)`[@.(#@:] <: 1:) NB. insert - '(key kv value) i tree'
s=:([ $: >@:{.@:])`(v@:])`([ $: >@:{:@:])@.(>:@:*@:(- k))`('notfound'"1)@.(#@:] <: 1:) NB. search - 'key s tree'
p=:[: i/ kv"0 NB. populate - 'keys p values'

minRightNode=:1 2&{@:(>`]@.(*@:<:@:#))@:({.^:(-.@:(=&a:)@:{.)^:_)@:>@:{: NB. min node in right subtree
dme2children=:(}: , <@:(k d >@:{:))@:(''&(minRightNode@:]`(1 2"1)`]})) NB. delete me case for 2 children
dme=:>@:(a:"1)`((3: - i.&a:) >@:{ ])`dme2children@.(2: - +/@:(=&a:)) NB. delete me
d=:(<@:([ $: >@:{.@:]) , }.@:])`(dme@:])`(}:@:] , <@:([ $: >@:{:@:]))@.(>:@:*@:(- k))`(''"1)@.(#@:] <: 1:) NB. delete - 'key d tree'
dropBranch=:(<@:([ $: >@:{.@:]) , }.@:])`(a:"1)`(}:@:] , <@:([ $: >@:{:@:]))@.(>:@:*@:(- k))`[@.(#@:] <: 1:)
