// A heap is a binary tree with two properties:
// ORDER: All nodes have a value greater than or equal to that of it's children
// SHAPE:
//   All leaves at depth d or d-1
//   All leaves at depth d - 1 are to the right of the leaves at depth d
//   There is at most 1 node with 1 child, it is the left child of it's parent, it is the rightmost leaf at depth d

// Root @ 0 idx

p:{floor x%2} // parent
l:{1+2*x} // left child
r:{2+2*x} // right child

swap:{[a;i1;i2]
  a[(i1;i2)]:a[(i2;i1)];
  a}

hi:{[heap;n] // heap insert.
  size:count where not null heap;
  if[count heap=size;heap:heap,size#0N]; // double size if full
  heap[idx:size]:n;
  while[heap[idx]<heap[parent:p idx];
    heap:swap[heap;idx;parent];
    idx:parent];
  heap}

build:{[elements]hi/[1#elements;1_elements]}
  
  
