==

(setf *heuristics* (list
  ; Diferencia de semillas. (Heurística del jugador regular)
  #'(lambda (estado)( - (suma-fila 
                           (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)) 
                        (suma-fila 
                           (estado-tablero estado) 
                           (lado-contrario (estado-lado-sgte-jugador estado)))))
  

  ; El máximo que me puedo llevar.
  #'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  ; El máximo que se puede llevar el otro
  #'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))

  ; En cuántos hoyos sí puedo robar semillas.
  #'(lambda (estado)
    (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
        (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
          (list-lado estado (estado-lado-sgte-jugador estado))))))
  ))

((0.49723768 0.9590616 0.35664272 0.7548175) -0.43)
(0.49723768 0.9590616 0.35664272 0.7548175)
"results: "
(-0.83 -0.92 0 0 0 0.029999971 0 0)

======

==

(setf *heuristics* (list
  ; Diferencia de semillas. (Heurística del jugador regular)
  #'(lambda (estado)( - (suma-fila 
                           (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)) 
                        (suma-fila 
                           (estado-tablero estado) 
                           (lado-contrario (estado-lado-sgte-jugador estado)))))
  

  ; En cuántos hoyos sí puedo robar semillas.
  #'(lambda (estado)
    (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
        (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
          (list-lado estado (estado-lado-sgte-jugador estado))))))
  ))

¿?¿?¿?¿

== 

(setf *heuristics* (list
  ; Diferencia de semillas. (Heurística del jugador regular)
  #'(lambda (estado)( - (suma-fila 
                           (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)) 
                        (suma-fila 
                           (estado-tablero estado) 
                           (lado-contrario (estado-lado-sgte-jugador estado)))))
  
   #'(lambda (estado) (length (remove-if #'(lambda (x) (= x 0))
                            (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))

  ; En cuántos hoyos sí puedo robar semillas.
  #'(lambda (estado)
    (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
        (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
          (list-lado estado (estado-lado-sgte-jugador estado))))))

((0.41107774 -0.48793554 -0.13301778) -0.51250005)
(0.41107774 -0.48793554 -0.13301778)
"results: "
(-0.75 -0.9 0 -0.48000002 0.44 -0.84000003 0.72 0.45)


========

((0.369668 -0.8616693 0.5896423 -0.28041363) -0.51250005)
(0.369668 -0.8616693 0.5896423 -0.28041363)
"results: "
(-0.75 -0.9 0 -0.84000003 0.44 -0.84000003 0 0)

(setf *heuristics* (list
  #'(lambda (estado)( - (suma-fila 
                           (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)) 
                        (suma-fila 
                           (estado-tablero estado) 
                           (lado-contrario (estado-lado-sgte-jugador estado)))))
  
   #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
         (list-lado estado (estado-lado-sgte-jugador estado)))))
    #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))) 
  
  #'(lambda (estado)
    (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
        (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
          (list-lado estado (estado-lado-sgte-jugador estado))))))
  ))

=====================================

With heuristics
(setf *heuristics* (list
  #'(lambda (estado)( - (suma-fila 
                           (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)) 
                        (suma-fila 
                           (estado-tablero estado) 
                           (lado-contrario (estado-lado-sgte-jugador estado)))))
  


   #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
         (list-lado estado (estado-lado-sgte-jugador estado)))))
    #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  

  
  
  #'(lambda (estado)
    (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
        (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
          (list-lado estado (estado-lado-sgte-jugador estado))))))
  ))

Results
((0.369668 -0.8616693 0.5896423 -0.28041363) -0.51250005) 
(0.369668 -0.8616693 0.5896423 -0.28041363) 
"results: " 
(-0.75 -0.9 0 -0.84000003 0.44 -0.84000003 0 0) 

Parece ser que nos interesa mucho quitarle movimientos al otro, y evitar que nosotros nos quedemos sin movimientos.
=====================================

With heuristics
(setf *heuristics* (list
  #'(lambda (estado)( - (suma-fila 
                           (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)) 
                        (suma-fila 
                           (estado-tablero estado) 
                           (lado-contrario (estado-lado-sgte-jugador estado)))))
  

  #'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))

   #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
         (list-lado estado (estado-lado-sgte-jugador estado)))))
    #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  

  
  
  #'(lambda (estado)
    (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
        (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
          (list-lado estado (estado-lado-sgte-jugador estado))))))
  ))

Results
((0.23983121 0.12515736 -0.15647388 0.40483785 0.002963066) -0.32999998) 
(0.23983121 0.12515736 -0.15647388 0.40483785 0.002963066) 
"results: " 
(0 -0.9 0 0 0.32 -0.74 0 0) 

Parece que Esto consigue perder menos... no influye mucho el máximo que me puedo llevar pero mejora.
=====================================

With heuristics
(setf *heuristics* (list
  #'(lambda (estado)( - (suma-fila 
                           (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)) 
                        (suma-fila 
                           (estado-tablero estado) 
                           (lado-contrario (estado-lado-sgte-jugador estado)))))
  

  #'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))

   #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
         (list-lado estado (estado-lado-sgte-jugador estado)))))
    #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  

  
  
  #'(lambda (estado)
    (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
        (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
          (list-lado estado (estado-lado-sgte-jugador estado))))))
  ))

Results
 -0.19874999) 
(0.33343124 0.9107299 0.8952265 -0.48621678 -0.17710924 0.44976187) 
"results: " 
(-0.81 0 0 0.120000005 -0.9 0 0 0) 

Los máximos parecen hacer que empates más fácilmente.
=====================================

With heuristics
(setf *heuristics* (list
  #'(lambda (estado)(max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado)(max-list (list-lado estado (estado-lado-sgte-jugador estado))))
  #'(lambda (estado)( - (suma-fila 
                           (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)) 
                        (suma-fila 
                           (estado-tablero estado) 
                           (lado-contrario (estado-lado-sgte-jugador estado)))))
  

  #'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))

  #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
         (list-lado estado (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  

  
  
  #'(lambda (estado)
    (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
        (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
          (list-lado estado (estado-lado-sgte-jugador estado))))))
  ))

Results
(0.7316818 -0.87269235 0.7214341 -0.2820835 0.5460341 -0.26717234 -0.27499962
 0.06303573) 
"results: " 
(-0.79 0 0.3 0 -0.92 -0.3 0 0) 

Mola. Gana al bueno y empata.
=====================================

With heuristics
(setf *heuristics* (list
  #'(lambda (estado)(max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado)(max-list (list-lado estado (estado-lado-sgte-jugador estado))))
  #'(lambda (estado)( - (suma-fila 
                           (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)) 
                        (suma-fila 
                           (estado-tablero estado) 
                           (lado-contrario (estado-lado-sgte-jugador estado)))))
  

  #'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))

  #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
         (list-lado estado (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  

  
  
  ))

Results
 -0.37125003) 
(-0.16444111 -0.34410143 0.8369167 0.54667044 0.006665468 -0.7300024 0.6384437) 
"results: " 
(-0.75 0 0.36 0 -0.9 -0.84000003 -0.84000003 0) 

Reventando al bueno.
=====================================

With heuristics
(setf *heuristics* (list
  #'(lambda (estado)(max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado)(max-list (list-lado estado (estado-lado-sgte-jugador estado))))
  #'(lambda (estado)( - (suma-fila 
                           (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)) 
                        (suma-fila 
                           (estado-tablero estado) 
                           (lado-contrario (estado-lado-sgte-jugador estado)))))
  

  #'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))

  #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
         (list-lado estado (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  

  #'(lambda (estado) (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) 
                            (list-lado estado (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4)))
                            (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  
  
  ))

Results
Average: -0.19875 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     1          T          -0.75      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       1          T          0.44       
Ju-Mmx-Bueno-SA       2          T          0.45999998           
Ju-Mmx-Regular-SA     1          NIL        -0.9       
Ju-Mmx-Regular-SA     2          NIL        0          
Ju-Mmx-Bueno-SA       1          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.7880688 -0.668489 0.79436946 -0.78768563 0.065045595 0.2920618
          0.97934103 0.8868735 0.20814347)

No empeora en exceso con más profundidad
=====================================

With heuristics
(setf *heuristics* (list
  
  #'(lambda (estado) (suma-fila 
      (estado-tablero estado) 
      (estado-lado-sgte-jugador estado)))
  #'(lambda (estado) (suma-fila 
      (estado-tablero estado) 
      (lado-contrario (estado-lado-sgte-jugador estado))))



  

  
  
  #'(lambda (estado)
    (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
      (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
    (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
      (list-lado estado (estado-lado-sgte-jugador estado))))))
  ))

Results
Average: -0.26125 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     1          T          -0.83      
Ju-Mmx-Regular-SA     2          T          -0.43      
Ju-Mmx-Bueno-SA       1          T          0.16000003           
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     1          NIL        -0.92      
Ju-Mmx-Regular-SA     2          NIL        -0.100000024         
Ju-Mmx-Bueno-SA       1          NIL        0.029999971          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.38119102 -0.7240486 0.74162436)

Tres heurísticas y un buen resultado, ganando siempre al regular. Puede que venga bien si tenemos problemas de timeouts.
=====================================

With heuristics
(setf *heuristics* (list
  
  #'(lambda (estado) (suma-fila 
      (estado-tablero estado) 
      (estado-lado-sgte-jugador estado)))
  #'(lambda (estado) (suma-fila 
      (estado-tablero estado) 
      (lado-contrario (estado-lado-sgte-jugador estado))))


  #'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))

  

  
  
  #'(lambda (estado)
    (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
      (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
    (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
      (list-lado estado (estado-lado-sgte-jugador estado))))))
  ))

Results
Average: -0.22375001 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     1          T          -0.83      
Ju-Mmx-Regular-SA     2          T          -0.20999998          
Ju-Mmx-Bueno-SA       1          T          0.13999999           
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     1          NIL        -0.92      
Ju-Mmx-Regular-SA     2          NIL        -0.58000004          
Ju-Mmx-Bueno-SA       1          NIL        0.61       
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.17763829 -0.43314886 -0.40800285 0.36564374 0.50443673)

Bastante bueno contra el regular, no gana al bueno.
=====================================

With heuristics
(setf *heuristics* (list
  #'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))
  
  #'(lambda (estado)( - (suma-fila 
                           (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)) 
                        (suma-fila 
                           (estado-tablero estado) 
                           (lado-contrario (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (suma-fila 
      (estado-tablero estado) 
      (estado-lado-sgte-jugador estado)))
  #'(lambda (estado) (suma-fila 
      (estado-tablero estado) 
      (lado-contrario (estado-lado-sgte-jugador estado))))

  #'(lambda (estado) (if (< (get-tot 1) (get-tot 0))
    (max-list-chained 0 estado)
    (max-list-chained 1 estado)))  

  #'(lambda (estado) (max-list-chained 0 estado))
  #'(lambda (estado) (max-list-chained 1 estado))

  #'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))

  #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
   (list-lado estado (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
    (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  
  #'(lambda (estado) 
    ( - (length (remove-if-not #'(lambda (x) (not (= x 1)))
      (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
    (length (remove-if-not #'(lambda (x) (not (= x 1))) 
      (list-lado estado (estado-lado-sgte-jugador estado))))))

  #'(lambda (estado) (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) 
    (list-lado estado (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4)))
    (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  
  
  #'(lambda (estado)
    (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
      (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
    (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
      (list-lado estado (estado-lado-sgte-jugador estado))))))

  #'(lambda (estado) (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
      (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  
  #'(lambda (estado) (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
      (list-lado estado (estado-lado-sgte-jugador estado)))))
  ))

Results
Average: -0.26000002 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     1          T          -0.83      
Ju-Mmx-Regular-SA     2          T          -0.59000003          
Ju-Mmx-Bueno-SA       1          T          0.53999996           
Ju-Mmx-Bueno-SA       2          T          0.22000003           
Ju-Mmx-Regular-SA     1          NIL        -0.92      
Ju-Mmx-Regular-SA     2          NIL        -0.5       
Ju-Mmx-Bueno-SA       1          NIL        0          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.94323397 -0.7057936 0.86797476 0.2741928 -0.46726465 0.8146305
          -0.58670497 -0.41763878 0.17199922 -0.5764067 0.24967074 0.61843204
          0.9160948 -0.019191027 -0.5582106 0.1565535 0.86168814 0.0536623)

WTF.
=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))))

Results

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))))

Results
Average: -0.13 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0.24000001           
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.76      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.9709265 0.62347627 -0.735173 -0.50837207 0.64231896 -0.85520816
          -0.9305308 0.06684446 -0.43534732 -0.8156774 0.2648635 -0.28211212
          -0.15307546 -0.9315431)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))))

Results
Average: -0.21000001 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.21485448 -0.4471631 -0.31403756 -0.122477055 0.7146423 -0.9815879
          0.45315528 -0.549741 -0.49639106 -0.5163741 -0.71051216 -0.56660724
          0.8745415 -0.45656133)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado)( - (suma-fila 
                           (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)) 
                        (suma-fila 
                           (estado-tablero estado) 
                           (lado-contrario (estado-lado-sgte-jugador estado)))))))

Results
Average: -0.2125 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.37      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.48000002          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.28283668 0.19458771 0.12129736 0.53270173 0.88392043 -0.79977775
          -0.13669443 -0.2821188 0.16726065 -0.09277749 -0.7088342 -0.07123971
          -0.3239839 -0.39361167)

