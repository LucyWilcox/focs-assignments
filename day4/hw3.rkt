#lang racket

;;; Student Name: Lucy Wilcox
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___
;;;          
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


(display (assq "hello2" (list (list "hello" 5) (list "hello2" 6))))


;;;;;;;;;;;
;; 2. lookup-list

;; Add the ability to look up symbols to your evaluator.
;;
;; Add the `lookup-list` argument to your hw2 evaluator (or ours, from the solution set).
;; `(evaluate 'foo lookup-list)` should return whatever `'foo` is associated with in `lookup-list`.

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
                (calculate-5(second(rest(rest x))))])]
        [(eq? (first x) 'lookup-list)
         (assq(