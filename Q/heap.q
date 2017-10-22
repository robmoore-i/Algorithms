// A heap is a binary tree with two properties:
// ORDER: All nodes have a value greater than or equal to that of it's children
// SHAPE:
//   All leaves at depth d or d-1
//   All leaves at depth d - 1 are to the right of the leaves at depth d
//   There is at most 1 node with 1 child, it is the left child of it's parent, it is the leftmost leaf at depth d

// Root @ 0 idx

.heap.p:{floor x%2} // parent

.heap.swap:{[a;i1;i2]
  a[(i1;i2)]:a[(i2;i1)];
  a}

.heap.size:{[heap]sum not null heap}

.heap.hi:{[heap;n] // heap insert.
  size:.heap.size heap;
  if[count heap=size;heap:heap,size#0N]; // double size if full
  heap[idx:size]:n;
  while[heap[idx]<heap[parent:.heap.p idx];
    heap:.heap.swap[heap;idx;parent];
    idx:parent];
  heap}

.heap.build:{[elements].heap.hi/[1#elements;1_elements]}

.heap.pop:{[heap]
  r:heap[0];
  (r;.heap.pd heap)}

.heap.children:{[heap;idx]heap[1 2 + 2*idx]}

.heap.minChildIdx:{[heap;pIdx].[>;.heap.children[heap;pIdx]]+1+2*pIdx}

.heap.leaf:{[heap;idx]all 0N=.heap.children[heap;idx]}

.heap.pd:{[heap] // percolating down
  heap[idx:0]:0N;
  while[not .heap.leaf[heap;idx];
    mIdx:.heap.minChildIdx[heap;idx];
    heap:.heap.swap[heap;mIdx;idx];
    idx:mIdx]
  next heap}
