#lang racket

 (require 2htdp/image)
 (require 2htdp/universe)

;;;Rules
;F1 Standard
;--Standard Rules

;F2 2 Kings
;--Checkmate 1 King, Or Check Both Kings Simultaneously

;F3 Queens
;--Checkmate With Only Queens

;F4 Hoard
;--White has Standard Set
;--Black has 36 Pawns

;F5 Charge of the Light Brigade
;--Black has 7 Knights
;--White has 3 Queens

;F6 Racing Kings
;--Kings Cannot Be In Check
;--Win By Moving Your King To Other Side

;F7 Checkers
;--Standard Rules

;F8 Chess V Checkers
;--Chess Pieces Against Checkers Pieces

;F9 Sideways
;--Board Is Flipped Sideways

;F10 Fortress
;--Win If You Capture A Flag Or Checkmate
;--Full Blocks Prevent All Movements Over It

;F11 Blank
;--Empty

;How To Play
;1/Q - King
;2/W - Queen
;3/E - Rook
;4/R - Knight
;5/T - Bishop
;6/Y - Pawn
;7/U - Checker
;8/I - Checker King
;9/O - Flag
;0/P - Shogi Piece

; Z  - Radioactive
; X  - Snow Flake
; C  - Block

;Spc - Remove
;Esc - Unselect
; `  - Flip Board


;;;Other Chess Variations

;King Of The Hill
;--First King To Center 4 Squares While Not In Check Wins

;Prussian
;--Pieces Cannot Move Backwards
;--If Piece Becomes Useless, Piece Dies (Moves Past Enemy Lines)


;;;Sprites

;Dark Square Color
(define dsc 'gray)

;Light Square Color
(define lsc 'white)

;Piece Color
(define pc 'black)

;Highlight Color
(define hc 'green)

;Highlight Amount
(define ha 50)

;Piece Size
(define ps 44)

;Square Size
(define ss 60)

;Pieces & Other Glyphs
(define Wk "♔")
(define Wq "♕")
(define Wr "♖")
(define Wb "♗")
(define Wn "♘")
(define Wp "♙")
(define Wc "⛀")
(define Ws "⛁")
(define Wf "⚐")
(define Sw "☖")

(define Gg " ")

(define Bk "♚")
(define Bq "♛")
(define Br "♜")
(define Bb "♝")
(define Bn "♞")
(define Bp "♟")
(define Bc "⛂")
(define Bs "⛃")
(define Bf "⚑")
(define Sb "☗")

(define Ra "☢")
(define Fr "❄")
(define Fb "█")

;Generate Chess Piece
(define
  (p t)
  (overlay
   (text t ps pc)
   (square ss 0 'red)
   )
  )

;Dark Square
(define d (square ss 'solid dsc))

;Light Square
(define l (square ss 'solid lsc))

;Board Row
(define
  (Pboard c)
  (if
   (= c 8)
   l
   (beside
    (if
     (even? c)
     l
     d
     )
    (Pboard
     (+ c 1)
     )
    )
   )
  )

;Board Complete
(define
  (Cboard c)
  (if
   (= c 8)
   (Pboard 1)
   (above
    (if
     (even? c)
     (Pboard 1)
     (flip-horizontal
      (Pboard 1)
      )
     )
    (Cboard
     (+ c 1)
     )
    )
   )
  )

;Board
(define
  board
  (Cboard 1)
  )

;Place Pieces Row
(define
  (placerow ch a b)
  (if
   (= b 7)
   (p
    (list-ref
     (list-ref
      (chess-mtrx ch)
      a
      )
     7
     )
    )
   (beside
    (p
     (list-ref
      (list-ref
       (chess-mtrx ch)
       a
       )
      b
      )
     )
    (placerow
     ch
     a
     (+ b 1)
     )
    )
   )
  )

;Place Entire Pieces
;Let a = 0 When Generating Chess Pieces
(define
  (place ch a)
  (if
   (= a 7)
   (placerow ch 7 0)
   (above
    (placerow ch a 0)
    (place
     ch
     (+ a 1)
     )
    )
   )
  )

;Final Board
(define
  (posi ch)
   (overlay
    (place ch 0)
    (if
     (and
      (>
       (chess-x ch)
       0
       )
      (>
       (chess-y ch)
       0
       )
      )
     (overlay/xy
      (square ss ha hc)
      (*
       (loco(chess-x ch))
       -1
       ss
       )
      (*
       (loco
        (chess-y ch)
        )
       -1
       ss
       )
      board
      )
     board
     )
    )
   )

;;;Struct Define
;Board Matrix
;Position Of Last Move
(define-struct chess (mtrx x y))

;Board Setups

;Standard
(define f1
  (make-chess
   (list
    (list Br Bn Bb Bq Bk Bb Bn Br)
    (list Bp Bp Bp Bp Bp Bp Bp Bp)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Wp Wp Wp Wp Wp Wp Wp Wp)
    (list Wr Wn Wb Wq Wk Wb Wn Wr)
    )
   -1
   -1
   )
  )

;2 Kings
(define f2
  (make-chess
   (list
    (list Br Bn Bb Bk Bk Bb Bn Br)
    (list Bp Bp Bp Bp Bp Bp Bp Bp)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Wp Wp Wp Wp Wp Wp Wp Wp)
    (list Wr Wn Wb Wk Wk Wb Wn Wr)
    )
   -1
   -1
   )
  )

;Queens
(define f3
  (make-chess
   (list
    (list Gg Gg Gg Gg Bk Gg Gg Gg)
    (list Bq Bq Bq Bq Bq Bq Bq Bq)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Wq Wq Wq Wq Wq Wq Wq Wq)
    (list Gg Gg Gg Gg Wk Gg Gg Gg)
    )
   -1
   -1
   )
  )

;Hoard
(define f4
  (make-chess
   (list
    (list Bp Bp Bp Bp Bp Bp Bp Bp)
    (list Bp Bp Bp Bp Bp Bp Bp Bp)
    (list Bp Bp Bp Bp Bp Bp Bp Bp)
    (list Bp Bp Bp Bp Bp Bp Bp Bp)
    (list Gg Bp Bp Gg Gg Bp Bp Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Wp Wp Wp Wp Wp Wp Wp Wp)
    (list Wr Wn Wb Wq Wk Wb Wn Wr)
    )
   -1
   -1
   )
  )


;Charge of the Light Brigade
(define f5
  (make-chess
   (list
    (list Bn Bn Bn Bn Bk Bn Bn Bn)
    (list Bp Bp Bp Bp Bp Bp Bp Bp)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Wp Wp Wp Wp Wp Wp Wp Wp)
    (list Gg Wq Gg Wq Wk Gg Wq Gg)
    )
   -1
   -1
   )
  )



;Racing Kings
(define f6
  (make-chess
   (list
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Bk Br Bb Bn Wn Wb Wr Wk)
    (list Bq Br Bb Bn Wn Wb Wr Wq)
    )
   -1
   -1
   )
  )

;Checkers
(define f7
  (make-chess
   (list
    (list Gg Bc Gg Bc Gg Bc Gg Bc)
    (list Bc Gg Bc Gg Bc Gg Bc Gg)
    (list Gg Bc Gg Bc Gg Bc Gg Bc)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Wc Gg Wc Gg Wc Gg Wc Gg)
    (list Gg Wc Gg Wc Gg Wc Gg Wc)
    (list Wc Gg Wc Gg Wc Gg Wc Gg)
    )
   -1
   -1
   )
  )

;Chess V Checkers
(define f8
  (make-chess
   (list
    (list Bc Bc Bc Bc Bc Bc Bc Bc)
    (list Bc Bc Bc Bc Bc Bc Bc Bc)
    (list Bc Bc Bc Bc Bc Bc Bc Bc)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Wp Wp Wp Wp Wp Wp Wp Wp)
    (list Wr Wn Wb Wq Wk Wb Wn Wr)
    )
   -1
   -1
   )
  )

;Sideways
(define f9
  (make-chess
   (list
    (list Wr Gg Gg Gg Gg Gg Bp Br)
    (list Wn Wp Gg Gg Gg Gg Bp Bn)
    (list Wb Wp Gg Gg Gg Gg Bp Bb)
    (list Wq Wp Gg Gg Gg Gg Bp Bq)
    (list Wk Wp Gg Gg Gg Gg Bp Bk)
    (list Wb Wp Gg Gg Gg Gg Bp Bb)
    (list Wn Wp Gg Gg Gg Gg Bp Bn)
    (list Wr Wp Gg Gg Gg Gg Gg Br)
    )
   -1
   -1
   )
  )

;Battlefield
(define f10
  (make-chess
   (list
    (list Br Bf Bq Bn Bn Bq Bf Br)
    (list Bp Bb Fb Bp Bp Fb Bb Bp)
    (list Bp Fb Fb Bp Bp Fb Fb Bp)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Wp Fb Fb Wp Wp Fb Fb Wp)
    (list Wp Wb Fb Wp Wp Fb Wb Wp)
    (list Wr Wf Wq Wn Wn Wq Wf Wr)
    )
   -1
   -1
   )
  )

;Blank
(define f11
  (make-chess
   (list
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    (list Gg Gg Gg Gg Gg Gg Gg Gg)
    )
   -1
   -1
   )
  )

;;;Mechanics

;Matrx Rotate
#|(define
  (mtrxrot mat)
  (reverse
   (build-list
    (length mat)
    (lambda
     (x)
     (reverse
      (list-ref
       mat
       x
       )
      )
     )
    )
   )
  )|#
(define
  (mtrxrot mtrx)
  (reverse
   (map reverse mtrx)
   )
  )

;Mouse Location
(define
  (loco x)
  (*
   (sgn x)
   (floor
    (/
     x
     (+
      ss
      1
      )
     )
    )
   )
  )

;Replace Item In Matrix
(define
  (replace mat x y item)
  (list-set
   mat
   y
   (list-set
    (list-ref mat y)
    x
    item
    )
   )
  )

;Used To Shorten Code
(define
  (qrep ch char)
  (replace
   (chess-mtrx ch)
   (loco(chess-x ch))
   (loco(chess-y ch))
   char
   )
  )

;Mouse Functions
(define
  (mouse ch x y event)
  (make-chess
   (if
    (and
     (string=?
      "button-down"
      event
      )
     (>
      (chess-x ch)
      -1
      )
     (>
      (chess-y ch)
      -1
      )
     (not
      (and
       (=
        (loco(chess-x ch))
        (loco x)
        )
       (=
        (loco(chess-y ch))
        (loco y)
        )
       )
      )
     )
    (replace
     (replace
      (chess-mtrx ch)
      (loco x)
      (loco y)
      (list-ref
       (list-ref
        (chess-mtrx ch)
        (loco(chess-y ch))
        )
       (loco(chess-x ch))
       )
      )
     (loco(chess-x ch))
     (loco(chess-y ch))
     " "
     )
    (chess-mtrx ch)
    )
   (if
    (string=?
     "button-down"
     event
     )
    (if
     (or
      (=
       (chess-x ch)
       -1
       )
      (=
       (chess-y ch)
       -1
       )
      )
     x
     -1
     )
    (chess-x ch)
    )
   (if
    (string=?
     "button-down"
     event
     )
    (if
     (or
      (=
       (chess-x ch)
       -1
       )
      (=
       (chess-y ch)
       -1
       )
      )
     y
     -1
     )
    (chess-y ch)
    )
   )
  )

;Keyboard Functions
(define
  (key ch k)
  (cond
    [(string=?"f1" k)f1 ]
    [(string=?"f2" k)f2 ]
    [(string=?"f3" k)f3 ]
    [(string=?"f4" k)f4 ]
    [(string=?"f5" k)f5 ]
    [(string=?"f6" k)f6 ]
    [(string=?"f7" k)f7 ]
    [(string=?"f8" k)f8 ]
    [(string=?"f9" k)f9 ]
    [(string=?"f10"k)f10]
    [(string=?"f11"k)f11]
    [(string=?"`"k)(make-chess(mtrxrot(chess-mtrx ch))-1 -1)]
    [(string=?"esc"k)(make-chess(chess-mtrx ch)-1 -1)]
    [(and
      (>
       (chess-x ch)
       -1
       )
      (>
       (chess-y ch)
       -1
       )
      )
     (make-chess
      (cond
        [(string=?" "k)(qrep ch Gg)]
        [(string=?"1"k)(qrep ch Wk)]
        [(string=?"2"k)(qrep ch Wq)]
        [(string=?"3"k)(qrep ch Wr)]
        [(string=?"4"k)(qrep ch Wn)]
        [(string=?"5"k)(qrep ch Wb)]
        [(string=?"6"k)(qrep ch Wp)]
        [(string=?"7"k)(qrep ch Wc)]
        [(string=?"8"k)(qrep ch Ws)]
        [(string=?"9"k)(qrep ch Wf)]
        [(string=?"0"k)(qrep ch Sw)]
        [(string=?"q"k)(qrep ch Bk)]
        [(string=?"w"k)(qrep ch Bq)]
        [(string=?"e"k)(qrep ch Br)]
        [(string=?"r"k)(qrep ch Bn)]
        [(string=?"t"k)(qrep ch Bb)]
        [(string=?"y"k)(qrep ch Bp)]
        [(string=?"u"k)(qrep ch Bc)]
        [(string=?"i"k)(qrep ch Bs)]
        [(string=?"o"k)(qrep ch Bf)]
        [(string=?"p"k)(qrep ch Sb)]
        [(string=?"z"k)(qrep ch Ra)]
        [(string=?"x"k)(qrep ch Fr)]
        [(string=?"c"k)(qrep ch Fb)]
        [else(chess-mtrx ch)]
        )
      -1
      -1
      )
     ]
    [else ch]
   )
  )

(big-bang f1(on-draw posi)(on-mouse mouse)(on-key key))

;(display(string-append"(make-chess(list(list""\""(list-ref(list-ref(chess-mtrx st)0)0)"\"" "\""(list-ref(list-ref(chess-mtrx st)0)1)"\"" "\""(list-ref(list-ref(chess-mtrx st)0)2)"\"" "\""(list-ref(list-ref(chess-mtrx st)0)3)"\"" "\""(list-ref(list-ref(chess-mtrx st)0)4)"\"" "\""(list-ref(list-ref(chess-mtrx st)0)5)"\"" "\""(list-ref(list-ref(chess-mtrx st)0)6)"\"" "\""(list-ref(list-ref(chess-mtrx st)0)7)"\""")(list""\""(list-ref(list-ref(chess-mtrx st)1)0)"\"" "\""(list-ref(list-ref(chess-mtrx st)1)1)"\"" "\""(list-ref(list-ref(chess-mtrx st)1)2)"\"" "\""(list-ref(list-ref(chess-mtrx st)1)3)"\"" "\""(list-ref(list-ref(chess-mtrx st)1)4)"\"" "\""(list-ref(list-ref(chess-mtrx st)1)5)"\"" "\""(list-ref(list-ref(chess-mtrx st)1)6)"\"" "\""(list-ref(list-ref(chess-mtrx st)1)7)"\""")(list""\""(list-ref(list-ref(chess-mtrx st)2)0)"\"" "\""(list-ref(list-ref(chess-mtrx st)2)1)"\"" "\""(list-ref(list-ref(chess-mtrx st)2)2)"\"" "\""(list-ref(list-ref(chess-mtrx st)2)3)"\"" "\""(list-ref(list-ref(chess-mtrx st)2)4)"\"" "\""(list-ref(list-ref(chess-mtrx st)2)5)"\"" "\""(list-ref(list-ref(chess-mtrx st)2)6)"\"" "\""(list-ref(list-ref(chess-mtrx st)2)7)"\""")(list""\""(list-ref(list-ref(chess-mtrx st)3)0)"\"" "\""(list-ref(list-ref(chess-mtrx st)3)1)"\"" "\""(list-ref(list-ref(chess-mtrx st)3)2)"\"" "\""(list-ref(list-ref(chess-mtrx st)3)3)"\"" "\""(list-ref(list-ref(chess-mtrx st)3)4)"\"" "\""(list-ref(list-ref(chess-mtrx st)3)5)"\"" "\""(list-ref(list-ref(chess-mtrx st)3)6)"\"" "\""(list-ref(list-ref(chess-mtrx st)3)7)"\""")(list""\""(list-ref(list-ref(chess-mtrx st)4)0)"\"" "\""(list-ref(list-ref(chess-mtrx st)4)1)"\"" "\""(list-ref(list-ref(chess-mtrx st)4)2)"\"" "\""(list-ref(list-ref(chess-mtrx st)4)3)"\"" "\""(list-ref(list-ref(chess-mtrx st)4)4)"\"" "\""(list-ref(list-ref(chess-mtrx st)4)5)"\"" "\""(list-ref(list-ref(chess-mtrx st)4)6)"\"" "\""(list-ref(list-ref(chess-mtrx st)4)7)"\""")(list""\""(list-ref(list-ref(chess-mtrx st)5)0)"\"" "\""(list-ref(list-ref(chess-mtrx st)5)1)"\"" "\""(list-ref(list-ref(chess-mtrx st)5)2)"\"" "\""(list-ref(list-ref(chess-mtrx st)5)3)"\"" "\""(list-ref(list-ref(chess-mtrx st)5)4)"\"" "\""(list-ref(list-ref(chess-mtrx st)5)5)"\"" "\""(list-ref(list-ref(chess-mtrx st)5)6)"\"" "\""(list-ref(list-ref(chess-mtrx st)5)7)"\""")(list""\""(list-ref(list-ref(chess-mtrx st)6)0)"\"" "\""(list-ref(list-ref(chess-mtrx st)6)1)"\"" "\""(list-ref(list-ref(chess-mtrx st)6)2)"\"" "\""(list-ref(list-ref(chess-mtrx st)6)3)"\"" "\""(list-ref(list-ref(chess-mtrx st)6)4)"\"" "\""(list-ref(list-ref(chess-mtrx st)6)5)"\"" "\""(list-ref(list-ref(chess-mtrx st)6)6)"\"" "\""(list-ref(list-ref(chess-mtrx st)6)7)"\""")(list""\""(list-ref(list-ref(chess-mtrx st)7)0)"\"" "\""(list-ref(list-ref(chess-mtrx st)7)1)"\"" "\""(list-ref(list-ref(chess-mtrx st)7)2)"\"" "\""(list-ref(list-ref(chess-mtrx st)7)3)"\"" "\""(list-ref(list-ref(chess-mtrx st)7)4)"\"" "\""(list-ref(list-ref(chess-mtrx st)7)5)"\"" "\""(list-ref(list-ref(chess-mtrx st)7)6)"\"" "\""(list-ref(list-ref(chess-mtrx st)7)7)"\"""))-1 -1))"))
