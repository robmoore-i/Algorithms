// A heap is a binary tree with two properties:
// ORDER: All nodes have a value greater than or equal to that of it's children
// SHAPE:
//   All leaves at depth d or d-1
//   All leaves at depth d - 1 are to the right of the leaves at depth d
//   There is at most 1 node with 1 child, it is the left child of it's parent, it is the leftmost leaf at depth d

// Root @ 0 idx

p:{floor x%2} // parent

swap:{[a;i1;i2]
  a[(i1;i2)]:a[(i2;i1)];
  a}

hi:{[heap;n] // heap insert.
  size:sum not null heap;
  if[count heap=size;heap:heap,size#0N]; // double size if full
  heap[idx:size]:n;
  while[heap[idx]<heap[parent:p idx];
    heap:swap[heap;idx;parent];
    idx:parent];
  heap}

build:{[elements]hi/[1#elements;1_elements]}

pop:{[heap]
  r:heap[0];
  (r;pd heap)}

children:{[heap;idx]heap[1 2 + 2*idx]}

minChildIdx:{[heap;parentIdx].[>;children[heap;parentIdx]]+1+2*parentIdx}

leaf:{[heap;idx]all 0N=children[heap;idx]}

pd:{[heap] // percolating down
  heap[idx:0]:0N;
  while[not leaf[heap;idx];
    mIdx:minChildIdx[heap;idx];
    heap:swap[heap;mIdx;idx];
    idx:mIdx]
  next heap}
