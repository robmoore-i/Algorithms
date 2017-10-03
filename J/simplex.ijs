NB. The algorithm gives a strictly minimising solution,
NB.   so maximisation problems must have their objective
NB.   function negated to move them into standard form.

basicCols=:I.@:((|.@:(0&=)@:i.@:{.@:$) *./@:="1 ((/:~)"1@:|:))
freeCols=:(i.@:<:@:{:@:$ -. basicCols)
pivot=:[ - (({"1~ {:) - {.@] = i.@#@[) */ ({~ {.) % ({~ <)

pivotColIdx=:{.@:(I.@:(<./ = ])@:(<@:(0&;)@:freeCols { ]) { freeCols)
pivotCol=:{"1~ pivotColIdx
zeroes=:(#&0@:#@:])
positivePivotIdxs=:(I.@:,@:(0&<)@:pivotCol@:])
maximumDeltaPivot=:(<./ = ])@:%~/@:(I.@:,@:(0&<)@:pivotCol {"1 ,@:pivotCol ,: ,@:({:"1))@:]
pivotRowIdx=:{.@:I.@:(''&(maximumDeltaPivot`positivePivotIdxs`zeroes}))

notOptimal=:1: - *./@:(0&<:)@:}.@:}:@:(0&{)
simplexIterate=:(] pivot (pivotRowIdx , pivotColIdx))
fromStandardForm=:({.@:{. , }.@:-@:{.) , }.
NB. simplex M - Objective row must be on the top, the constraint rows then follow.
simplex=:fromStandardForm@:(simplexIterate^:notOptimal^:_)