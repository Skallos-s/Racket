#lang racket

(require 2htdp/image)
(require 2htdp/universe)

(define SIZE 50)

; ListOf[ListOf[integer]] ListOf[bool]
(define-struct sb (balls slide))
(define start
  (make-sb
   (map
    make-list
    (make-list 8 4)
    (list 1 1 1 0 0 2 2 2))
   (make-list 8 #f)))

; Convert integer to ball or empty space.
; integer -> image
(define
  (tile n)
  (overlay
   (cond
     [(= n 1) (circle (/ SIZE 2) 'solid 'slateblue)]
     [(= n 2) (circle (/ SIZE 2) 'solid 'turquoise)]
     [else empty-image])
   (square SIZE 'solid 'lightgray)
   (rectangle 100 50 0 'red)))

; Draws gamescreen
; sb -> image
(define
  (draw SB)
  (crop
   (* 4 SIZE) 0 (* 13 SIZE)(* 11 SIZE)
   (overlay
    (crop
     (* 0.5 SIZE) 0 (* 9 SIZE) (* 8 SIZE)
     (apply
      above/align
      (list*
       'left
       (map
        (lambda (ball move altr)
          (beside
           (if move (square SIZE 0 'red) empty-image)
           (if altr (square SIZE 0 'red) empty-image)
           (apply beside (map tile ball))))
        (sb-balls SB)
        (sb-slide SB)
        (flatten (make-list 4 '(#f #t)))))))
    (rectangle (* 9 SIZE) (* 8 SIZE) 'solid 'silver)
    (ellipse (* 21 SIZE) (* 11 SIZE) 'solid 'darkgray)
    (rectangle (* 21 SIZE) (* 11 SIZE) 'solid 'white))))

; Handles mouse movements
; sb integer integer string -> sb
(define
  (mouse SB X Y M)
  (let
      ([NY (- (inexact->exact (floor (+ (/ Y SIZE) 1/2))) 2)])
    (if
     (and
      (string=? M "button-down")
      (<= 0 NY 7))
     (make-sb
      (sb-balls SB)
      (list-update (sb-slide SB) NY not))
     SB)))

; Moves marble to the bottom/top
; list -> list
; #f is wall
; 0  is space
; everything else is marble
(define (rise LST [C 0])
  (cond
    [(empty? LST) (make-list C 0)]
    [(= -1 (car LST)) (append (make-list C 0) (list -1) (rise (cdr LST) 0))]
    [(= (car LST) 0) (rise (cdr LST) (add1 C))]
    [else (cons (car LST) (rise (cdr LST) C))]))
(define (fall LST [C 0]) (reverse (rise (reverse LST) C)))

; Create columns
; sb -> ListOf[ListOf[integer]]
(define
  (columns SB)
  (build-list
   9
   (lambda (x)
     (build-list
      8
      (lambda (y)
        (if
         (even? y)
         (cond
           [(= x 8) -1]
           [(and (even? x) (not (list-ref (sb-slide SB) y)))
            (list-ref (list-ref (sb-balls SB) y) (/ x 2))]
           [(and (odd? x) (list-ref (sb-slide SB) y))
            (list-ref (list-ref (sb-balls SB) y) (/ (- x 1) 2))]
           [else -1])
         (cond
           [(= x 0) -1]
           [(and (odd? x) (not (list-ref (sb-slide SB) y)))
            (list-ref (list-ref (sb-balls SB) y) (/ (- x 1) 2))]
           [(and (even? x) (list-ref (sb-slide SB) y))
            (list-ref (list-ref (sb-balls SB) y) (/ (- x 2) 2))]
           [else -1])))))))

; Create marbles
; ListOf[ListOf[integer]] -> ListOf[ListOf[integer]]
(define
  (marbles LSTS)
  (build-list
   8
   (lambda (x)
     (remove*
      '(-1)
      (map
       (lambda (y)
         (list-ref y x))
       LSTS)))))

; Handles game key events
; sb string -> sb
(define
  (key SB key)
  (cond
    [(string=? key "w")
     (make-sb
      (marbles (map rise (columns SB)))
      (sb-slide SB))]
    [(string=? key "s")
     (make-sb
      (marbles (map fall (columns SB)))
      (sb-slide SB))]
    [else SB]))

(big-bang start (to-draw draw) (on-key key) (on-mouse mouse))
