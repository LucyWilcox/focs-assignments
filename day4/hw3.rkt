#lang racket

;;; Student Name: Lucy Wilcox
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [x] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___
;;;          https://docs.racket-lang.org/reference/symbols.html
;;;          Scheme in one page
;;;;;;;;;;;
;; 1. assq

;; `assq` is a function that takes a key and an association list.
;;
;; It returns the corresponding key/value pair from the list
;; (*i.e.*, the pair whose key is *eq?* to the one it is given).
;;
;; If the key is not found in the list, `assq` returns `#f`.


(define (assq key alst)
  (cond [(empty? alst) #f]
        [(eq? key (first(first alst))) (first(rest(first alst)))]
        [else (assq key (rest alst))]))


(display (assq "hello2" '(("hello" 5) ("hello2" 6))))(newline); --> 6
(display (assq "m"  '(("hello" 5) ("hello2" 6))))(newline) ; --> #f


;;;;;;;;;;;
;; 2. lookup-list

;; Add the ability to look up symbols to your evaluator.
;;
;; Add the `lookup-list` argument to your hw2 evaluator (or ours, from the solution set).
;; `(evaluate 'foo lookup-list)` should return whatever `'foo` is associated with in `lookup-list`.

(define (evaluate x lookup-list)
  (cond [(symbol? x) (evaluate (assq x lookup-list) lookup-list)]
        [else
         (cond [(number?  x) x]
               [(eq? (first x) 'ADD) (+ (evaluate(first(rest x)) lookup-list) (evaluate(second(rest x)) lookup-list))]
               [(eq? (first x) 'SUB) (- (evaluate(first(rest x)) lookup-list) (evaluate(second(rest x)) lookup-list))]
               [(eq? (first x) 'MUL) (* (evaluate(first(rest x)) lookup-list) (evaluate(second(rest x)) lookup-list))]
               [(eq? (first x) 'DIV) (/ (evaluate(first(rest x)) lookup-list) (evaluate(second(rest x)) lookup-list))]
               [(eq? (first x) 'GT) (> (evaluate(first(rest x)) lookup-list) (evaluate(second(rest x)) lookup-list))]
               [(eq? (first x) 'LT) (< (evaluate(first(rest x)) lookup-list) (evaluate(second(rest x)) lookup-list))]
               [(eq? (first x) 'GE)(>= (evaluate(first(rest x)) lookup-list) (evaluate(second(rest x)) lookup-list))]
               [(eq? (first x) 'LE) (<= (evaluate(first(rest x)) lookup-list) (evaluate(second(rest x)) lookup-list))]
               [(eq? (first x) 'EQ) (= (evaluate(first(rest x)) lookup-list) (evaluate(second(rest x)) lookup-list))]
               [(eq? (first x) 'NEQ) (not(= (evaluate(first(rest x)) lookup-list) (evaluate(second(rest x)) lookup-list)))]
               [(eq? (first x) 'ANND) (and (evaluate(first(rest x)) lookup-list) (evaluate(second(rest x)) lookup-list))]
               [(eq? (first x) 'ORR) (or (evaluate(first(rest x)) lookup-list) (evaluate(second(rest x)) lookup-list))]
               [(eq? (first x) 'NOTT) (not (evaluate(rest x)) lookup-list)]
               [(eq? (first x) 'IPH)
                (cond [(eq? (evaluate(first(rest x)) lookup-list) #t)
                       (evaluate(second(rest x)) lookup-list )]
                      [(eq? (evaluate(first(rest x)) lookup-list) #f)
                       (evaluate(second(rest(rest x))) lookup-list)])])]))

(display(evaluate 'y  '((x 3) (y 2) (z -5))))(newline) ;; --> 2
(display(evaluate '(IPH (GT x 0) x (SUB 0 x)) '((x 3) (y 2) (z -5))))(newline) ; --> 3
(display(evaluate '(ADD x y) '((x 3) (y 2) (z -5))))(newline) ; --> 5
(display(evaluate '(IPH (GT z 0) z (SUB 0 z)) '((x 3) (y 2) (z -5))))(newline) ;--> 5