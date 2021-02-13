#lang racket

 (require 2htdp/image)
 (require 2htdp/universe)

;Board Size
;Set To Zero For Automatic
;If Value Is Too Large, Then Automatic Truncation
;If Odd, Subtract 1
(define psize 2)
(define size(+(if(odd? psize)-1 0)psize))

;Constants
(define x 20)

;Load Sprites
(define ft (bitmap"FTile.png"))
(define bt (bitmap"BTile.png"))
(define (gg m)(overlay(text(number->string m)(* x 0.75)'black)(square(+ x x)0'red)))
(define ggf (square(+ x x)0'red))

;Define Shape Functions
(define(p1 m c)(square x m c))
(define(p2 m c)(circle(/ x 2)m c))
(define(p3 m c)(triangle x m c))
(define(p4 m c)(star(/ x 8/5)m c))
(define(p5 m c)(rotate 45(square(/ x(sqrt 2))m c)))
(define(p6 m c)(star-polygon(* x 2/5)8 3 m c))
(define(p7 m c)(regular-polygon(* x 5/8)5 m c))
(define(p8 m c)(regular-polygon(/ x 2)6 m c))

;Shape List
(define
  sl
  (list
   p1
   p2
   p3
   p4
   p5
   p6
   p7
   p8))

;Mode List
(define
  ml
  (list
   'solid
   'outline))

;Color List
(define
  cl
  (list
   'red
   'orange
   'yellow
   'green
   'blue
   'purple
   'white
   'black
   'hotpink
   'darkgreen
   'midnightblue
   'cyan
   'darkgray))

;Create Tile
(define
  (ct s m c)
  ((list-ref sl s)(list-ref ml m)(list-ref cl c)))

;Tile Enumeration List
(define
  tel
  (flatten
   (for/list
       ([i(in-range(length sl))])
     (for/list
         ([j(in-range(length ml))])
       (for/list
           ([k(in-range(length cl))])
         (overlay
          ((list-ref sl i)
           (list-ref ml j)
           (list-ref cl k))
          ft))))))

;New Board Size
(define
  nsize
  (inexact->exact
   (min
    (-
     size
     (if (odd? size)
      1
      0))
    (*
     (floor
      (sqrt
       (/
        (length tel)
        2)))
     2))))

;Truncate List
(define
  (cut li a b)
  (build-list
   (- b a -1)
   (lambda
     (x)
     (list-ref
      li
      (+ x a)))))

;Shuffle Then Truncate List According To Board Size
(define
  ntel
  (cut
   (shuffle tel)
   0
   (inexact->exact
    (-
     (/
      (expt nsize 2)
      2)
     1))))

;Final List
(define
  ftel
  (shuffle
   (append
    ntel
    ntel)))

;Blank List
(define
  blis
  (build-list
   (expt nsize 2)
   (lambda(x)bt)))

;Tile Row
(define
  (row li r c)
  (if
   (= r(- nsize 1))
   (list-ref li(+(* c nsize)r))
   (beside
    (list-ref li(+(* c nsize)r))
    (row
     li
     (+ r 1)
     c))))

;Tile Board
(define
  (full li c)
  (if
   (= c(- nsize 1))
   (row li 0 c)
   (above
    (row li 0 c)
    (full
     li
     (+ c 1)))))

;Struct Define
(define-struct
  gm
  (tl
   cl
   x1
   y1
   x2
   y2
   co))
(define st(make-gm ftel blis -1 -1 -1 -1 0))

;Mouse Location
(define
  (loco p)
  (*(sgn p)
   (floor
    (/ p(+ x x)))))

;Replace Item In List
(define
  (replace li x y item)
  (list-set
   li
   (+(* y nsize)x)
   item))

;Draw Board
(define
  (draw ts)
  (overlay
   (full(gm-cl ts)0)
   (full(gm-tl ts)0)))

;Equal Pieces?
(define
  (ep? ts)
  (and
   (equal?
    (list-ref(gm-tl ts)(+(*(gm-y1 ts)nsize)(gm-x1 ts)))
    (list-ref(gm-tl ts)(+(*(gm-y2 ts)nsize)(gm-x2 ts))))
   (not
    (and
     (=(gm-x1 ts)(gm-x2 ts))
     (=(gm-y1 ts)(gm-y2 ts))))))

;Mouse Universe
#|(define
  (mouse ts x y ev)
  (if
   (and
    (string=?"button-down"ev)
    (not(equal?(list-ref(gm-tl ts)(+(*(loco y)nsize)(loco x)))gg)))
   (if
    (=(gm-x1 ts)(gm-y1 ts)-1)
    (make-gm
     (gm-tl ts)
     (replace(gm-cl ts)(loco x)(loco y)gg)
     (loco x)
     (loco y)
     (gm-x2 ts)
     (gm-y2 ts)
     (gm-co ts))
    (if
     (=(gm-x2 ts)(gm-y2 ts)-1)
     (make-gm
      (gm-tl ts)
      (replace(gm-cl ts)(loco x)(loco y)gg)
      (gm-x1 ts)
      (gm-y1 ts)
      (loco x)
      (loco y)
     (gm-co ts))
     (if
      (ep? ts)
      (make-gm
       (replace
        (replace(gm-tl ts)(gm-x1 ts)(gm-y1 ts)gg)
        (gm-x2 ts)
        (gm-y2 ts)
        gg)
       (replace
        (replace(gm-cl ts)(gm-x1 ts)(gm-y1 ts)gg)
        (gm-x2 ts)
        (gm-y2 ts)
        gg)
       -1
       -1
       -1
       -1
      (+(gm-co ts)1))
      (make-gm
       (gm-tl ts)
       (replace
        (replace(gm-cl ts)(gm-x1 ts)(gm-y1 ts)bt)
        (gm-x2 ts)
        (gm-y2 ts)
        bt)
       -1
       -1
       -1
       -1
      (+(gm-co ts)1)))))
   ts))|#
(define
  (mouse ts x y ev)
  (if
   (and
    (string=?"button-down"ev)
    (not(equal?(list-ref(gm-tl ts)(+(*(loco y)nsize)(loco x)))ggf)))
   (if
    (=(gm-x1 ts)(gm-y1 ts)-1)
    (make-gm
     (gm-tl ts)
     (replace(gm-cl ts)(loco x)(loco y)(gg(gm-co ts)))
     (loco x)
     (loco y)
     (gm-x2 ts)
     (gm-y2 ts)
     (gm-co ts))
    (if
     (=(gm-x2 ts)(gm-y2 ts)-1)
     (make-gm
      (gm-tl ts)
      (replace(gm-cl ts)(loco x)(loco y)(gg(gm-co ts)))
      (gm-x1 ts)
      (gm-y1 ts)
      (loco x)
      (loco y)
     (gm-co ts))
     (if
      (ep? ts)
      (make-gm
       (replace
        (replace(gm-tl ts)(gm-x1 ts)(gm-y1 ts)ggf)
        (gm-x2 ts)
        (gm-y2 ts)
        ggf)
       (replace
        (replace(gm-cl ts)(gm-x1 ts)(gm-y1 ts)ggf)
        (gm-x2 ts)
        (gm-y2 ts)
        ggf)
       -1
       -1
       -1
       -1
      (+(gm-co ts)1))
      (make-gm
       (gm-tl ts)
       (replace
        (replace(gm-cl ts)(gm-x1 ts)(gm-y1 ts)bt)
        (gm-x2 ts)
        (gm-y2 ts)
        bt)
       -1
       -1
       -1
       -1
      (+(gm-co ts)1)))))
   ts))

;Big Bang
(big-bang st(on-mouse mouse)(to-draw draw))
