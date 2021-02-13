#lang racket

 (require 2htdp/image)
 (require 2htdp/universe)

;Call Color Triplet From List
;If -1 Then Transparent
(define
  (calcol li n)
  (if
   (=
    (list-ref li(* n 3))
    -1)
   (make-color 0 0 0 0)
   (make-color
    (list-ref li(* n 3))
    (list-ref li(+(* n 3)1))
    (list-ref li(+(* n 3)2)))))

;Creates A 4x4 Sprite From List
;Uses calcol
;2 Functions For Optimization
(define
  (spriterow li r)
  (beside
   (square 2'solid(calcol li r))
   (square 2'solid(calcol li(+ r 1)))
   (square 2'solid(calcol li(+ r 2)))
   (square 2'solid(calcol li(+ r 3)))))
(define
  (sprite li)
  (freeze
   (above
    (spriterow li 0)
    (spriterow li 4)
    (spriterow li 8)
    (spriterow li 12))))



#| Big improvement here. Instead of painfully drawing out each sprite and having everything be inconsistant, all 4x4 sprites are now generated from a Bitmap |#


;Achievement Sprites
;Encoded as Bitmaps

;Cookie Achievement 1
(define li1(list
 -01 -01 -01 209 051 000 209 051 000 -01 -01 -01
 209 051 000 052 012 000 209 051 000 209 051 000
 209 051 000 209 051 000 209 051 000 052 012 000
 -01 -01 -01 209 051 000 209 051 000 -01 -01 -01))

;Cookie Achievement 2
(define li2(list
 -01 -01 -01 255 105 110 255 105 110 -01 -01 -01
 255 105 110 255 000 110 255 105 110 255 105 110
 255 105 110 255 105 110 255 105 110 255 000 110
 -01 -01 -01 255 105 110 255 105 110 -01 -01 -01))

;Cookie Achievement 3
(define li3(list
 -01 -01 -01 255 247 102 255 247 102 -01 -01 -01
 255 247 102 184 174 000 255 247 102 255 247 102
 255 247 102 255 247 102 255 247 102 184 174 000
 -01 -01 -01 255 247 102 255 247 102 -01 -01 -01))

;Cookie Achievement 4
(define li4(list
 -01 -01 -01 000 234 218 000 234 218 -01 -01 -01
 000 234 218 000 135 126 000 234 218 000 234 218
 000 234 218 000 234 218 000 234 218 000 135 126
 -01 -01 -01 000 234 218 000 234 218 -01 -01 -01))

;Cheat Cookie
(define li5(list
 -01 -01 -01 255 000 000 255 000 000 -01 -01 -01
 255 000 000 000 000 000 255 000 000 255 000 000
 255 000 000 255 000 000 255 000 000 000 000 000
 -01 -01 -01 255 000 000 255 000 000 -01 -01 -01))

;Clicker Achievement
(define li6(list
 000 000 000 000 000 000 -01 -01 -01 -01 -01 -01
 000 000 000 255 255 255 000 000 000 -01 -01 -01
 -01 -01 -01 000 000 000 255 255 255 000 000 000
 -01 -01 -01 -01  -01 -01 000 000 000 -01 -01 -01))

;Grandma Achievement
(define li7(list
 -01 -01 -01 -01 -01 -01 -01 -01 -01 -01 -01 -01
 -01 -01 -01 255 000 110 255 000 110 -01 -01 -01
 255 000 110 255 105 110 255 105 110 255 000 110
 127 000 055 127 000 055 127 000 055 127 000 055))

;Mine Achievement
(define li8(list
 128 128 128 -01 -01 -01 -01 -01 -01 128 128 128
 128 128 128 043 021 000 043 021 000 128 128 128
 128 128 128 043 021 000 043 021 000 128 128 128
 128 128 128 -01 -01 -01 -01 -01 -01 128 128 128))

;3D Printer Achievement
(define li9(list
 -01 -01 -01 122 122 122 122 122 122 122 122 122
 -01 -01 -01 191 191 191 -01 -01 -01 122 122 122
 -01 -01 -01 209 051 000 209 051 000 122 122 122
 063 063 063 063 063 063 063 063 063 063 063 063))

;Factory Achievement
(define li10(list
 -01 -01 -01 127 127 127 -01 -01 -01 127 127 127
 127 127 127 198 017 017 127 127 127 198 017 017
 198 017 017 017 017 024 017 017 024 198 017 017
 198 017 017 198 017 017 198 017 017 198 017 017))

;Chemistry Lab Achievement
(define li11(list
 193 193 193 083 193 062 083 193 062 193 193 193
 193 193 193 083 193 062 083 147 062 193 193 193
 193 193 193 083 147 062 083 147 062 193 193 193
 -01 -01 -01 193 193 193 193 193 193 -01 -01 -01))

;Duplicator Achievement
(define li12(list
 000 000 000 064 064 064 064 064 064 064 064 064
 000 000 000 255 000 000 067 255 000 064 064 064
 000 000 000 067 255 000 255 000 000 064 064 064
 000 000 000 000 000 000 000 000 000 000 000 000))

;Time Machine Achievement
(define li13(list
 -01 -01 -01 127 127 127 191 191 191 -01 -01 -01
 000 000 127 000 000 127 000 000 127 000 000 127
 000 000 127 112 112 255 255 255 000 000 000 127
 000 000 127 000 000 127 000 000 127 000 000 127))

;Portal Achievement
(define li14(list
 -01 -01 -01 255 106 000 255 106 000 -01 -01 -01
 255 106 000 255 255 255 255 255 255 000 038 255
 255 106 000 255 255 255 255 255 255 000 038 255
 -01 -01 -01 000 038 255 000 038 255 -01 -01 -01))

;Prism Achievement
(define li15(list
 -01 -01 -01 -01 -01 -01 255 000 000 255 000 000
 -01 -01 -01 255 000 000 255 255 000 255 255 000
 255 000 000 255 255 000 000 255 000 000 255 000
 255 000 000 255 255 000 000 255 000 000 000 255))

;Large Hadron Collider Achievement
(define li16(list
 -01 -01 -01 -01 -01 -01 255 216 000 -01 -01 -01
 127 000 000 255 216 000 255 106 000 -01 -01 -01
 -01 -01 -01 127 000 000 255 000 000 255 106 000
 -01 -01 -01 255 000 000 -01 -01 -01 -01 -01 -01))

;Elf Achievement
(define li17(list
 -01 -01 -01 -01 -01 -01 -01 -01 -01 255 255 000
 -01 -01 -01 -01 -01 -01 000 147 000 -01 -01 -01
 -01 -01 -01 000 147 000 000 147 000 -01 -01 -01
 255 000 000 255 000 000 255 000 000 255 000 000))

;Upgrade Achievement
(define li18(list
 -01 -01 -01 000 255 000 000 255 000 -01 -01 -01
 000 255 000 000 255 000 000 255 000 000 255 000
 000 255 000 000 255 000 000 255 000 000 255 000
 -01 -01 -01 000 255 000 000 255 000 -01 -01 -01))

;Base 10 Achievement
(define li19(list
 000 148 255 -01 -01 -01 -01 -01 -01 -01 -01 -01
 000 038 255 000 019 127 000 019 127 000 019 127
 000 148 255 000 019 127 -01 -01 -01 000 019 127
 -01 -01 -01 000 019 127 000  019 127 000 019 127))

;Binary Achievement
(define li20(list
 000 255 033 -01 -01 -01 -01 -01 -01 -01 -01 -01
 000 187 033 000 127 014 000 127 014 000 127 014
 000 255 033 000 127 014 -01 -01 -01 000 127 014
 -01 -01 -01 000 127 014 000 127 014 000 127 014))

;Time Achievement
(define li21(list
 -01 -01 -01 239 239 239 198 198 198 -01 -01 -01
 198 198 198 255 255 255 255 255 255 239 239 239
 239 239 239 255 255 255 255 255 255 198 198 198
 -01 -01 -01 198 198 198 239 239 239 -01 -01 -01))
 
;Spend Achievement
(define li22(list
 -01 -01 -01 000 240 000 000 205 000 -01 -01 -01
 -01 -01 -01 000 205 000 -01 -01 -01 -01 -01 -01
 -01 -01 -01 -01 -01 -01 000 205 000 -01 -01 -01
 -01 -01 -01 000 205 000 000 240 000 -01 -01 -01))

;Nyan Achievements
(define Q1a(list
 -01 -01 -01 -01 -01 -01 000 000 000 -01 -01 -01
 -01 -01 -01 000 000 000 000 000 000 -01 -01 -01
 000 000 000 153 153 153 000 000 000 -01 -01 -01
 153 153 153 255 255 255 073 073 073 000 000 000))

(define Q2a(list
 -01 -01 -01 000 000 000 -01 -01 -01 -01 -01 -01
 -01 -01 -01 000 000 000 000 000 000 -01 -01 -01
 -01 -01 -01 000 000 000 153 153 153 000 000 000
 000 000 000 153 153 153 255 255 255 073 073 073))

(define Q3a(list
 000 000 000 153 153 153 073 073 073 073 073 073
 000 000 000 153 153 153 255 153 153 153 153 153
 000 000 000 153 153 153 153 153 153 153 153 153
 -01 -01 -01 000 000 000 000 000 000 000 000 000))

(define Q4a(list
 153 153 153 073 073 073 073 073 073 000 000 000
 153 153 153 153 153 153 255 153 153 000 000 000
 153 153 153 153 153 153 153 153 153 000 000 000
 000 000 000 000 000 000 000 000 000 -01 -01 -01))

;Nayn Achievements
(define Q1b(list
 -01 -01 -01 -01 -01 -01 000 000 000 -01 -01 -01
 -01 -01 -01 000 000 000 000 000 000 -01 -01 -01
 000 000 000 025 025 025 000 000 000 -01 -01 -01
 255 000 000 255 255 255 025 025 025 000 000 000))

(define Q2b(list
 -01 -01 -01 000 000 000 -01 -01 -01 -01 -01 -01
 -01 -01 -01 000 000 000 000 000 000 -01 -01 -01
 -01 -01 -01 000 000 000 025 025 025 000 000 000
 000 000 000 255 000 000 255 255 255 025 025 025))

(define Q3b(list
 000 000 000 255 000 000 255 000 000 025 025 025
 000 000 000 255 153 153 025 025 025 025 025 025
 000 000 000 025 025 025 025 025 025 025 025 025
 -01 -01 -01 000 000 000 000 000 000 000 000 000))

(define Q4b(list
 255 000 000 255 000 000 025 025 025 000 000 000
 025 025 025 255 153 153 025 025 025 000 000 000
 025 025 025 025 025 025 025 025 025 000 000 000
 000 000 000 000 000 000 000 000 000 -01 -01 -01))

#|These are used to make accessing the sprites with fewer characters|#
;Quick Reference
(define ac1 (freeze(sprite li1 )))
(define ac2 (freeze(sprite li2 )))
(define ac3 (freeze(sprite li3 )))
(define ac4 (freeze(sprite li4 )))
(define ac5 (freeze(sprite li5 )))
(define ac6 (freeze(sprite li6 )))
(define ac7 (freeze(sprite li7 )))
(define ac8 (freeze(sprite li8 )))
(define ac9 (freeze(sprite li9 )))
(define ac10(freeze(sprite li10)))
(define ac11(freeze(sprite li11)))
(define ac12(freeze(sprite li12)))
(define ac13(freeze(sprite li13)))
(define ac14(freeze(sprite li14)))
(define ac15(freeze(sprite li15)))
(define ac16(freeze(sprite li16)))
(define ac17(freeze(sprite li17)))
(define ac18(freeze(sprite li18)))
(define ac19(freeze(sprite li19)))
(define ac20(freeze(sprite li20)))
(define ac21(freeze(sprite li21)))
(define ac22(freeze(sprite li22)))

;Nyan Cat & Tac Nayn Sprite
;2X Detail
;Uses 4 Bitmap sprites
(define nyan
  (freeze
   (scale
    0.5
    (above
     (beside
      (sprite Q2a)
      (sprite Q1a))
     (beside
      (sprite Q3a)
      (sprite Q4a))))))
(define nayn
  (freeze
   (scale
    0.5
    (above
     (beside
      (sprite Q2b)
      (sprite Q1b))
     (beside
      (sprite Q3b)
      (sprite Q4b))))))

#| These sprites are the backgrounds for the Achievement sprites.

'dark' is used when an achievement is locked.
'back' is used as a back-cover for tier-1 achievements.
'gold' is used as a back-cover for tier-2 achievements.
'onyx' is used as a back-cover for tier-3 achievements.
|#
;Back Ground Sprites
;Not Encoded As Bitmaps

(define back
 (freeze
  (overlay
   (square 12'solid(make-color 110 42 20))
   (square 16'solid(make-color 163 95 28)))))
(define dark
 (freeze
  (overlay
   (square 12'solid(make-color 109 92 87))
   (square 16'solid(make-color 160 144 128)))))
(define gold
 (freeze
  (overlay
   (square 12'solid(make-color 153 127 0))
   (square 16'solid(make-color 255 216 0)))))
(define onyx
 (freeze
  (overlay
   (square 12'solid(make-color 83 0 122))
   (square 16'solid'black))))