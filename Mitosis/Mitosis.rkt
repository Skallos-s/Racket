#lang racket

;Daniel Bujno
;BIOL 1015

;;      __      __  ______  ______  ______  ______  ______  ______
;;     / /_  __/ /\/_  __/\/_  __/\/ __  /\/ ____/\/_  __/\/ ____/\
;;    / __/\/_  / /\/ /\_\/\/ /\_\/ /\/ / / /\___\/\/ /\_\/ /\___\/
;;   / /\/_/\/ / / / / /   / / / / / / / /___  /\  / / / /___  /\
;;  / / /\_\/ / /_/ /_/   / / / / /_/ / _\__/ / /_/ /_/ _\__/ / /
;; /_/ /   /_/ /_____/\  /_/ / /_____/ /_____/ /_____/\/_____/ /
;; \_\/    \_\/\_____\/  \_\/  \_____\/\_____\/\_____\/\_____\/




(require 2htdp/image)
(require 2htdp/universe)

;Used for pathing between two points
(define (path x2 x1 t)
  (+ (* (/ t 50) x1) (* (- 1 (/ t 50)) x2)))

;; CELL BODY
(define wall_colr (make-color 107 72 8))   ;Cell Wall Color
(define cyto_colr (make-color 247 211 157));Cytoplasm Color
(define wall_widt 20) ;Wall Width
(define cyto_widt 400);Cytoplasm Widt
(define cyto_hght 300);Cytoplasm Height
(define cell ;Cell
  (overlay
   (ellipse cyto_widt cyto_hght 'solid cyto_colr)
   (ellipse
    (+ cyto_widt wall_widt wall_widt)
    (+ cyto_hght wall_widt wall_widt)
    'solid wall_colr)))
(define (cell_cyto t) ;Cytokenises Cell Body
  (overlay
   (overlay/xy
    (ellipse (path cyto_widt (- (/ cyto_widt 2) wall_widt) t) cyto_hght 'solid cyto_colr)
    (path 0 (+ (/ cyto_widt 2) wall_widt) t) 0
    (ellipse (path cyto_widt (- (/ cyto_widt 2) wall_widt) t) cyto_hght 'solid cyto_colr))
   (overlay/xy
    (ellipse
     (path (+ cyto_widt wall_widt wall_widt) (+ (/ cyto_widt 2) wall_widt) t)
     (+ cyto_hght wall_widt wall_widt)
     'solid wall_colr)
    (path 0 (+ (/ cyto_widt 2) wall_widt) t) 0
    (ellipse
     (path (+ cyto_widt wall_widt wall_widt) (+ (/ cyto_widt 2) wall_widt) t)
     (+ cyto_hght wall_widt wall_widt)
     'solid wall_colr))))

;; NUCLEUS
(define (nucw_cola alpha) (make-color 167 79 255 alpha)) ;Transparent Nucelus Wall Color
(define (nucb_cola alpha) (make-color 61 16 186 alpha))  ;Transparent Nucleus Body Color
(define nucw_colr (make-color 167 79 255)) ;Nucleus Wall Color
(define nucb_colr (make-color 61 16 186))  ;Nucleus Body Color
(define nucw_widt 10) ;Nuclus Radius
(define nucb_widt 80) ;Nucleus Wall Width
(define nucleus ;Nucleus
  (overlay
   (circle nucb_widt 'solid nucb_colr)
   (circle (+ nucb_widt nucw_widt) 'solid nucw_colr)))
(define (nucleus_alpha alpha) ;Transparent Nucleus
  (overlay
   (circle nucb_widt 'solid (nucb_cola alpha))
   (circle (+ nucb_widt nucw_widt) 'solid (nucw_cola alpha))))
(define nucleus_small ;Small Nucleus
  (overlay
   (circle (/ nucb_widt 2) 'solid nucb_colr)
   (circle (/ (+ nucb_widt nucw_widt)2) 'solid nucw_colr)))
(define (nucleus_small_alpha alpha) ;Transparent Small Nucleus
  (overlay
   (circle (/ nucb_widt 2) 'solid (nucb_cola alpha))
   (circle (/ (+ nucb_widt nucw_widt)2) 'solid (nucw_cola alpha))))

;; CHROMOSOME
(define (chrm_cola alpha) (make-color 219 0 226 alpha)) ;Transparent Chromosome Color
(define chrm_colr (make-color 219 0 226)) ;Chromosome Color
(define chrm_size 10) ;Chromosome Size
(define (chromosome_alpha alpha) ;Transparent Chromosome
  (beside
   (overlay/xy
    (rotate 10(ellipse chrm_size (* 4 chrm_size) 'solid (chrm_cola alpha)))
    0 (* 2 chrm_size)
    (rotate -10(ellipse chrm_size (* 4 chrm_size) 'solid (chrm_cola alpha))))
   (overlay/xy
    (rotate -10(ellipse chrm_size (* 4 chrm_size) 'solid (chrm_cola alpha)))
    0 (* 2 chrm_size)
    (rotate 10(ellipse chrm_size (* 4 chrm_size) 'solid (chrm_cola alpha))))))
(define chromosome ;Chromosome
  (beside
   (overlay/xy
    (rotate 10(ellipse chrm_size (* 4 chrm_size) 'solid chrm_colr))
    0 (* 2 chrm_size)
    (rotate -10(ellipse chrm_size (* 4 chrm_size) 'solid chrm_colr)))
   (overlay/xy
    (rotate -10(ellipse chrm_size (* 4 chrm_size) 'solid chrm_colr))
    0 (* 2 chrm_size)
    (rotate 10(ellipse chrm_size (* 4 chrm_size) 'solid chrm_colr)))))
(define chromatidl ;Left Chromatid
  (overlay/xy
   (rotate 10(ellipse chrm_size (* 4 chrm_size) 'solid chrm_colr))
   0 (* 2 chrm_size)
   (rotate -10(ellipse chrm_size (* 4 chrm_size) 'solid chrm_colr))))
(define chromatidr ;Right Chromatid
  (overlay/xy
   (rotate -10(ellipse chrm_size (* 4 chrm_size) 'solid chrm_colr))
   0 (* 2 chrm_size)
   (rotate 10(ellipse chrm_size (* 4 chrm_size) 'solid chrm_colr))))
(define (chromatidl_alpha alpha) ;Transparent Left Chromatid
  (overlay/xy
   (rotate 10(ellipse chrm_size (* 4 chrm_size) 'solid (chrm_cola alpha)))
   0 (* 2 chrm_size)
   (rotate -10(ellipse chrm_size (* 4 chrm_size) 'solid (chrm_cola alpha)))))
(define (chromatidr_alpha alpha) ;Transparent Right Chromatid
  (overlay/xy
   (rotate -10(ellipse chrm_size (* 4 chrm_size) 'solid (chrm_cola alpha)))
   0 (* 2 chrm_size)
   (rotate 10(ellipse chrm_size (* 4 chrm_size) 'solid (chrm_cola alpha)))))

;; SPINDLE
(define spin_colr (make-color 204 164 6)) ;Spindle Color


;; PHASES
(define (prophase t)
  (overlay/xy
   (chromosome_alpha (floor (* 255 (/ t 50))))
   (/(- 100 cyto_widt wall_widt wall_widt)2)
   (/(-   0 cyto_hght wall_widt wall_widt)2)
   (overlay/xy
    (chromosome_alpha (floor (* 255 (/ t 50))))
    (/(-   0 cyto_widt wall_widt wall_widt)2)
    (/(- 100 cyto_hght wall_widt wall_widt)2)
    (overlay/xy
     (chromosome_alpha (floor (* 255 (/ t 50))))
     (/(- -90 cyto_widt wall_widt wall_widt)2)
     (/(-  50 cyto_hght wall_widt wall_widt)2)
     (overlay
      nucleus
      cell)))))

(define (prometaphase t)
  (add-curve
   (add-curve
    (add-curve
     (add-curve
      (add-curve
       (add-curve
        (overlay/xy
         chromosome
         (/(- 100 cyto_widt wall_widt wall_widt)2)
         (/(-   0 cyto_hght wall_widt wall_widt)2)
         (overlay/xy
          chromosome
          (/(-   0 cyto_widt wall_widt wall_widt)2)
          (/(- 100 cyto_hght wall_widt wall_widt)2)
          (overlay/xy
           chromosome
           (/(- -90 cyto_widt wall_widt wall_widt)2)
           (/(-   50 cyto_hght wall_widt wall_widt)2)
           (overlay
            (nucleus_alpha (- 255 (floor (* 255 (/ t 50)))))
            cell))))
        (* wall_widt 3) (+ (/ cyto_hght 2) wall_widt) -45 1/2
        (path (* wall_widt 3) (/(+ -100 cyto_widt wall_widt wall_widt (/(image-width chromosome)2))2) t)
        (path (+ (/ cyto_hght 2) wall_widt)(/(+ cyto_hght wall_widt wall_widt (image-height chromosome))2) t)
        0 1/2
        (make-pen spin_colr 4 'solid 'round 'round))
       (- cyto_widt wall_widt wall_widt) (+ (/ cyto_hght 2) wall_widt) 225 1/2
       (path (- cyto_widt wall_widt wall_widt) (/(+ -100 cyto_widt wall_widt wall_widt (/(image-width chromosome)2/3))2) t)
       (path (+ (/ cyto_hght 2) wall_widt) (/(+ cyto_hght wall_widt wall_widt (image-height chromosome))2) t)
       180 1/2
       (make-pen spin_colr 4 'solid 'round 'round))
      (* wall_widt 3) (+ (/ cyto_hght 2) wall_widt) 45 1/2
      (path (* wall_widt 3) (/(+    0 cyto_widt wall_widt wall_widt (/(image-width chromosome)2))2) t)
      (path (+ (/ cyto_hght 2) wall_widt) (/(+ -100 cyto_hght wall_widt wall_widt (image-height chromosome))2) t)
      0 1/2
      (make-pen spin_colr 4 'solid 'round 'round))
     (- cyto_widt wall_widt wall_widt) (+ (/ cyto_hght 2) wall_widt) 135 1/2
     (path (- cyto_widt wall_widt wall_widt) (/(+    0 cyto_widt wall_widt wall_widt (/(image-width chromosome)2/3))2) t)
     (path (+ (/ cyto_hght 2) wall_widt) (/(+ -100 cyto_hght wall_widt wall_widt (image-height chromosome))2) t)
     180 1/2
     (make-pen spin_colr 4 'solid 'round 'round))
    (* wall_widt 3) (+ (/ cyto_hght 2) wall_widt) 0 1/2
    (path (* wall_widt 3) (/(+  90 cyto_widt wall_widt wall_widt (/(image-width chromosome)2))2) t)
    (path (+ (/ cyto_hght 2) wall_widt) (/(+ -50 cyto_hght wall_widt wall_widt (image-height chromosome))2) t)
    0 1/2
    (make-pen spin_colr 4 'solid 'round 'round))
   (- cyto_widt wall_widt wall_widt) (+ (/ cyto_hght 2) wall_widt) 180 1/2
   (path (- cyto_widt wall_widt wall_widt) (/(+  90 cyto_widt wall_widt wall_widt (/(image-width chromosome)2/3))2) t)
   (path (+ (/ cyto_hght 2) wall_widt) (/(+ -50 cyto_hght wall_widt wall_widt (image-height chromosome))2) t)
   180 1/2
   (make-pen spin_colr 4 'solid 'round 'round)))

(define (metaphase t)
  (add-curve
   (add-curve
    (add-curve
     (add-curve
      (add-curve
       (add-curve
        (overlay/xy
         chromosome
         (path (/(- 100 cyto_widt wall_widt wall_widt)2) (/(- (image-width chromosome) cyto_widt wall_widt wall_widt)2) t)
         (path (/(-   0 cyto_hght wall_widt wall_widt)2) (- (image-height chromosome) cyto_hght) t)
         (overlay/xy
          chromosome
          (path (/(-   0 cyto_widt wall_widt wall_widt)2) (/(- (image-width chromosome) cyto_widt wall_widt wall_widt)2) t)
          (path (/(- 100 cyto_hght wall_widt wall_widt)2) (* wall_widt -2) t)
          (overlay/xy
           chromosome
           (path (/(- -90 cyto_widt wall_widt wall_widt)2) (/(- (image-width chromosome) cyto_widt wall_widt wall_widt)2) t)
           (path (/(-   50 cyto_hght wall_widt wall_widt)2) (/(- (image-height chromosome) cyto_hght wall_widt wall_widt)2) t)
           cell)))
        (* wall_widt 3) (+ (/ cyto_hght 2) wall_widt) -45 1/2
        (path (/(+ -100 cyto_widt wall_widt wall_widt (/(image-width chromosome)2))2) (/(+ (-(image-width chromosome)) cyto_widt wall_widt wall_widt (/(image-width chromosome)2))2) t)
        (path (/(+ cyto_hght wall_widt wall_widt (image-height chromosome))2) (- cyto_hght (/(image-height chromosome)2) ) t)
        0 1/2
        (make-pen spin_colr 4 'solid 'round 'round))
       (- cyto_widt wall_widt wall_widt) (+ (/ cyto_hght 2) wall_widt) 225 1/2
       (path (/(+ -100 cyto_widt wall_widt wall_widt (/(image-width chromosome)2/3))2) (/(+ (-(image-width chromosome)) cyto_widt wall_widt wall_widt (/(image-width chromosome)2/3))2) t)
       (path (/(+ cyto_hght wall_widt wall_widt (image-height chromosome))2) (- cyto_hght (/(image-height chromosome)2) ) t)
       180 1/2
       (make-pen spin_colr 4 'solid 'round 'round))
      (* wall_widt 3) (+ (/ cyto_hght 2) wall_widt) 45 1/2
      (path (/(+    0 cyto_widt wall_widt wall_widt (/(image-width chromosome)2))2) (/(+ (-(image-width chromosome)) cyto_widt wall_widt wall_widt (/(image-width chromosome)2))2) t)
      (path (/(+ -100 cyto_hght wall_widt wall_widt (image-height chromosome))2) (+ (/ (image-height chromosome) 2) wall_widt wall_widt) t)
      0 1/2
      (make-pen spin_colr 4 'solid 'round 'round))
     (- cyto_widt wall_widt wall_widt) (+ (/ cyto_hght 2) wall_widt) 135 1/2
     (path (/(+ cyto_widt wall_widt wall_widt (/(image-width chromosome)2/3))2) (/(+ (-(image-width chromosome)) cyto_widt wall_widt wall_widt (/(image-width chromosome)2/3))2) t)
     (path (/(+ -100 cyto_hght wall_widt wall_widt (image-height chromosome))2) (+ (/ (image-height chromosome) 2) wall_widt wall_widt) t)
     180 1/2
     (make-pen spin_colr 4 'solid 'round 'round))
    (* wall_widt 3) (+ (/ cyto_hght 2) wall_widt) 0 1/2
    (path (/(+ 90 cyto_widt wall_widt wall_widt (/(image-width chromosome)2))2) (/(+ (-(image-width chromosome)) cyto_widt wall_widt wall_widt (/(image-width chromosome)2))2) t)
    (path (/(+ -50 cyto_hght wall_widt wall_widt (image-height chromosome))2) (/(+ cyto_hght wall_widt wall_widt)2) t)
    0 1/2
    (make-pen spin_colr 4 'solid 'round 'round))
   (- cyto_widt wall_widt wall_widt) (+ (/ cyto_hght 2) wall_widt) 180 1/2
   (path (/(+ 90 cyto_widt wall_widt wall_widt (/(image-width chromosome)2/3))2) (/(+ (-(image-width chromosome)) cyto_widt wall_widt wall_widt (/(image-width chromosome)2/3))2) t)
   (path (/(+ -50 cyto_hght wall_widt wall_widt (image-height chromosome))2) (/(+ cyto_hght wall_widt wall_widt)2) t)
   180 1/2
   (make-pen spin_colr 4 'solid 'round 'round)))

(define (anaphase t)
  (add-curve
   (add-curve
    (add-curve
     (add-curve
      (add-curve
       (add-curve
        (overlay/xy
         chromatidl
         (path (/(- (image-width chromosome) cyto_widt wall_widt wall_widt)2) (* wall_widt -3) t)
         (/(- (image-height chromosome) cyto_hght wall_widt wall_widt)2)
         (overlay/xy
          chromatidl
          (path (/(- (image-width chromosome) cyto_widt wall_widt wall_widt)2) (* wall_widt -3) t)
          (path (* wall_widt -2)  (/(- (image-height chromosome) cyto_hght wall_widt wall_widt)2) t)
          (overlay/xy
           chromatidl
           (path (/(- (image-width chromosome) cyto_widt wall_widt wall_widt)2) (* wall_widt -3) t)
           (path (- (image-height chromosome) cyto_hght) (/(- (image-height chromosome) cyto_hght wall_widt wall_widt)2) t)
           (overlay/xy
            chromatidr
            (path (/(- 0 cyto_widt wall_widt wall_widt)2) (- (* wall_widt 2) cyto_widt) t)
            (/(- (image-height chromosome) cyto_hght wall_widt wall_widt)2)
            (overlay/xy
             chromatidr
             (path (/(- 0 cyto_widt wall_widt wall_widt)2) (- (* wall_widt 2) cyto_widt) t)
             (path (* wall_widt -2) (/(- (image-height chromosome) cyto_hght wall_widt wall_widt)2) t)
             (overlay/xy
              chromatidr
              (path (/(- 0 cyto_widt wall_widt wall_widt)2) (- (* wall_widt 2) cyto_widt) t)
              (path (- (image-height chromosome) cyto_hght) (/(- (image-height chromosome) cyto_hght wall_widt wall_widt)2) t)
              cell))))))
        (* wall_widt 3) (+ (/ cyto_hght 2) wall_widt) -45 1/2
        (path (/(+ (-(image-width chromosome)) cyto_widt wall_widt wall_widt (/(image-width chromosome)2))2) (* wall_widt 3) t)
        (path (- cyto_hght (/(image-height chromosome)2)) (+ (/ cyto_hght 2) wall_widt) t)
        0 1/2
        (make-pen spin_colr 4 'solid 'round 'round))
       (- cyto_widt wall_widt wall_widt) (+ (/ cyto_hght 2) wall_widt) 225 1/2
       (path (/(+ (-(image-width chromosome)) cyto_widt wall_widt wall_widt (/(image-width chromosome)2/3))2) (- cyto_widt wall_widt wall_widt) t)
       (path (- cyto_hght (/(image-height chromosome)2)) (+ (/ cyto_hght 2) wall_widt) t)
       180 1/2
       (make-pen spin_colr 4 'solid 'round 'round))
      (* wall_widt 3) (+ (/ cyto_hght 2) wall_widt) 45 1/2
      (path (/(+ (-(image-width chromosome)) cyto_widt wall_widt wall_widt (/(image-width chromosome)2))2) (* wall_widt 3) t)
      (path (+ (/ (image-height chromosome) 2) wall_widt wall_widt) (+ (/ cyto_hght 2) wall_widt) t)
      0 1/2
      (make-pen spin_colr 4 'solid 'round 'round))
     (- cyto_widt wall_widt wall_widt) (+ (/ cyto_hght 2) wall_widt) 135 1/2
     (path (/(+ (-(image-width chromosome)) cyto_widt wall_widt wall_widt (/(image-width chromosome)2/3))2) (- cyto_widt wall_widt wall_widt) t)
     (path (+ (/ (image-height chromosome) 2) wall_widt wall_widt) (+ (/ cyto_hght 2) wall_widt) t)
     180 1/2
     (make-pen spin_colr 4 'solid 'round 'round))
    (* wall_widt 3) (+ (/ cyto_hght 2) wall_widt) 0 1/2
    (path (/(+ (-(image-width chromosome)) cyto_widt wall_widt wall_widt (/(image-width chromosome)2))2) (* wall_widt 3) t)
    (/(+ cyto_hght wall_widt wall_widt)2)
    0 1/2
    (make-pen spin_colr 4 'solid 'round 'round))
   (- cyto_widt wall_widt wall_widt) (+ (/ cyto_hght 2) wall_widt) 180 1/2
   (path (/(+ (-(image-width chromosome)) cyto_widt wall_widt wall_widt (/(image-width chromosome)2/3))2) (- cyto_widt wall_widt wall_widt) t)
   (/(+ cyto_hght wall_widt wall_widt)2)
   180 1/2
   (make-pen spin_colr 4 'solid 'round 'round)))

(define (telophase t)
  (overlay/xy
   (chromatidl_alpha (- 255 (floor (* 255 (/ t 50)))))
   (* wall_widt -3) (/(- (image-height chromosome) cyto_hght wall_widt wall_widt)2)
   (overlay/xy
    (chromatidr_alpha (- 255 (floor (* 255 (/ t 50)))))
    (- (* wall_widt 2) cyto_widt) (/(- (image-height chromosome) cyto_hght wall_widt wall_widt)2)
    (overlay/xy
     (nucleus_small_alpha (floor (* 255 (/ t 50))))
     (- 0 wall_widt wall_widt) (/ (- (image-height nucleus_small) cyto_hght wall_widt wall_widt)2)
     (overlay/xy
      (nucleus_small_alpha (floor (* 255 (/ t 50))))
      (- (image-width nucleus_small) cyto_widt) (/ (- (image-height nucleus_small) cyto_hght wall_widt wall_widt)2)
      cell)))))

(define (cytokinesis t)
  (overlay/xy
   nucleus_small
   (- 0 wall_widt wall_widt)
   (/ (- (image-height nucleus_small) cyto_hght wall_widt wall_widt)2)
   (overlay/xy
    nucleus_small
    (- (image-width nucleus_small) cyto_widt)
    (/ (- (image-height nucleus_small) cyto_hght wall_widt wall_widt)2)
    (cell_cyto t))))

;; OUTPUT

;Draw Function
(define (draw t)
  (overlay
   (cond
    [(< t 50 )(above (prophase t)            (overlay (text "Prohase"      20 'black) (rectangle (+ cyto_widt wall_widt wall_widt) 40 0 'red)))]
    [(< t 100)(above (prometaphase (- t 50)) (overlay (text "Prometaphase" 20 'black) (rectangle (+ cyto_widt wall_widt wall_widt) 40 0 'red)))]
    [(< t 150)(above (metaphase (- t 100))   (overlay (text "Metaphase"    20 'black) (rectangle (+ cyto_widt wall_widt wall_widt) 40 0 'red)))]
    [(< t 200)(above (anaphase (- t 150))    (overlay (text "Anaphase"     20 'black) (rectangle (+ cyto_widt wall_widt wall_widt) 40 0 'red)))]
    [(< t 250)(above (telophase (- t 200))   (overlay (text "Telophase"    20 'black) (rectangle (+ cyto_widt wall_widt wall_widt) 40 0 'red)))]
    [(< t 300)(above (cytokinesis (- t 250)) (overlay (text "Cytokinesis"  20 'black) (rectangle (+ cyto_widt wall_widt wall_widt) 40 0 'red)))]
    [else     (above (cytokinesis 50)        (overlay (text "Cytokinesis"  20 'black) (rectangle (+ cyto_widt wall_widt wall_widt) 40 0 'red)))])
   (rectangle (+ cyto_widt (* wall_widt 4)) (+ cyto_hght (* wall_widt 4) 40) 'solid 'white)))

;Save Images to PostImages
;Folder must be in same directory
;(for([i(in-range 0 301)])
;  (save-image
;   (draw i)
;   (string->path
;    (string-append
;     "PostImages\\.\\Img_"
;     (make-string
;      (- 3
;       (string-length
;        (number->string i)))
;      #\0)
;     (number->string i)
;     ".png"))))

;World Scene
(big-bang 0(on-tick add1 0.1)(to-draw draw))
