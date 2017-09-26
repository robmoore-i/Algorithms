basicCols=:I.@:((|.@:(0&=)@:i.@:{.@:$) *./@:="1 ((/:~)"1@:|:))
freeCols=:(i.@:<:@:{:@:$ -. basicCols)
pivot=:[ - (({"1~ {:) - {.@] = i.@#@[) */ ({~ {.) % ({~ <)

pivotColIdx=:{.@:(I.@:(<./ = ])@:(<@:(0&;)@:freeCols { ]) { freeCols)
pivotCol=:{"1~ pivotColIdx
zeroes=:(#&0@:#@:])
positivePivotIdxs=:(I.@:,@:(0&<)@:pivotCol@:])
maximumDeltaPivot=:(<./ = ])@:%~/@:(I.@:,@:(0&<)@:pivotCol {"1 ,@:pivotCol ,: ,@:({:"1))@:]
pivotRowIdx=:I.@:(''&(maximumDeltaPivot`positivePivotIdxs`zeroes}))

notOptimal=:1: - *./@:(0&<:)@:}.@:}:@:(0&{)
simplexIterate=:(] pivot (pivotRowIdx , pivotColIdx))
simplex=:simplexIterate^:notOptimal^:_