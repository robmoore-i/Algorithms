module Dijkstras where

import Data.List
import Data.Maybe

type Node   = Int
type Weight = Int
type Edge   = (Node, Node, Weight) -- (From, To, Weight)
type Graph  = [Edge] -- Graph is directed
type Path   = [Node] -- First element is start node, last element is end node

g1 :: Graph
g1 = [
      (0, 1, 1),
      (0, 4, 6),
      (0, 2, 3),
      (1, 2, 1),
      (1, 3, 3),
      (2, 0, 1),
      (2, 1, 1),
      (2, 3, 1),
      (3, 0, 3),
      (3, 4, 2),
      (4, 3, 1),
      (5, 2, 9)
     ]
            
g2 :: Graph
g2 = [
      (0, 1, 3),
      (0, 4, 1),
      (1, 2, 6),
      (1, 3, 1),
      (1, 5, 2),
      (3, 0, 4),
      (3, 2, 3),
      (3, 4, 2),
      (4, 0, 1),
      (4, 2, 2),
      (5, 2, 4)
     ]

nodes :: Graph -> [Node]
nodes edges
  = (sort . nub . concat) [[a, b] | (a, b, c) <- edges]
  
imminentPaths :: [Node] -> Graph -> [(Node, Node, Weight)]
imminentPaths nodes edges
  = (sort . concat) [[(a, b, c) | (a, b, c) <- edges, a == id] | id <- nodes]

shortestImminentPath :: [Node] -> Graph -> (Node, Node, Weight)
shortestImminentPath nodes []
  = (0, 0, -1)
shortestImminentPath nodes edges
  = minimum [(a, b, c) | (a, b, c) <- paths, c == minimumWeight]
  where
    paths = imminentPaths nodes edges
    minimumWeight = minimum [w | (_, _, w) <- paths]

allShortestPaths :: Node -> Graph -> [(Node, Weight)]
allShortestPaths id edges
  = fixLeftOuts ((0, 0) : allShortestPaths' id edges [(0, 0)] [0]) edges

allShortestPaths' :: Node -> Graph -> [(Node, Weight)] -> [Node] -> [(Node, Weight)]
allShortestPaths' id edges currentDistanceMatrix visitedNodes
  | (from, nextNode, x) == (0, 0, -1) = []
  | otherwise                         = nextPath : allShortestPaths' nextNode editedGraph newDistanceMatrix updatedVisitedNodes
  where
    (from, nextNode, x) = shortestImminentPath visitedNodes editedGraph
    nextNodeWeight      = x + (fromJust (lookup from currentDistanceMatrix))
    nextPath            = (nextNode, nextNodeWeight)
    editedGraph         = (removeIncomingEdges id edges)
    newDistanceMatrix   = (nextPath : currentDistanceMatrix)
    updatedVisitedNodes = (nextNode : visitedNodes)
    
removeIncomingEdges :: Node -> Graph -> Graph
removeIncomingEdges id edges
  = [edge | edge@(a, b, _) <- edges, b /= id]
  
findLeftOuts :: [(Node, Weight)] -> Graph -> [Node]
findLeftOuts shortestPaths edges
  = [x | x <- nodes edges, not (elem x includedNodes)]
  where
    includedNodes = [a | (a, b) <- shortestPaths]
    
fixLeftOuts :: [(Node, Weight)] -> Graph -> [(Node, Weight)]
fixLeftOuts shortestPaths edges
  = shortestPaths ++ [(x, -1) | x <- findLeftOuts shortestPaths edges] -- Unreachability indicated by -1
