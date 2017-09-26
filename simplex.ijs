rowOp =: 1 : 0
:
  (x ({ u) y) (x}) y
)

NB. Example
M=:3 7 $ 1 2 3 4 0 0 0 0 3 2 1 1 0 10 0 2 5 3 0 1 15

basicCols=:I.@:((|.@:(0&=)@:i.@:{.@:$) *./@:="1 ((/:~)"1@:|:))
freeCols=:(i.@:<:@:{:@:$ -. freeCols)
pivot=:[ - (({"1~ {:) - {.@] = i.@#@[) */ ({~ {.) % ({~ <)

pivotColIdx=:I.@:(<./ = ])@:(0&{)
pivotRowIdx=:I.@:(''&((<./ = ])@:%~/@:(I.@:,@:(0&<)@:pivotCol {"1 |:@:pivotCol , {:"1)@:]`(I.@:,@:(0&<)@:pivotCol@:])`(#&0@:#@:])}))

isOptimal=:*./@:(0&<:)@:}.@:}:@:(0&{)

simplexIterate=:(] pivot (pivotRowIdx , pivotColIdx))
