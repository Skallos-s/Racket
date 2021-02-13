#lang racket
 (require 2htdp/image)
 (require 2htdp/universe)
 (require lang/posn)

;Variables
(define w 64) ;width
(define h 48) ;height

(define b (square 1'solid'black))          ;block
(define c (square 1'solid'red))            ;candy
(define f (rectangle w h'solid'lightgray)) ;field

;All Posns
(define a
  (flatten
   (for/list ([i(in-range w)])
    (for/list ([j(in-range h)])
     (make-posn(- i)(- j))))))

;Generate Random Posn List
(define
  (p n)
  (build-list n
   (lambda(x)(make-posn(-(random w))(-(random h))))))

;Overlay Posns onto Field
(define
  (m p(i f))
  (if(empty? p)i
   (m(rest p)(overlay/xy b(posn-x(first p))(posn-y(first p))i))))

;Reverse Rest
(define
  (r l)
  (reverse
   (rest
    (reverse l))))

;Generate New Candy Location
(define
  (z p)
  (first
   (shuffle
    (filter
     (lambda(x)(not(index-of p x)))
     a))))

;(index-of p(make-posn(-(random w))(-(random h))))
;Struct
(define-struct
  g
  (d   ;Direction
   c   ;Candy Location
   l   ;List of Body Posns
   s   ;Score
   p)) ;Pause
(define x
  (make-g
   "up"
   (z(list(make-posn(-(quotient w 2))(-(quotient h 2)))))
   (list(make-posn(-(quotient w 2))(-(quotient h 2))))
   0
   0))

;Stop
(define
  (s g)
  (cond
    [(> (posn-x(first(g-l g)))0)#t]
    [(> (posn-y(first(g-l g)))0)#t]
    [(<=(posn-x(first(g-l g)))(- w))#t]
    [(<=(posn-y(first(g-l g)))(- h))#t]
    [(index-of(rest(g-l g))(first(g-l(u g))))#t]
    [else #f]))

;Direction
(define
  (d d p)
  (cond
    [(equal?"up"   d)(list(make-posn(posn-x p)(+(posn-y p)1)))]
    [(equal?"down" d)(list(make-posn(posn-x p)(-(posn-y p)1)))]
    [(equal?"left" d)(list(make-posn(+(posn-x p)1)(posn-y p)))]
    [(equal?"right"d)(list(make-posn(-(posn-x p)1)(posn-y p)))]
    [else(list p)]))
  

;Update
(define
  (u g)
  (if
   (equal?(list(g-c g))(d(g-d g)(first(g-l g))))
   (make-g
    (g-d g)
    (z(g-l g))
    (append(d(g-d g)(first(g-l g)))(g-l g))
    (+(g-s g)1)
    0)
   (make-g
    (g-d g)
    (g-c g)
    (append(d(g-d g)(first(g-l g)))(r(g-l g)))
    (g-s g)
    0)))

;Key
(define
  (k g k)
  (cond
    [(and(equal?"up"   k)(=(g-p g)0)(not(equal?"down" (g-d g))))(make-g k(g-c g)(g-l g)(g-s g)1)]
    [(and(equal?"down" k)(=(g-p g)0)(not(equal?"up"   (g-d g))))(make-g k(g-c g)(g-l g)(g-s g)1)]
    [(and(equal?"left" k)(=(g-p g)0)(not(equal?"right"(g-d g))))(make-g k(g-c g)(g-l g)(g-s g)1)]
    [(and(equal?"right"k)(=(g-p g)0)(not(equal?"left" (g-d g))))(make-g k(g-c g)(g-l g)(g-s g)1)]
    [else g]))

;Draw
(define
  (e g)
  (above
   (scale 10
    (overlay/xy
     c
     (posn-x(g-c g))
     (posn-y(g-c g))
     (m(g-l g))))
   (overlay
    (text(number->string(g-s g))40'black)
    (rectangle(* w 10)45'solid'gray))))

(big-bang x(stop-when s)(on-tick u 1/20)(on-key k)(to-draw e))
