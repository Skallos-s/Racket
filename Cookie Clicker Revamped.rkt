#lang racket

 (require 2htdp/image)
 (require 2htdp/universe)

#|Constants|#
;Starting Time
(define m(current-seconds))

;Back Rank Amount
(define bck 50)

;Gold Rank Amount
(define gld 250)

;Onyx Rank Amount
(define nyx 500)

;Text Color
(define tcl 'black)

#| Start Functions |#

;Struct Define
(define-struct ccr (
                    cook ;Current Cookies
                    clik ;Clicker
                    grma ;Grandma
                    mine ;Mine
                    3Dpr ;3D Printer
                    fact ;Factory
                    chem ;Chemistry Lab
                    dupl ;Duplicator
                    time ;Time Machine
                    port ;Portal
                    pris ;Prism
                    hadr ;Large Hadron Collider
                    elfs ;Elf
                    meme ;Meme
                    totl ;Alltime Cookies
                    chet ;Cheat Code Level
                    upgr ;Upgrades
                         ))

(define st (make-ccr 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0))
(define fi (make-ccr 0 2048 1024 512 500 500 500 500 500 500 500 500 500 1337 (expt 10 64) 4 1000))


;Achievement Rank Functions
(define(utota x)(cond
    [(<(ccr-totl x)(expt 10 6))1]
    [(<(ccr-totl x)(expt 10 27))2]
    [(<(ccr-totl x)(expt 10 42))4]
    [else 8]))
(define(utotb x)(cond
    [(<(ccr-totl x)(expt 10 9))1]
    [(<(ccr-totl x)(expt 10 30))2]
    [(<(ccr-totl x)(expt 10 45))4]
    [else 8]))
(define(utotc x)(cond
    [(<(ccr-totl x)(expt 10 12))1]
    [(<(ccr-totl x)(expt 10 33))2]
    [(<(ccr-totl x)(expt 10 48))4]
    [else 8]))
(define(utotd x)(cond
    [(<(ccr-totl x)(expt 10 24))1]
    [(<(ccr-totl x)(expt 10 39))2]
    [(<(ccr-totl x)(expt 10 63))4]
    [else 8]))
(define(uchet x)(cond
    [(<(ccr-chet x)2)1]
    [(<(ccr-chet x)3)2]
    [(<(ccr-chet x)4)4]
    [else 8]))
(define(uclik x)(cond
    [(<(ccr-clik x)bck)1]
    [(<(ccr-clik x)gld)1.25]
    [(<(ccr-clik x)nyx)2.5]
    [else 5]))
(define(ugrma x)(cond
    [(<(ccr-grma x)bck)1]
    [(<(ccr-grma x)gld)1.25]
    [(<(ccr-grma x)nyx)2.5]
    [else 5]))
(define(umine x)(cond
    [(<(ccr-mine x)bck)1]
    [(<(ccr-mine x)gld)1.25]
    [(<(ccr-mine x)nyx)2.5]
    [else 5]))
(define(u3Dpr x)(cond
    [(<(ccr-3Dpr x)bck)1]
    [(<(ccr-3Dpr x)gld)1.25]
    [(<(ccr-3Dpr x)nyx)2.5]
    [else 5]))
(define(ufact x)(cond
    [(<(ccr-fact x)bck)1]
    [(<(ccr-fact x)gld)1.25]
    [(<(ccr-fact x)nyx)2.5]
    [else 5]))
(define(uchem x)(cond
    [(<(ccr-chem x)bck)1]
    [(<(ccr-chem x)gld)1.25]
    [(<(ccr-chem x)nyx)2.5]
    [else 5]))
(define(udupl x)(cond
    [(<(ccr-dupl x)bck)1]
    [(<(ccr-dupl x)gld)1.25]
    [(<(ccr-dupl x)nyx)2.5]
    [else 5]))
(define(utime x)(cond
    [(<(ccr-time x)bck)1]
    [(<(ccr-time x)gld)1.25]
    [(<(ccr-time x)nyx)2.5]
    [else 5]))
(define(uport x)(cond
    [(<(ccr-port x)bck)1]
    [(<(ccr-port x)gld)1.25]
    [(<(ccr-port x)nyx)2.5]
    [else 5]))
(define(upris x)(cond
    [(<(ccr-pris x)bck)1]
    [(<(ccr-pris x)gld)1.25]
    [(<(ccr-pris x)nyx)2.5]
    [else 5]))
(define(uhadr x)(cond
    [(<(ccr-hadr x)bck)1]
    [(<(ccr-hadr x)gld)1.25]
    [(<(ccr-hadr x)nyx)2.5]
    [else 5]))
(define(uelfs x)(cond
    [(<(ccr-elfs x)bck)1]
    [(<(ccr-elfs x)gld)1.25]
    [(<(ccr-elfs x)nyx)2.5]
    [else 5]))
(define(uupgr x)(cond
    [(<(ccr-upgr x)bck)1]
    [(<(ccr-upgr x)gld)1.25]
    [(<(ccr-upgr x)nyx)2.5]
    [else 5]))
(define(udeci x)(cond
    [(mold x 3 6 9 12 15 18 21 24 27 30 33 36)8]
    [(mold x 2 4 6  8 10 12 14 16 18 20 22 24)4]
    [(mold x 1 2 3  4  5  6  7  8  9 10 11 12)2]
    [else 1]))
(define(ubina x)(cond
    [(mold x 1 2 4 8 16 32 64 128 256 512 1024 2048)8]
    [(mold x 0 1 2 4  8 16 32  64 128 256  512 1024)4]
    [(mold x 0 0 1 2  4  8 16  32  64 128  256  512)2]
    [else 1]))
(define(usecs x)(cond
    [(<=(-(current-seconds)m)1800 )1]
    [(<=(-(current-seconds)m)7200 )2]
    [(<=(-(current-seconds)m)14400)4]
    [else 8]))
(define(uspnt x)(cond
    [(<=(-(ccr-totl x)(ccr-cook x))(expt 10 36))1]
    [(<=(-(ccr-totl x)(ccr-cook x))(expt 10 36))2]
    [(<=(-(ccr-totl x)(ccr-cook x))(expt 10 36))4]
    [else 8]))
(define(umem1 x)(cond
    [(<(ccr-meme x)50)1]
    [(<(ccr-meme x)200)50]
    [(<(ccr-meme x)901)420]
    [else 1337]))
(define(umem2 x)(cond
    [(<(ccr-meme x)69)1]
    [(<(ccr-meme x)420)50]
    [(<(ccr-meme x)1337)500]
    [else 9001]))
;Upgrade Improvement Function
(define (t x)
  (if (=(abs(ccr-chet x))4)
   2
   (if (=(abs(ccr-chet x))3)
    1
    (if (=(abs(ccr-chet x))2)
      0.75
      0.5))))

;Cookies Per Tick
(define (CPT x)
  (/
   (floor
    (*
     (+(*(ccr-dupl x)(udupl x))1)
     100
     (+(*(ccr-upgr x)(uchet x)(uupgr x))1)
     (+
      (*(ccr-clik x)(uclik x)0.1)
      (*(ccr-grma x)(ugrma x)0.2)
      (*(ccr-mine x)(umine x))
      (*(ccr-3Dpr x)(u3Dpr x)5)
      (*(ccr-fact x)(ufact x)10)
      (*(ccr-chem x)(uchem x)50)
      (*(ccr-time x)(utime x)100)
      (*(ccr-port x)(uport x)500)
      (*(ccr-pris x)(upris x)1000)
      (*(ccr-hadr x)(uhadr x)5000)
      (*(ccr-elfs x)(uelfs x)10000)
      (*(ccr-meme x)(umem1 x)(umem2 x)100000))))
   100))

;Cookies Per Space
(define (CPS x)
  (floor
   (*
    (+(*(ccr-dupl x)(udupl x))1)
    (+(*(ccr-upgr x)(uchet x)(uupgr x))1)
    (+
     (*(ccr-clik x)(uclik x))
     (*(ccr-grma x)(ugrma x)2)
     (*(ccr-mine x)(umine x)5)
     (*(ccr-3Dpr x)(u3Dpr x)10)
     (*(ccr-fact x)(ufact x)25)
     (*(ccr-chem x)(uchem x)125)
     (*(ccr-time x)(utime x)250)
     (*(ccr-port x)(uport x)1000)
     (*(ccr-pris x)(upris x)2500)
     (*(ccr-hadr x)(uhadr x)10000)
     (*(ccr-elfs x)(uelfs x)20000)
     (*(ccr-meme x)(umem1 x)(umem2 x)500000)))))

;Big Number Names
(define
  bnn
  (list
   ""
   "Thousand"
   "Million"
   "Billion"
   "Trillion"
   "Quadrillion"
   "Quintillion"
   "Sextillion"
   "Septillion"
   "Octillion"
   "Nonillion"
   "Decillion"
   "Undecillion"
   "Duodecillion"
   "Tredecillion"
   "Quattuordecillion"
   "Quindecillion"
   "Sexdecillion"
   "Septendecillion"
   "Octodecillion"
   "Novemdecillion"
   "Vigintillion"
   "Unvigintillion"
   "Duovigintillion"
   "Trevigintillion"
   "Quattuorvigintillion"
   "Quinvigintillion"
   "Sexvigintillion"
   "Octvigintillion"
   "Novemvigintillion"
   "Trigintillion"
   "Untrigintillion"
   "Duotrigintillion"
   "Quattuortrigintillion"
   "Quintrigintillion"
   "Sextrigintillion"
   "Octtrigintillion"
   "Novemtrigintillion"
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ""
   ))
   
;Shortens A Number For Scientific Notation
(define
  (short n)
  (substring
   (number->string(inexact->exact(floor n)))
   0
   (inexact->exact
    (+
     (remainder
      (-
       (string-length
        (number->string
         (inexact->exact
          (floor n))))
       1)
      3)
     4))))


(define
  (scinot n)
  (if (>= n 1000)
  (string-append
   (string-append
    (substring
     (short n)
     0
     (-
      (string-length
       (short n))
      3))
    "."
    (substring
     (short n)
     (-
      (string-length
       (short n))
      3)
     (+
      (-
       (string-length
        (short n))
       3)
      3)))
   " "
   (list-ref
    bnn
    (floor
     (/
      (inexact->exact
       (-
       (string-length
        (number->string
         (inexact->exact
          (floor n))))
       1))
      3))))
  (number->string(inexact->exact(floor n)))))


;Checks To See If Item Amount Exceeds Values In False List
(define (mold x a b c d e f g h i j k l)
  (and
   (>=(ccr-elfs x)a)
   (>=(ccr-hadr x)b)
   (>=(ccr-pris x)c)
   (>=(ccr-port x)d)
   (>=(ccr-time x)e)
   (>=(ccr-dupl x)f)
   (>=(ccr-chem x)g)
   (>=(ccr-fact x)h)
   (>=(ccr-3Dpr x)i)
   (>=(ccr-mine x)j)
   (>=(ccr-grma x)k)
   (>=(ccr-clik x)l)))

;Properly Overlays Achievement Images
(define (pover ac gr st)(clear-pinhole(overlay/pinhole ac(put-pinhole 8 8 (beside gr st)))))

;Price Functions
(define (p1  x) (floor(*(expt 1.15 x)10)))          ;Clicker
(define (p2  x) (floor(*(expt 1.15 x)50)))          ;Grandma
(define (p3  x) (floor(*(expt 1.15 x)500)))         ;Mine
(define (p4  x) (floor(*(expt 1.15 x)2500)))        ;3D Printer
(define (p5  x) (floor(*(expt 1.15 x)10000)))       ;Factory
(define (p6  x) (floor(*(expt 1.15 x)50000)))       ;Chemistry Lab
(define (p7  x) (floor(*(expt 1.15 x)100000)))      ;Duplicator
(define (p8  x) (floor(*(expt 1.16 x)5000000)))     ;Time Machine
(define (p9  x) (floor(*(expt 1.16 x)25000000)))    ;Portal
(define (p10 x) (floor(*(expt 1.16 x)75000000)))    ;Prism
(define (p11 x) (floor(*(expt 1.16 x)1500000000)))  ;Large Hadron Collider
(define (p12 x) (floor(*(expt 1.16 x)7500000000)))  ;Elf
(define (p13 x) (floor(*(expt 1.17 x)15000000000))) ;Meme
(define (p14 x) (floor(*(expt 1.17 x)50000)))       ;Upgrade



#| Load Sprites |#
(define ac1 (bitmap "Ac1.png" ))
(define ac2 (bitmap "Ac2.png" ))
(define ac3 (bitmap "Ac3.png" ))
(define ac4 (bitmap "Ac4.png" ))
(define ac5 (bitmap "Ac5.png" ))
(define ac6 (bitmap "Ac6.png" ))
(define ac7 (bitmap "Ac7.png" ))
(define ac8 (bitmap "Ac8.png" ))
(define ac9 (bitmap "Ac9.png" ))
(define ac10(bitmap "Ac10.png"))
(define ac11(bitmap "Ac11.png"))
(define ac12(bitmap "Ac12.png"))
(define ac13(bitmap "Ac13.png"))
(define ac14(bitmap "Ac14.png"))
(define ac15(bitmap "Ac15.png"))
(define ac16(bitmap "Ac16.png"))
(define ac17(bitmap "Ac17.png"))
(define ac18(bitmap "Ac18.png"))
(define ac19(bitmap "Ac19.png"))
(define ac20(bitmap "Ac20.png"))
(define ac21(bitmap "Ac21.png"))
(define ac22(bitmap "Ac22.png"))
(define nyan(bitmap "nyan.png"))
(define nayn(bitmap "nayn.png"))
(define dark(bitmap "dark.png"))
(define back(bitmap "back.png"))
(define gold(bitmap "gold.png"))
(define onyx(bitmap "onyx.png"))
(define bord(bitmap "bord.png"))
(define gord(bitmap "gord.png"))
(define oord(bitmap "oord.png"))


#| Store all used strings for quick access and neater code |#
#| Some Stored As Images|#
;Strings
(define nul (text"------------"14 tcl))

;Item Names
(define nm0  "Cookie"               )
(define nm1  "Clicker"              )
(define nm2  "Grandma"              )
(define nm3  "Mine"                 )
(define nm4  "3D Printer"           )
(define nm5  "Factory"              )
(define nm5p "Factories"            )
(define nm6  "Chemistry Lab"        )
(define nm7  "Duplicator"           )
(define nm8  "Time Machine"         )
(define nm9  "Portal"               )
(define nm10 "Prism"                )
(define nm11 "Large Hadron Collider")
(define nm12 "Elf"                  )
(define nm13 "Meme"                 )
(define nm14 "Upgrade"              )

;Locked Achievements
(define stac1  (text" 1M Cookies        To Unlock"14 tcl))
(define stac2  (text" 1G Cookies        To Unlock"14 tcl))
(define stac3  (text" 1T Cookies        To Unlock"14 tcl))
(define stac4  (text" 1Y Cookies        To Unlock"14 tcl))
(define stac5  (text" Use A Cheatcode   To Unlock"14 tcl))
(define stac6  (text(string-append" "(number->string bck)" Clickers       To Unlock")14 tcl))
(define stac7  (text(string-append" "(number->string bck)" Grandmas       To Unlock")14 tcl))
(define stac8  (text(string-append" "(number->string bck)" Mines          To Unlock")14 tcl))
(define stac9  (text(string-append" "(number->string bck)" 3D Printers    To Unlock")14 tcl))
(define stac10 (text(string-append" "(number->string bck)" Factories      To Unlock")14 tcl))
(define stac11 (text(string-append" "(number->string bck)" Chemistry Labs To Unlock")14 tcl))
(define stac12 (text(string-append" "(number->string bck)" Duplicators    To Unlock")14 tcl))
(define stac13 (text(string-append" "(number->string bck)" Time Machines  To Unlock")14 tcl))
(define stac14 (text(string-append" "(number->string bck)" Portals        To Unlock")14 tcl))
(define stac15 (text(string-append" "(number->string bck)" Prisms         To Unlock")14 tcl))
(define stac16 (text(string-append" "(number->string bck)" LHCs           To Unlock")14 tcl))
(define stac17 (text(string-append" "(number->string bck)" Elfs           To Unlock")14 tcl))
(define stac18 (text(string-append" "(number->string bck)" Upgrades       To Unlock")14 tcl))
(define stac19 (text" Base 10           To Unlock"14 tcl))
(define stac20 (text" Base 2            To Unlock"14 tcl))
(define stac21 (text" Waste Time        To Unlock"14 tcl))
(define stac22 (text" Spend Cookies     To Unlock"14 tcl))
(define stac23 (text" Memes             To Unlock"14 tcl))

;Standard Achievements
(define staca1  (text" Million Cookies"            14 tcl))
(define staca2  (text" Billion Cookies"            14 tcl))
(define staca3  (text" Trillion Cookies"           14 tcl))
(define staca4  (text" Septillion Cookies"         14 tcl))
(define staca5  (text" ↑ ↑ ↓ ↓ ← → ← → B A Start"  14 tcl))
(define staca6  (text" Clicker Collector"          14 tcl))
(define staca7  (text" Grandma Greed"              14 tcl))
(define staca8  (text" Mine Mob"                   14 tcl))
(define staca9  (text" 3D Printer Plethora"        14 tcl))
(define staca10 (text" Factory Frenzy"             14 tcl))
(define staca11 (text" Chemistry Lab Collection"   14 tcl))
(define staca12 (text" Duplicator Desire"          14 tcl))
(define staca13 (text" Time Machine Turmoil"       14 tcl))
(define staca14 (text" Portal Plenty"              14 tcl))
(define staca15 (text" Prism Profusion"            14 tcl))
(define staca16 (text" Large Hadron Collider Clump"14 tcl))
(define staca17 (text" Elf Extravagance"           14 tcl))
(define staca18 (text" Upgrade Utopia"             14 tcl))
(define staca19 (text" Base 10 Behemoth"           14 tcl))
(define staca20 (text" Binary Bewilderment"        14 tcl))
(define staca21 (text" Time Twister"               14 tcl))
(define staca22 (text" Big Spender"                14 tcl))
(define staca23 (text" Meme Myriad"                14 tcl))
(define staca24 (text" Meme Master"                14 tcl))

;Gold Achievements
(define stacb1  (text" Octillion Cookies"     14 tcl))
(define stacb2  (text" Nonillion Cookies"     14 tcl))
(define stacb3  (text" Decillion Cookies"     14 tcl))
(define stacb4  (text" Duodecillion Cookies"  14 tcl))
(define stacb5  (text" Open Sesame"           14 tcl))
(define stacb6  (text" Poke!"                 14 tcl))
(define stacb7  (text" Ovens! Mitts! Cake!"   14 tcl))
(define stacb8  (text" Holes In The Earth"    14 tcl))
(define stacb9  (text" Quick Prototyping"     14 tcl))
(define stacb10 (text" Mass Production"       14 tcl))
(define stacb11 (text" A Mole Is A Unit!"     14 tcl))
(define stacb12 (text" 500 Ain't Enough!"     14 tcl))
(define stacb13 (text" Back To The Future I"  14 tcl))
(define stacb14 (text" Wormholes"             14 tcl))
(define stacb15 (text" Glass Castle"          14 tcl))
(define stacb16 (text" Why Though?"           14 tcl))
(define stacb17 (text" Santa's Little Helpers"14 tcl))
(define stacb18 (text" Upgrade Distopia"      14 tcl))
(define stacb19 (text" Base 11 Behemoth"      14 tcl))
(define stacb20 (text" Computers"             14 tcl))
(define stacb21 (text" Waste Of A Life"       14 tcl))
(define stacb22 (text" Rich Guy"              14 tcl))
(define stacb23 (text" Meme Lord"             14 tcl))
(define stacb24 (text" Three Spooky Five Me"  14 tcl))

;Onyx Achievements
(define stacc1  (text" Tredecillion Cookies"          14 tcl))
(define stacc2  (text" Quattuordecillion Cookies"     14 tcl))
(define stacc3  (text" Quindecillion Cookies"         14 tcl))
(define stacc4  (text" Vigintillion Cookies"          14 tcl))
(define stacc5  (text" HHHAAAXXX!!!"                  14 tcl))
(define stacc6  (text" Poke Poke Ouch"                14 tcl))
(define stacc7  (text" Too Many Ovens"                14 tcl))
(define stacc8  (text" Cookie Cavern"                 14 tcl))
(define stacc9  (text" Better Than Paper Cookies"     14 tcl))
(define stacc10 (text" China"                         14 tcl))
(define stacc11 (text" 6×10²³"                        14 tcl))
(define stacc12 (text" Copy Cat"                      14 tcl))
(define stacc13 (text" Back To The Future II"         14 tcl))
(define stacc14 (text" Aperture Science"              14 tcl))
(define stacc15 (text" Double Rainbow"                14 tcl))
(define stacc16 (text" Polonium Lanthanum Neodymium"  14 tcl))
(define stacc17 (text" North Pole"                    14 tcl))
(define stacc18 (text" Strange Green Pixel Circle"    14 tcl))
(define stacc19 (text" Base 12 Behemoth"              14 tcl))
(define stacc20 (text" Beep Boop"                     14 tcl))
(define stacc21 (text" Stop Playing This Game"        14 tcl))
(define stacc22 (text" Trump"                         14 tcl))
(define stacc23 (text" It's Over 9000!"               14 tcl))
(define stacc24 (text" All Your Base Are Belong To Us"14 tcl))


;Screen Draw


;Achievement Screen

(define
  (AS x)
  (above/align
   'left
   (cond
     [(=(ccr-totl x)0)(beside dark nul)]
     [(=(utota x)1)(beside dark stac1)]
     [(=(utota x)2)(pover ac1 back staca1)]
     [(=(utota x)4)(pover ac1 gold stacb1)]
     [(=(utota x)8)(pover ac1 onyx stacc1)])
   (cond
     [(=(ccr-totl x)0)(beside dark nul)]
     [(=(utotb x)1)(beside dark stac2)]
     [(=(utotb x)2)(pover ac2 back staca2)]
     [(=(utotb x)4)(pover ac2 gold stacb2)]
     [(=(utotb x)8)(pover ac2 onyx stacc2)])
   (cond
     [(=(ccr-totl x)0)(beside dark nul)]
     [(=(utotc x)1)(beside dark stac3)]
     [(=(utotc x)2)(pover ac3 back staca3)]
     [(=(utotc x)4)(pover ac3 gold stacb3)]
     [(=(utotc x)8)(pover ac3 onyx stacc3)])
   (cond
     [(=(ccr-totl x)0)(beside dark nul)]
     [(=(utotd x)1)(beside dark stac4)]
     [(=(utotd x)2)(pover ac4 back staca4)]
     [(=(utotd x)4)(pover ac4 gold stacb4)]
     [(=(utotd x)8)(pover ac4 onyx stacc4)])
   (cond
     [(=(uchet x)1)(square 0 0'red)]
     [(=(uchet x)2)(pover ac5 back staca5)]
     [(=(uchet x)4)(pover ac5 gold stacb5)]
     [(=(uchet x)8)(pover ac5 onyx stacc5)])
   (cond
     [(=(ccr-clik x)0)(beside dark nul)]
     [(=(uclik x)1   )(beside dark stac6)]
     [(=(uclik x)1.25)(pover ac6 back staca6)]
     [(=(uclik x)2.5 )(pover ac6 gold stacb6)]
     [(=(uclik x)5   )(pover ac6 onyx stacc6)])
   (cond
     [(=(ccr-grma x)0)(beside dark nul)]
     [(=(ugrma x)1   )(beside dark stac7)]
     [(=(ugrma x)1.25)(pover ac7 back staca7)]
     [(=(ugrma x)2.5 )(pover ac7 gold stacb7)]
     [(=(ugrma x)5   )(pover ac7 onyx stacc7)])
   (cond
     [(=(ccr-mine x)0)(beside dark nul)]
     [(=(umine x)1   )(beside dark stac8)]
     [(=(umine x)1.25)(pover ac8 back staca8)]
     [(=(umine x)2.5 )(pover ac8 gold stacb8)]
     [(=(umine x)5   )(pover ac8 onyx stacc8)])
   (cond
     [(=(ccr-3Dpr x)0)(beside dark nul)]
     [(=(u3Dpr x)1   )(beside dark stac9)]
     [(=(u3Dpr x)1.25)(pover ac9 back staca9)]
     [(=(u3Dpr x)2.5 )(pover ac9 gold stacb9)]
     [(=(u3Dpr x)5   )(pover ac9 onyx stacc9)])
   (cond
     [(=(ccr-fact x)0)(beside dark nul)]
     [(=(ufact x)1   )(beside dark stac10)]
     [(=(ufact x)1.25)(pover ac10 back staca10)]
     [(=(ufact x)2.5 )(pover ac10 gold stacb10)]
     [(=(ufact x)5   )(pover ac10 onyx stacc10)])
   (cond
     [(=(ccr-chem x)0)(beside dark nul)]
     [(=(uchem x)1   )(beside dark stac11)]
     [(=(uchem x)1.25)(pover ac11 back staca11)]
     [(=(uchem x)2.5 )(pover ac11 gold stacb11)]
     [(=(uchem x)5   )(pover ac11 onyx stacc11)])
   (cond
     [(=(ccr-dupl x)0)(beside dark nul)]
     [(=(udupl x)1   )(beside dark stac12)]
     [(=(udupl x)1.25)(pover ac12 back staca12)]
     [(=(udupl x)2.5 )(pover ac12 gold stacb12)]
     [(=(udupl x)5   )(pover ac12 onyx stacc12)])
   (cond
     [(=(ccr-time x)0)(beside dark nul)]
     [(=(utime x)1   )(beside dark stac13)]
     [(=(utime x)1.25)(pover ac13 back staca13)]
     [(=(utime x)2.5 )(pover ac13 gold stacb13)]
     [(=(utime x)5   )(pover ac13 onyx stacc13)])
   (cond
     [(=(ccr-port x)0)(beside dark nul)]
     [(=(uport x)1   )(beside dark stac14)]
     [(=(uport x)1.25)(pover ac14 back staca14)]
     [(=(uport x)2.5 )(pover ac14 gold stacb14)]
     [(=(uport x)5   )(pover ac14 onyx stacc14)])
   (cond
     [(=(ccr-pris x)0)(beside dark nul)]
     [(=(upris x)1   )(beside dark stac15)]
     [(=(upris x)1.25)(pover ac15 back staca16)]
     [(=(upris x)2.5 )(pover ac15 gold stacb16)]
     [(=(upris x)5   )(pover ac15 onyx stacc16)])
   (cond
     [(=(ccr-hadr x)0)(beside dark nul)]
     [(=(uhadr x)1   )(beside dark stac16)]
     [(=(uhadr x)1.25)(pover ac16 back staca16)]
     [(=(uhadr x)2.5 )(pover ac16 gold stacb16)]
     [(=(uhadr x)5   )(pover ac16 onyx stacc16)])
   (cond
     [(=(ccr-elfs x)0)(beside dark nul)]
     [(=(uelfs x)1   )(beside dark stac17)]
     [(=(uelfs x)1.25)(pover ac17 back staca17)]
     [(=(uelfs x)2.5 )(pover ac17 gold stacb17)]
     [(=(uelfs x)5   )(pover ac17 onyx stacc17)])
   (cond
     [(=(ccr-upgr x)0)(beside dark nul)]
     [(=(uupgr x)1   )(beside dark stac18)]
     [(=(uupgr x)1.25)(pover ac18 back staca18)]
     [(=(uupgr x)2.5 )(pover ac18 gold stacb18)]
     [(=(uupgr x)5   )(pover ac18 onyx stacc18)])
   (cond
     [(=(udeci x)1)(square 0 0'red)]
     [(=(udeci x)2)(pover ac19 back staca19)]
     [(=(udeci x)4)(pover ac19 gold stacb19)]
     [(=(udeci x)8)(pover ac19 onyx stacc19)])
   (cond
     [(=(ubina x)1)(square 0 0'red)]
     [(=(ubina x)2)(pover ac20 back staca20)]
     [(=(ubina x)4)(pover ac20 gold stacb20)]
     [(=(ubina x)8)(pover ac20 onyx stacc20)])
   (cond
     [(=(usecs x)1)(square 0 0'red)]
     [(=(usecs x)2)(pover ac21 back staca21)]
     [(=(usecs x)4)(pover ac21 gold stacb21)]
     [(=(usecs x)8)(pover ac21 onyx stacc21)])
   (cond
     [(=(uspnt x)1)(square 0 0'red)]
     [(=(uspnt x)2)(pover ac22 back staca22)]
     [(=(uspnt x)4)(pover ac22 gold stacb22)]
     [(=(uspnt x)8)(pover ac22 onyx stacc22)])
   (cond
     [(=(umem1 x)1   )(square 0 0'red)]
     [(=(umem1 x)50  )(pover nyan back staca23)]
     [(=(umem1 x)420 )(pover nyan gold stacb23)]
     [(=(umem1 x)1337)(pover nyan onyx stacc23)])
   (cond
     [(=(umem2 x)1   )(square 0 0'red)]
     [(=(umem2 x)50  )(pover nayn back staca24)]
     [(=(umem2 x)500 )(pover nayn gold stacb24)]
     [(=(umem2 x)9001)(pover nayn onyx stacc24)])))

;Buy Screen
(define
  (BS x)
  (above/align
   'left
   (if(<(ccr-totl x)(p1  0))nul(text(string-append "1 - "nm1 )14 tcl))
   (text(string-append(scinot(p1 (ccr-clik x)))" "nm0"s")14 tcl)
   (square 2 0'red)
   (if(<(ccr-totl x)(p2  0))nul(text(string-append "2 - "nm2 )14 tcl))
   (text(string-append(scinot(p2 (ccr-grma x)))" "nm0"s")14 tcl)
   (square 2 0'red)
   (if(<(ccr-totl x)(p3  0))nul(text(string-append "3 - "nm3 )14 tcl))
   (text(string-append(scinot(p3 (ccr-mine x)))" "nm0"s")14 tcl)
   (square 2 0'red)
   (if(<(ccr-totl x)(p4  0))nul(text(string-append "4 - "nm4 )14 tcl))
   (text(string-append(scinot(p4 (ccr-3Dpr x)))" "nm0"s")14 tcl)
   (square 2 0'red)
   (if(<(ccr-totl x)(p5  0))nul(text(string-append "5 - "nm5 )14 tcl))
   (text(string-append(scinot(p5 (ccr-fact x)))" "nm0"s")14 tcl)
   (square 2 0'red)
   (if(<(ccr-totl x)(p6  0))nul(text(string-append "6 - "nm6 )14 tcl))
   (text(string-append(scinot(p6 (ccr-chem x)))" "nm0"s")14 tcl)
   (square 2 0'red)
   (if(<(ccr-totl x)(p7  0))nul(text(string-append "7 - "nm7 )14 tcl))
   (text(string-append(scinot(p7 (ccr-dupl x)))" "nm0"s")14 tcl)
   (square 2 0'red)
   (if(<(ccr-totl x)(p8  0))nul(text(string-append"f1 - "nm8 )14 tcl))
   (text(string-append(scinot(p8 (ccr-time x)))" "nm0"s")14 tcl)
   (square 2 0'red)
   (if(<(ccr-totl x)(p9  0))nul(text(string-append"f2 - "nm9 )14 tcl))
   (text(string-append(scinot(p9 (ccr-port x)))" "nm0"s")14 tcl)
   (square 2 0'red)
   (if(<(ccr-totl x)(p10 0))nul(text(string-append"f3 - "nm10)14 tcl))
   (text(string-append(scinot(p10(ccr-pris x)))" "nm0"s")14 tcl)
   (square 2 0'red)
   (if(<(ccr-totl x)(p11 0))nul(text(string-append"f4 - "nm11)14 tcl))
   (text(string-append(scinot(p11(ccr-hadr x)))" "nm0"s")14 tcl)
   (square 2 0'red)
   (if(<(ccr-totl x)(p12 0))nul(text(string-append"f5 - "nm12)14 tcl))
   (text(string-append(scinot(p12(ccr-elfs x)))" "nm0"s")14 tcl)
   (square 2 0'red)
   (if(<(ccr-totl x)(p13 0))nul(text(string-append"f6 - "nm13)14 tcl))
   (text(string-append(scinot(p13(ccr-meme x)))" "nm0"s")14 tcl)
   (square 2 0'red)
   (if(<(ccr-totl x)(p14 0))nul(text(string-append"f7 - "nm14)14 tcl))
   (text(string-append(scinot(p14(ccr-upgr x)))" "nm0"s")14 tcl)))

;Info Screen
(define
  (IS x)
  (above/align
   'left
   (text(string-append(scinot(floor(ccr-cook x)))" "nm0(if(=(ccr-cook x)1)"""s"))14 tcl)
   (square 16 0'red)
   (text(string-append(scinot(floor(ccr-totl x)))" Cumulative "nm0(if(=(ccr-totl x)1)"""s"))14 tcl)
   (square 16 0'red)
   (text(string-append(scinot(floor(*(CPT x)2)))" "nm0(if(=(floor(*(CPT x)2))1)"""s")" Per Second")14 tcl)
   (square 16 0'red)
   (if(=(ccr-clik x)0)nul(text(string-append(number->string(inexact->exact(ccr-clik x)))" "nm1 (if(=(ccr-clik x)1)"""s"))14 tcl))
   (if(=(ccr-grma x)0)nul(text(string-append(number->string(inexact->exact(ccr-grma x)))" "nm2 (if(=(ccr-grma x)1)"""s"))14 tcl))
   (if(=(ccr-mine x)0)nul(text(string-append(number->string(inexact->exact(ccr-mine x)))" "nm3 (if(=(ccr-mine x)1)"""s"))14 tcl))
   (if(=(ccr-3Dpr x)0)nul(text(string-append(number->string(inexact->exact(ccr-3Dpr x)))" "nm4 (if(=(ccr-3Dpr x)1)"""s"))14 tcl))
   (if(=(ccr-fact x)0)nul(text(string-append(number->string(inexact->exact(ccr-fact x)))" " (if(=(ccr-fact x)1)nm5 nm5p))14 tcl))
   (if(=(ccr-chem x)0)nul(text(string-append(number->string(inexact->exact(ccr-chem x)))" "nm6 (if(=(ccr-chem x)1)"""s"))14 tcl))
   (if(=(ccr-dupl x)0)nul(text(string-append(number->string(inexact->exact(ccr-dupl x)))" "nm7 (if(=(ccr-dupl x)1)"""s"))14 tcl))
   (if(=(ccr-time x)0)nul(text(string-append(number->string(inexact->exact(ccr-time x)))" "nm8 (if(=(ccr-time x)1)"""s"))14 tcl))
   (if(=(ccr-port x)0)nul(text(string-append(number->string(inexact->exact(ccr-port x)))" "nm9 (if(=(ccr-port x)1)"""s"))14 tcl))
   (if(=(ccr-pris x)0)nul(text(string-append(number->string(inexact->exact(ccr-pris x)))" "nm10(if(=(ccr-pris x)1)"""s"))14 tcl))
   (if(=(ccr-hadr x)0)nul(text(string-append(number->string(inexact->exact(ccr-hadr x)))" "nm11(if(=(ccr-hadr x)1)"""s"))14 tcl))
   (if(=(ccr-elfs x)0)nul(text(string-append(number->string(inexact->exact(ccr-elfs x)))" "nm12(if(=(ccr-elfs x)1)"""s"))14 tcl))
   (if(=(ccr-meme x)0)nul(text(string-append(number->string(inexact->exact(ccr-meme x)))" "nm13(if(=(ccr-meme x)1)"""s"))14 tcl))
   (if(=(ccr-upgr x)0)nul(text(string-append(number->string(inexact->exact(ccr-upgr x)))" "nm14(if(=(ccr-upgr x)1)"""s"))14 tcl))))




#|Universe Functions|#

;Update CCR
(define
  (update x)
  (make-ccr
   (+(CPT x)(ccr-cook x))
   (ccr-clik x)
   (ccr-grma x)
   (ccr-mine x)
   (ccr-3Dpr x)
   (ccr-fact x)
   (ccr-chem x)
   (ccr-dupl x)
   (ccr-time x)
   (ccr-port x)
   (ccr-pris x)
   (ccr-hadr x)
   (ccr-elfs x)
   (ccr-meme x)
   (+(CPT x)(ccr-totl x))
   (ccr-chet x)
   (ccr-upgr x)))

;Draw CCR
(define
  (draw x)
  (overlay
   (beside/align
    'top
    (IS x)
    (square 40 0'red)
    (BS x)
    (square 40 0'red)
    (AS x)
    )
   (cond
    [(<(ccr-totl x)(expt 10 40))bord]
    [(<(ccr-totl x)(expt 10 64))gord]
    [else                       oord])
   )
  )

;Key CCR
(define
  (key x k)
  (make-ccr
   (cond
     [(string=?" "k)(+(CPS x)(CPT x)(ccr-cook x)(*(utota x)(utotb x)(utotc x)(utotd x)(udeci x)(ubina x)(usecs x)(uspnt x)))]
     [(and(>=(ccr-cook x)(p1 (ccr-clik x)))(string=?"1" k))(-(ccr-cook x)(p1 (ccr-clik x)))]
     [(and(>=(ccr-cook x)(p2 (ccr-grma x)))(string=?"2" k))(-(ccr-cook x)(p2 (ccr-grma x)))]
     [(and(>=(ccr-cook x)(p3 (ccr-mine x)))(string=?"3" k))(-(ccr-cook x)(p3 (ccr-mine x)))]
     [(and(>=(ccr-cook x)(p4 (ccr-3Dpr x)))(string=?"4" k))(-(ccr-cook x)(p4 (ccr-3Dpr x)))]
     [(and(>=(ccr-cook x)(p5 (ccr-fact x)))(string=?"5" k))(-(ccr-cook x)(p5 (ccr-fact x)))]
     [(and(>=(ccr-cook x)(p6 (ccr-chem x)))(string=?"6" k))(-(ccr-cook x)(p6 (ccr-chem x)))]
     [(and(>=(ccr-cook x)(p7 (ccr-dupl x)))(string=?"7" k))(-(ccr-cook x)(p7 (ccr-dupl x)))]
     [(and(>=(ccr-cook x)(p8 (ccr-time x)))(string=?"f1"k))(-(ccr-cook x)(p1 (ccr-time x)))]
     [(and(>=(ccr-cook x)(p9 (ccr-port x)))(string=?"f2"k))(-(ccr-cook x)(p9 (ccr-port x)))]
     [(and(>=(ccr-cook x)(p10(ccr-pris x)))(string=?"f3"k))(-(ccr-cook x)(p10(ccr-pris x)))]
     [(and(>=(ccr-cook x)(p11(ccr-hadr x)))(string=?"f4"k))(-(ccr-cook x)(p11(ccr-hadr x)))]
     [(and(>=(ccr-cook x)(p12(ccr-elfs x)))(string=?"f5"k))(-(ccr-cook x)(p12(ccr-elfs x)))]
     [(and(>=(ccr-cook x)(p13(ccr-meme x)))(string=?"f6"k))(-(ccr-cook x)(p13(ccr-meme x)))]
     [(and(>=(ccr-cook x)(p14(ccr-upgr x)))(string=?"f7"k))(-(ccr-cook x)(p14(ccr-upgr x)))]
     [else(ccr-cook x)])
   (if(and(>=(ccr-cook x)(p1 (ccr-clik x)))(string=?"1" k))(+(ccr-clik x)1)(ccr-clik x))
   (if(and(>=(ccr-cook x)(p2 (ccr-grma x)))(string=?"2" k))(+(ccr-grma x)1)(ccr-grma x))
   (if(and(>=(ccr-cook x)(p3 (ccr-mine x)))(string=?"3" k))(+(ccr-mine x)1)(ccr-mine x))
   (if(and(>=(ccr-cook x)(p4 (ccr-3Dpr x)))(string=?"4" k))(+(ccr-3Dpr x)1)(ccr-3Dpr x))
   (if(and(>=(ccr-cook x)(p5 (ccr-fact x)))(string=?"5" k))(+(ccr-fact x)1)(ccr-fact x))
   (if(and(>=(ccr-cook x)(p6 (ccr-chem x)))(string=?"6" k))(+(ccr-chem x)1)(ccr-chem x))
   (if(and(>=(ccr-cook x)(p7 (ccr-dupl x)))(string=?"7" k))(+(ccr-dupl x)1)(ccr-dupl x))
   (if(and(>=(ccr-cook x)(p8 (ccr-time x)))(string=?"f1"k))(+(ccr-time x)1)(ccr-time x))
   (if(and(>=(ccr-cook x)(p9 (ccr-port x)))(string=?"f2"k))(+(ccr-port x)1)(ccr-port x))
   (if(and(>=(ccr-cook x)(p10(ccr-pris x)))(string=?"f3"k))(+(ccr-pris x)1)(ccr-pris x))
   (if(and(>=(ccr-cook x)(p11(ccr-hadr x)))(string=?"f4"k))(+(ccr-hadr x)1)(ccr-hadr x))
   (if(and(>=(ccr-cook x)(p12(ccr-elfs x)))(string=?"f5"k))(+(ccr-elfs x)1)(ccr-elfs x))
   (if(and(>=(ccr-cook x)(p13(ccr-meme x)))(string=?"f6"k))(+(ccr-meme x)1)(ccr-meme x))
   (if(string=?" "k)(+(CPS x)(CPT x)(ccr-totl x)(*(utota x)(utotb x)(utotc x)(utotd x)(udeci x)(ubina x)(usecs x)(uspnt x)))(ccr-totl x))
   (cond
     [(and(string=?"g"       k)(=(abs(ccr-chet x))1))2]
     [(and(string=?"shift"   k)(=(abs(ccr-chet x))2))3]
     [(and(string=?"wheel-up"k)(=(abs(ccr-chet x))3))4]
     [else(ccr-chet x)])
   (if(and(>=(ccr-cook x)(p14(ccr-upgr x)))(string=?"f7"k))(+(ccr-upgr x)1)(ccr-upgr x))))

;Big Bang
(big-bang st(on-key key)(on-draw draw)(on-tick update 0.5))