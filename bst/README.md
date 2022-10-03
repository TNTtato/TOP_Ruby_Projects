# Binary Search Tree

For this project, I implemented a Binary Search Tree (BST).

The idea is to build a balanced BST from an array of values. Each time an insertion or a deletion is performed, the #balanced? is called, and it evaluates if the tree is in balance, if not, the #rebalance is called. This method uses a level order traversal algorithm to store all the existing nodes in an array, and then performs a reconstruction of the tree, this time, balanced.