#lang racket

 (require 2htdp/image)
 (require 2htdp/universe)

;;;Sturct Define
;X-Coordinate
;Y-Coordinate
;List Of Current Board Position
(define-struct gm (x y li))
(define st(make-gm 0 0 (list 0 0 0 0 0 0 0 0 0 1)))



;;;Graphics

;Color Variables
(define edgecolor 'black)
(define invicolor (make-color 0 0 0 0))
(define linecolor 'gray)
(define xcolor    'blue)
(define ocolor    'red)
(define trans 200)

;Row Graphic
(define rw (rectangle 150 25 trans linecolor))

;Column Graphic
(define co (rectangle 25 150 trans linecolor))

;Diagnal graphic
(define di (rotate 45 (rectangle 25 (* 150 (sqrt 2)) trans linecolor)))

;Hroizontal Filler
(define ho (rectangle 10 150 0 'red))

;Vertical Filler
(define ve (rectangle 150 1 0 'red))

;X Graphic
(define
  x
  (overlay
   (rotate
    45
    (overlay
     (rectangle 40 10 'solid xcolor)
     (rectangle 10 40 'solid xcolor)
     )
    )
   (square 50 0 'red)
   )
  )

;O Graphic
(define
  o
  (overlay
   (circle 15 'outline (make-pen ocolor 10 'solid 'round 'round))
   (square 50 0 'red)
   )
  )

;Blank Graphic
(define
  b
  (square 50 0 'red)
  )

;Board Graphic
(define
  board
  (overlay
   (beside
    (rectangle 50 200 'solid invicolor)
    (rectangle 25 200 'solid edgecolor)
    (rectangle 50 200 'solid invicolor)
    (rectangle 25 200 'solid edgecolor)
    (rectangle 50 200 'solid invicolor)
    )
   (above
    (rectangle 200 50 'solid invicolor)
    (rectangle 200 25 'solid edgecolor)
    (rectangle 200 50 'solid invicolor)
    (rectangle 200 25 'solid edgecolor)
    (rectangle 200 50 'solid invicolor)
    )
   )
  )

;This Function Spits Out Proper Symbol Given A Number
(define
  (sy s)
  (cond
    [(=  0 s) b]
    [(= -1 s) o]
    [(=  1 s) x]
    )
  )

;This Places Symbols Onto The Board Given A List Of Current Board Position
(define
  (pl ga)
  (above
   (beside
    (sy
     (list-ref
      (gm-li ga)
      0
      )
     )
    (square 25 0 'red)
    (sy
     (list-ref
      (gm-li ga)
      1
      )
     )
    (square 25 0 'red)
    (sy
     (list-ref
      (gm-li ga)
      2
      )
     )
    )
   (square 25 0 'red)
   (beside
    (sy
     (list-ref
      (gm-li ga)
      3
      )
     )
    (square 25 0 'red)
    (sy
     (list-ref
      (gm-li ga)
      4
      )
     )
    (square 25 0 'red)
    (sy
     (list-ref
      (gm-li ga)
      5
      )
     )
    )
   (square 25 0 'red)
   (beside
    (sy
     (list-ref
      (gm-li ga)
      6
      )
     )
    (square 25 0 'red)
    (sy
     (list-ref
      (gm-li ga)
      7
      )
     )
    (square 25 0 'red)
    (sy
     (list-ref
      (gm-li ga)
      8
      )
     )
    )
   )
  )

;Draws Line When Win
(define
  (winline ga)
  (overlay
    (if(=(abs(r1 ga))1)(above rw ho) (square 0 0'red))
    (if(=(abs(r2 ga))1)rw            (square 0 0'red))
    (if(=(abs(r3 ga))1)(above ho rw) (square 0 0'red))
    (if(=(abs(c1 ga))1)(beside co ve)(square 0 0'red))
    (if(=(abs(c2 ga))1)co            (square 0 0'red))
    (if(=(abs(c3 ga))1)(beside ve co)(square 0 0'red))
    (if(=(abs(d1 ga))1)di            (square 0 0'red))
    (if(=(abs(d2 ga))1)(rotate 90 di)(square 0 0'red))
    )
   )


;;;Mechanics

;Gives -1 If Input Is -3
;Gives  1 If Input Is  3
;Gives  0 Else
(define
  (si n)
  (cond
    [(= n -3)-1]
    [(= n  3) 1]
    [else 0    ]
    )
  )

;;These Functions Check Whenever There Is A Win
;;Outputs -1, 0, Or 1 Depending On Who Won For A Certain Triplet

;Row 1
(define
  (r1 ga)
  (si
   (+
    (list-ref
     (gm-li ga)
     0
     )
    (list-ref
     (gm-li ga)
     1
     )
    (list-ref
     (gm-li ga)
     2
     )
    )
   )
  )

;Row 2
(define
  (r2 ga)
  (si
   (+
    (list-ref
     (gm-li ga)
     3
     )
    (list-ref
     (gm-li ga)
     4
     )
    (list-ref
     (gm-li ga)
     5
     )
    )
   )
  )
  
;Row 3
(define
  (r3 ga)
  (si
   (+
    (list-ref
     (gm-li ga)
     6
     )
    (list-ref
     (gm-li ga)
     7
     )
    (list-ref
     (gm-li ga)
     8
     )
    )
   )
  )

;Column 1
(define
  (c1 ga)
  (si
   (+
    (list-ref
     (gm-li ga)
     0
     )
    (list-ref
     (gm-li ga)
     3
     )
    (list-ref
     (gm-li ga)
     6
     )
    )
   )
  )

;Column 2
(define
  (c2 ga)
  (si
   (+
    (list-ref
     (gm-li ga)
     1
     )
    (list-ref
     (gm-li ga)
     4
     )
    (list-ref
     (gm-li ga)
     7
     )
    )
   )
  )

;Column 1
(define
  (c3 ga)
  (si
   (+
    (list-ref
     (gm-li ga)
     2
     )
    (list-ref
     (gm-li ga)
     5
     )
    (list-ref
     (gm-li ga)
     8
     )
    )
   )
  )

;Diagnal 1
(define
  (d1 ga)
  (si
   (+
    (list-ref
     (gm-li ga)
     0
     )
    (list-ref
     (gm-li ga)
     4
     )
    (list-ref
     (gm-li ga)
     8
     )
    )
   )
  )

;Diagnal 2
(define
  (d2 ga)
  (si
   (+
    (list-ref
     (gm-li ga)
     2
     )
    (list-ref
     (gm-li ga)
     4
     )
    (list-ref
     (gm-li ga)
     6
     )
    )
   )
  )

;Mouse Quadrant
(define
  (mquad ga)
  (+
   (cond
     [(<= 0   (gm-x ga) 50 )0]
     [(<= 75  (gm-x ga) 125)1]
     [(<= 150 (gm-x ga) 200)2]
     [else 10]
     )
   (cond
     [(<= 0   (gm-y ga) 50 )0]
     [(<= 75  (gm-y ga) 125)3]
     [(<= 150 (gm-y ga) 200)6]
     [else 10]
     )
   )
  )

;Truncates A List
(define
  (cut li a b)
  (build-list
   (-
    b
    a
    -1
    )
   (lambda
       (x)
     (list-ref
      li
      (+
       x
       a
       )
      )
     )
   )
  )

;Checks To See If There Is A Triplet
(define
  (pwin ga)
  (>
   (abs
    (+
     (r1 ga)
     (r2 ga)
     (r3 ga)
     (c1 ga)
     (c2 ga)
     (c3 ga)
     (d1 ga)
     (d2 ga)
    )
   )
   0
   )
  )

;;;Universe Functions

;Pause For A Few Ticks Before Win Registers
(define
  (tock ga)
  (make-gm
   (gm-x ga)
   (gm-y ga)
   (if
    (pwin ga)
    (append
     (cut
      (gm-li ga)
      0
      8
      )
     (list 0)
     )
    (gm-li ga)
    )
   )
  )
   

;Draws The Main Board
(define
  (draw ga)
  (overlay
   (winline ga)
   (pl ga)
   board
   )
  )

;Mouse Functions
;Placement Of Marks
(define
  (mouse ga x y event)
  (make-gm
   x
   y
   (if
    (<
     (mquad ga)
     10
     )
    (if
     (and
      (=
       (list-ref
        (gm-li ga)
        (mquad ga)
        )
       0
       )
      (string=?
       "button-down"
       event
       )
      (=
       (abs
        (list-ref
         (gm-li ga)
         9
         )
        )
       1
       )
      )
     (append
      (cut
       (gm-li ga)
       0
       (-
        (mquad ga)
        1
        )
       )
      (list
       (list-ref
        (gm-li ga)
        9
        )
       )
      (cut
       (gm-li ga)
       (+
        (mquad ga)
        1
        )
       8
       )
      (list
       (*
        -1
        (list-ref
         (gm-li ga)
         9
         )
        )
       )
      )
     (gm-li ga)
     )
    (gm-li ga)
    )
   )
  )

;Resets Board When R Is Pressed
(define
  (key ga k)
  (if
   (string=?
    k
    "r"
    )
   st
   ga
   )
  )

(big-bang st(on-tick tock)(on-draw draw)(on-mouse mouse)(on-key key))