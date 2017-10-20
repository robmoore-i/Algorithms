module Radix where

data Label = E | L Char           -- Epsilon | Label
  deriving (Show, Eq)
data Node = N [(Label, Node)] | T -- Node | Terminal
  deriving (Eq)

razeNewLine :: [String] -> String -- Raze with interspersed newlines
razeNewLine = foldl1 (\x y -> x ++ "\n" ++ y)

instance Show (Node) where
  show T = "T"
  show (N branches) = razeNewLine $ map (showBranch "") branches
    where
      showBranch :: String -> (Label, Node) -> String
      showBranch tabs (E, T)          = tabs ++ "E-T"
      showBranch tabs (L c, T)        = tabs ++ "L(" ++ [c] ++ ")-T"
      showBranch tabs (l, N branches) = tabs ++ (show l) ++ "\n" ++ (razeNewLine $ map (showBranch ("  " ++ tabs)) branches)

d :: (Label, Node)
d = (E, T)                        -- Done

insert :: Node -> [Char] -> Node
insert T []                = N [d]
insert n []                = n
insert T (c:cs)            = N [(L c, insert T cs)]
insert (N branches) (c:cs) =
  let l = L c in
  case lookup l branches of
    Nothing               -> N ((l, insert T cs) : branches)
    Just T                -> N [(l, insert T cs)]
    Just (N moreBranches) -> N (updateAssoc l (insert (N moreBranches) cs) branches)

createRadixTree :: [String] -> Node
createRadixTree = foldl insert T

updateAssoc :: Eq a => a -> b -> [(a, b)] -> [(a, b)]
updateAssoc key newVal [] = []
updateAssoc key newVal ((k, v) : rest) =
  if key == k
  then (k, newVal) : rest
  else (k, v) : updateAssoc key newVal rest

