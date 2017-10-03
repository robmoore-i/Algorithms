module Kruskals where

import Data.List

type Node   = Int
type Weight = Int
type Edge   = (Node, Node, Weight) -- (node A, node B, Weight)
type Graph  = [Edge] -- Graph is undirected

g1 :: Graph
g1 = [
      (0, 1, 1),
      (0, 2, 2),
      (0, 3, 4),
      (0, 4, 6),
      (1, 2, 1),
      (1, 3, 3),
      (2, 3, 1),
      (2, 5, 9),
      (3, 4, 2)
     ]
     
g2 :: Graph
g2 = [
      (0, 1, 1),
      (1, 3, 4),
      (1, 5, 2),
      (2, 3, 2),
      (2, 7, 1),
      (3, 4, 3),
      (3, 6, 1),
      (6, 7, 2)
     ]

nodes :: Graph -> [Node]
nodes edges
  = (sort . nub . concat) [[a, b] | (a, b, w) <- edges]

orderEdges :: Graph -> Graph
orderEdges edges
  = sort (map (\(a, b, w) -> (w, a, b)) edges)

shortestEdge :: Graph -> Edge
shortestEdge edges
  = (\(w, a, b) -> (a, b, w)) (minimum (orderEdges edges))
  
additionOfEdgeCausesCycle :: Graph -> Edge -> Bool
additionOfEdgeCausesCycle edges (toAdd, alreadyIn, _weight)
  = any (isConnected edges alreadyIn) (imminentNodes [toAdd] edges)
  
imminentPaths :: [Node] -> Graph -> [Edge]
imminentPaths nodes edges
  = (sort . concat) [[(a, b, w) | (a, b, w) <- edges, a == id || b == id] | id <- nodes]
  
imminentNodes :: [Node] -> Graph -> [Node]
imminentNodes nodes edges 
  = nub (concatMap (\(a, b, w) -> [a, b]) (imminentPaths nodes edges))

isConnected :: Graph -> Node -> Node -> Bool
isConnected edges a b
  = elem b (traverse edges a [a])
  
traverse :: Graph -> Node -> [Node] -> [Node]
traverse edges start visitedNodes
  | null unvisitedImminentNodes = [start]
  | otherwise  = start : traverse edges nextNode (nextNode : visitedNodes)
  where
    possibleNextNodes      = imminentNodes visitedNodes edges
    unvisitedImminentNodes = [id | id <- possibleNextNodes, not (elem id visitedNodes)]
    nextNode = minimum unvisitedImminentNodes

minimumConnector :: Graph -> (Graph, Weight)
minimumConnector edges
  = (minimumSpanningGraph, totalWeight minimumSpanningGraph)
  where
    minimumSpanningGraph = minimumConnector' edges []

minimumConnector' :: Graph -> Graph -> Graph
minimumConnector' availableEdges currentEdges
  | null availableEdges = []
  | edgeIsAppropriate   = nextRecursion
  | otherwise           = candidateEdge : nextRecursion
  where
    candidateEdge     = shortestEdge availableEdges
    edgeIsAppropriate = additionOfEdgeCausesCycle currentEdges candidateEdge
    removeUsedEdge    = (removeEdge availableEdges candidateEdge)
    updatedGraph      = (candidateEdge : currentEdges)
    nextRecursion     = minimumConnector' removeUsedEdge updatedGraph
     
removeEdge :: Graph -> Edge -> Graph
removeEdge edges removeMe
  = [edge | edge <- edges, edge /= removeMe]
  
totalWeight :: Graph -> Weight
totalWeight edges
  = sum [w | (a, b, w) <- edges]






