empty_tree=:'';_1

c=:2&}.        NB. children - 'c tree'
ill=:({."1)@:> NB. immediate link labels - 'il tree'
lls=:>@:(#&.>)@:ill@:c NB. label lengths
pl=:>@:(#&.>) NB. Path lengths

pfc=:pl@:ill@:c@:] $&.> <@:[ NB. prep for comparison - 'suffix pfc tree'
mli=:I.@:(s:@:pfc = s:@:ill@:c@:]) NB. (first) matching leaf index - 'suffix mli tree'
fl=:([`(({.@:(mli >@:{ c@:]))~))@.((# > 2:)@:[) NB. follow link - 'tree fp suffix'
nextSuffix=:(#@:>@:{.@:[ }. ]) NB. 'followedPath nextSuffix suffix
nextNode=:((2#a:)&,)@:<@:[
fp=:((fl (nextNode $: nextSuffix) ])`[)@.(#@:[ <: 2:) NB. follows links until there's no more. - 'tree fp suffix'

NB. Examples
xabxa=:'';_1;('bxa$';2);('$$';5);('a';4;(<'bxa$';1));(<'xa';3;(<'bxa$';0))
implicit_xabxa=:'';_1;('bxa';2);('a';'bxa';1);(<'xa';'bxa';0)

(implicit_xabxa fp 'xa')    shouldEqual ('bxa';0)
(implicit_xabxa fp 'bxa')   shouldEqual <2
(implicit_xabxa fp 'abxa')  shouldEqual <1
(implicit_xabxa fp 'xabxa') shouldEqual <0
