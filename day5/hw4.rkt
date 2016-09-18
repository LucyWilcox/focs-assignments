#lang racket

;;; Student Name: Frankly Olin [change to your name]
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___

(define (apply-operator op args)
  (cond [(eq? op 'ADD) (+ (first args) (second args))]
        [(eq? op 'SUB) (- (first args) (second args))]
        [(eq? op 'MUL) (* (first args) (second args))]
        [(eq? op 'DIV) (/ (first args) (second args))]
        [(eq? op 'GT) (> (first args) (second args))]
        [(eq? op 'LT) (< (first args) (second args))]
        [(eq? op 'GE) (>= (first args) (second args))]
        [(eq? op 'LE) (<= (first args) (second args))]
        [(eq? op 'EQ) (= (first args) (second args))]
        [(eq? op 'NEQ) (not (= (first args) (second args)))]
        [(eq? op 'ANND) (and (first args) (second args))]
        [(eq? op 'ORR) (or (first args) (second args))]
        [(eq? op 'NOTT) (not (first args))]
        [else (error "Don't know how to " op)]))

(define (define? lst)
  (eq? (first lst) 'DEFINE))


(define (calculate-5 expr)
  (cond [(number? expr) expr]   ;; these first three cases are sometimes called
        [(boolean? expr) expr]  ;; self-evaluating (because they are their own
        [(null? expr) expr]     ;; values and don't need explicit evaluating)
        [(IPH-expr? expr) (calculate-IPH expr)]
        [(define? expr) 7]
        [(list? expr) (apply-operator (first expr) (map calculate-5 (rest expr)))]
        [else (error `(calculate-5:  not sure what to do with expr ,expr))]))

(define (IPH-expr? sexpr)
  (and (pair? sexpr) (eq? (first sexpr) 'IPH)))

(define (IPH-TEST iph-expr)
  (second iph-expr))

(define (IPH-THEN iph-expr)
  (third iph-expr))

(define (IPH-ELSE iph-expr)
  (if (= (length iph-expr) 4)
      (fourth iph-expr)
      false))

(define (calculate-IPH sexpr)
  (if (calculate-5 (IPH-TEST sexpr))
      (calculate-5 (IPH-THEN sexpr))
      (calculate-5 (IPH-ELSE sexpr))))


(define (run-repl)
  (display "mini-eval")
  (repl))

(define (repl)
  (display "> ")
  (display (calculate-5 (read)))
  (newline)
  (repl))


(run-repl)