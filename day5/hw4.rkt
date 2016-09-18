#lang racket

;;; Student Name: Lucy Wilcox
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [x] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___
;;;     https://docs.racket-lang.org/reference/pairs.html#%28def._%28%28lib._racket%2Fprivate%2Flist..rkt%29._assq%29%29
;;;     Sophie (I ended up just handling outing club transport instead of leading a hike.... too much work
;;;        so I was able to go to office hours. Also we had some issues with map I decided to not use
;;;        apply operator in the way I think you expected. Though I understand that it could have been
;;;        the initial environment.
;;;     http://stackoverflow.com/questions/21688944/zip-function-in-racket-scheme

(define (lookup expr env)
  (cond [(eq? (assq expr env) #f) (error "Not in env")]
        [else (second (assq expr env))]))

(define (ap-helper lst-so-far lst env)
  (cond [(empty? lst) lst-so-far]
        [else (ap-helper (cons (calculate-5 (first lst) env) lst-so-far) (rest lst) env)]))

(define (apply-proc x y env)
   (calculate-5 (third x)(map list (second x)(reverse(ap-helper env y env)))))

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
                (calculate-5(second(rest(rest x))) env )])]
        [(eq? (first (first x)) 'LAMBDA) (apply-proc (calculate-5 (first x) env) (rest x) env)]
        [else (error `(calculate-5:  not sure what to do with expr , x))]))

(define (IPH-expr? sexpr)
  (and (pair? sexpr) (eq? (first sexpr) 'IPH)))

(define (IPH-TEST iph-expr)
  (second iph-expr))

(define (IPH-THEN iph-expr)
  (third iph-expr))

(define (IPH-ELSE iph-expr)
  (if (= (length iph-expr))
      (fourth iph-expr)
      false))

(define (calculate-IPH sexpr env)
  (if (calculate-5 (IPH-TEST sexpr) env)
      (calculate-5 (IPH-THEN sexpr) env)
      (calculate-5 (IPH-ELSE sexpr) env)))

(define starting-env null) ; Because I'm not using apply-operator as an inital env

(define (run-repl)
  (display "mini-eval")
  (repl starting-env))

(define (repl env)
  (display "> ")
  (display (calculate-5 (read) env))
  (newline)
  (repl env))


(run-repl)
