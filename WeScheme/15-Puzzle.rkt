#|                                                                                                    
[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]
[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]
[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]
                                                                                                      
 .---. .---------.            .--------.   .--.   .--. .--------.  .--------.  .--.        .---------.
/_   | |         |            |    __   \  |  |   |  | '.______  | '.______  | |  |        |   ______/
  |  | |  .------'            |   /  \   | |  |   |  |        /  /        /  / |  |        |  |       
  |  | |  |          ______   |   \__/   | |  |   |  |       /  /        /  /  |  |        |  |       
  |  | |  |---..   .'      `. |          | |  |   |  |      /  /        /  /   |  |        |  |______ 
  |  | |        \  |        | |   ______/  |  |   |  |     /  /        /  /    |  |        |         /
  |  | |.---.    | `.______.' |  |         |  |   |  |    /  /        /  /     |  |        |  .-----' 
  |  |       |   |            |  |         |  |   |  |   /  /        /  /      |  |        |  |       
  |  | .----`    |            |  |         |  `._.'  |  /  /        /  /       |  |        |  |       
  |  | |        .             |  |         `.       .' |  '------. |  '------. |  '------. |  '------.
  |__| `._____.'              |__|           `.___.'   `._______.' `._______.' `.________/ '.________/
                                                                                                      
[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]
[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]
[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]
                                                                                                      
  .-------.   .-----.   .-----.     .---------. .-----.                       .------.    .--.    .--.
.'   _____/  /   _   \  |      \    |   ______/ |      \                      |       \   |   \  /   |
|   /       |  .' `.  | |  ,.   \   |  |        |  ,.   \                     |  .''\  \   \   \/   / 
|  |        |  |   |  | |  | \   \  |  |        |  | \   \                    |  |   |  |   \      /  
|  |        |  |   |  | |  |  \   | |  |______  |  |  \   |                   |  `--'   |    \    /   
|  |        |  |   |  | |  |   |  | |         / |  |   |  |                   |        /      |  |    
|  |        |  |   |  | |  |   |  | |  .-----'  |  |   |  |                   |        \      |  |    
|  |        |  |   |  | |  |  /   | |  |        |  |  /   |                   |  .''\   |     |  |    
|   \       |  |   |  | |  |_/   /  |  |        |  |_/   /                    |  |   |  |     |  |    
`.   `----. \  `---'  / |       /   |  '------. |       /                     |  `--'  /      |  |    
  `.______/  `._____.'  `._____/    '.________/ `._____/                      `.______/       |__|    
                                                                                                      
          .-------.  .--.   .--.    .----.    .--.        .--.          .-----.    .-------.          
         /   ___   \ |  |  /  /   .'  __  `.  |  |        |  |         /   _   \  /   ___   \         
         |  |   \__| |  | /  /   |  .'  `.  | |  |        |  |        |  .' `.  | |  |   \__|         
         |  |        |  |/  /    |  |    |  | |  |        |  |        |  |   |  | |  |                
         |  `-----.  |     /     |  `----'  | |  |        |  |        |  |   |  | |  `-----.          
         \         \ |    {      |   ____   | |  |        |  |        |  |   |  | \         \         
          '-----.  | |     \     |  |    |  | |  |        |  |        |  |   |  |  '-----.  |         
                |  | |  |\  \    |  |    |  | |  |        |  |        |  |   |  |        |  |         
         .--.   |  | |  | \  \   |  |    |  | |  |        |  |        |  |   |  | .--.   |  |         
         \   `--'  / |  |  \  \  |  |    |  | |  '------. |  '------. \  `---'  / \   `--'  /         
          `._____.'  |__|   \__\ |__|    |__| `.________/ `.________/  `._____.'   `._____.'          
                                                                                                      
[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]
[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]
[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]
                                                                                                      
      █       █       █       █       █       █       █       █       █       █       █       █       
    ░▒█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░    
|#

;Background Sprites
(define empt(square 60'solid'peru))
(define invi(square 20 0'red))
(define row(beside empt invi empt invi empt invi empt))
(define grid(overlay(above row invi row invi row invi row)(square 340'solid'brown)))

;Foreground Sprite
(define(tile num)(if(= num 0)(square 60 0'red)(overlay(text(number->string num)20'black)(square 40'solid'white)(square 60'solid'black))))

;Function Define
(define(TF a)(if a 1 0))
(define(find0 li)(if(=(first li)0)(- 16(length li))(find0(remove(first li)li))))
(define(cut li a b)(build-list(- b a -1)(lambda(x)(list-ref li(+ x a)))))
(define(win li)(and(=(list-ref li 0)1)(=(list-ref li 1)2)(=(list-ref li 2)3)(=(list-ref li 3)4)(=(list-ref li 4)5)(=(list-ref li 5)6)(=(list-ref li 6)7)(=(list-ref li 7)8)(=(list-ref li 8)9)(=(list-ref li 9)10)(=(list-ref li 10)11)(=(list-ref li 11)12)(=(list-ref li 12)13)(=(list-ref li 13)14)(=(list-ref li 14)15)))

;List Randomizing
(define p1(+(random 15)1))
(define z2(random 14))
(define z3(random 13))
(define z4(random 12))
(define z5(random 11))
(define z6(random 10))
(define z7(random 9))
(define z8(random 8))
(define z9(random 7))
(define z10(random 6))
(define z11(random 5))
(define z12(random 4))
(define z13(random 3))
(define z14(random 2))
(define l1(remove p1(list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)))
(define p2(list-ref l1 z2))
(define l2(remove p2 l1))
(define p3(list-ref l2 z3))
(define l3(remove p3 l2))
(define p4(list-ref l3 z4))
(define l4(remove p4 l3))
(define p5(list-ref l4 z5))
(define l5(remove p5 l4))
(define p6(list-ref l5 z6))
(define l6(remove p6 l5))
(define p7(list-ref l6 z7))
(define l7(remove p7 l6))
(define p8(list-ref l7 z8))
(define l8(remove p8 l7))
(define p9(list-ref l8 z9))
(define l9(remove p9 l8))
(define p10(list-ref l9 z10))
(define l10(remove p10 l9))
(define p11(list-ref l10 z11))
(define l11(remove p11 l10))
(define p12(list-ref l11 z12))
(define l12(remove p12 l11))
(define p13(list-ref l12 z13))
(define l13(remove p13 l12))
(define e14(list-ref l13 z14))
(define l14(remove e14 l13))
(define e15(first l14))

;Defining Variables
(define start(list p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 e14 e15 0))

;Parity Checking
(define d1(-(first start)1))
(define d2(+(TF(>(list-ref start 1)(list-ref start 2)))(TF(>(list-ref start 1)(list-ref start 3)))(TF(>(list-ref start 1)(list-ref start 4)))(TF(>(list-ref start 1)(list-ref start 5)))(TF(>(list-ref start 1)(list-ref start 6)))(TF(>(list-ref start 1)(list-ref start 7)))(TF(>(list-ref start 1)(list-ref start 8)))(TF(>(list-ref start 1)(list-ref start 9)))(TF(>(list-ref start 1)(list-ref start 10)))(TF(>(list-ref start 1)(list-ref start 11)))(TF(>(list-ref start 1)(list-ref start 12)))(TF(>(list-ref start 1)(list-ref start 13)))(TF(>(list-ref start 1)(list-ref start 14)))(TF(>(list-ref start 1)(list-ref start 15)))))
(define d3(+(TF(>(list-ref start 2)(list-ref start 3)))(TF(>(list-ref start 2)(list-ref start 4)))(TF(>(list-ref start 2)(list-ref start 5)))(TF(>(list-ref start 2)(list-ref start 6)))(TF(>(list-ref start 2)(list-ref start 7)))(TF(>(list-ref start 2)(list-ref start 8)))(TF(>(list-ref start 2)(list-ref start 9)))(TF(>(list-ref start 2)(list-ref start 10)))(TF(>(list-ref start 2)(list-ref start 11)))(TF(>(list-ref start 2)(list-ref start 12)))(TF(>(list-ref start 2)(list-ref start 13)))(TF(>(list-ref start 2)(list-ref start 14)))(TF(>(list-ref start 2)(list-ref start 15)))))
(define d4(+(TF(>(list-ref start 3)(list-ref start 4)))(TF(>(list-ref start 3)(list-ref start 5)))(TF(>(list-ref start 3)(list-ref start 6)))(TF(>(list-ref start 3)(list-ref start 7)))(TF(>(list-ref start 3)(list-ref start 8)))(TF(>(list-ref start 3)(list-ref start 9)))(TF(>(list-ref start 3)(list-ref start 10)))(TF(>(list-ref start 3)(list-ref start 11)))(TF(>(list-ref start 3)(list-ref start 12)))(TF(>(list-ref start 3)(list-ref start 13)))(TF(>(list-ref start 3)(list-ref start 14)))(TF(>(list-ref start 3)(list-ref start 15)))))
(define d5(+(TF(>(list-ref start 4)(list-ref start 5)))(TF(>(list-ref start 4)(list-ref start 6)))(TF(>(list-ref start 4)(list-ref start 7)))(TF(>(list-ref start 4)(list-ref start 8)))(TF(>(list-ref start 4)(list-ref start 9)))(TF(>(list-ref start 4)(list-ref start 10)))(TF(>(list-ref start 4)(list-ref start 11)))(TF(>(list-ref start 4)(list-ref start 12)))(TF(>(list-ref start 4)(list-ref start 13)))(TF(>(list-ref start 4)(list-ref start 14)))(TF(>(list-ref start 4)(list-ref start 15)))))
(define d6(+(TF(>(list-ref start 5)(list-ref start 6)))(TF(>(list-ref start 5)(list-ref start 7)))(TF(>(list-ref start 5)(list-ref start 8)))(TF(>(list-ref start 5)(list-ref start 9)))(TF(>(list-ref start 5)(list-ref start 10)))(TF(>(list-ref start 5)(list-ref start 11)))(TF(>(list-ref start 5)(list-ref start 12)))(TF(>(list-ref start 5)(list-ref start 13)))(TF(>(list-ref start 5)(list-ref start 14)))(TF(>(list-ref start 5)(list-ref start 15)))))
(define d7(+(TF(>(list-ref start 6)(list-ref start 7)))(TF(>(list-ref start 6)(list-ref start 8)))(TF(>(list-ref start 6)(list-ref start 9)))(TF(>(list-ref start 6)(list-ref start 10)))(TF(>(list-ref start 6)(list-ref start 11)))(TF(>(list-ref start 6)(list-ref start 12)))(TF(>(list-ref start 6)(list-ref start 13)))(TF(>(list-ref start 6)(list-ref start 14)))(TF(>(list-ref start 6)(list-ref start 15)))))
(define d8(+(TF(>(list-ref start 7)(list-ref start 8)))(TF(>(list-ref start 7)(list-ref start 9)))(TF(>(list-ref start 7)(list-ref start 10)))(TF(>(list-ref start 7)(list-ref start 11)))(TF(>(list-ref start 7)(list-ref start 12)))(TF(>(list-ref start 7)(list-ref start 13)))(TF(>(list-ref start 7)(list-ref start 14)))(TF(>(list-ref start 7)(list-ref start 15)))))
(define d9(+(TF(>(list-ref start 8)(list-ref start 9)))(TF(>(list-ref start 8)(list-ref start 10)))(TF(>(list-ref start 8)(list-ref start 11)))(TF(>(list-ref start 8)(list-ref start 12)))(TF(>(list-ref start 8)(list-ref start 13)))(TF(>(list-ref start 8)(list-ref start 14)))(TF(>(list-ref start 8)(list-ref start 15)))))
(define d10(+(TF(>(list-ref start 9)(list-ref start 10)))(TF(>(list-ref start 9)(list-ref start 11)))(TF(>(list-ref start 9)(list-ref start 12)))(TF(>(list-ref start 9)(list-ref start 13)))(TF(>(list-ref start 9)(list-ref start 14)))(TF(>(list-ref start 9)(list-ref start 15)))))
(define d11(+(TF(>(list-ref start 10)(list-ref start 11)))(TF(>(list-ref start 10)(list-ref start 12)))(TF(>(list-ref start 10)(list-ref start 13)))(TF(>(list-ref start 10)(list-ref start 14)))(TF(>(list-ref start 10)(list-ref start 15)))))
(define d12(+(TF(>(list-ref start 11)(list-ref start 12)))(TF(>(list-ref start 11)(list-ref start 13)))(TF(>(list-ref start 11)(list-ref start 14)))(TF(>(list-ref start 11)(list-ref start 15)))))
(define d13(+(TF(>(list-ref start 12)(list-ref start 13)))(TF(>(list-ref start 12)(list-ref start 14)))(TF(>(list-ref start 12)(list-ref start 15)))))
(define d14(+(TF(>(list-ref start 13)(list-ref start 14)))(TF(>(list-ref start 13)(list-ref start 15)))))
(define d15(TF(>(list-ref start 14)(list-ref start 15))))
(define dt(+ d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15))
(define p14(if(even? dt)e14 e15))
(define p15(if(even? dt)e15 e14))
(define game(list p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 0))

;Draw Image
(define(draw li)(overlay(if(win li)(text"YOU WIN"75'green)(square 0 0'red))(above(beside(tile(list-ref li 0))invi(tile(list-ref li 1))invi(tile(list-ref li 2))invi(tile(list-ref li 3)))invi(beside(tile(list-ref li 4))invi(tile(list-ref li 5))invi(tile(list-ref li 6))invi(tile(list-ref li 7)))invi(beside(tile(list-ref li 8))invi(tile(list-ref li 9))invi(tile(list-ref li 10))invi(tile(list-ref li 11)))invi(beside(tile(list-ref li 12))invi(tile(list-ref li 13))invi(tile(list-ref li 14))invi(tile(list-ref li 15))))grid))

;Key Press
(define(key li k)(cond
[(and(string=?"left"k)(not(=(find0 li)0))(not(=(find0 li)4))(not(=(find0 li)8))(not(=(find0 li)12)))(append(cut li 0(-(find0 li)2))(list 0)(list(list-ref li(-(find0 li)1)))(cut li(+(find0 li)1)15))]
[(and(string=?"right"k)(not(=(find0 li)3))(not(=(find0 li)7))(not(=(find0 li)11))(not(=(find0 li)15)))(append(cut li 0(-(find0 li)1))(list(list-ref li(+(find0 li)1)))(list 0)(cut li(+(find0 li)2)15))]
[(and(string=?"up"k)(not(=(find0 li)0))(not(=(find0 li)1))(not(=(find0 li)2))(not(=(find0 li)3)))(append(cut li 0(-(find0 li)5))(list 0)(cut li(-(find0 li)3)(-(find0 li)1))(list(list-ref li(-(find0 li)4)))(cut li(+(find0 li)1)15))]
[(and(string=?"down"k)(not(=(find0 li)12))(not(=(find0 li)13))(not(=(find0 li)14))(not(=(find0 li)15)))(append(cut li 0(-(find0 li)1))(list(list-ref li(+(find0 li)4)))(cut li(+(find0 li)1)(+(find0 li)3))(list 0)(cut li(+(find0 li)5)15))]
[else li]))

;Game Start
(big-bang game(on-key key)(to-draw draw)(stop-when win))
(draw(list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 0))
