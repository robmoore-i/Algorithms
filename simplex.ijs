basicCols=:I.@:((|.@:(0&=)@:i.@:{.@:$) *./@:="1 ((/:~)"1@:|:))
freeCols=:(i.@:<:@:{:@:$ -. basicCols)
pivot=:[ - (({"1~ {:) - {.@] = i.@#@[) */ ({~ {.) % ({~ <)

pivotColIdx=:{.@:(I.@:(<./ = ])@:(<@:(0&;)@:freeCols { ]) { freeCols)
pivotCol=:{"1~ pivotColIdx
pivotRowIdx=:I.@:(''&((<./ = ])@:%~/@:(I.@:,@:(0&<)@:pivotCol {"1 ,@:pivotCol ,: ,@:({:"1))@:]`(I.@:,@:(0&<)@:pivotCol@:])`(#&0@:#@:])}))

notOptimal=:-.@:*./@:(0&<:)@:}.@:}:@:(0&{)
simplexIterate=:(] pivot (pivotRowIdx , pivotColIdx))
simplex=:simplexIterate@:(simplexIterate^:notOptimal^:_)