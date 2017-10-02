#include "suffix_tree.h"
#include <stdbool.h>
#include <stdlib.h>

struct node {
    int idx;
    int nOutgoing;
    struct edge* outgoing[];
    int nIncoming;
    struct edge* incoming[];
};

struct edge {
    char label[];
    struct node* src;
    struct node* dst;
};

bool is_leaf(struct node* node) {
    return (-1 == node->idx);
}

bool has_path(struct node *root, char extension) {
    int nOutgoing = root->nOutgoing;
    struct edge** outgoing = (struct edge **) root->outgoing;
    for (int i = 0;i < nOutgoing;i++) {
        struct edge* e = outgoing[i];
        if (extension == (e->label)[0]) {
            return true;
        }
    }
    return false;
}

struct node* follow_path(struct node *root, char *suffix) {
}

struct node* suffix_extend(struct node* root, char suffix[], char extension) {
    struct node* end_of_path = follow_path(root, suffix);
    if (is_leaf(end_of_path)) {
        // CASE 1
    } else if (has_path(end_of_path, extension)) {
        // CASE 2
    } else {
        // CASE 3
    }
}

