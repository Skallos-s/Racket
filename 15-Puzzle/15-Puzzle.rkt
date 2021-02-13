#lang racket
 (require 2htdp/image)
 (require 2htdp/universe)

;;Variables
(define BWM 10) ;Board Witdh  Max
(define BHM 10) ;Board Height Max
(define BFW 20) ;Board Frame Width
(define BFH 20) ;Board Frame Height

;Control Scheme
(define CS(with-handlers([exn:fail?(lambda(x)#f)])
          (substring(file->string"READ_ME.txt")18 24)))
;Reverse Controls
(define RC(with-handlers([exn:fail?(lambda(x)#f)])
          (substring(file->string"READ_ME.txt")59 62)))
;Controls List
(define CL
  (cond
    [(and(equal?"Arrows"CS)(equal?"On "RC))
     (list"w""a""s""d""up""left""down""right")]
    [(and(equal?"WASD  "CS)(equal?"On "RC))
     (list"up""left""down""right""w""a""s""d")]
    [(and(equal?"Arrows"CS)(equal?"Off"RC))
     (list"w""a""s""d""down""right""up""left")]
    [(and(equal?"WASD  "CS)(equal?"Off"RC))
     (list"up""left""down""right""s""d""w""a")]
    [else(list"w""a""s""d""up""left""down""right")]))

;Images
(define Imgs
  (filter
   (lambda(x)(not(equal? x 1)))
   (build-list 10
    (lambda(x)
     (with-handlers
      ([exn:fail?(lambda(x)1)])
      (bitmap/file
       (string->path
        (string-append
         "Assets\\.\\Img"
         (number->string(+ x 1))
         ".png"))))))))

;Max Scene
(define MS
  (overlay
   (above
    (text"Press Any Key to Begin"40'black)
    (if(nand CS  RC #t)(text"READ_ME.txt is missing"40'black)empty-image)
    (if(empty? Imgs)(text"Assets Missing or Wrong Format"40'black)empty-image))
   (rectangle
    (+(max(with-handlers([exn:fail?(lambda(x)500)])
      (apply max(map image-width  Imgs)))500)BFW BFW)
    (+(max(with-handlers([exn:fail?(lambda(x)500)])
      (apply max(map image-height Imgs)))500)BFH BFH)
    'solid'white)))

;;World Functions
;Struct Define
(define-struct gm
  (pl  ;Piece List
   pic ;Picture
   nl  ;Number List
   w   ;Board Width
   h)) ;Board Height

;Blank Tile Row
(define (BTR lst w)
  (quotient
   (index-of
    lst
    (length lst))
   w))

;Blank Tile Column
(define (BTC lst w)
  (remainder
   (index-of
    lst
    (length lst))
   w))

;List Polarity
(define (LP lst)
  (apply +
   (flatten
    (for/list([i(in-range(-(length lst)1))])
     (for/list([j(in-range(-(length lst)i 1))])
      (if(>
          (length lst)
          (list-ref lst i)
          (list-ref lst(+ i j 1)))
         1 0))))))

;List Polarity Fix
(define (LPF lst w)
  (cond
    [(and
      (or
       (and
        (odd? w)
        (odd?(LP lst)))
       (and
        (even? w)
        (odd?(+(LP lst)(BTR(reverse lst)w)))))
      (>
       (index-of lst(length lst))
       (-(length lst)2)))
     (append
      (list(list-ref lst 1))
      (list(list-ref lst 0))
      (rest(rest lst)))]
    [(or
       (and
        (odd? w)
        (odd?(LP lst)))
       (and
        (even? w)
        (odd?(+(LP lst)(BTR(reverse lst)w)))))
     (reverse
      (append
       (list
        (second(reverse lst)))
       (list(first(reverse lst)))
       (rest(rest(reverse lst)))))]
    [else lst]))

;Move Blank Left
(define (MBL lst)
  (list-set
   (list-set lst(-(index-of lst(length lst))1)(length lst))
   (index-of lst(length lst))
   (list-ref lst(-(index-of lst(length lst))1))))

;Move Blank Right
(define (MBR lst)
  (list-set
   (list-set lst(+(index-of lst(length lst))1)(length lst))
   (index-of lst(length lst))
   (list-ref lst(+(index-of lst(length lst))1))))

;Move Blank Up
(define (MBU lst w)
  (list-set
   (list-set lst(-(index-of lst(length lst))w)(length lst))
   (index-of lst(length lst))
   (list-ref lst(-(index-of lst(length lst))w))))

;Move Blank Down
(define (MBD lst w)
  (list-set
   (list-set lst(+(index-of lst(length lst))w)(length lst))
   (index-of lst(length lst))
   (list-ref lst(+(index-of lst(length lst))w))))

;Starting Sorted List
(define (SSL w h)(build-list(* w h)add1))

;Shuffled List
(define (SL w h)(LPF(shuffle(build-list(* w h)add1))w))

;Image Piece List
(define (IPL pic w h)
  (flatten
   (for/list ([i(in-range h)])
     (for/list ([j(in-range w)])
       (if
        (and(=(- h 1)i)(=(- w 1)j))
        (rectangle
         (/(image-width  pic)w)
         (/(image-height pic)h)
         'solid'black)
        (freeze
         (crop
          (/(*(image-width  pic)j)w)
          (/(*(image-height pic)i)h)
          (/(image-width  pic)w)
          (/(image-height pic)h)
          pic)))))))

;Image Draw
(define (ID g)
  (if(image?(gm-pl g))(gm-pl g)
   (overlay
    (if
     (equal?(SSL(gm-w g)(gm-h g))(gm-nl g))
     (gm-pic g)
     (apply
      above
      (map
       (lambda(x)
        (apply beside x))
       (for/list([i(in-range(gm-h g))])
        (for/list([j(in-range(gm-w g))])
         (list-ref
          (map
           (lambda(x)
             (list-ref
              (gm-pl g)(- x 1)))
           (gm-nl g))
          (+(* i(gm-w g))j)))))))
    (above
     (rectangle
      (+(*(image-width(first(gm-pl g)))(gm-w g))BFW BFW)
      BFH'solid'black)
     (beside
      (rectangle
       BFW(*(image-height(first(gm-pl g)))(gm-h g))
       'solid'black)
      (rectangle
       (*(image-width(first(gm-pl g)))(gm-w g))
       (*(image-height(first(gm-pl g)))(gm-h g))
       0'red)
      (rectangle
       BFW(*(image-height(first(gm-pl g)))(gm-h g))
       'solid'black))
     (rectangle
      (+(*(image-width(first(gm-pl g)))(gm-w g))BFW BFW)
      BFH'solid'black)))))

;Stock Image
(define (SI w h)
  (freeze
   (apply
   above
   (map
    (lambda(x)
     (apply beside x))
    (for/list([i(in-range h)])
     (for/list([j(in-range w)])
      (list-ref
       (build-list
        (* w h)
        (lambda(x)
          (overlay
           (text
            (number->string(+ x 1))
            (floor(min(/ 250 w)(/ 400 h)))'black)
           (rectangle
            (/ 500 w)(/ 500 h)'solid
            (let([lst(shuffle(list(random 256)0 255))])
              (make-color
               (first lst)
               (second lst)
               (third lst)))))))
       (+(* i w)j))))))))

;Zero Check
(define (ZC n) (if(zero? n)10 n))

;Mouse Function
(define
  (mouse g a b c)
  (if(and(image?(gm-pl g))(equal?"button-down"c))SW g))

;Key Function
(define
  (key g k)
  (cond
    [(image?(gm-pl g))SW]
    [(equal?"q"k)(let([k(SI(gm-w g)(gm-h g))])
      (make-gm(IPL k(gm-w g)(gm-h g))k(SSL(gm-w g)(gm-h g))(gm-w g)(gm-h g)))]
    [(and(string->number k)(<=(ZC(string->number k))(length Imgs)))
     (make-gm(IPL(list-ref Imgs(-(ZC(string->number k))1))(gm-w g)(gm-h g))
      (list-ref Imgs(-(string->number k)1))(SSL(gm-w g)(gm-h g))(gm-w g)(gm-h g))]
    [(equal?"r"k)(make-gm(gm-pl g)(gm-pic g)(SL(gm-w g)(gm-h g))(gm-w g)(gm-h g))]
    [(and(equal?(list-ref CL 0)k)(<(gm-h g)BHM))
     (make-gm
      (IPL(gm-pic g)(gm-w g)(+(gm-h g)1))
      (gm-pic g)
      (SSL(gm-w g)(+(gm-h g)1))
      (gm-w g)
      (+(gm-h g)1))]
    [(and(equal?(list-ref CL 1)k)(>(gm-w g)2))
     (make-gm
      (IPL(gm-pic g)(-(gm-w g)1)(gm-h g))
      (gm-pic g)
      (SSL(-(gm-w g)1)(gm-h g))
      (-(gm-w g)1)
      (gm-h g))]
    [(and(equal?(list-ref CL 2)k)(>(gm-h g)2))
     (make-gm
      (IPL(gm-pic g)(gm-w g)(-(gm-h g)1))
      (gm-pic g)
      (SSL(gm-w g)(-(gm-h g)1))
      (gm-w g)
      (-(gm-h g)1))]
    [(and(equal?(list-ref CL 3)k)(<(gm-w g)BWM))
     (make-gm
      (IPL(gm-pic g)(+(gm-w g)1)(gm-h g))
      (gm-pic g)
      (SSL(+(gm-w g)1)(gm-h g))
      (+(gm-w g)1)
      (gm-h g))]
    [(and(equal?(list-ref CL 4)k)(>(BTR(gm-nl g)(gm-w g))0))
     (make-gm
      (gm-pl g)
      (gm-pic g)
      (MBU(gm-nl g)(gm-w g))
      (gm-w g)
      (gm-h g))]
    [(and(equal?(list-ref CL 5)k)(>(BTC(gm-nl g)(gm-w g))0))
     (make-gm
      (gm-pl g)
      (gm-pic g)
      (MBL(gm-nl g))
      (gm-w g)
      (gm-h g))]
    [(and(equal?(list-ref CL 6)k)(<(BTR(gm-nl g)(gm-w g))(-(gm-h g)1)))
     (make-gm
      (gm-pl g)
      (gm-pic g)
      (MBD(gm-nl g)(gm-w g))
      (gm-w g)
      (gm-h g))]
    [(and(equal?(list-ref CL 7)k)(<(BTC(gm-nl g)(gm-w g))(-(gm-w g)1)))
     (make-gm
      (gm-pl g)
      (gm-pic g)
      (MBR(gm-nl g))
      (gm-w g)
      (gm-h g))]
    [else g]))

;Starting World
(define SW (let([k(SI 4 4)])(make-gm(IPL k 4 4)k(SSL 4 4)4 4)))
(define EW (make-gm MS 0 0 4 4))
(big-bang EW(on-key key)(on-mouse mouse)(on-draw ID))
