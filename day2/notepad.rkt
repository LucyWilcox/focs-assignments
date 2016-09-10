#lang racket
(define (square x)
  (* x x))
  
(display (square 2)) (newline)  ;; -> 4

(define (is-right-triangle a b c)
   (eq? (sqrt(+ (square a)(square b))) c))
  
(display (is-right-triangle 3 4 5)) (newline)  ;; -> #t
(display (is-right-triangle 4 5 6)) (newline)  ;; -> #f



;;(define (fact n)
;;  (fact-helper n n))

(define (fact n)
  (cond[(eq? n 1)
        1]
       [else
        (* n (fact(- n 1)))]))
  

(display (fact 1)) (newline) ;; -> 1
(display (fact 5)) (newline) ;; -> 1


(define (fib n)
   (cond[(eq? n 0)
         0]
        [(eq? n 1)
         1]
        [(eq? n 2)
         1]
        [else
         (+ (fib (- n 1)) (fib (- n 2)))]))

(display (fib 1)) (newline) ;; -> 1
(display (fib 2)) (newline) ;; -> 1
(display (fib 3)) (newline) ;; -> 2
(display (fib 4)) (newline) ;; -> 3
(display (fib 5)) (newline) ;; -> 5
(display (fib 6)) (newline) ;; -> 8

(define (sum-helper total lst)
  (cond[(null? lst)
         total]
       [else
        (sum-helper (+ total (first lst)) (rest lst))]))

(define (sum lst)
  (cond[(null? (rest(cons (first lst) (rest lst))))
         (first (cons (first lst) (rest lst)))]
       [else
        (sum (cons (+ (first lst) (second lst)) (rest (rest (cons (first lst) (rest lst)))))) ]))

(display (sum '(1 2 3 4))) (newline) ;; -> 10
(display (sum '(1 20 300))) (newline) ;; -> 321


