module Radix where

data Label = E | L Char           -- Epsilon | Label
  deriving (Show, Eq)
data Node = N [(Label, Node)] | T -- Node | Terminal
  deriving (Show, Eq)

d :: (Label, Node)
d = (E, T)                        -- Done

insert :: [Char] -> Node -> Node
insert [] T                = N [d]
insert [] n                = n
insert (c:cs) T            = N [(L c, insert cs T)]
insert (c:cs) (N branches) =
  let l = L c in
  case lookup l branches of
    Nothing               -> N ((l, insert cs T) : branches)
    Just T                -> N [(l, insert cs T)]
    Just (N moreBranches) -> N (update l (insert cs (N moreBranches)) branches)

updateNode :: Label -> Node -> [(Label, Node)] -> Node
updateNode label node branches = N (update label node branches)

update :: Eq a => a -> b -> [(a, b)] -> [(a, b)]
update key newVal [] = []
update key newVal ((k, v) : rest) =
  if key == k
  then (k, newVal) : rest
  else (k, v) : update key newVal rest

