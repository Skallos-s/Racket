#lang racket

; Load Packages
 (require 2htdp/image)
 (require 2htdp/universe)

; Text
(define INFO "Version 1.0 -- Made by Skallos")
(define NAME "Pocket Frogs Search Minigame Tool Version 1.0")

;             ________________________________________________________________
;       _.-'``                                                                `*-._
;     .'                                                                           `-.
;   .'                                                                                '.
;  /                                                                                    \
; /                                                                                      \
;/                                         _______                                        \
;|                                  _.-~```       ```-._                                  |
;|                               .-(   @)           (@  `T._                              |
;|                             .'  |   `             `   |  '.                            |
;|                           .'    |                     \    '.                          |
;|                          /   _./_                     .\._   \                         |
;|                        .'  .`.'  `.  .-``-  .```.  .'` `-_\   \                        |
;|                       /|  ( /      ) |    `.`   ) (       \)  |\                       |
;|                       /|   \      /  \          /  \     .'   | \                      |
;|                      / |    `T---`    |         |   `---`.     \ \                     |
;|             .'``.   / /      |        /         \        \      \ \   (``.             |
;|              '. '. | /      /        /     .     \       \      \ \  .'_.`             |
;|                '. \/ /      |       /     / \    \        \      \ \/ /                |
;|                  \/ /       |       /    /   \    \       |       \\ /                 |
;|           .``---~`|/        |      /     |   |     \      \       \ \`---```.          |
;|           `.-*;'  //       /       /     |   |     \      |        \\ '.-.-`           |
;|              /   |/        |      /      /   \     \      \         \|   \             |
;|              (   |         /     /      /    \      \      \         |   )             |
;|         .--. \   |        /     /       /     \      \      \        |   / .-.         |
;|  .-*-   \  |  \  |        |     (      (       |      |     |       /  .' (  .)  .-`-  |
;|  `._ `._  \ \  `-.\       |     |      |       |      |     |       /-`   / /  _.` _/  |
;|     `-. `-.) `,.---\      |     |      \      /       |     |      /.._.-` `-~` .'`    |
;|        `)  .-`      \     |     |       \     /       |     |     /     ``-.  (`       |
;|   .--.-`  /          '.   |     |       |    |        |     \   .'          \  `-..-.  |
;|  (  .--``(-._          './      |       \    /        |     \.-'           .) `-._  )  |
;|   ``      \  `-._         `-._  |        \   /        |  _.-`         _.-*` /     ``   |
;|            '._    `---...____.:`*--..____\__/__....---`=:________..-*`   _.'           |
;|               `-._                 _.`          `-._                 _.-`              |
;|                   `*~--........--~`                 `~-..._____..-**`                  |
;\                                                                                        /
; \                                                                                      /
;  \                                                                                    /
;   '.                                                                                .'
;     `._                                                                          _.'
;        `-.___                                                              ___.-'
;              ``````````````````````````````````````````````````````````````


;;;;;;;;;;;
; Sprites ;
;;;;;;;;;;;

;Lily pad
(define lily
  (overlay
   (circle 28'solid(make-color 52 175 0))
   (circle 32'solid(make-color 29 96 0))))

;Red frog
(define frga
  (overlay
   (circle 7'solid(make-color 255 0 0))
   (circle 8'solid(make-color 127 0 0))))

;Blue frog
(define frgb
  (overlay
   (circle 7'solid(make-color 0 38 255))
   (circle 8'solid(make-color 0 19 127))))

;Flower
(define flwr
  (overlay
   (star-polygon 7 10 3'solid'yellow)
   (star-polygon 10 10 3'solid'black)))

;Black circle
(define chck
  (place-image
   (circle 10'outline
    (pen 'black 2 'solid 'round 'round))
   32 32
   (square 64 0'red)))

;Brown cross
(define crss
  (rotate 45
   (scale(sqrt 2)
    (overlay
     (rectangle 3 14'solid'brown)
     (rectangle 13 3'solid'brown)))))

;Gold check
(define conf
  (rotate 45
   (scale(sqrt 2)
    (above/align 'left
     (square 3'solid'yellow)
     (rectangle 12 3'solid'yellow)))))

;Padding sprites
(define blc1 (square 64 0'red))
(define blc2 (square 80 0'red))

;;;;;;;;
; Data ;
;;;;;;;;

; Frog Search Patterns
; Patterns for all frogs. Pop frogs are listed with a 5x5 grid pattern.
; First two values are the width and height.
; Rest arehte dot patterns.
(define ANURA     (list 4 2 1 0 0 1 1 0 0 1))                 (define PARTIRI   (list 4 1 1 1 1 1))
(define CRUSTALLI (list 3 2 1 1 1 0 1 0))                     (define VELATUS   (list 4 2 0 0 0 1 1 1 1 0))
(define CLUNICULA (list 4 2 0 1 1 0 1 0 0 1))                 (define MARMOREA  (list 4 3 1 0 0 1 0 1 0 0 0 1 0 0))
(define MIXTUS    (list 4 3 1 0 0 0 1 0 0 1 0 1 0 0))         (define NASUS     (list 3 2 1 1 1 0 1 0))
(define STELLATA  (list 3 3 0 1 0 1 0 1 0 1 0))               (define PUNCTI    (list 4 4 1 0 0 1 0 0 0 0 0 0 0 0 1 0 0 1))
(define ZEBRAE    (list 3 2 1 1 0 0 1 1))                     (define CALYX     (list 1 4 1 1 1 1))
(define NIMBILIS  (list 2 2 1 1 1 1))                         (define ROBORIS   (list 3 3 1 0 1 0 1 0 0 1 0))
(define ADAMANTIS (list 3 3 0 1 0 1 0 1 0 1 0))               (define AFRICANUS (list 4 4 0 0 1 0 1 0 0 0 0 0 0 1 0 1 0 0))
(define SERPENTIS (list 2 4 0 1 1 0 0 1 1 0))                 (define BOVIS     (list 4 2 0 0 0 1 1 1 1 0))
(define VIDUO     (list 2 3 1 1 0 0 1 1))                     (define SPINAE    (list 3 3 0 1 0 0 0 0 1 1 1))
(define CESTI     (list 1 4 1 1 1 1))                         (define SAGITTA   (list 3 4 0 1 0 1 0 1 0 0 0 0 1 0))
(define AMFRACTUS (list 2 4 0 1 1 0 1 0 0 1))                 (define ORNATUS   (list 3 4 0 0 1 0 1 0 1 0 0 1 0 0))
(define SOL       (list 4 4 0 0 0 1 0 0 1 0 1 0 0 0 0 1 0 0)) (define LUCUS     (list 4 2 0 1 0 0 1 0 1 1))
(define LIGO      (list 4 4 0 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0)) (define CORONA    (list 2 4 1 0 0 1 0 1 1 0))
(define ARBOR     (list 3 4 1 0 0 0 1 0 0 0 1 0 0 1))         (define OCULARIS  (list 3 3 0 1 0 0 0 0 1 1 1))
(define INSERO    (list 2 4 1 1 0 0 1 0 0 1))                 (define BIPLEX    (list 3 3 0 1 1 1 0 0 0 0 1))
(define PINGO     (list 3 3 1 0 0 0 1 0 1 0 1))               (define CALVARIA  (list 4 2 1 0 0 1 0 1 1 0))
(define FLORESCO  (list 2 3 1 1 0 1 1 0))                     (define MAGUS     (list 4 3 0 1 1 0 0 0 0 0 1 0 0 1))
(define VERU      (list 2 4 1 0 0 1 0 1 0 1))
(define TRIBUS    (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define LANTERNA  (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define GLACIO    (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define LUDO      (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define MARINUS   (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define DEXTERA   (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define TRIVIUM   (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define OBARO     (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define BULLA     (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define ORBIS     (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define VINACEUS  (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define PERSONA   (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define SIGNUM    (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define GYRUS     (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define GEMINUS   (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define BULBUS    (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(define TEMPLUM   (list 3 3 0 1 0 0 1 0 1 0 1))       (define PAPILIO   (list 2 3 1 0 1 1 1 0))
(define PLUMA     (list 4 2 1 1 0 0 0 0 1 1))         (define CORNUS    (list 3 3 1 1 0 0 1 0 0 0 1))
(define VOLTA     (list 4 2 0 1 0 1 1 0 1 0))         (define FLECTO    (list 4 3 1 0 0 0 0 1 0 1 0 0 1 0))
(define FIGULARIS (list 2 4 0 1 1 0 0 1 1 0))         (define ACERIS    (list 3 2 0 1 0 1 1 1))
(define LUNARIS   (list 2 2 1 1 1 1))                 (define TABULA    (list 3 4 0 1 0 1 0 0 0 0 0 0 0 1))
(define PICTORIS  (list 4 2 1 0 0 1 0 0 1 0))         (define SHELBUS   (list 3 2 1 0 0 1 0 1))
(define SKELETOS  (list 4 3 1 0 0 1 0 0 0 0 0 1 0 0)) (define PYRAMIS   (list 4 3 0 0 0 1 1 0 0 0 0 1 0 0))
(define LOTUS     (list 3 3 1 0 0 0 1 0 0 0 1))       (define SPIRA     (list 3 3 0 0 1 1 0 0 0 1 0))
(define PLANETA   (list 3 3 1 1 0 0 0 0 0 0 1))       (define MAZEUS    (list 4 3 1 0 0 0 0 1 0 0 0 0 0 1))
(define PALMA     (list 3 3 0 1 0 0 0 0 1 0 1))       (define COCLEARIS (list 3 4 0 1 0 0 0 0 0 0 0 1 0 1))
(define MUSTACIUM (list 3 3 1 0 0 0 1 0 0 0 1))       (define AXIS      (list 3 4 0 1 0 0 0 0 0 0 0 1 0 1))
(define IGNEOUS   (list 2 4 0 1 0 0 0 1 1 0))         (define INFINITAS (list 3 2 0 1 0 1 0 1))
(define NODARE    (list 2 3 0 1 1 0 1 0))             (define DIMIDIUS  (list 2 3 0 1 1 0 0 1))
(define SCUTULATA (list 3 3 1 0 1 0 0 0 0 0 1))       (define ARCUS     (list 3 4 1 0 0 0 0 0 0 1 0 0 0 1))
(define BOTULUS   (list 2 3 1 0 0 1 1 0))             (define AMERICANO (list 2 3 1 1 0 0 1 0))
(define SYMPHONIA (list 3 2 1 0 1 1 0 0))             (define VICIS     (list 2 4 1 0 0 0 0 1 1 0))
(define JANUS     (list 3 2 0 1 0 1 0 1))             (define LEVAR     (list 3 2 0 0 1 1 0 1))
(define GEMMA     (list 3 2 0 1 0 1 0 1))             (define FAVUS     (list 4 3 0 0 1 0 1 0 0 0 0 0 0 1))
(define TESSERA   (list 3 4 0 0 1 0 0 0 1 0 0 0 1 0)) (define FRONDIS   (list 3 3 0 1 0 0 0 1 1 0 0))
(define PISTRIX   (list 4 3 0 1 0 0 0 0 0 0 1 0 0 1)) (define NEBULA    (list 2 4 0 1 0 0 0 0 1 0))
(define FRACTUS   (list 2 3 0 1 0 0 1 0))             (define HENNAE    (list 2 2 0 1 1 0))
(define PULVILLUS (list 3 3 1 0 0 0 0 0 0 0 1))       (define QUILTA    (list 2 2 1 0 0 1))
(define FORAMEN   (list 3 3 1 0 0 0 0 0 0 0 1))       (define EMBLEMA   (list 3 3 0 0 1 0 0 0 1 0 0))
(define FORTUNO   (list 2 2 0 1 1 0))                 (define SPLENDICO (list 4 1 1 0 0 1))
(define HEXAS     (list 4 3 1 0 0 0 0 0 0 0 0 0 0 1)) (define SPARGO    (list 2 3 0 1 0 0 1 0))
(define LATUS     (list 3 1 1 0 1))                   (define LENTIUM   (list 2 2 0 1 1 0))
(define ALTILIUM  (list 1 3 1 0 1))                   (define PROCURSUS (list 1 4 1 0 0 1))
(define STILLAS   (list 3 2 1 0 0 0 0 1))             (define INVERSO   (list 3 4 0 0 1 0 0 0 0 0 0 1 0 0))
(define EXCLAMO   (list 1 2 1 1))
(define IMBRIS    (list 5 5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))

; Frog String List
(define FSL
  (list "Anura"     "Partiri"   "Crustalli" "Velatus"   "Clunicula"
        "Marmorea"  "Mixtus"    "Nasus"     "Stellata"  "Puncti"
        "Zebrae"    "Calyx"     "Nimbilis"  "Roboris"   "Adamantis"
        "Africanus" "Serpentis" "Bovis"     "Viduo"     "Spinae"
        "Cesti"     "Sagitta"   "Amfractus" "Ornatus"   "Sol"
        "Lucus"     "Ligo"      "Corona"    "Arbor"     "Ocularis"
        "Insero"    "Biplex"    "Pingo"     "Calvaria"  "Floresco"
        "Magus"     "Veru"      "Tribus"    "Lanterna"  "Glacio"
        "Ludo"      "Marinus"   "Dextera"   "Trivium"   "Obaro"
        "Bulla"     "Orbis"     "Vinaceus"  "Persona"   "Signum"
        "Gyrus"     "Geminus"   "Bulbus"    "Templum"   "Papilio"
        "Pluma"     "Cornus"    "Volta"     "Flecto"    "Figularis"
        "Aceris"    "Lunaris"   "Tabula"    "Pictoris"  "Shelbus"
        "Skeletos"  "Pyramis"   "Lotus"     "Spira"     "Planeta"
        "Mazeus"    "Palma"     "Coclearis" "Mustacium" "Axis"
        "Igneous"   "Infinitas" "Nodare"    "Dimidius"  "Scutulata"
        "Arcus"     "Botulus"   "Americano" "Symphonia" "Vicis"
        "Janus"     "Levar"     "Gemma"     "Favus"     "Tessera"
        "Frondis"   "Pistrix"   "Nebula"    "Fractus"   "Hennae"
        "Pulvillus" "Quilta"    "Foramen"   "Emblema"   "Fortuno"
        "Splendico" "Hexas"     "Spargo"    "Latus"     "Lentium"
        "Altilium"  "Procursus" "Stillas"   "Inverso"   "Exclamo"
        "Imbris"))

; Truncated Frog String List
; Only non-pop frogs included.
(define tFSL
  (list "Aceris"    "Adamantis" "Africanus" "Altilium"  "Americano"
        "Amfractus" "Anura"     "Arbor"     "Arcus"     "Axis"
        "Biplex"    "Botulus"   "Bovis"     "Calvaria"  "Calyx"
        "Cesti"     "Clunicula" "Coclearis" "Cornus"    "Corona"
        "Crustalli" "Dimidius"  "Emblema"   "Exclamo"   "Favus"
        "Figularis" "Flecto"    "Floresco"  "Foramen"   "Fortuno"
        "Fractus"   "Frondis"   "Gemma"     "Hennae"    "Hexas"
        "Igneous"   "Infinitas" "Insero"    "Inverso"   "Janus"
        "Latus"     "Lentium"   "Levar"     "Ligo"      "Lotus"
        "Lucus"     "Lunaris"   "Magus"     "Marmorea"  "Mazeus"
        "Mixtus"    "Mustacium" "Nasus"     "Nebula"    "Nimbilis"
        "Nodare"    "Ocularis"  "Ornatus"   "Palma"     "Papilio"
        "Partiri"   "Pictoris"  "Pingo"     "Pistrix"   "Planeta"
        "Pluma"     "Procursus" "Pulvillus" "Puncti"    "Pyramis"
        "Quilta"    "Roboris"   "Sagitta"   "Scutulata" "Serpentis"
        "Shelbus"   "Skeletos"  "Sol"       "Spargo"    "Spinae"
        "Spira"     "Splendico" "Stellata"  "Stillas"   "Symphonia"
        "Tabula"    "Templum"   "Tessera"   "Velatus"   "Veru"
        "Vicis"     "Viduo"     "Volta"     "Zebrae"))

; Frog Pattern List
(define FPL
  (list ANURA     PARTIRI   CRUSTALLI VELATUS   CLUNICULA
        MARMOREA  MIXTUS    NASUS     STELLATA  PUNCTI
        ZEBRAE    CALYX     NIMBILIS  ROBORIS   ADAMANTIS
        AFRICANUS SERPENTIS BOVIS     VIDUO     SPINAE
        CESTI     SAGITTA   AMFRACTUS ORNATUS   SOL
        LUCUS     LIGO      CORONA    ARBOR     OCULARIS
        INSERO    BIPLEX    PINGO     CALVARIA  FLORESCO
        MAGUS     VERU      TRIBUS    LANTERNA  GLACIO
        LUDO      MARINUS   DEXTERA   TRIVIUM   OBARO
        BULLA     ORBIS     VINACEUS  PERSONA   SIGNUM
        GYRUS     GEMINUS   BULBUS    TEMPLUM   PAPILIO
        PLUMA     CORNUS    VOLTA     FLECTO    FIGULARIS
        ACERIS    LUNARIS   TABULA    PICTORIS  SHELBUS
        SKELETOS  PYRAMIS   LOTUS     SPIRA     PLANETA
        MAZEUS    PALMA     COCLEARIS MUSTACIUM AXIS
        IGNEOUS   INFINITAS NODARE    DIMIDIUS  SCUTULATA
        ARCUS     BOTULUS   AMERICANO SYMPHONIA VICIS
        JANUS     LEVAR     GEMMA     FAVUS     TESSERA
        FRONDIS   PISTRIX   NEBULA    FRACTUS   HENNAE
        PULVILLUS QUILTA    FORAMEN   EMBLEMA   FORTUNO
        SPLENDICO HEXAS     SPARGO    LATUS     LENTIUM
        ALTILIUM  PROCURSUS STILLAS   INVERSO   EXCLAMO
        IMBRIS))

; Frog Level List
(define FLL
  (list  1  5  2  2  3  3  6  5  7  3  4  6
         8  5  4  4  7  5  6  7  8  9  9 10
        10 11 11 12 12 13 13 14 14 15 15 16
        16  3  3  3  4  5  6 14 10  8  9 12
        11 16 13  7 15 17 17 17 18 18 18 19
        19 19 20 20 20 21 21 21 22 22 22 23
        23 23 24 24 24 25 25 25 26 26 26 27
        27 27 28 28 28 29 29 29 30 30 30 31
        31 31 32 32 32 33 33 33 34 34 34 35
        35 35 30 ))


;;;;;;;;;;;;;;
; Functional ;
;;;;;;;;;;;;;;

; Empty board
(define BOARD
  (make-list 25 0))

; Struct Definition
(define-struct PF
  (frga ;Frog A Pattern (Integer)
   frgb ;Frog B Pattern (Integer)
   bord ;Board Position (List of Integers)
   mode ;Pad Type Mode (Integer)
   poss ;Possible Boards (List of Lists of Integers) (Deprectaed. Will most likely be removed in next update)
   scrl ;Menu Scroll (Pair of Integers)
   mous ;Mouse X and Y (Pair of Integers)
   levl ;Frog Level (Integer)
   updt ;Update Frequencies (Boolean)
   ))
; Starting board state
(define t (make-PF 0 0 BOARD 1 (list BOARD) (cons 0 0) (cons 0 0) 0 true))

; Cut List
; Returns Python equivalent of lst[a:b].
; Assumes valid inputs.
(define
  (cut lst a b)
  (cond
    [(= a b -1) lst]
    [(= a -1) (take lst b)]
    [(= b -1) (take-right lst (- (length lst) a))]
    [else (take-right (take lst b) (- b a))]))

; Short Truncated Frog String List
; Returns frogs that can appear in the given level.
; A value of zero returns all frogs.
(define
  (sFSL x)
  (if (= x 0) tFSL
    (filter
     (lambda(y)
       (<=
        (- x 4)
        (list-ref FLL (index-of FSL y))
        x))
     tFSL)))

; Generate Frog Pattern Mask
; Returns frog pattern overlayed on 5x5 "grid".
; (gemask ANURA 1 1) => '(0 0 0 0 0 0 1 0 0 1 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0)
(define
    (genmask lst x y)
    (let ; Local variables 
     ([w (list-ref lst 0)]
      [h (list-ref lst 1)])
    (append
     (make-list (+ (* y 5) x) 0) ; Front padding
     (flatten ; Frog Pattern
      (build-list h
       (lambda(z)
        (append
         (cut
          (cut lst 2 -1)
          (* z w)
          (* (+ z 1) w))
         (make-list
          (if (= z (- h 1)) 0 (- 5 w))
          0)))))
     (make-list ; Back Padding
      (- 25
        (* 5 (+ y h -1))
        x w)
      0))))

; Check Mask Compatability
; Check if two masks fit on a given board.
; This function checks if each possible placement of frogs matches the board the user input.
(define
   (fit ls la lb)
    (= 1 ; If an inconsistency arrises, there will be a 0 in the list.
     (apply * ; Making the product of all integers in the list zero.
      (build-list 25
       (lambda(x)
        (let ; Local values of the input lists at each position.
         ([s (list-ref ls x)]
          [a (list-ref la x)]
          [b (list-ref lb x)])
        (cond
          [(= a b 1) 0] ; Both masks collide
          [(or (= b (- 2 s)) (= a (- s 1))) 0] ; Masks collide with placed frogs
          [(and (= s 3) (> (+ a b) 0)) 0] ; Mask collides with flower
          [else 1] ; No collision
          )))))))

; Overlay Two Masks
; Returns overlayed masks.
; 1 represents frog A.
; 2 represents frog B.
(define
    (stack la lb)
    (build-list 25
     (lambda(x)
      (cond
       [(= 1 (list-ref la x)) 1]
       [(= 1 (list-ref lb x)) 2]
       [else 0]))))

; Possible Placements
; Computes all possible solutions given the current state of the tool.
(define
  (placement B)
  (let ; Local variables of the frog pattern dimensions
   ([xa (list-ref (list-ref FPL (PF-frga B)) 0)]
    [ya (list-ref (list-ref FPL (PF-frga B)) 1)]
    [xb (list-ref (list-ref FPL (PF-frgb B)) 0)]
    [yb (list-ref (list-ref FPL (PF-frgb B)) 1)])
   (apply append ; for/list returns a list.
    (apply append ; append flattens the nested lists to the desired level.
     (apply append ; Cannot use flatten to keep the required structure of a list of lists.
      (for/list ([i (range (- 6 xa))]) ; Loop through frog A's x-position.
        (for/list ([j (range (- 6 ya))]) ; Loop through frog A's x-position.
          (for/list ([k (range (- 6 xb))]) ; Loop through frog B's y-position.
            (for/list ([l (range (- 6 yb))] ; Loop through frog B's y-position.
                       #:when (fit ; Ignore cases when masks don't produce a valid solution.
                               (PF-bord B)
                               (genmask
                                (list-ref FPL (PF-frga B))
                                i j)
                               (genmask
                                (list-ref FPL (PF-frgb B))
                                k l)))
              (stack ; Return solution.
               (genmask
                (list-ref FPL (PF-frga B))
                i j)
               (genmask
                (list-ref FPL (PF-frgb B))
                k l)))))))))))

; Location Frequency
; Computes the frequency a frog appears in each empty location.
; Ignore the spots where the user input data.
(define
  (frequency llst bord)
  (build-list 25
   (lambda(y)
    (if
     (<= 1 (list-ref bord y) 3)
     0 ; Ignore locations input by user.
     (apply +
      (map
       (lambda(x)
        (if ; 1 if a frog is in a specific position. 0 if not.
          (= (list-ref x y) 0)
         0 1))
       llst))))))

;;;;;;;;;;;;
; Graphics ;
;;;;;;;;;;;;

; Draw Lily pad + Overlay
; Returns lily pad with the correct image above.
(define
  (pad i)
  (overlay
   (cond
     [(= i 1) frga]
     [(= i 2) frgb]
     [(= i 3) flwr]
     [(= i 4) chck]
     [(= i 5) conf]
     [(= i 6) crss]
     [else blc1])
   lily blc2))

; Build Lilypad Board
; Returns an image of the 5x5 grid of lily pads showing board data.
(define
  (pond B)
  (overlay
   (apply above
    (map
     (lambda(x)
      (apply beside (map pad x)))
     (build-list 5
      (lambda(x)
       (cut B
        (* x 5)
        (* (+ x 1) 5)
        )
       )
      )
     )
    )
   (square 480 'solid 'darkblue))
  )

; Draw Frog Pattern
; Returns an image of the dot patterns of a specific breed.
(define
  (dots lst)
  (let ; Local variables of the frog pattern dimensions
   ([x (list-ref lst 0)]
    [y (list-ref lst 1)]
    [new (cut lst 2 -1)])
   (apply above ; Stack list of images into one image.
    (append
     (build-list y
      (lambda (z)
       (apply beside ; Place list of images side by side into one image.
        (append
         (map ; Replace 0 and 1 in frog pattern list slice with squares.
          (lambda (w)
           (overlay
            (if (= w 0)
             (square 10 'solid (make-color 140 62 25)) ; No frog
             (square 10 'solid 'white)) ; Frog
            (square 15 0'red))
           )
          (cut new ; Slice of frog pattern list.
           (* z x)
           (* (+ z 1) x)
           )
          )
         (list(square 0 0'red))) ; In case frog pattern list has a width of 1.
        )
       )
      )
     (list(square 0 0'red))) ; In case frog pattern list has a height of 1.
    )
   )
  )

; Draw Buttons
; Returns image of four buttons, with the current button selected.
(define
  (buttons i)
  (apply
   beside
   (build-list 4
    (lambda(x)
     (overlay
      (list-ref (list crss frga frgb flwr) x) ; List of button symbols.
      (square 48 'solid
       (if (= i x)
        'dimgray 'gray))
      (square 50 'solid 'black)
      (square 64 0'red))))))


; Draw Screen
; Return application screen image given the current state of the tool.
(define
  (draw B)
  (beside
   (overlay
    (above
     (beside
      (overlay/align ; Info of Frog A
       'middle
       'top
       (above
        (rectangle 0 10 0'red)
        (text (list-ref FSL (PF-frga B)) 20'black)
        (overlay
         frga
         lily)
        (dots (list-ref FPL (PF-frga B))))
       (rectangle 128 180 0'red))
      (overlay/align ; Info of Frog B
       'middle
       'top
       (above
        (rectangle 0 10 0'red)
        (text (list-ref FSL (PF-frgb B)) 20'black)
        (overlay
         frgb
         lily)
        (dots (list-ref FPL (PF-frgb B))))
       (rectangle 128 180 0'red)))
     (overlay ; Box containing level.
      (text(string-append"LVL: "(number->string(PF-levl B))) 20'black)
      (rectangle 98 18'solid'gray)
      (rectangle 100 20'solid'black))
     (beside ; Box containing breeds to select.
      (apply above ; Frog A box
       (build-list 5
        (lambda(x)
         (overlay
          (text
           (with-handlers
               ([exn:fail?(lambda(x)"")]) ; If truncated list is too short, return empty string.
             (list-ref (sFSL (PF-levl B)) (+ x (car (PF-scrl B)))))
           14 'black)
          (rectangle 98 18'solid'gray)
          (rectangle 100 20'solid'black)))))
      (apply above ; Frog B box
       (build-list 5
        (lambda(x)
         (overlay
          (text
           (with-handlers
               ([exn:fail?(lambda(x)"")]) ; If truncated list is too short, return empty string.
             (list-ref (sFSL (PF-levl B)) (+ x (cdr (PF-scrl B)))))
           14 'black)
          (rectangle 98 18'solid'gray)
          (rectangle 100 20'solid'black))))))
     (rectangle 50 20 0'red) ; Padding
     (buttons (PF-mode B))) ; Buttons
    (overlay/align ; Padding with info overlayed.
     'left 'bottom
     (text INFO 10'black)
     (rectangle 256 480'solid'sienna)))
   (pond (PF-bord B))))

;;;;;;;;;;;;;;;;
; World Events ;
;;;;;;;;;;;;;;;;

; Mouse Event
; Updates game state based off of mouse input.
(define
  (mouse B x y ev)
  (cond
    [(string=? ev "button-down") ; Mouse pressed
     (let
      ([scrolly (inexact->exact(floor(/(- y 248)20)))] ; Index of breed selection.
       [buttonx1 (inexact->exact(floor(/(- x 7)64)))] ; Index of button.
       [buttonx2 (inexact->exact(floor(/(+ x 7)64)))] ; Two values are used to ensure mouse is above a button.
       [pondx1 (inexact->exact(floor(/(- x 288)80)))] ; X-index of pond lily pad.
       [pondx2 (inexact->exact(floor(/(- x 304)80)))] ; Ditto of buttonx2.
       [pondy1 (inexact->exact(floor(/(- y 32)80)))] ; Y-index of pond lily pad.
       [pondy2 (inexact->exact(floor(/(- y 48)80)))]) ; Ditto of buttonx2.
       (make-PF
        (if ; Update frog A breed.
         (and (<= 0 scrolly 4) (<= 24 x 128)) ; Mouse is within bounding box.
         (index-of FSL
          (let
           ([str (list-ref
                  (append(sFSL (PF-levl B))(make-list 5 ""))
                  (+ (car (PF-scrl B)) scrolly))])
            (if (string=? str "") (list-ref FSL (PF-frga B)) str))) ; Make sure frog breed is selected.
         (PF-frga B))
        (if ; Update frog B breed.
         (and (<= 0 scrolly 4) (<= 128 x 228)) ; Mouse is within bounding box.
         (index-of FSL
          (let
           ([str (list-ref
                  (append(sFSL (PF-levl B))(make-list 5 ""))
                  (+ (cdr (PF-scrl B)) scrolly))])
            (if (string=? str "") (list-ref FSL (PF-frgb B)) str))) ; Make sure frog breed is selected.
         (PF-frgb B))
        (if ; Update pond lily pads.
         (and ; Mouse is on a lilypad.
          (= pondx1 pondx2)
          (= pondy1 pondy2)
          (<= 0 pondx1 4)
          (<= pondy1 4))
         (list-set ; Set symbol on board.
          (PF-bord B)
          (+ (* pondy1 5) pondx1)
          (if
           (=
            (list-ref
             (PF-bord B)
             (+ (* pondy1 5) pondx1))
            (PF-mode B)) ; Toggle if same
           0 (PF-mode B))) ; Replace if different
         (PF-bord B))
        (if ; Update buttons
         (and ; Mouse is on a button
          (<= 375 y 425)
          (= buttonx1 buttonx2)
          (<= 0 buttonx1 3))
         buttonx1
         (PF-mode B))
        (PF-poss B) ; Keep possible states the same.
        (PF-scrl B) ; Keep mouse scroll the same.
        (cons x y) ; Current mouse X and Y coordinates.
                   ; This is necessary since the scroll wheel is a keyboard event.
        (PF-levl B) ; Keep frog level the same.
        true))] ; Update the board position on the next game tick.
    [else ; Button not pressed. Mouse X and Y coordinates must still be updated.
     (make-PF
       (PF-frga B)
       (PF-frgb B)
       (PF-bord B)
       (PF-mode B)
       (PF-poss B)
       (PF-scrl B)
       (cons x y)
       (PF-levl B)
       (PF-updt B))]))

; Key Event
; Updates game state based off of keyboad input.
(define
  (key B k)
  (cond
    [(string=? k "r") t] ; Reset. Resets tool to original state.
    [(string=? k "c") ; Clear. Clears pond and keeps all else constant.
     (make-PF
       (PF-frga B)
       (PF-frgb B)
       BOARD
       (PF-mode B)
       (PF-poss B)
       (PF-scrl B)
       (PF-mous B)
       (PF-levl B)
       true)]
    [(string=? k "wheel-up") ; Wheel scrolls up.
      (make-PF
       (PF-frga B)
       (PF-frgb B)
       (PF-bord B)
       (PF-mode B)
       (PF-poss B)
       (cond ; Update scroll of frog list.
        [(and ; Mouse is in bounding box.
          (< 0 (car (PF-scrl B)))
          (<=  24 (car (PF-mous B)) 128)
          (<= 248 (cdr (PF-mous B)) 348))
         (cons (sub1 (car (PF-scrl B))) (cdr (PF-scrl B)))]
        [(and ; Mouse is in bounding box.
          (< 0 (cdr (PF-scrl B)))
          (<= 128 (car (PF-mous B)) 228)
          (<= 248 (cdr (PF-mous B)) 348))
         (cons (car (PF-scrl B)) (sub1 (cdr (PF-scrl B))))]
        [else (PF-scrl B)])
       (PF-mous B)
       (PF-levl B)
       (PF-updt B))]
    [(string=? k "wheel-down") ; Wheel scrolls down.
      (make-PF
       (PF-frga B)
       (PF-frgb B)
       (PF-bord B)
       (PF-mode B)
       (PF-poss B)
       (cond ; Update scroll of frog list.
        [(and ; Mouse is in bounding box.
          (< (car (PF-scrl B)) (- (length (sFSL (PF-levl B))) 5))
          (<=  24 (car (PF-mous B)) 128)
          (<= 248 (cdr (PF-mous B)) 348))
         (cons (add1 (car (PF-scrl B))) (cdr (PF-scrl B)))]
        [(and ; Mouse is in bounding box.
          (< (cdr (PF-scrl B)) (- (length (sFSL (PF-levl B))) 5))
          (<= 128 (car (PF-mous B)) 228)
          (<= 248 (cdr (PF-mous B)) 348))
         (cons (car (PF-scrl B)) (add1 (cdr (PF-scrl B))))]
        [else (PF-scrl B)])
       (PF-mous B)
       (PF-levl B)
       (PF-updt B))]
    [(string->number k) ; Number input
     (make-PF
       (PF-frga B)
       (PF-frgb B)
       (PF-bord B)
       (PF-mode B)
       (PF-poss B)
       (cons 0 0) ; Reset scroll position.
       (PF-mous B) ; Types in number. Maxes out at max frog level. 
       (min (apply max FLL) (+ (*(PF-levl B) 10) (string->number k)))
       (PF-updt B))]
    [(string=? k "\b") ; Backspace. Undo level number.
     (make-PF
       (PF-frga B)
       (PF-frgb B)
       (PF-bord B)
       (PF-mode B)
       (PF-poss B)
       (cons 0 0) ; Reset scroll position.
       (PF-mous B)
       (quotient (PF-levl B) 10) ; Acts like how backspace should.
       (PF-updt B))]
    [else B]))

; Update Event
; Checks if the solutions need to be computed every frame.
; Updates to board or frog info will set this code off.
(define
  (update B)
  (if
   (PF-updt B) ; Check if update is necessary.
   (let ; Local variables of new possible solutions and frog frequencies.
    ([p (placement B)]
     [f (frequency (placement B) (PF-bord B))])
    (make-PF
     (PF-frga B)
     (PF-frgb B)
     (build-list 25 ; Build new board to display.
      (lambda(x)
       (let ; Local variables of current index of the frequency list and old pond board.
        ([a(list-ref f x)]
         [b(list-ref(PF-bord B)x)])
        (cond
          [(<= 1 b 3) b] ; Keep user input.
          [(= a 0) 6] ; No frog in position. Place brown cross.
          [(= a (length p)) 5] ; Every solution has a frog here. Place gold check.
          [(= a(apply max f)) 4] ; Best position. Place black circle.
          [else 0])))) ; Place empty location.
     (PF-mode B)
     p ; New possible solutions.
     (PF-scrl B)
     (PF-mous B)
     (PF-levl B)
     false)) ; No need to update again.
   B))

; Start application
(big-bang t
  (to-draw draw) ; Draw screen
  (on-mouse mouse) ; Mouse input
  (on-key key) ; Keyboard input
  (on-tick update) ; Update
  (name NAME)) ; Appliction name