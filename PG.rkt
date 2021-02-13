#lang racket
 (require 2htdp/image)
 (require 2htdp/universe)
 (require lang/posn)
 (require (only-in racket/gui/base get-file))

(define colors (list 'yellow 'blue 'white 'red)) ; Verticie colors.

(define ks 0.1) ; Spring force constant
(define kq 1)   ; Repulsive force consant
(define dd 2)   ; Spring default distance

(define width 480)  ; Window height
(define height 480) ; Graph screen width
(define menu 160)   ; Menu screen width
(define back (rectangle width height 'solid 'black)) ; Graph screen
(define empt (rectangle width height 0 'red)) ; Empty graph screen for drawing
(define size 5) ; Node size
(define buttonx 120) ; Button dimension
(define buttony 40) ; Button dimension
(define margin (/ (- menu buttonx) 2)) ; Space between button and side of menu bar
(define gap 10) ; Space between buttons
(define shine 5) ; Width of shine detail
(define buttona (overlay(beside(polygon(list(make-posn 0 0)(make-posn shine shine)(make-posn shine (- buttony shine))(make-posn 0 buttony))'solid'silver)
    (rectangle (- buttonx shine shine) (- buttony shine shine) 'solid 'darkgray) ; Unselected button constant
    (polygon(list(make-posn shine 0)(make-posn 0 shine)(make-posn 0 (- buttony shine))(make-posn shine buttony))'solid'silver))(rectangle buttonx buttony 'solid 'lightgray)))
(define buttonb (overlay(beside(polygon(list(make-posn 0 0)(make-posn shine shine)(make-posn shine (- buttony shine))(make-posn 0 buttony))'solid'silver)
    (rectangle (- buttonx shine shine) (- buttony shine shine) 'solid 'gainsboro) ; Selected button constant
    (polygon(list(make-posn shine 0)(make-posn 0 shine)(make-posn 0 (- buttony shine))(make-posn shine buttony))'solid'silver))(rectangle buttonx buttony 'solid 'lightgray)))

(define (mrand) (- (* (random) 2) 1)) ; Random variable between -1 and 1

(define-struct pt (x y z st ty)) ; x-coor y-coor z-coor puzzle-state node-type
(define-struct gf (pts cns)) ; list_of_points list_of_connections
(define-struct sc (gf mx my ds md mv)) ; graph mouse-x mouse-y zoom toggle-mode moves

(define (root st) (make-gf (list (make-pt 0 0 0 st 3)) '())) ; Trivial starting graph. Input is solved state

(define (checkfiletype s ft)(and (index-of(string->list s)#\.) ; Check if s has file type ft
      (string=? ft (substring s (+ 1(index-of(string->list s)#\.))))))

(define (arg x y) ; Argument given 2d point
  (cond ; Pulled from Wikipedia
    [(< x 0) (atan (/ y x))]
    [(< y 0) (- (/ pi 2) (atan (/ x  y)))]
    [(> y 0) (- 0 (/ pi 2) (atan (/ x y)))]
    [(> x 0) (+ pi (atan (/ y x)))]))

(define (slide a b c d x) ; _/' graph pattern. For edge length depth coloring
  (cond
    [(<= x a) c]
    [(>= x b) d]
    [else (+ (/ (* x (- d c)) (- b a)) c (/ (* (- c d) a) (- b a)))]))

(define (hsv H S V) ; Convert HSV to RGB
  (let
      ([C (* V S)]
       [X (* V S (- 1 (abs (/ (- (remainder H 120) 60) 60))))])
    (let
        ([m (- V C)]
         [RGB
          (cond
            [(<=   0 H  60) (list C X 0)]
            [(<=  60 H 120) (list X C 0)]
            [(<= 120 H 180) (list 0 C X)]
            [(<= 180 H 240) (list 0 X C)]
            [(<= 240 H 300) (list X 0 C)]
            [(<= 300 H 360) (list C 0 X)])])
      (make-color
       (inexact->exact(floor(* (+ (first  RGB) m) 255)))
       (inexact->exact(floor(* (+ (second RGB) m) 255)))
       (inexact->exact(floor(* (+ (third  RGB) m) 255)))))))

; (mi minimum z-coor) (ma maximum z-coor) (za pt-a z-coor) (zb pt-b z-coor) (hu hue) (sa saturation)
(define (col mi ma za zb hu sa) ; Edge color given proper values.
  (let ([va (slide mi ma 0.4 1 (/ (+ za zb) 2))])
    (hsv hu sa va)))

(define (loadpuzzle si) ; Create new puzzle info. On failue, output si.
  (with-handlers([exn:fail?(lambda(x)si)])
   (let ([lines (file->lines(get-file))])
     (let ([parse (map(lambda(x)
                    (map(lambda(y)
                      (map string->number(string-split y)))
                        (string-split x"|")))
                      lines)])
       (if
        (= 1(apply *
          (map(lambda(x)
             (if(and (=(+ 1(length(first parse)))(length x))
                    (= 2(length(first x))))1 0))
            (drop parse 1))))
        (make-sc
         (root (first parse)) -1 -1 80 0
         (map(lambda(x)(list(first x)(lambda(y)(move y (drop x 1)))))(drop parse 1)))
        si)))))

(define (drgf gf ds) ; Draw Graph. Take in grpah data and zoom.
  (overlay
   (foldl ; Plot points onto empt canvas
    (lambda(x y)
     (place-image
      (circle size'solid(list-ref colors (max 0 (pt-ty x))))
      (+ (* (pt-x x) ds) (* size 2) (/ width 2))
      (+ (* (pt-y x) ds) (* size 2) (/ width 2))
      y))
    empt (gf-pts gf))
   (foldl ; Plot edges onto empt canvas
    (lambda(x y)
      (let
          ([a (list-ref (gf-pts gf) (first x))] ; First point
           [b (list-ref (gf-pts gf) (second x))] ; Second point
           [mi (apply min (map pt-z (gf-pts gf)))] ; Minimum z-coor
           [ma (apply max (map pt-z (gf-pts gf)))]) ; Maximum z-coor
        (scene+line y
         (+ (* (pt-x a) ds) (* size 2) (/ width 2))
         (+ (* (pt-y a) ds) (* size 2) (/ width 2))
         (+ (* (pt-x b) ds) (* size 2) (/ width 2))
         (+ (* (pt-y b) ds) (* size 2) (/ width 2))
         (col mi ma (pt-z a) (pt-z b) (third x) (fourth x)))))
    empt (gf-cns gf))
   back))

(define (rot gf t f) ; Rotate graph given theta and phi
  (make-gf
   (map
    (lambda(p)
      (let
        ([x  (pt-x p)] [y  (pt-y p)] [z  (pt-z p)] [St (sin t)] [Ct (cos t)] [Sf (sin f)] [Cf (cos f)])
        (make-pt
         (+ (* y Sf Cf (- Ct 1)) (* x (+ (* Sf Sf) (* Cf Cf Ct))) (* z St Cf -1))
         (+ (* x Sf Cf (- Ct 1)) (* y (+ (* Cf Cf) (* Sf Sf Ct))) (* z St Sf -1))
         (+ (* x Cf St) (* y Sf St) (* z Ct))
         (pt-st p) (pt-ty p))))
    (gf-pts gf)) (gf-cns gf)))

(define (pan gf x y z) ; Pan graph given x y and z
  (make-gf
   (map (lambda(w) (make-pt (+ (pt-x w) x) (+ (pt-y w) y) (+ (pt-z w) z) (pt-st w) (pt-ty w)))
    (gf-pts gf)) (gf-cns gf)))

(define (drg gf dx dy) ; Pan only selected nodes. z-coor unchanged.
  (make-gf
   (map (lambda(w) (if (negative? (pt-ty w)) (make-pt(+ (pt-x w) dx)(+ (pt-y w) dy)(pt-z w)(pt-st w)(pt-ty w)) w))
    (gf-pts gf)) (gf-cns gf)))

(define (sel gf x y ds) ; Select nodes nearby mouse.
  (make-gf
   (map
    (lambda(w)
      (cond
        [(let ([px (+ (* ds (pt-x w)) (* 2 size) (/ width 2))] [py (+ (* ds (pt-y w)) (* 2 size) (/ width 2))])
           (<= (+ (expt (- px x) 2) (expt (- py y) 2)) (expt size 2)))
         (make-pt (pt-x w) (pt-y w) (pt-z w) (pt-st w) (-(pt-ty w)))]
        [else w]))
    (gf-pts gf)) (gf-cns gf)))

(define (mid gf) ; Center the graph
  (let ([x (/ (apply + (map (lambda(x)(pt-x x))(gf-pts gf))) (length(gf-pts gf)))]
        [y (/ (apply + (map (lambda(y)(pt-y y))(gf-pts gf))) (length(gf-pts gf)))]
        [z (/ (apply + (map (lambda(z)(pt-z z))(gf-pts gf))) (length(gf-pts gf)))])
    (pan gf (- x) (- y) (- z))))

(define (des gf) ; Deselect all nodes.
  (make-gf
   (map
    (lambda(x) (make-pt (pt-x x) (pt-y x) (pt-z x) (pt-st x) (abs (pt-ty x))))
    (gf-pts gf)) (gf-cns gf)))

(define (sca gf) ; Output optimal scale value
  (let ([gc (mid gf)])
    (let ([m
           (apply max
            (map
             (lambda(x) (sqrt (+ (expt (pt-x x) 2) (expt (pt-y x) 2) (expt (pt-z x) 2))))
             (gf-pts gc)))])
      (/ 80 (expt 1/3 1/2) (max m 0.1)))))

(define (force-intermediate gf) ; Outputs list of tuples to be summed for each point.
  (build-list (length (gf-pts gf)) ; Each tuple contains the original point coor at its position in the tuple.
   (lambda(x) ; Each other position contains the force vector of either repulsive or attractive.
     (let
         ([con ; List of connected points
           (map
            (lambda(y) (if (=(first y)x) (second y) (first y)))
            (filter
             (lambda(y) (or (=(first y)x) (=(second y)x)))
             (gf-cns gf)))])
       (let
           ([conlis ; Boolean Connection
             (map
              (lambda(y) (= 0(count(lambda(z)(= y z))con)))
              (range(length(gf-pts gf))))])
         (build-list (length (gf-pts gf))
          (lambda(y)
            (let
                ([d
                  (max 0.001
                   (sqrt (+
                    (expt (- (pt-x(list-ref (gf-pts gf) x)) (pt-x(list-ref (gf-pts gf) y)))2)
                    (expt (- (pt-y(list-ref (gf-pts gf) x)) (pt-y(list-ref (gf-pts gf) y)))2)
                    (expt (- (pt-z(list-ref (gf-pts gf) x)) (pt-z(list-ref (gf-pts gf) y)))2))))])
              (let
                  ([ix (/ (- (pt-x(list-ref (gf-pts gf) y)) (pt-x(list-ref (gf-pts gf) x)))d)]
                   [iy (/ (- (pt-y(list-ref (gf-pts gf) y)) (pt-y(list-ref (gf-pts gf) x)))d)]
                   [iz (/ (- (pt-z(list-ref (gf-pts gf) y)) (pt-z(list-ref (gf-pts gf) x)))d)])
                (cond
                  [(= x y)(list (pt-x(list-ref (gf-pts gf) x)) (pt-y(list-ref (gf-pts gf) x)) (pt-z(list-ref (gf-pts gf) x)))]
                  [(list-ref conlis y) (list (* ix kq (/ -1 d d)) (* iy kq (/ -1 d d)) (* iz kq (/ -1 d d)))]
                  [else (list (* ix ks (- d dd)) (* iy ks (- d dd)) (* iz ks (- d dd)))]))))))))))

(define (force gf) ; Returns updated graph with forces applied to each point.
  (let ([f (force-intermediate gf)])
    (make-gf
     (build-list
      (length (gf-pts gf))
      (lambda(x)
        (make-pt
         (apply + (map first  (list-ref f x)))
         (apply + (map second (list-ref f x)))
         (apply + (map third  (list-ref f x)))
         (pt-st (list-ref (gf-pts gf) x))
         (pt-ty (list-ref (gf-pts gf) x)))))
     (gf-cns gf))))

(define (move s m) ; Apply move m to state s.
 (build-list (length s)
  (lambda(x)
   (let([y(list-ref m x)]
        [z(list-ref s (first (list-ref m x)))])
    (list (first z)
     (remainder(+ (second z) (second y))(third y)))))))

(define (newnodes pt mv) ; Output list of new points from given moves
  (map (lambda(x) (list (first x)
                        (make-pt
                         (+ (mrand) (pt-x pt))
                         (+ (mrand) (pt-y pt))
                         (+ (mrand) (pt-z pt))
                         ((second x) (pt-st pt)) 1))) mv))

(define (gen1 unused si) ; Generate new nodes from first selected.
  (let ([temp (index-of(map(lambda(x)(sgn(pt-ty x)))(gf-pts(sc-gf si)))-1)])
    (let ([s
           (cond
             [temp temp]
             [(index-of (map pt-ty (gf-pts(sc-gf si))) 1) (index-of (map pt-ty (gf-pts(sc-gf si))) 1)]
             [else 0])])
      (if (and (= s 0) (> (length (gf-cns(sc-gf si))) 0))
       (make-sc
        (make-gf
         (list-update (gf-pts(sc-gf si)) 0
          (lambda(x) (make-pt (pt-x x) (pt-y x) (pt-z x) (pt-st x) 3)))
         (gf-cns(sc-gf si)))
        (sc-mx si) (sc-my si) (sc-ds si) (sc-md si) (sc-mv si))
       (let ([nn (newnodes (list-ref(gf-pts(sc-gf si))s) (sc-mv si))]
             [ts (map pt-st (gf-pts(sc-gf si)))])
         (let
             ([n- (filter (lambda(x)(index-of ts (pt-st (second x)))) nn)]
              [n+ (filter (lambda(x)(not(index-of ts (pt-st (second x))))) nn)])
           (make-sc
            (make-gf
             (append
              (list-update (gf-pts(sc-gf si)) s
               (lambda(x) (make-pt (pt-x x) (pt-y x) (pt-z x) (pt-st x) (if (= (abs(pt-ty x)) 3) 3 2))))
              (map second n+))
             (append
              (gf-cns(sc-gf si))
              (build-list (length n+)
               (lambda(x) (append(list s (+ x (length(gf-pts(sc-gf si)))))(first(list-ref n+ x)))))
              (map
               (lambda(x)(append(list s(second x))(first x)))
               (filter
                (lambda(x)(map(lambda(l)(not(or(equal?(list s(second x))(take l 2))(equal?(list(second x)s)(take l 2)))))(gf-cns(sc-gf si))))
                (map (lambda(x)(list (first x) (index-of (map pt-st (gf-pts(sc-gf si))) (pt-st(second x))))) n-)))))
            (sc-mx si) (sc-my si) (sc-ds si) (sc-md si) (sc-mv si))))))))

(define (genall si) ; Generate all selected nodes
  (foldl gen1 si
         (let([c (count(lambda(x)(negative?(pt-ty x)))(gf-pts(sc-gf si)))])
           (build-list (if (> c 0)c(max 1(count(lambda(x)(= 1(pt-ty x)))(gf-pts(sc-gf si))))) integer?))))

;Menu buttons. "TOGGLE" is replaced to three different modes.
(define menutext (list "Load" "Reset" "Generate" "Force" "Center" "Scale" "TOGGLE" "Deselect"))

(define (draw si) ; Draw app screen.
  (beside
   (drgf (sc-gf si) (sc-ds si)) ; Graph screen
   (overlay/align/offset 'center 'top ; Below is menu screen
    (apply above
     (build-list
      (length menutext)
      (lambda(x)
       (let([y (cond ; Replace "TOGGLE" with appropriate mode.
                 [(not(string=?"TOGGLE"(list-ref menutext x)))(list-ref menutext x)]
                 [(= (sc-md si) 0) "Rotate Mode"]
                 [(= (sc-md si) 1) "Pan Mode"]
                 [else "Drag Mode"])])
         (above
          (overlay
           (text y 15'black)
           (if
            (and
             (<= (+ width margin) (sc-mx si) (- (+ width menu) margin))
             (<= (+ (* x (+ buttony gap)) margin) (sc-my si) (+ (* x (+ buttony gap)) buttony margin)))
            buttona buttonb))
          (square gap 0'red))))))
    0 (- margin)
    (rectangle menu height 'solid 'gainsboro))))

(define (mouse si x y e) ; Update app according to mouse interactions
  (cond
    [(<= x width) ; Mouse in graph screen
     (make-sc
      (let ([dx (- x (sc-mx si))] [dy (- y (sc-my si))])
        (cond
          [(and (not (and (= dx 0) (= dy 0))) (string=? "drag" e)) ; Mouse drag
           (cond 
             [(= (sc-md si) 0) (rot (sc-gf si) (/ (+ (abs dx) (abs dy)) pi 64) (arg dx dy))] ; rotate
             [(= (sc-md si) 1) (pan (sc-gf si) (/ dx (sc-ds si)) (/ dy (sc-ds si)) 0)] ; pan
             [else (drg (sc-gf si) (/ dx (sc-ds si)) (/ dy (sc-ds si)))])] ; drag
          [(string=? "button-down" e) (sel (sc-gf si) x y (sc-ds si))] ; Select nodes
          [else (sc-gf si)])) x y (sc-ds si) (sc-md si) (sc-mv si))] ; No chagne
    [(and (string=? "button-down" e) (>= x width) (<= (+ width margin) (sc-mx si) (- (+ width menu) margin)))
     (let ([x1 (inexact->exact(floor(/(- y margin)(+ buttony gap))))] [x2 (inexact->exact(floor(/(- (+ y gap) margin)(+ buttony gap))))])
       (cond ; Mouse in menu screen (Check menutext for each item interaction.)
         [(= x1 x2 0) (loadpuzzle si)]
         [(= x1 x2 1) (make-sc (root (pt-st(first(gf-pts(sc-gf si))))) x y 80 (sc-md si) (sc-mv si))]
         [(= x1 x2 2) (genall si)]
         [(= x1 x2 3) (make-sc (force (sc-gf si)) x y (sc-ds si) (sc-md si) (sc-mv si))]
         [(= x1 x2 4) (make-sc (mid (sc-gf si)) x y (sc-ds si) (sc-md si) (sc-mv si))]
         [(= x1 x2 5) (make-sc (sc-gf si) x y (sca (sc-gf si)) (sc-md si) (sc-mv si))]
         [(= x1 x2 6) (make-sc (sc-gf si) x y (sc-ds si) (remainder (+ (sc-md si) 1) 3) (sc-mv si))]
         [(= x1 x2 7) (make-sc (des (sc-gf si)) x y (sc-ds si) (sc-md si) (sc-mv si))]
         [else (make-sc (sc-gf si) x y (sc-ds si) (sc-md si) (sc-mv si))]))]
    [else (make-sc (sc-gf si) x y (sc-ds si) (sc-md si) (sc-mv si))]))

(define (key si k) ; Update app by keyboard input
  (make-sc
   (cond
     [(string=? "l" k) (loadpuzzle si)] ; Load (See #key)
     [(string=? "r" k) (root (pt-st(first(gf-pts(sc-gf si)))))] ; Reset (See #key)
     [(string=? "g" k) (sc-gf(genall si))] ; Generate (See #mouse)
     [(string=? "f" k) (force (sc-gf si))] ; Force (See #mouse) Allows for continuous forcing
     [(string=? "c" k) (mid (sc-gf si))] ; Center (See #mouse)
     [(string=? "d" k) (des (sc-gf si))] ; Deselect (See #mouse)
     [else (sc-gf si)])
   (sc-mx si) (sc-my si)
   (cond
     [(string=? "wheel-up"   k) (* (sc-ds si) 1.05)] ; Zoom in
     [(string=? "wheel-down" k) (/ (sc-ds si) 1.05)] ; Zoom out
     [(string=? "s" k) (sca (sc-gf si))] ; Reset (See #mouse)
     [else (sc-ds si)])
   (if (string=? "m" k) (remainder (+ (sc-md si) 1) 3) (sc-md si)) (sc-mv si)))

(define st (make-sc (root 0) -1 -1 80 0'()))
(big-bang st (to-draw draw) (on-mouse mouse) (on-key key))