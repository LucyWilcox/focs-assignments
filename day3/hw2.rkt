#lang racket

;;; Student Name: Lucy Wilcox
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [x] I completed this assignment with assistance from ___
;;;     and/or using these external resources:
;;;        Scheme in one page
;;;        Looked at my last weeks homework some

;;; 1.  Create a calculator that takes one argument: a list that represents an expression.


(define (calculate-1 x)
  (cond [(eq? (first x) 'ADD)
         (+ (first(rest x)) (second(rest x)))]
        [(eq? (first x) 'SUB)
         (- (first(rest x)) (second(rest x)))]
        [(eq? (first x) 'MUL)
         (* (first(rest x)) (second(rest x)))]
        [(eq? (first x) 'DIV)
         (/ (first(rest x)) (second(rest x)))]))

(calculate-1 '(ADD 3 4)) ;; --> 7
(calculate-1 '(SUB 3 4)) ;; --> -1
(calculate-1 '(MUL 3 4)) ;; --> 12
(calculate-1 '(DIV 3 4)) ;; --> 3/4


;;; 2. Expand the calculator's operation to allow for arguments that are themselves well-formed arithmetic expressions.

(define (calculate-2 x)
  (cond [(number?  x)
          x]
        [(eq? (first x) 'ADD)
         (+ (calculate-2(first(rest x))) (calculate-2(second(rest x))))]
        [(eq? (first x) 'SUB)
         (- (calculate-2(first(rest x))) (calculate-2(second(rest x))))]
        [(eq? (first x) 'MUL)
         (* (calculate-2(first(rest x))) (calculate-2(second(rest x))))]
        [(eq? (first x) 'DIV)
         (/ (calculate-2(first(rest x))) (calculate-2(second(rest x))))]))


(calculate-2 '(ADD 3 (MUL 4 5))) ;; --> 23   ;; what is the equivalent construction using list? See next line
(calculate-2 (list 'ADD 3 (list 'MUL 4 5)))
(calculate-2 '(SUB (ADD 3 4) (MUL 5 6))) ;; --> -23
(calculate-2 '(ADD (ADD 3 4) (ADD 5 6))) ;; --> 18
(calculate-2 '(ADD (ADD 3 4) (ADD 5 (ADD 3 3)))) ;; --> 18

;;; 3. Add comparators returning booleans (*e.g.*, greater than, less than, …).
;; Note that each of these takes numeric arguments (or expressions that evaluate to produce numeric values),
;; but returns a boolean.  We suggest operators `GT`, `LT`, `GE`, `LE`, `EQ`, `NEQ`.

(define (calculate-3 x)
  (cond [(number?  x)
          x]
        [(eq? (first x) 'ADD)
         (+ (calculate-3(first(rest x))) (calculate-3(second(rest x))))]
        [(eq? (first x) 'SUB)
         (- (calculate-3(first(rest x))) (calculate-3(second(rest x))))]
        [(eq? (first x) 'MUL)
         (* (calculate-3(first(rest x))) (calculate-3(second(rest x))))]
        [(eq? (first x) 'DIV)
         (/ (calculate-3(first(rest x))) (calculate-3(second(rest x))))]
        [(eq? (first x) 'GT)
         (> (calculate-3(first(rest x))) (calculate-3(second(rest x))))]
        [(eq? (first x) 'LT)
         (< (calculate-3(first(rest x))) (calculate-3(second(rest x))))]
        [(eq? (first x) 'GE)
         (>= (calculate-3(first(rest x))) (calculate-3(second(rest x))))]
        [(eq? (first x) 'LE)
         (<= (calculate-3(first(rest x))) (calculate-3(second(rest x))))]
        [(eq? (first x) 'EQ)
         (= (calculate-3(first(rest x))) (calculate-3(second(rest x))))]
        [(eq? (first x) 'NEQ)
         (not(= (calculate-3(first(rest x))) (calculate-3(second(rest x)))))]))

(calculate-3 '(GT (ADD 3 4) (MUL 5 6))) ;; --> #f
(calculate-3 '(LT (ADD 3 4) (MUL 5 6))) ;; --> #t
(calculate-3 '(LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6))))) ;; --> #t
(calculate-3 '(EQ (ADD 3 4) (ADD 6 1))) ;; --> #t
(calculate-3 '(NEQ (ADD 3 4) (ADD 6 1))) ;; --> #f

;;; 4. Add boolean operations ANND, ORR, NOTT

(define (calculate-4 x)
  (cond [(number?  x)
          x]
        [(eq? (first x) 'ADD)
         (+ (calculate-4(first(rest x))) (calculate-4(second(rest x))))]
        [(eq? (first x) 'SUB)
         (- (calculate-4(first(rest x))) (calculate-4(second(rest x))))]
        [(eq? (first x) 'MUL)
         (* (calculate-4(first(rest x))) (calculate-4(second(rest x))))]
        [(eq? (first x) 'DIV)
         (/ (calculate-4(first(rest x))) (calculate-4(second(rest x))))]
        [(eq? (first x) 'GT)
         (> (calculate-4(first(rest x))) (calculate-4(second(rest x))))]
        [(eq? (first x) 'LT)
         (< (calculate-4(first(rest x))) (calculate-4(second(rest x))))]
        [(eq? (first x) 'GE)
         (>= (calculate-4(first(rest x))) (calculate-4(second(rest x))))]
        [(eq? (first x) 'LE)
         (<= (calculate-4(first(rest x))) (calculate-4(second(rest x))))]
        [(eq? (first x) 'EQ)
         (= (calculate-4(first(rest x))) (calculate-4(second(rest x))))]
        [(eq? (first x) 'NEQ)
         (not(= (calculate-4(first(rest x))) (calculate-4(second(rest x)))))]
        [(eq? (first x) 'ANND)
         (and (calculate-4(first(rest x))) (calculate-4(second(rest x))))]
        [(eq? (first x) 'ORR)
         (or (calculate-4(first(rest x))) (calculate-4(second(rest x))))]
        [(eq? (first x) 'NOTT)
         (not (calculate-4(rest x)))]))

(calculate-4 '(AND (GT (ADD 3 4) (MUL 5 6)) (LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6)))))) ;; --> #f
(calculate-4 '(ORR (EQ (ADD 3 4) (ADD 6 1)) (NEQ (ADD 3 4) (ADD 6 1)))) ;; --> #t
(calculate-4 '(NOTT(ORR (EQ (ADD 3 4) (ADD 6 1)) (NEQ (ADD 3 4) (ADD 6 1))))) ;; --> #f

;;; 5. Add IPH

(define (calculate-5 x)
  (cond [(number?  x)
          x]
        [(eq? (first x) 'ADD)
         (+ (calculate-5(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) 'SUB)
         (- (calculate-5(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) 'MUL)
         (* (calculate-5(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) 'DIV)
         (/ (calculate-5(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) 'GT)
         (> (calculate-5(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) 'LT)
         (< (calculate-5(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) 'GE)
         (>= (calculate-5(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) 'LE)
         (<= (calculate-5(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) 'EQ)
         (= (calculate-5(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) 'NEQ)
         (not(= (calculate-5(first(rest x))) (calculate-5(second(rest x)))))]
        [(eq? (first x) 'ANND)
         (and (calculate-5(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) 'ORR)
         (or (calculate-5(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) 'NOTT)
         (not (calculate-5(rest x)))]
        [(eq? (first x) 'IPH)
         (cond [(eq? (calculate-5(first(rest x))) #t)
                (calculate-5(second(rest x)))]
               [(eq? (calculate-5(first(rest x))) #f)
                (calculate-5(second(rest(rest x))))])]))

(calculate-5 '(IPH (GT (ADD 3 4) 7) (ADD 1 2) (ADD 1 3))) ;; -> 4
(calculate-5 '(IPH (GE (ADD 3 4) 7) (ADD 1 2) (ADD 1 3))) ;; -> 3


;;; 6. Not totally sure if this is what you mean by spelling that is more like scheme's,
;;; it this seems to simple for a challenge question, but here's a go at it.

(define (calculate-6 x)
  (cond [(number?  x)
          x]
        [(eq? (first x) '+)
         (+ (calculate-6(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) '-)
         (- (calculate-6(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) '*)
         (* (calculate-6(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) '/)
         (/ (calculate-6(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) '>)
         (> (calculate-6(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) '<)
         (< (calculate-6(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) '>=)
         (>= (calculate-6(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) '<=)
         (<= (calculate-6(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) '=)
         (= (calculate-6(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) '!=)
         (not(= (calculate-6(first(rest x))) (calculate-5(second(rest x)))))]
        [(eq? (first x) 'and)
         (and (calculate-6(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) 'or)
         (or (calculate-6(first(rest x))) (calculate-5(second(rest x))))]
        [(eq? (first x) 'not)
         (not (calculate-6(rest x)))]
        [(eq? (first x) 'if)
         (cond [(eq? (calculate-6(first(rest x))) #t)
                (calculate-6(second(rest x)))]
               [(eq? (calculate-6(first(rest x))) #f)
                (calculate-6(second(rest(rest x))))])]))

(calculate-6 '(if (> (+ 3 4) 7) (+ 1 2) (+ 1 3))) ;; -> 4