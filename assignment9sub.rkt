#lang racket
;; Programming Languages, Assignment 9
;;
;; This assignment is meant to help you catch up on the basic Racket syntax.
;;
;; Use `define` for all your function definitions. You can use either the `lambda`
;; version of define or the syntactic sugar'ed version.
(provide (all-defined-out))

;; Write a function `add-nums`. It takes as input a list and it adds up those elements
;; in the list that are actually numbers. You can check if something is a number via
;; `number?`. The result for an empty list should be 0.
;; The reference solution is 5 lines.

(define (add-nums lst)
  (cond [(null? lst) 0]
        [(number? (car lst)) (+ (car lst) (add-nums (cdr lst)))]
        [else (add-nums (cdr lst))]))

;; Write a function `length`. It takes as input a list and returns the length of the
;; list.
;; The reference solution is 4 lines.

(define (length lst)
  (if (null? lst)
      0
      (+ 1 (length (cdr lst)))))

;; Write a function `get-nth`. It takes as input a list and an integer, and it returns
;; the n-th element in the list, starting at index 0. If the integer is negative it
;; should return `(error "negative index")`. If the list is not long enough it should
;; return `(error "list too short")`.
;; The reference solution is 5 lines.

(define (get-nth lst ar)
  (cond [(< ar 0) (error "negative index")]
        [(> ar (length lst)) (error "list too short")]
        [(equal? ar 0) (car lst)]
        [else (get-nth (cdr lst)(- ar 1))]))

;; Write a function `every-other`. It takes as input a list, and it returns a new list
;; where every other term is skipped. So applied to the list `'(1 2 3)` it should return
;; `'(1 3)`, and the same for the list `'(1 2 3 4)`.
;; The reference solution is 5 lines.

(define (every-other lst)
  (cond [(null? lst) (list)]
        [(null? (cdr lst)) (cons (car lst) (list))]
        [else (cons (car lst) (every-other (cdr (cdr lst))))]))
  
;; Write a function `map`. It takes two arguments: a function and a list. It then
;; returns a new list of the result of applying the function on each element.
;; The reference solution is 5 lines.

(define (map fun lst)
  (cond [(null? lst) (list)]
        [else (cons (fun (car lst)) (map fun (cdr lst)))]))

;; Write a function `map2`. It takes three arguments: a function that takes two inputs
;; and two lists. It then creates a single new list by applying the function to pairs
;; of values one from each list. The process stops when one of the lists is empty.
;; The reference solution is 5 lines.

(define (map2 fun lst1 lst2)
  (cond [(null? lst1) (list)]
        [(null? lst2) (list)]
        [else (cons (fun (car lst1) (car lst2)) (map2 fun (cdr lst1) (cdr lst2)))]))

;; Write a function `filter`. It takes as input a function and a list and returns
;; a new list consisting of those elements for which the function does not return #f
;; The reference solution is 5 lines.

(define (filter fun lst)
  (cond [(null? lst) (list)]
        [(equal? (fun (car lst)) #t) (cons (car lst) (filter fun (cdr lst)))]
        [else (filter fun (cdr lst))]))

;; Write a function `call-all`. It takes as input a list of "thunks", and returns a
;; list of the results of calling those thunks. To call a function, you put it as the
;; first entry in parentheses, followed by any arguments it may have.
;; The reference solution is 4 lines.

(define (call-all lst)
  (cond [(null? lst) (list)]
        [else (cons ((car lst)) (call-all (cdr lst)))]))
