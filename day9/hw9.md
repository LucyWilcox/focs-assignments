# FOCS Homework 9, for Day 10

You may edit your answers into this file, or add a separate file in the same directory.

If you add a separate file, please include the following at the top:

```
Student Name: Lucy Wilcox
Check one:
[ ] I completed this assignment without assistance or external resources.
[x] I completed this assignment with assistance from ___
   and/or using these external resources:
   Sipser's book
```

## 1. Reading

Read Sipser pp. 101–125. (This was the optional reading for today. It is required for Monday.)

## 2. Constructing Grammars

Construct a Context Free Grammar for each of the following languages.

a) All strings (over {0,1}) consisting of a substring _w_ followed by its reverse. (This is the same problem you were asked to work on in class.)

S -> 0S0 | 1S1 | e

Give a derivation for `010010`.

S -> 0S0 -> 01S10 -> 010S010 -> 010e010 -> 010010

b) All strings (over {a,b,c}) of the form a^{i}b^{i}c^{j}: an equal number of `a`s and `b`s, followed by any number of `c`s. For example, `aabb`, `aabbcc`, and `aabbcccc`, but not `aaaabbcc`.

S -> S1S2

S1 -> aS1b | e

S2 -> c | e

c) All strings (over {a,b,c}) of the form a^{i}b^{j}c^{j}: any number of `a`s, followed by an equal number of `b`s and `c`s. For example, `abbcc`, `aabbcc`, and `aaaabbcc`, but not `aabbccc`.

S -> S1S2

S1 -> aS1 | e

S2 -> bS2c | e

d) Give two distinct grammars that produce the strings described by the regular expression `(ab)*`: empty, `ab`, `abab`, `ababab`, ….

S -> abS | e

or 

S -> S1S2 | e

S1 -> a

S2 -> b | bS

## 4. Ambiguous Grammars

Consider the grammar:

    S --> a S | a S b S | epsilon 

This grammar is ambiguous. Show in particular that the string `a a b` has
two:

a. ![parse trees](parsetree.jpg)

b. leftmost derivations (These are the ones that, starting from the start variable, rewrite the leftmost nonterminal first.)

S -> aS -> aaSbS -> aabS -> aab

S -> aSbS -> aaSbS -> aabS -> aab

c. rightmost derivations (These are the ones that, starting from the start variable, rewrite the rightmost nonterminal first.)

S -> aS -> aaSbS -> aaSb -> aab

S -> aSbS -> aSb -> aaSb -> aab

Extra Credit/Challenge: Prove that this grammar generates all and only the strings of `a`s and `b`s such that every prefix has at least as many `a`s as `b`s. **Hint: Do the readings!**

## 5. [Optional] Play with Prolog

Read the page and download the sample files from [here](https://sites.google.com/site/focs16fall/prolog).

Warning: your instructor was unable to get these to reliably run today, and some of the instructions are from memory of when it previously worked. Your mileage may vary.
