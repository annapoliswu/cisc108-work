;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname sum-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; example of replacing duplicate computation with a local variable
(define (diff a b f)
  (- (max (f a) (f b)) (min (f a) (f b))))

(define (diff.v2 a b f) ; looks strange, doesn't really improve performance
  (local [(define fa (f a))
          (define fb (f b))]
    (- (max fa fb) (min fa fb))))




(define BIGLIST (build-list 100000 (lambda (x) (random 1000000))))

(define (sum-list.v1 alon)
  (cond [(empty? alon) 0]
        [else (+ (first alon)
                 (sum-list.v1 (rest alon)))]))
;(+5 (+6 (+7 0)))

(define (sum-list.v2 alon result)
  (cond [(empty? alon) result]
        [else (sum-list.v2 (rest alon) (+ (first alon) result))]))

(check-expect (sum-list.v1 BIGLIST) (sum-list.v2 BIGLIST 0))

;Plus 7 0 evaluated first then (+ 6 7), evaluated to (+5 11), end with 18
;doesn't change size of stack as much. saves memory space


(define (sum-list.v3 alon)
  (local [(define (sum-helper alon result)
            (cond [(empty? alon) result] ;important, goes through list hits last, produces result.
                  [else (sum-helper (rest alon) (+ (first alon) result))]))]
    (sum-helper alon 0)))

;basically hides .v2 in our function, don't need extra parameter.
;same amount of calls. basically saves memory space.

;python equivalent
;result = 0
; for first in alon
;   result += first


(display "sum-list.v1: ")
(time (sum-list.v1 BIGLIST))

(display "sum-list.v2: ")
(time (sum-list.v2 BIGLIST 0))

(display "sum-list.v3: ")
(time (sum-list.v3 BIGLIST))

(display "foldl: ")
(time (foldl + 0 BIGLIST))

(display "foldr: ")
(time (foldr + 0 BIGLIST))


#| ACCUMULATOR TEMPLATE
; Domain -> Range 
(define (function d0)
  (local (; Domain AccuDomain -> Range
          ; accumulator ...
          (define (function/a d a)
            ...))
    (function/a d0 a0)))
|#

;; fact : NatNum --> Number
;; Note use Natural Number template
(check-expect (fact 0) 1)
(check-expect (fact 1) 1)
(check-expect (fact 2) (* 2 1))
(check-expect (fact 3) (* 3 2 1))
(check-expect (fact 4) (* 4 3 2 1))

(define (fact n)
  (cond [(zero? n) 1]
        [else
         (* n
            (fact (- n 1)))]))

;"Linear recursion"  O(n) time and O(n) SPACE
;(sum '(1 2 3 4 5))

#;(define (afact n)
  (local [(define (faux n result-so-far)
...)]))