# Course: ENGR3520
# Author: Oliver Steele
# Date: 2016-10-01

def apply_op(op, a, b):
    """Helper function to actually do the arithmetic"""
    import operator
    ops = {'+': operator.add, '-': operator.sub, '*': operator.mul}
    return ops[op](a, b)

def calc_as_you_go(tokens):
    """As-you-go calculation (finite registers)

    >>> calc_as_you_go([1, '+', 2])
    3
    >>> calc_as_you_go([1, '+', 2, '*', 3])
    9
    >>> calc_as_you_go([3, '-', 1])
    2
    >>> calc_as_you_go([2, '*', 3, '+', 4])
    10
    >>> calc_as_you_go([4, '+', 2, '*', 3])
    18
    """

    n = tokens.pop(0)
    while tokens:
        op = tokens.pop(0)
        arg = tokens.pop(0)
        n = apply_op(op, n, arg)
    return n


print calc_as_you_go([5, '+', 4, "*", 3, "+", 2])

def calc_rpn(tokens):
    """Full RPN Calculator (uses a stack)
    >>> calc_rpn([1, 2, '+'])
    3
    >>> calc_rpn([2, 3, '+', 4, '*'])
    20
    >>> calc_rpn([2, 3, 4, '+', '*'])
    14
    """

    stack = []
    for x in tokens:
        if isinstance(x, str):
            arg2 = stack.pop()
            arg1 = stack.pop()
            n = apply_op(x, arg1, arg2)
            stack.append(n)
        else:
            stack.append(x)
    return stack[0]


print calc_as_you_go([5, 4, 3, 2 '+', "*", "+"])

def eval_tree(expr):
    """Full tree-walking infix calculator.

    >>> eval_tree([2, '*', [3, '+', 4]])
    14
    """
    if isinstance(expr, list):
        left_expr, op, right_expr = expr
        # recursively evaluate left and right children
        left, right = eval_tree(left_expr), eval_tree(right_expr)
        if op == '+':                   # NOTE:  could use apply-op here
            return left + right
        elif op == '-':
            return left - right
        elif op == '*':
            return left * right
        elif op == '/':
            return left / right
    else:
        return expr

def parse_parens(tokens):
    """Parse a list of tokens, with parentheses, into a tree, represented as a list of lists."""
    tree = []
    while tokens:
        token = tokens.pop(0)
        if token == '(':
            tree.append(parse_parens(tokens))
        elif token == ')':
            return tree
        else:
            tree.append(token)
    return tree

def eval_parens(tokens):
    """Evaluate an expression represented as a list of tokens, with parentheses.

    >>> eval_parens([2, '*', '(', 3, '+', 4, ')'])
    14
    """

    return eval_tree(parse_parens(tokens))
