\l heap.q

.pq.init:{pq::enlist 0N}
.pq.add:{pq::.heap.hi[$[0=count pq;enlist 0N;pq];x]}
.pq.pop:{
  popped:.heap.pop[pq];
  pq::popped[1];
  popped[0]}
