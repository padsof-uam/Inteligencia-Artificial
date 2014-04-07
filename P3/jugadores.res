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

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))))

Results
Average: -0.1675 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0.17000002           
Weights: (-0.070144415 0.069034815 -0.7037604 -0.36022305 -0.3530512 -0.9558861
          0.71130276 -0.3847916 0.044801712 0.29642677 -0.6028466 -0.54198956
          -0.4193294 0.14722681)

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
Weights: (-0.12937546 -0.27676582 0.4477129 -0.7702668 0.61504245 -0.6945007
          -0.7131195 -0.93477297 0.37122655 -0.19700289 0.34961557 -0.5448494
          -0.24521351 -0.42153335)

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
Average: -0.33249998 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.73      
Ju-Mmx-Bueno-SA       2          T          0.16000003           
Ju-Mmx-Regular-SA     2          NIL        -0.76      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.16559815 0.2053101 -0.78633595 -0.54811907 0.660336 -0.21264148
          -0.2840302 0.27898479 0.3938203 0.4709146 -0.9943857 -0.98180795
          0.91379 -0.84375405)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (suma-fila 
       (estado-tablero estado) 
       (estado-lado-sgte-jugador estado)))))

Results
Average: -0.1475 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.63      
Ju-Mmx-Bueno-SA       2          T          0.04000002           
Ju-Mmx-Regular-SA     2          NIL        0          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.32811236 -0.06445074 -0.17773438 0.690505 0.90943265 -0.92213273
          -0.70859575 0.6644523 -0.30233455 0.13402915 -0.4289713 -0.84490466
          0.19111776 -0.6306319)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (suma-fila 
       (estado-tablero estado) 
       (lado-contrario (estado-lado-sgte-jugador estado))))))

Results
Average: -0.3125 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.49      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.76      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.8522191 -0.8159313 -0.86852956 0.17638731 0.5699904 -0.90429616
          -0.9732437 -0.62153316 0.7385254 0.7230971 -0.5677247 -0.7994139
          0.35345364 0.020882845)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (if (< (get-tot 1) (get-tot 0))
    (max-list-chained 0 estado)
    (max-list-chained 1 estado)))))

Results
Average: -0.2275 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.35000002          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.56      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.09321833 0.555707 -0.8780215 -0.284029 0.96055484 -0.9975586
          0.08773208 -0.54198503 -0.33549023 0.5783918 0.20250344 -0.7837231
          -0.26741982 0.5885918)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list-chained 0 estado))))

Results
Average: -0.155 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.62      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.22336578 -0.28709316 -0.23674607 -0.41722274 0.904243 -0.93487024
          -0.7815225 0.7000065 0.95046234 0.24262786 0.34030747 0.46985745
          0.10352826 -0.91546583)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list-chained 1 estado))))

Results
Average: -0.28750002 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.31      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.19900799 -0.36395 0.9362426 -0.21895742 0.4314897 -0.8486037
          -0.81272125 -0.38450074 -0.8896258 -0.23576427 0.12061238 -0.81781316
          0.4888456 -0.23776007)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))))

Results
Average: -0.13250001 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0.24000001           
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0.06999999           
Weights: (0.8464427 -0.49374962 -0.1856134 -0.10320735 -0.42895603 -0.9778197
          -0.73005176 0.3534608 0.8709502 -0.08315563 -0.52679944 0.95057034
          -0.87243986 -0.16362476)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))))

Results
Average: -0.31 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.73      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.64      
Ju-Mmx-Bueno-SA       2          NIL        0.13       
Weights: (0.65752625 0.41851377 -0.98976135 0.59977484 -0.57611036 -0.77501035
          0.2940693 -0.8144119 0.9350574 0.26413274 0.77808523 -0.2507007
          0.49770713 -0.93225837)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (x) (= x 0))))

Results
Average: -0.23 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.13      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0.050000012          
Weights: (0.42120552 0.66997004 -0.9129739 0.38847446 -0.14990854 -0.5192332
          -0.06434178 -0.7523761 0.79695797 0.018956423 -0.5036669 0.059994936
          -0.41899633 0.10153341)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (x) (= x 0))))

Results
Average: -0.14000002 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0.27999997           
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.8457744 -0.059308052 -0.41446924 -0.116765976 0.18742847
          -0.47915244 -0.1670742 -0.17156339 -0.67760324 0.33135915 -0.29805064
          -0.09795976 -0.68905425 -0.034178257)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (x) (not (= x 1)))))

Results
Average: -0.26749998 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.73      
Ju-Mmx-Bueno-SA       2          T          0.42000002           
Ju-Mmx-Regular-SA     2          NIL        -0.76      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.1267581 0.15186667 -0.5975461 0.057397842 0.66949224 -0.9037261
          0.0057370663 -0.33037233 -0.8928714 -0.6718738 0.7428427 -0.9740982
          -0.18595433 -0.64526343)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (x) (not (= x 1)))))

Results
Average: -0.155 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.62      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.21060967 -0.07763791 0.8094053 0.26096702 -0.03959298 -0.9931245
          -0.918098 -0.67244744 0.3756423 0.70782566 -0.3216324 -0.8012035
          -0.709296 -0.62507033)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (x) (or (= x 0) (>= x 4)))))

Results
Average: -0.19 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.76      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.6814475 0.47769976 -0.22817731 -0.30939627 0.65397835 -0.5095711
          -0.8705044 0.02137518 -0.13592625 -0.5393379 -0.10705209 -0.34761953
          0.33584833 -0.47110176)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (x) (or (= x 0) (>= x 4)))))

Results
Average: -0.2425 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.61      
Ju-Mmx-Bueno-SA       2          T          0.27999997           
Ju-Mmx-Regular-SA     2          NIL        -0.64      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.5144007 0.1908946 0.7671807 0.6527524 -0.18396044 -0.99811244
          -0.1087234 -0.7763252 0.9949722 -0.46371675 0.9988003 -0.6792903
          0.9540472 -0.89893603)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (x) (and (>= x 1) (< x 4)))))

Results
Average: -0.1075 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0.41000003           
Weights: (0.3606677 -0.15168715 -0.63159823 -0.77302504 0.19154024 0.2612338
          -0.7540343 -0.4076202 0.9075637 -0.8934729 -0.7829442 -0.087347984
          0.6577289 0.1553824)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (x) (and (>= x 1) (< x 4)))))

Results
Average: -0.18500002 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.73      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.44      
Ju-Mmx-Bueno-SA       2          NIL        0.43       
Weights: (-0.053128004 0.18199897 0.14963508 0.32675767 0.025164127 -0.92479444
          0.60408735 -0.976521 0.008670092 0.75385475 -0.15088892 -0.5731635
          0.79648113 -0.47474337)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (x) (and (>= x 1) (< x 4)))))

Results
Average: -0.325 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.75      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.78      
Ju-Mmx-Bueno-SA       2          NIL        0.23000002           
Weights: (-0.2949183 -0.02828908 -0.7235284 0.00900507 -0.17994738 -0.587523
          -0.4982252 -0.049283028 0.6273184 0.0043759346 0.6995406 -0.6812978
          0.6440804 -0.997262)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (x) (and (>= x 1) (< x 4)))))

Results
Average: -0.245 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.61      
Ju-Mmx-Bueno-SA       2          T          0.13999999           
Ju-Mmx-Regular-SA     2          NIL        -0.64      
Ju-Mmx-Bueno-SA       2          NIL        0.13       
Weights: (0.34049964 0.37781096 0.7247412 -0.9803312 0.7291899 -0.8417337
          0.14837575 -0.08110714 -0.030855417 -0.53743076 0.09516001
          -0.25656414 -0.57903194 0.18288302)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))))

Results
Average: -0.22250001 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.17000002          
Ju-Mmx-Bueno-SA       2          T          0.0        
Ju-Mmx-Regular-SA     2          NIL        -0.72      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.103476286 0.4078424 -0.65963435 -0.011513233 0.26119518
          -0.60809636 -0.8642707 -0.7911837 0.9975772 -0.76395655 -0.20173693
          0.21450233 0.038756132 -0.13989282)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (estado)( - (suma-fila 
                           (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)) 
                        (suma-fila 
                           (estado-tablero estado) 
                           (lado-contrario (estado-lado-sgte-jugador estado)))))))

Results
Average: -0.19 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.76      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.50017834 0.22005677 0.21003008 -0.16312432 0.09426737 -0.71316266
          -0.94049454 -0.15508747 -0.021897554 -0.9484868 0.7187669 -0.87248874
          0.21208048 -0.65202236)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (estado) (suma-fila 
       (estado-tablero estado) 
       (estado-lado-sgte-jugador estado)))))

Results
Average: -0.18499999 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.029999971         
Ju-Mmx-Bueno-SA       2          T          0.0        
Ju-Mmx-Regular-SA     2          NIL        -0.76      
Ju-Mmx-Bueno-SA       2          NIL        0.050000012          
Weights: (-0.58094144 0.58890533 -0.8030336 0.5392959 0.7332909 -0.7447829
          0.21110892 -0.638726 0.11241794 -0.28115392 0.69284797 -0.52935624
          0.020699263 -0.76850104)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (estado) (suma-fila 
       (estado-tablero estado) 
       (lado-contrario (estado-lado-sgte-jugador estado))))))

Results
Average: -0.17500001 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0.13999999           
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.1487627 0.7965727 -0.6227176 -0.24571586 0.25290275 -0.30471492
          -0.25625587 0.989892 -0.2003653 -0.5653386 -0.36180377 0.44068146
          0.58963394 -0.44331908)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (estado) (if (< (get-tot 1) (get-tot 0))
    (max-list-chained 0 estado)
    (max-list-chained 1 estado)))))

Results
Average: -0.285 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.73      
Ju-Mmx-Bueno-SA       2          T          0.060000002          
Ju-Mmx-Regular-SA     2          NIL        -0.6       
Ju-Mmx-Bueno-SA       2          NIL        0.13       
Weights: (0.2272942 0.8505058 0.74283123 0.9573326 -0.11120629 -0.9427607
          -0.37306237 -0.5346608 0.6677015 -0.9211421 0.20981812 -0.71950865
          0.94538784 -0.9292798)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (estado) (max-list-chained 0 estado))))

Results
Average: -0.185 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.74      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.1975627 -0.13081026 0.18668246 -0.24827385 -0.22639704 -0.88577604
          0.121800184 -0.4869349 -0.60947275 0.32945967 0.20568943 0.19949746
          0.69096327 -0.5946858)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (estado) (max-list-chained 1 estado))))

Results
Average: -0.21000001 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.03502655 0.54031825 -0.8217802 -0.51757526 0.29662538 -0.48171163
          0.43141484 0.14162064 0.44762206 -0.30568266 -0.8766546 0.5194199
          0.09471083 -0.04100132)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))))

Results
Average: -0.21000001 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.15679383 -0.1045475 -0.18713474 -0.5870359 -0.16769838 -0.9542141
          -0.7394991 -0.13180685 -0.06592178 0.021451712 0.14241385 -0.46024442
          0.2877941 -0.7949102)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))))

Results
Average: -0.185 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.74      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.19075012 -0.052318335 0.8044884 -0.39179492 0.7827215 -0.8319769
          0.7063949 -0.23817444 0.075725794 -0.41810417 -0.04019928 0.71068335
          0.9655094 -0.7702241)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (x) (= x 0))))

Results
Average: -0.2175 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.19      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.68      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.3381822 -0.17633963 -0.7066853 -0.10110617 0.54924846 -0.81975245
          -0.79864573 -0.6932564 -0.3391688 -0.2104373 -0.92516255 -0.6849041
          -0.39259672 0.3092761)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (x) (= x 0))))

Results
Average: -0.21000001 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.51793694 0.05034423 -0.84224653 0.44811654 0.6414342 -0.67962027
          -0.23685789 -0.7786765 0.82979894 -0.62055993 -0.34120822
          -0.099695206 0.9971082 -0.6983528)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (x) (not (= x 1)))))

Results
Average: -0.2825 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.73      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.39999998          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.44228697 -0.09034014 -0.26545286 0.23191667 -0.33248544 -0.8393872
          -0.32846498 0.61937857 0.60060954 0.020139694 -0.94973564 -0.8908639
          0.1688633 -0.83859515)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (x) (not (= x 1)))))

Results
Average: -0.19 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.76      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.3346362 0.41620994 0.34132528 -0.6176498 0.6002579 -0.87560797
          -0.5035491 -0.42835808 0.89078546 -0.6519816 -0.6131058 -0.5509515
          0.83216643 -0.6158049)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (x) (or (= x 0) (>= x 4)))))

Results
Average: -0.1825 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.73      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        0          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.16134644 0.31760526 0.14511108 0.840034 -0.7152424 -0.8074372
          0.42296386 -0.93970895 -0.020726442 -0.38053036 0.27056885
          -0.25668216 0.57890654 -0.41010213)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (x) (or (= x 0) (>= x 4)))))

Results
Average: -0.21000001 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.61820006 0.56322503 0.48777604 -0.111955166 0.621372 -0.9168687
          -0.9509468 -0.94053364 0.45321894 -0.2441051 -0.6617105 -0.6854696
          0.94652724 -0.041229486)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (x) (and (>= x 1) (< x 4)))))

Results
Average: -0.3125 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.73      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.52      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.05005908 0.045436144 -0.90164185 -0.953645 0.5364082 -0.008911371
          0.35182667 -0.95505977 -0.47153544 0.5224261 -0.25500727 -0.84872055
          -0.01443553 -0.8556137)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (x) (and (>= x 1) (< x 4)))))

Results
Average: -0.2425 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.45      
Ju-Mmx-Bueno-SA       2          T          0.32       
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.6728585 -0.1712594 -0.5257726 -0.79190063 -0.40960836 -0.9648452
          -0.3004949 -0.97899294 0.8969686 -0.87402034 -0.34985042 -0.691313
          -0.5141306 0.45287538)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (x) (and (>= x 1) (< x 4)))))

Results
Average: -0.33 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.73      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.72      
Ju-Mmx-Bueno-SA       2          NIL        0.13       
Weights: (0.5380912 -0.7608361 -0.5494127 -0.20203424 0.26816988 -0.35083747
          -0.31614852 -0.87626266 0.6685159 0.42829204 -0.024131775 -0.69514275
          0.6506779 -0.7618587)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))#'(lambda (x) (and (>= x 1) (< x 4)))))

Results
Average: -0.24249999 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.32999998          
Ju-Mmx-Bueno-SA       2          T          0.01999998           
Ju-Mmx-Regular-SA     2          NIL        -0.65999997          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.9208126 0.5492759 0.19929552 -0.35548234 0.27183175 -0.929276
          -0.9143398 -0.89945173 0.038151026 -0.65116334 0.13699341 -0.99787545
          0.41455913 -0.14136052)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))#'(lambda (estado)( - (suma-fila 
                           (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)) 
                        (suma-fila 
                           (estado-tablero estado) 
                           (lado-contrario (estado-lado-sgte-jugador estado)))))))

Results
Average: -0.19 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.76      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.7342329 -0.3137915 -0.27358532 0.14079905 0.107893944 -0.66137624
          -0.69656897 -0.70855284 -0.8831384 -0.10223675 0.6512816 -0.5273478
          -0.16180372 -0.4960215)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))#'(lambda (estado) (suma-fila 
       (estado-tablero estado) 
       (estado-lado-sgte-jugador estado)))))

Results
Average: -0.1375 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.73      
Ju-Mmx-Bueno-SA       2          T          -0.19      
Ju-Mmx-Regular-SA     2          NIL        0          
Ju-Mmx-Bueno-SA       2          NIL        0.37       
Weights: (0.7670984 -0.051876307 -0.066803694 -0.4147942 0.89162636 -0.7861719
          -0.18976879 0.28370357 0.5532043 -0.7158272 0.60375667 0.33626056
          -0.515882 -0.5265205)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))#'(lambda (estado) (suma-fila 
       (estado-tablero estado) 
       (lado-contrario (estado-lado-sgte-jugador estado))))))

Results
Average: -0.29500002 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.75      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0.41000003           
Weights: (-0.92903376 0.74559 0.31782508 -0.12640452 0.119716644 -0.8503351
          -0.6651695 -0.260988 -0.287858 0.3249781 -0.18198681 -0.71008706
          0.7240908 -0.40750217)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))#'(lambda (estado) (if (< (get-tot 1) (get-tot 0))
    (max-list-chained 0 estado)
    (max-list-chained 1 estado)))))

Results
Average: -0.20250002 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0.029999971          
Weights: (0.33731437 0.68652344 -0.58948016 0.15470076 0.8135464 -0.84134746
          -0.50559545 -0.7277832 0.19998813 0.06963706 0.41765714 -0.07124305
          -0.38342667 -0.18494368)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))#'(lambda (estado) (max-list-chained 0 estado))))

Results
Average: -0.29250002 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.73      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.44      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.32568526 0.9757352 0.070658445 0.1720357 0.65847516 -0.6907878
          -0.74931955 -0.5439851 0.39999747 -0.4470904 -0.23163342 -0.9201524
          0.7795162 -0.8609326)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))#'(lambda (estado) (max-list-chained 1 estado))))

Results
Average: -0.3225 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.65      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.64      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.031841516 0.51766515 -0.15200758 -0.061704397 0.39503622
          -0.71587014 0.3055129 0.72417283 0.456918 -0.66150594 -0.41262674
          -0.70276475 -0.4328189 -0.6030953)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))))

Results
Average: -0.21000001 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.6918266 -0.5179148 -0.5989542 -0.27551723 0.16864705 -0.92905474
          0.16792822 -0.83242226 0.5451658 -0.7086742 -0.25967932 0.48776865
          0.78982806 0.15637636)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))))

Results
Average: -0.21000001 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.6055236 0.47102833 -0.70258474 0.5469427 0.18976021 -0.53535604
          -0.5474775 -0.9751408 0.786145 -0.83971405 -0.90565133 0.12051225
          -0.95325136 0.12710166)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))#'(lambda (x) (= x 0))))

Results
Average: -0.2425 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.73      
Ju-Mmx-Bueno-SA       2          T          0.32       
Ju-Mmx-Regular-SA     2          NIL        -0.56      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.048692703 0.377769 0.04237342 0.5851846 -0.16892624 -0.9275706
          -0.35660982 -0.4656875 -0.4923396 0.6129894 -0.08906889 -0.98369837
          0.8540149 -0.8156824)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))#'(lambda (x) (= x 0))))

Results
Average: -0.27249998 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.32999998          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.76      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.61741185 -0.062119722 -0.87037635 0.22199678 0.86432886 -0.5426619
          -0.8516376 -0.78237796 -0.13876247 -0.4779179 0.20700383 -0.3327713
          -0.20324755 -0.35926533)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))#'(lambda (x) (not (= x 1)))))

Results
Average: -0.21000001 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.7395892 0.4938681 -0.7350509 0.81601477 0.5225544 -0.57543063
          -0.60396695 -0.6486428 0.72047424 -0.7613661 -0.5341015 -0.18224764
          -0.22775078 -0.108555555)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))#'(lambda (x) (not (= x 1)))))

Results
Average: -0.15 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.6       
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.58570576 0.5578346 0.59760785 0.5816233 0.71808314 -0.09921718
          -0.93147993 -0.76762414 -0.39577317 -0.56411815 -0.27296925
          -0.9339194 -0.42048836 -0.41211677)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))#'(lambda (x) (or (= x 0) (>= x 4)))))

Results
Average: -0.2925 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.65      
Ju-Mmx-Bueno-SA       2          T          0.120000005          
Ju-Mmx-Regular-SA     2          NIL        -0.64      
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.23617148 0.1620593 -0.49759245 -0.0852201 -0.1136992 -0.8625691
          0.042234898 -0.3520193 0.8280568 0.78846717 0.56041694 0.03732395
          -0.89025736 -0.78453565)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))#'(lambda (x) (or (= x 0) (>= x 4)))))

Results
Average: -0.3625 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          -0.61      
Ju-Mmx-Bueno-SA       2          T          0          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.6369469 -0.6356125 -0.6221688 0.18836808 0.53891873 -0.8880861
          0.28905392 -0.73657346 -0.815063 -0.57688975 -0.1341896 0.9039304
          0.8639517 0.29104614)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))))

Results
Average: 0.66999996 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0.38       
Ju-Mmx-Bueno-SA       2          T          0.92       
Ju-Mmx-Regular-SA     2          NIL        0.75       
Ju-Mmx-Bueno-SA       2          NIL        0.63       
Weights: (-0.9310014)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))))

Results
















































Game v.7.0 
Evaluation took:
  0.000 seconds of real time
  0.000387 seconds of total run time (0.000376 user, 0.000011 system)
  100.00% CPU
  539,382 processor cycles
  32,768 bytes consed
  

Evaluation took:
  0.002 seconds of real time
  0.002161 seconds of total run time (0.002158 user, 0.000003 system)
  100.00% CPU
  3,784,861 processor cycles
  294,272 bytes consed
  

Evaluation took:
  0.000 seconds of real time
  0.000459 seconds of total run time (0.000457 user, 0.000002 system)
  100.00% CPU
  719,718 processor cycles
  32,768 bytes consed
  

Evaluation took:
  0.000 seconds of real time
  0.000439 seconds of total run time (0.000437 user, 0.000002 system)
  100.00% CPU
  708,798 processor cycles
  32,752 bytes consed
  

Evaluation took:
  0.058 seconds of real time
  0.050557 seconds of total run time (0.050469 user, 0.000088 system)
  87.93% CPU
  122,473,619 processor cycles
  7,750,688 bytes consed
  

Evaluation took:
  0.051 seconds of real time
  0.050975 seconds of total run time (0.050771 user, 0.000204 system)
  100.00% CPU
  106,611,679 processor cycles
  7,752,160 bytes consed
  


Evaluation took:
  0.081 seconds of real time
  0.061191 seconds of total run time (0.060302 user, 0.000889 system)
  [ Run times consist of 0.010 seconds GC time, and 0.052 seconds non-GC time. ]
  75.31% CPU
  169,784,203 processor cycles
  7,717,216 bytes consed
  

Evaluation took:
  0.101 seconds of real time
  0.052284 seconds of total run time (0.052056 user, 0.000228 system)
  51.49% CPU
  210,304,395 processor cycles
  7,847,344 bytes consed
  

Evaluation took:
  0.000 seconds of real time
  0.000424 seconds of total run time (0.000422 user, 0.000002 system)
  100.00% CPU
  711,653 processor cycles
  32,512 bytes consed
  

Evaluation took:
  0.000 seconds of real time
  0.000436 seconds of total run time (0.000434 user, 0.000002 system)
  100.00% CPU
  725,781 processor cycles
  65,200 bytes consed
  


Game v.7.0 cg.base already loaded or Lisp Ver. > 8


















Evaluation took:
  0.001 seconds of real time
  0.000393 seconds of total run time (0.000391 user, 0.000002 system)
  0.00% CPU
  471,304 processor cycles
  32,768 bytes consed
  

Evaluation took:
  0.006 seconds of real time
  0.001867 seconds of total run time (0.001837 user, 0.000030 system)
  33.33% CPU
  12,935,984 processor cycles
  294,560 bytes consed
  

Evaluation took:
  0.000 seconds of real time
  0.000408 seconds of total run time (0.000406 user, 0.000002 system)
  100.00% CPU
  693,231 processor cycles
  65,456 bytes consed
  

Evaluation took:
  0.000 seconds of real time
  0.000394 seconds of total run time (0.000391 user, 0.000003 system)
  100.00% CPU
  665,798 processor cycles
  32,608 bytes consed
  

Evaluation took:
  0.141 seconds of real time
  0.050352 seconds of total run time (0.050124 user, 0.000228 system)
  35.46% CPU
  297,827,701 processor cycles
  7,748,784 bytes consed
  

Evaluation took:
  0.134 seconds of real time
  0.065987 seconds of total run time (0.064940 user, 0.001047 system)
  [ Run times consist of 0.018 seconds GC time, and 0.048 seconds non-GC time. ]
  49.25% CPU
  281,929,589 processor cycles
  7,751,840 bytes consed
  
Evaluation took:
  0.121 seconds of real time
  0.047797 seconds of total run time (0.046847 user, 0.000950 system)
  39.67% CPU
  253,784,266 processor cycles
  7,717,440 bytes consed
  

Evaluation took:
  0.090 seconds of real time
  0.048770 seconds of total run time (0.047985 user, 0.000785 system)
  54.44% CPU
  187,264,828 processor cycles
  7,847,776 bytes consed
  

Evaluation took:
  0.001 seconds of real time
  0.000405 seconds of total run time (0.000403 user, 0.000002 system)
  0.00% CPU
  699,422 processor cycles
  32,768 bytes consed
  

Evaluation took:
  0.009 seconds of real time
  0.000513 seconds of total run time (0.000495 user, 0.000018 system)
  11.11% CPU
  19,373,143 processor cycles
  65,424 bytes consed
  








STYLE-WARNING: redefining COMMON-LISP-USER::MAX-LIST-CHAINED in DEFUN
STYLE-WARNING: redefining COMMON-LISP-USER::MAX-LIST-CHAINED-AUX in DEFUN
STYLE-WARNING: redefining COMMON-LISP-USER::CHAIN-ATE in DEFUN







STYLE-WARNING: redefining COMMON-LISP-USER::OXFORD-EVAL in DEFUN







STYLE-WARNING: redefining COMMON-LISP-USER::PARTIDA-ALL-GAMES in DEFUN



STYLE-WARNING: redefining COMMON-LISP-USER::RANGE in DEFUN










0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.75 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.595 
0.595 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.75 
0.75 
0.595 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.595 
0.595 
0.75 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.595 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.75 
0.75 
0.75 
0.595 
0.75 
0.595 
0.595 
0.595 
0.75 
0.75 
0.75 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.595 
0.595 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.75 
0.595 
0.595 
0.595 
0.75 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
0.595 
0.595 
0.75 
0.595 
0.595 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.75 
0.595 
0.595 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.75 
0.595 
0.595 
0.595 
0.75 
0.75 
0.75 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
0.595 
0.595 
0.595 
0.75 
0.75 
0.75 
0.595 
0.75 
0.75 
0.595 
0.595 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.75 
0.75 
0.75 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.75 
0.595 
0.75 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.75 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.595 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.75 
0.75 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.595 
0.595 
0.595 
0.595 
0.75 
0.595 
0.75 
0.75 
0.595 
0.75 
0.75 
((0.9748821) 0.595) 
>>>RBG 
Average: 0.595 
Average: 0.595 
Results: 
Results: 
Enemy                 Depth      Starts     Result      
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0.44       
Ju-Mmx-Regular-SA     2          T          0.44       
Ju-Mmx-Bueno-SA       2          T          0.8        
Ju-Mmx-Bueno-SA       2          T          0.8        
Ju-Mmx-Regular-SA     2          NIL        0.26999998           
Ju-Mmx-Regular-SA     2          NIL        0.26999998           
Ju-Mmx-Bueno-SA       2          NIL        0.87       
Ju-Mmx-Bueno-SA       2          NIL        0.87       
Weights: (0.9748821)
Weights: (0.9748821)
5 
5 
0.775 
0.775 
0.59000003 
0.59000003 
0.14 
0.14 
0.14 
0.14 
0.14 
0.14 
0.55 
0.55 
0.82500005 
0.82500005 
0.825 
0.825 
0.71000004 
0.71000004 
0.865 
0.865 
0.71000004 
0.71000004 
0.755 
0.755 
0.83 
0.83 
0.3625 
0.3625 
0.36 
0.36 
0.78499997 
0.78499997 
0.54 
0.54 
0.705 
0.705 
0.77 
0.77 
0.82 
0.82 
0.8 
0.8 
0.85 
0.85 
0.73 
0.73 
0.6 
0.6 
0.75 
0.75 
0.4575 
0.4575 
0.052499995 
0.052499995 
0.052499995 
0.052499995 
0.2475 
0.2475 
0.33249998 
0.33249998 
0.74 
0.74 
0.09249999 
0.09249999 
0.09249999 
0.09249999 
0.64 
0.64 
0.855 
0.855 
0.74 
0.74 
0.445 
0.445 
0.85999995 
0.85999995 
0.82 
0.82 
0.81 
0.81 
0.735 
0.735 
0.89000005 
0.89000005 
0.66499996 
0.66499996 
0.775 
0.775 
0.57000005 
0.57000005 
0.465 
0.465 
0.84000003 
0.84000003 
0.2875 
0.2875 
0.82000005 
0.82000005 
0.114999995 
0.114999995 
0.114999995 
0.114999995 
0.114999995 
0.114999995 
0.114999995 
0.114999995 
0.735 
0.735 
0.3725 
0.3725 
0.80499995 
0.80499995 
0.68500006 
0.68500006 
0.1725 
0.1725 
0.29500002 
0.29500002 
0.79999995 
0.79999995 
0.685 
0.685 
0.755 
0.755 
0.215 
0.215 
0.45 
0.45 
0.53 
0.53 
0.86 
0.86 
0.795 
0.795 
0.765 
0.765 
0.81499994 
0.81499994 
0.58500004 
0.58500004 
0.1875 
0.1875 
0.3525 
0.3525 
0.81 
0.81 
0.78000003 
0.78000003 
0.32 
0.32 
0.32 
0.32 
0.32 
0.32 
0.32 
0.32 
0.605 
0.605 
0.605 
0.605 
0.71500003 
0.71500003 
0.61 
0.61 
0.61 
0.61 
0.45499998 
0.45499998 
0.0 
0.0 
0.84000003 
0.84000003 
0.81 
0.81 
-0.065 
-0.065 
-0.065 
-0.065 
-0.065 
-0.065 
-0.065 
-0.065 
-0.065 
-0.065 
0.73 
0.73 
0.81 
0.81 
0.42999998 
0.42999998 
0.61999995 
0.61999995 
0.795 
0.795 
0.675 
0.675 
0.3375 
0.3375 
0.3375 
0.3375 
0.725 
0.725 
0.28750002 
0.28750002 
0.81499994 
0.81499994 
0.795 
0.795 
0.775 
0.775 
0.81 
0.81 
0.3475 
0.3475 
0.3475 
0.3475 
0.89000005 
0.89000005 
0.22250001 
0.22250001 
0.79 
0.79 
0.83 
0.83 
0.2125 
0.2125 
0.2125 
0.2125 
0.78499997 
0.78499997 
0.855 
0.855 
0.69000006 
0.69000006 
0.78499997 
0.78499997 
0.85 
0.85 
0.76 
0.76 
0.46499997 
0.46499997 
0.79499996 
0.79499996 
0.725 
0.725 
0.54 
0.54 
0.022499993 
0.022499993 
0.75 
0.75 
0.75 
0.75 
0.72999996 
0.72999996 
0.81 
0.81 
0.6775 
0.6775 
0.47500002 
0.47500002 
0.78000003 
0.78000003 
0.83 
0.83 
0.79499996 
0.79499996 
0.84 
0.84 
0.855 
0.855 
0.735 
0.735 
-0.0075000077 
-0.0075000077 
-0.0075000077 
-0.0075000077 
-0.0075000077 
-0.0075000077 
0.625 
0.625 
0 
0 
0 
0 
0.72 
0.72 
0.795 
0.795 
0.4375 
0.4375 
0.755 
0.755 
0.77 
0.77 
0.68000007 
0.68000007 
0.06999999 
0.06999999 
0.06999999 
0.06999999 
0.06999999 
0.06999999 
0.695 
0.695 
0.81499994 
0.81499994 
0.1975 
0.1975 
0.1975 
0.1975 
0.1975 
0.1975 
0.81499994 
0.81499994 
0.725 
0.725 
0.57 
0.57 
0.57 
0.57 
0.57 
0.57 
0.78 
0.78 
0.1475 
0.1475 
0.445 
0.445 
0.81 
0.81 
0.78 
0.78 
0.3425 
0.3425 
0.1775 
0.1775 
0.1775 
0.1775 
0.1775 
0.1775 
0.124999985 
0.124999985 
0.17 
0.17 
0.83 
0.83 
0.78999996 
0.78999996 
0.41249996 
0.41249996 
0.4225 
0.4225 
0.85499996 
0.85499996 
0.625 
0.625 
0.77500004 
0.77500004 
0.4 
0.4 
0.88000005 
0.88000005 
0.375 
0.375 
0.004999995 
0.004999995 
0.725 
0.725 
0.735 
0.735 
0.78000003 
0.78000003 
0.835 
0.835 
0.79999995 
0.79999995 
0.775 
0.775 
0.76 
0.76 
0.825 
0.825 
0.83 
0.83 
0.8 
0.8 
0.78 
0.78 
0.78999996 
0.78999996 
0.1825 
0.1825 
((-0.5141299 0.36071515 -0.034867525 -0.17185092 0.79197717 -0.22473979
((-0.5141299 0.36071515 -0.034867525 -0.17185092 0.79197717 -0.22473979
  -0.7894881 -0.76565766 0.29980803 0.63141847 -0.33035803 -0.7224705
  -0.7894881 -0.76565766 0.29980803 0.63141847 -0.33035803 -0.7224705
  -0.76203847 -0.011665106)
  -0.76203847 -0.011665106)
 -0.15) 
 -0.15) 
>>>RBG 
>>>RBG 
Average: -0.15 
Average: -0.15 
Results: 
Results: 
Enemy                 Depth      Starts     Result      
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0.24000001           
Ju-Mmx-Bueno-SA       2          T          0.24000001           
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Regular-SA     2          NIL        -0.84000003          
Ju-Mmx-Bueno-SA       2          NIL        0          
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (-0.5141299 0.36071515 -0.034867525 -0.17185092 0.79197717 -0.22473979
Weights: (-0.5141299 0.36071515 -0.034867525 -0.17185092 0.79197717 -0.22473979
          -0.7894881 -0.76565766 0.29980803 0.63141847 -0.33035803 -0.7224705
          -0.7894881 -0.76565766 0.29980803 0.63141847 -0.33035803 -0.7224705
          -0.76203847 -0.011665106)
          -0.76203847 -0.011665106)

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
Average: 0.3225 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0.7        
Ju-Mmx-Regular-SA     2          NIL        0          
Ju-Mmx-Bueno-SA       2          NIL        0.59000003           
Weights: (0.847157)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (suma-fila 
       (estado-tablero estado) 
       (estado-lado-sgte-jugador estado)))))

Results
Average: 0.3225 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0.7        
Ju-Mmx-Regular-SA     2          NIL        0          
Ju-Mmx-Bueno-SA       2          NIL        0.59000003           
Weights: (0.6056223)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (suma-fila 
       (estado-tablero estado) 
       (lado-contrario (estado-lado-sgte-jugador estado))))))

Results
Average: 0.3225 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0.7        
Ju-Mmx-Regular-SA     2          NIL        0          
Ju-Mmx-Bueno-SA       2          NIL        0.59000003           
Weights: (-0.97031975)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (if (< (get-tot 1) (get-tot 0))
    (max-list-chained 0 estado)
    (max-list-chained 1 estado)))))

Results
Average: 0.4125 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0.76       
Ju-Mmx-Regular-SA     2          NIL        0.89       
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.5867138)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list-chained 0 estado))))

Results
Average: 0.505 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0.9        
Ju-Mmx-Regular-SA     2          NIL        0.57       
Ju-Mmx-Bueno-SA       2          NIL        0.55       
Weights: (0.87906337)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list-chained 1 estado))))

Results
Average: 0.26749998 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0          
Ju-Mmx-Bueno-SA       2          T          0.76       
Ju-Mmx-Regular-SA     2          NIL        0.31       
Ju-Mmx-Bueno-SA       2          NIL        0          
Weights: (0.26701164)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))))

Results
Average: 0.66999996 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0.38       
Ju-Mmx-Bueno-SA       2          T          0.92       
Ju-Mmx-Regular-SA     2          NIL        0.75       
Ju-Mmx-Bueno-SA       2          NIL        0.63       
Weights: (-0.5712538)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))))

Results
Average: 0.595 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0.44       
Ju-Mmx-Bueno-SA       2          T          0.8        
Ju-Mmx-Regular-SA     2          NIL        0.26999998           
Ju-Mmx-Bueno-SA       2          NIL        0.87       
Weights: (0.68582773)

=====================================

With heuristics
(setf *heuristics* (list
#'(lambda (x) (= x 0))))

Results
Average: 0.595 
Results: 
Enemy                 Depth      Starts     Result      
Ju-Mmx-Regular-SA     2          T          0.44       
Ju-Mmx-Bueno-SA       2          T          0.8        
Ju-Mmx-Regular-SA     2          NIL        0.26999998           
Ju-Mmx-Bueno-SA       2          NIL        0.87       
Weights: (0.68582773)

