# FOCS Homework for Day 9

You may edit your answers into this file, or add a separate file in the same directory.

If you add a separate file, please include the following at the top:

```
Student Name: Lucy Wilcox
Check one:
[ ] I completed this assignment without assistance or external resources.
[X] I completed this assignment with assistance from Nora
   and/or using these external resources: 
   http://www.jflap.org/tutorial/pda/construct/
```

## 1. For each of the following languages, decide whether it is regular

For each of the following languages, decide whether it is regular.  If it is regular, give a regular expression or finite automaton that recognizes the language.  If it is not regular, demonstrate that using the pumping lemma.

a) Strings containing only the symbol a whose length is a power of 2 (*i.e.* length 2^n)

[The strings `a`, `aa`, `aaaa`, and `aaaaaaaa` are in this language; the string `aaaaa` is not.]

Answer:
This is not a regular language. A pumping lemma which proves this is starting with the string `a', which is in the language. We will loop with this one charecter. It can be looped 5 times giving the string 5, which is not in language. Therefore it is not a regular language.

b) All strings with an equal number of occurrences of the substrings `01` and `10`.

[010 is in this language; `000110` is in the language; `0101010` is in the language; but `010101` is not.]

Answer:
This is a regular language. See finite automation image 1b.

c) All strings (over {0,1}) consisting of a substring _w_ followed by the reverse of the substring.

[The strings `00100100` and `11110101011010101111` are in this language; the strings `00100` and `010101 `are not.]

Answer:
This is not a regular language. If I take the string 0110 and loop over 01 one addition time I will get 010110 which is not symmetrical.

## 2. Play the pumping game

Play the **pumping game** (referenced on the [Day 8 page](https://sites.google.com/site/focs16fall/in-class-exercises/day-8) and also found at [http://weitz.de/pump/](http://weitz.de/pump/)).  Solve at least two puzzles from that page (that do NOT appear in question 1, above) and provide the word you chose, the substring the computer chose, and your successfully pumped string.

Notation notes:

- The notation |w| sub a means the number of `a`'s in the word _w_.
- _a_^_n_ means _n_ occurrences of `a` (e.g. _a_^8 is `aaaaaaaa`)

If you have other questions about notation (or anything else), please post them to [Piazza](https://piazza.com) so that we can clarify for everyone.

Answer:

Excerise 8:
My word: a15
Highlighted part: the first 11 a's
The computer's sub-string: the first 3 a's
My pumped string: aaaaaaaaaaaaaaaa that's a16, or one loop of the 3 a's

Excerise 2:
My word: aaabbb
Highlighted part: aaabb
The computer's sub-string: the last a
My pumped string: aaaabbb, that's one loop of the last a to make 4 a's

## 3. Create a PDA

For one of the non-regular languages in problem 1 or 2 above, create a PDA (preferably in JFLAP) and include it with your completed homework.

Answer:
See image 3.

## 4. Reading

Optionally read Sipser pp. 101–125.

Optionally read Stuart pp. 128–134.

## 5. Install gprolog

Please download and install [gprolog](http://www.gprolog.org) before coming to class:

**Ubuntu**:

	$ sudo apt-get install gprolog

**Mac**, with [Homebrew](http://brew.sh) installed:

	$ brew install gnu-prolog

**Mac** without Homebrew, and **Windows**:

- Follow the instructions at [http://www.gprolog.org/#download](http://www.gprolog.org/#download).
