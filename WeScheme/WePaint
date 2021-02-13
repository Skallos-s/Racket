;1      circle stamp
;2      square stamp
;3      triangle stamp
;4      star stamp
;q      up red value
;a      down red value
;w      up green value
;s      down green value
;e      up blue value
;d      down blue value
;up     up size
;down   down size
;left   rotate left
;right  rotate right
;f1     toggle stat
;f2     return size
;f3     return rote
;f4     clear screen
(define-struct pic(image xp yp r g b size shape stat rote))
(define(rgb r g b)(above(square 20'solid(make-color r g b))(text(number->string r)20'red)(text(number->string g)20'green)(text(number->string b)20'blue)))
(define(draw pac)(put-image(rotate(pic-rote pac)((pic-shape pac)(pic-size pac)'solid(make-color(pic-r pac)(pic-g pac)(pic-b pac))))(pic-xp pac)(- 480(pic-yp pac))(beside(pic-image pac)(if(negative?(pic-stat pac))(square 0 0'red)(beside(rectangle 5 480'solid'black)(overlay(rgb(pic-r pac)(pic-g pac)(pic-b pac))(rectangle 50 480'solid(if(=(pic-stat pac)1)'black'yellow))))))))
(define(mouse pac xq yq mode)(make-pic(if(or(string=?"button-down"mode)(string=?"drag"mode))(put-image(rotate(pic-rote pac)((pic-shape pac)(pic-size pac)'solid(make-color(pic-r pac)(pic-g pac)(pic-b pac))))(pic-xp pac)(- 480(pic-yp pac))(pic-image pac))(pic-image pac))xq yq(pic-r pac)(pic-g pac)(pic-b pac)(pic-size pac)(pic-shape pac)(if(or(string=?"drag"mode)(string=?"button-down"mode))(*(sgn(pic-stat pac))2)(sgn(pic-stat pac)))(pic-rote pac)))
(define(keypress pac key)(make-pic(if(string=?"f4"key)(rectangle 640 480'solid'white)(pic-image pac))(pic-xp pac)(pic-yp pac)(if(and(string=?"q"key)(not(=(pic-r pac)255)))(+(pic-r pac)1)(if(and(string=?"a"key)(not(=(pic-r pac)0)))(-(pic-r pac)1)(pic-r pac)))(if(and(string=?"w"key)(not(=(pic-g pac)255)))(+(pic-g pac)1)(if(and(string=?"s"key)(not(=(pic-g pac)0)))(-(pic-g pac)1)(pic-g pac)))(if(and(string=?"e"key)(not(=(pic-b pac)255)))(+(pic-b pac)1)(if(and(string=?"d"key)(not(=(pic-b pac)0)))(-(pic-b pac)1)(pic-b pac)))(if(string=?"f2"key)10 (if(and(string=?"down"key)(not(=(pic-size pac)0)))(-(pic-size pac)1)(if(string=?"up"key)(+(pic-size pac)1)(pic-size pac))))(cond[(string=?"1"key)circle][(string=?"2"key)square][(string=?"3"key)triangle][(string=?"4"key)star][else(pic-shape pac)])(if(string=?"f1"key)(-(pic-stat pac))(pic-stat pac))(cond[(string=?"f3"key)0][(string=?"left"key)(if(=(pic-rote pac)359)0(+(pic-rote pac)1))][(string=?"right"key)(if(=(pic-rote pac)0)359(-(pic-rote pac)1))][else(pic-rote pac)])))
(big-bang(make-pic(rectangle 640 480'solid'white)0 0 0 0 0 10 circle 1 0)(on-key keypress)(on-mouse mouse)(to-draw draw))
