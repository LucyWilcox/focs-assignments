'''
#1
Changed the original code to add Node class, with parent
and simplify by using a list as a queue.

'''

class Node: 
  def __init__(self, cargo=None, successors=[]): 
    self.cur = cargo 
    self.successors = successors
    self.parent = None   

  def __str__(self): 
    return str(self.cur)

  def add_parent(self, parent):
    self.parent = parent


def bfs(start):
    """Graph breadth-first search.

    1. create a sequence that contains only node a
    2. until the collection is empty:
    3.    remove node n from the head of the sequence and visit it
    4.
    5. to visit a node:
    6.    add unvisited adjacent nodes to the tail of the sequence"""

    remaining_nodes = [start]
    visited = set()

    def visit(node):
        print(node)
        visited.add(node)
        for tail in node.successors:
            if tail not in visited:
                remaining_nodes.append(tail)
                visited.add(tail)
                tail.add_parent(node)

    while not len(remaining_nodes) == 0:
        n = remaining_nodes.pop(0)
        visit(n)
    
n4 = Node('D')
n3 = Node('C', [n4])
n2 = Node('B', [n3, n4])
n5 = Node('Q')
n1 = Node('A', [n2, n5])

bfs(n1)
