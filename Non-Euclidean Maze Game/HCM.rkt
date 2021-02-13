#lang racket
 (require 2htdp/image)
 (require 2htdp/universe)

(define BACK 50)
(define PATH 30)
(define WIND 100)
(define (BACKCOL d) (list-ref '(darkgray  darkgreen darkred) d))
(define (PATHCOL d) (list-ref '(lightgray lightgreen tomato) d))
(define WINDCOL 'black)

(define WINDOW (square WIND 'solid WINDCOL))

; Draw tile
(define (tile N E S W C)
  (let* ([EDGE (/(- BACK PATH)2)]
         [FULL (+ EDGE PATH)]
         [XBLK (rectangle FULL PATH 'solid (PATHCOL C))]
         [YBLK (rectangle PATH FULL 'solid (PATHCOL C))]
         [XPAD (rectangle EDGE PATH 0 'red)]
         [YPAD (rectangle PATH EDGE 0 'red)]
         [EMPT (square 0 0 'red)])
    (overlay
     (if N (above  YBLK YPAD) EMPT)
     (if E (beside XPAD XBLK) EMPT)
     (if S (above  YPAD YBLK) EMPT)
     (if W (beside XBLK XPAD) EMPT)
     (square BACK 'solid (BACKCOL C)))))

;Rotation transition animation
(define (transition A B t d)
  (cond
    [(<= t 0) (overlay A WINDOW)] [(>= t (/ pi 2)) (overlay B WINDOW)]
    [else
      (let([Q1 (list 1 (sin t) B)]
           [Q2 (list (cos t) 1 A)]
           [Q3 (list 1 (cos t) A)]
           [Q4 (list (sin t) 1 B)])
      (place-image
        ((if (odd? d) beside above)
         (apply scale/xy (list-ref (list Q1 Q2 Q3 Q4) d))
         (if (odd? d) (rectangle 1 BACK 'solid WINDCOL) (rectangle BACK 1 'solid WINDCOL))
         (apply scale/xy (list-ref (list Q3 Q4 Q1 Q2) d)))
       (/ WIND 2) (/ WIND 2)
       WINDOW))]))

;Return tile image from maxe graph and position
(define (get-tile maze posn)
  (apply tile
     (append
      (map (lambda(x)(>= x 0))
        (take (list-ref maze posn) 4))
      (drop (list-ref maze posn) 4))))

;Insert val at pos in lst
(define (list-insert lst pos val)
  (if
   (= pos (length lst))
   (append lst (list val))
   (flatten
    (list-set lst pos
              (cons val (list-ref lst pos))))))

;Generate starting root with at least 1 path option
(define (gen-root)
  (let ([op (random 1 16)])
     (list(append(build-list 4 (lambda(x)(>(bitwise-and op (expt 2 x))0)))(list 1)))))

;Generate new random node given connecting id and direction
(define (new-node i d)
  (let*
      ([op (random 0 8)]
       [ls (build-list 3 (lambda(x)(>(bitwise-and op (expt 2 x))0)))]
       [nd (list-ref (list 2 3 0 1) d)])
    (append(list-insert ls nd i)(list 0))))

;Replace 1 #f with -1
;Replace 1 #t with path to new node
(define (next-node unused gf)
  (let*
      ([t1 (map (lambda(x) (apply * (map (lambda(y) (if(integer? y)1 0)) x))) gf)]
       [t2 (index-of t1 0)])
    (if (not t2) gf
      (let*
          ([t3 (list-ref gf t2)]
           [t4 (index-of (map integer? t3) #f)])
        (if (list-ref t3 t4)
          (append
           (list-set gf t2 (list-set t3 t4 (length gf)))
           (list (new-node t2 t4)))
          (list-set gf t2 (list-set t3 t4 -1)))))))

;Replaces all #t and #f with -1
(define (cap gf)
  (map (lambda(x) (map (lambda(y)(if(integer? y)y -1)) x))gf))

;Makes last node finish
(define (fin gf)
  (append
   (drop-right gf 1)
   (list(list-set(last gf)4 2))))

;Generate Maze
(define (gen-maze n)
  (fin(cap(foldl next-node (gen-root) (make-list n 1)))))

(define-struct game
  (maze ;Maze structure
   curr ;Current position
   prev ;Previous position to be used in animation
   anim ;Animation timer
   dire ;Taken direction for animation
   scor ;Score
   ))

;Starting game
(define st (make-game (gen-maze 10) 0 -1 0 0 0))

;Update animation state
(define (tick gm)
  (cond
    [(> (game-anim gm) 0)
     (make-game
      (game-maze gm)
      (game-curr gm)
      (if (= 0 (game-anim gm)) -1 (game-prev gm))
      (sub1 (game-anim gm))
      (game-dire gm)
      (game-scor gm))]
    [(= (- (length (game-maze gm)) 1) (game-curr gm))
     (sleep 0.5)
     (make-game (gen-maze (+ (* (game-scor gm) 5) 10)) 0 -1 0 0 (add1(game-scor gm)))]
    [else gm]))

;Draw game
(define (draw gm)
  (overlay/align 'left 'top
   (beside (square 5 0'red)(text (number->string(game-scor gm)) 20'white))
   (if (= (game-anim gm) 0)
       (overlay (get-tile (game-maze gm) (game-curr gm)) WINDOW)
       (transition
        (get-tile (game-maze gm) (game-prev gm))
        (get-tile (game-maze gm) (game-curr gm))
        (* (- 20 (game-anim gm)) (/ pi 2 20))
        (game-dire gm)))))

;Keyboard input
(define (key gm k)
  (let ([d (index-of (list "up" "right" "down" "left") k)])
   (cond
     [(positive? (game-anim gm)) gm]
     [(not d) gm]
     [(negative? (list-ref (list-ref (game-maze gm) (game-curr gm)) d)) gm]
     [else
      (make-game
       (game-maze gm)
       (list-ref (list-ref (game-maze gm) (game-curr gm)) d)
       (game-curr gm)
       20 d
       (game-scor gm))])))

(big-bang st (on-tick tick) (on-draw draw) (on-key key))
