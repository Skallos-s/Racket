(define dom"PPAAYYRRIIGGTT")
(define het"PpAaYyRrIiGgTt")
(define rec"ppaayyrriiggtt")
(define pp1"ppAAyyRRiiGGtt")
(define pp2"PPaaYYrrIIggTT")
(define ran(string-append(if(=(random 2)0)"P""p")(if(=(random 2)0)"P""p")(if(=(random 2)0)"A""a")(if(=(random 2)0)"A""a")(if(=(random 2)0)"Y""y")(if(=(random 2)0)"Y""Y")(if(=(random 2)0)"R""r")(if(=(random 2)0)"R""r")(if(=(random 2)0)"I""i")(if(=(random 2)0)"I""i")(if(=(random 2)0)"G""g")(if(=(random 2)0)"G""g")(if(=(random 2)0)"T""t")(if(=(random 2)0)"T""t")))

(define FCP1'purple  )
(define FCP2'plum    )
(define FCp1'lavender)
(define FCp2'silver  )

(define cyl'yellow)
(define cgl'greenyellow)

(define cyd'gold)
(define cgd'green)


(define(phn str)(if(string=?(substring str 0 1)(substring str 1 2))(substring str 0 1)(if(string<?(substring str 0 1)(substring str 1 2))(substring str 0 1)(substring str 1 2))))
(define(SS str c1 c2)(if(string=?(phn str)"R")(overlay(circle 13'solid c1)(circle 15'solid c2))(overlay(ellipse 16 26'solid c1)(ellipse 26 16'solid c1)(ellipse 20 30'solid c2)(ellipse 30 20'solid c2))))
(define(SSph str)(if(string=?(phn(substring str 4 6))"Y")(SS(substring str 6 8)cyd cyl)(SS(substring str 6 8)cgd cgl)))

(define(PS str c1 c2)(if(string=?(phn str)"I")(overlay(ellipse 94 26'solid c1)(ellipse 100 30'solid c2))(overlay(overlay(ellipse 90 15'solid c1)(beside(circle 8'solid c1)(circle 2 0'red)(circle 13'solid c1)(circle 2 0'red)(circle 13'solid c1)(circle 2 0'red)(circle 8'solid c1)))(overlay(ellipse 100 20'solid c2)(beside(circle 10'solid c2)(circle 15'solid c2)(circle 15'solid c2)(circle 10'solid c2))))))
(define(PSph str)(beside(overlay/align'right'center(square 20'solid'forestgreen)(if(string=?(phn(substring str 10 12))"G")(PS(substring str 8 12)cgd cgl)(PS(substring str 8 12)cyd cyl)))(rotate 30(triangle 20'solid'forestgreen))))

(define(FC c1 c2)(overlay/xy(rotate 180(right-triangle 10 10'solid c2))0 -20(overlay/xy(above(square 5 0'red)(right-triangle 20 15'solid c1)(rectangle 20 10'solid c1)(crop 0 10 20 10(circle 10'solid c1)))-10 0(crop 10 0 30 20(circle 20'solid c2)))))
(define leaf(overlay(rectangle 2 20'solid'green)(crop 3 0 14 27(above(triangle 20'solid'limegreen)(crop 0 10 20 10(circle 10'solid'limegreen))))))
(define stem(overlay/xy(rotate 300 leaf)-25 -25(overlay/xy(rotate 60 leaf)25 0(beside(rectangle 2 60'solid'green)(rectangle 2 60'solid'limegreen)))))
(define(FPA str c1 c2)(if(string=?(phn str)"T")(overlay/xy(overlay/xy(rotate 60(FC c1 c2))20 -60(above(beside(FC c1 c2)(square 9 0'red))stem))20 100 stem)(overlay/xy(rotate 290(flip-horizontal(FC c1 c2)))-25 -30(above(beside(FC c1 c2)(square 9 0'red))stem))))
(define(FPT str c1 c2)(above(beside(FC c1 c2)(square 9 0'red))stem(if(string=?(phn str)"T")stem(square 0 0'red))))
(define(FPph str)(if(string=?(phn(substring str 2 4))"A")(if(string=?(phn(substring str 0 2))"P")(FPA(substring str 12 14)FCP1 FCP2)(FPA(substring str 12 14)FCp1 FCp2))(if(string=?(phn(substring str 0 2))"P")(FPT(substring str 12 14)FCP1 FCP2)(FPT(substring str 12 14)FCp1 FCp2))))

(define(Phenotype str)(above(FPph str)(square 20 0'red)(PSph str)(square 20 0'red)(SSph str)))

(define(Gamete str)(string-append(let([x(random 2)])(substring str x(+ x 1)))(let([x(random 2)])(substring str(+ x 2)(+ x 3)))(let([x(random 2)])(substring str(+ x 4)(+ x 5)))(let([x(random 2)])(substring str(+ x 6)(+ x 7)))(let([x(random 2)])(substring str(+ x 8)(+ x 9)))(let([x(random 2)])(substring str(+ x 10)(+ x 11)))(let([x(random 2)])(substring str(+ x 12)(+ x 13)))))

(define(Cross g1 g2)(string-append(substring g1 0 1)(substring g2 0 1)(substring g1 1 2)(substring g2 1 2)(substring g1 2 3)(substring g2 2 3)(substring g1 3 4)(substring g2 3 4)(substring g1 4 5)(substring g2 4 5)(substring g1 5 6)(substring g2 5 6)(substring g1 6 7)(substring g2 6 7)))

(define(PCG p1 p2)(Phenotype(Cross(Gamete p1)(Gamete p2))))





;(bitmap/url"http://images.slideplayer.com/24/6971163/slides/slide_7.jpg")
