#lang racket

;;;;;;;;;;
;;; Day 3 in class work

;;;;;;;;;;
;; 0.  Implement factorial both recursively and tail recursively.
;;     Hint:  The tail recursive version will use a helper function.

(define (factorial numb)
  (if (= numb 0)
      1
      (* numb (factorial (- numb 1)))))

(display (factorial 4))(newline)

(define (factorial-helper so-far numb)
  (if (= numb 1)
      so-far
      (factorial-helper (* so-far numb)(- numb 1))))

(define (factorial-te numb)
  (factorial-helper numb (- numb 1)))

(display (factorial-te 4))(newline)

;;;;;;;;;;;
;; 1.  Filter is built in to scheme.

;; (filter even? '(1 2 3 4 5 6))  --> '(2 4 6)  ;; using the built-in even?
;; (filter teen? '(21 17 2 13 4 42 2 16 3)) --> '(17 13 16)
;; assuming (define (teen x) (and (<= 13 x) (<= x 19)))))
;; (filter list? '(3 (3 2 1) symbol (4 2) (1 (2) 3)) --> '((3 2 1) (4 2) (1 (2) 3))

;; Implement it anyway.  You might want to call it my-filter?  What arguments does it take?

(define (teen x) (and (<= 13 x) (<= x 19)))

(define (filter-helper arg lst-so-far lst)
  (cond [(empty? lst) lst-so-far]
        [(arg (first lst)) (filter-helper arg (append lst-so-far (list(first lst))) (rest lst))]
        [else (filter-helper arg lst-so-far (rest lst))]))

(define (my-filter arg lst)
  (filter-helper arg null lst))

(display (my-filter even? '(1 2 3 4)))(newline)
(display (my-filter teen '(21 17 2 13 4 42 2 16 3)))(newline)


;;;;;;;;;;;
;; 2.  Map is also built in to scheme.

;; (map double '(1 2 3))  --> '(4 5 6)  ;; assuming (define (double x) (* 2 x))
;; (map incr '(1 2 3)) --> '(2 3 4)     ;; assuming (define (incr x) (+ x 1))
;; (map last '((3 2 1) (4 2) (1 2 3)) --> '(1 2 3)
;; assuming (define (last lst)
;;            (if (null? (rest lst))
;;                (first lst)
;;                (last (rest lst))))

;; Implement it as well.  You might want to call it my-map.  What arguments does it take?
(define (double x) (* 2 x))
(define (incr x) (+ x 1))
(define (last lst)
  (if (null? (rest lst))
      (first lst)
      (last (rest lst))))
(define (my-map-helper arg lst-so-far lst)
  (cond [(empty? lst) lst-so-far]
        [else (my-map-helper arg (append lst-so-far (list(arg (first lst)))) (rest lst))]))

(define (my-map arg lst)
  (my-map-helper arg null lst))

(display(map double '(1 2 3)))(newline) ;;  --> '(2 4 6)
(display(map incr '(1 2 3)))(newline);; --> '(2 3 4)
(display (map last '((3 2 1) (4 2) (1 2 3))))(newline);; --> '(1 2 3)

;;;;;;;;;;;
;; 3.  While we're reimplementing built-ins, implement my-append (just like built in append)
;;     It takes two lists and returns a list containing all of the elements of the originals, in order.
;;     Note that it is purely functional, i.e., it doesn't MODIFY either of the lists that it is passed.

;; (append '(1 2 3) '(4 5 6)) --> '(1 2 3 4 5 6)

;; You might want to draw out the box and pointer structures for the original two lists
;; as well as for the new list.  Confirm with a member of the instructional staff....

(define (my-append-helper alst lst1 lst2)
  (cond [(empty? lst2) alst]
        [(empty? lst1) (my-append-helper (cons (first lst2) alst) lst1 (rest lst2))]
        [else (my-append-helper (cons (first lst1) alst) (rest lst1) lst2)]))

(define (my-append lst1 lst2)
  (reverse(my-append-helper null lst1 lst2)))

(display (my-append '(1 2 3) '(4 5 6)))(newline)


;;;;;;;;;;;
;; 4.  zip takes two lists, and returns a list of elements of size two, until one of the lists runs out.

;; (zip '(1 2 3) '(4 5 6)) ;; --> '((1 4) (2 5) (3 6))
;; (zip '(1 2 3) '(a b c d e f g)) ;; --> '((1 a) (2 b) (3 c))

;; Implement `zip`.


(define (my-zip-helper lst-so-far lst1 lst2)
  (cond [(empty? lst1) lst-so-far]
        [(empty? lst2) lst-so-far]
        [else (my-zip-helper (append lst-so-far (list (list(first lst1)(first lst2)))) (rest lst1) (rest lst2))])) 

(define (my-zip lst1 lst2)
  (my-zip-helper null lst1 lst2))


(display(my-zip '(1 2 3) '(4 5 6))) (newline);; --> '((1 4) (2 5) (3 6))
(display(my-zip '(1 2 3) '(a b c d e f g)))(newline) ;; --> '((1 a) (2 b) (3 c))
;;;;;;;;;;;;
;; 5.  Last built-in (for now):  (my-)reverse.
;;     Takes a list, returns a new list with the elements reversed.

;; (reverse '(1 2 3)) --> '(3 2 1)

(define (my-reverse-helper lst-rev lst)
  (cond[(empty? lst) lst-rev]
       [else (my-reverse-helper (cons(first lst) lst-rev) (rest lst))]))

(define (my-reverse lst)
  (my-reverse-helper null lst))
  
(display (my-reverse '(1 2 3)));; --> '(3 2 1)

;;;;;;;;;;;;
;; More puzzles:
;;
;;  - (count elt lst) returns the number of times that elt appears in lst
;;  - (remove-dups lst) returns a new list that contains the elements of lst but without repeats
;;       (remove-dups '(1 2 3 1 4 5 2 4 6)) --> '(1 2 3 4 5 6)
;;  - reverse reverses a list, but doesn't reverse sublists in a tree.  (Try it and see.)
;;    Write deep-reverse, which reverses all sublists as well.
;;  - Which of these can you implement using tail recursion?
