#include <stdbool.h>

#ifndef C_SUFFIX_TREE_H
#define C_SUFFIX_TREE_H

struct node* suffix_extend(struct node*, char[], char);
struct node* follow_path(struct node *, char *);
bool has_path(struct node *, char);
bool is_leaf(struct node*);

#endif
