#lang racket

;;; Student Name: Frankly Olin [change to your name]
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___
;;;     https://docs.racket-lang.org/reference/pairs.html#%28def._%28%28lib._racket%2Fprivate%2Flist..rkt%29._assq%29%29

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

(define (lookup expr env)
  (cond [(eq? (assq expr env) #f) (error "Not in env")]
        [else (second (assq expr env))]))

(define (calculate-5 x env)
  (cond [(number? x) x]
        [(boolean? x) x]
        [(null? x) x]
        [(symbol? x) (lookup x env)]
        [(eq? (first x) 'DEFINE) (repl (cons (list (second x) (calculate-5 (last x) env)) env))]
        [(eq? (first x) 'LAMBDA) (list 'CLOSURE (second x) (third x) env)]
        [(eq? (first x) 'ADD)
         (+ (calculate-5(first(rest x)) env) (calculate-5(second(rest x)) env))]
        [(eq? (first x) 'SUB)
         (- (calculate-5(first(rest x)) env) (calculate-5(second(rest x)) env))]
        [(eq? (first x) 'MUL)
         (* (calculate-5(first(rest x)) env) (calculate-5(second(rest x)) env))]
        [(eq? (first x) 'DIV)
         (/ (calculate-5(first(rest x)) env) (calculate-5(second(rest x)) env))]
        [(eq? (first x) 'GT)
         (> (calculate-5(first(rest x)) env) (calculate-5(second(rest x)) env))]
        [(eq? (first x) 'LT)
         (< (calculate-5(first(rest x)) env) (calculate-5(second(rest x)) env))]
        [(eq? (first x) 'GE)
         (>= (calculate-5(first(rest x)) env) (calculate-5(second(rest x)) env))]
        [(eq? (first x) 'LE)
         (<= (calculate-5(first(rest x)) env) (calculate-5(second(rest x)) env))]
        [(eq? (first x) 'EQ)
         (= (calculate-5(first(rest x)) env) (calculate-5(second(rest x)) env))]
        [(eq? (first x) 'NEQ)
         (not(= (calculate-5(first(rest x)) env) (calculate-5(second(rest x)) env)))]
        [(eq? (first x) 'ANND)
         (and (calculate-5(first(rest x)) env) (calculate-5(second(rest x)) env))]
        [(eq? (first x) 'ORR)
         (or (calculate-5(first(rest x)) env) (calculate-5(second(rest x)) env))]
        [(eq? (first x) 'NOTT)
         (not (calculate-5(rest x)))]
        [(eq? (first x) 'IPH)
         (cond [(eq? (calculate-5(first(rest x))) #t)
                (calculate-5(second(rest x)) env)]
               [(eq? (calculate-5(first(rest x))) #f)
                (calculate-5(second(rest(rest x))) env )])]))

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

(define (calculate-IPH sexpr env)
  (if (calculate-5 (IPH-TEST sexpr env))
      (calculate-5 (IPH-THEN sexpr env))
      (calculate-5 (IPH-ELSE sexpr env))))

(define starting-env null)


(define (run-repl)
  (display "mini-eval")
  (repl starting-env))

(define (repl env)
  (display "> ")
  (display (calculate-5 (read) env))
  (newline)
  (repl env))


(run-repl)