; 3MV1SL28IC
; SimonDice

(defun mi-f-ev (estado)
  (+ 
    (* 0.27685022 ( - (suma-fila 
                        (estado-tablero estado) 
                        (estado-lado-sgte-jugador estado)) 
                      (suma-fila 
                        (estado-tablero estado) 
                        (lado-contrario (estado-lado-sgte-jugador estado)))))
    (* 0.35966134 (max-list (list-lado estado 
         (lado-contrario (estado-lado-sgte-jugador estado)))))
    (* 0.118098974 (max-list (list-lado estado (estado-lado-sgte-jugador estado))))
    (* -0.99456143 (length (remove-if-not #'(lambda (x) (= x 0)) 
          (list-lado estado (estado-lado-sgte-jugador estado)))))
    (* -0.80726767 (length (remove-if-not #'(lambda (x) (= x 0)) 
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
    (* 0.26139617
      ( - (length (remove-if-not #'(lambda (x) (not (= x 1)))
                (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
          (length (remove-if-not #'(lambda (x) (not (= x 1))) 
                (list-lado estado (estado-lado-sgte-jugador estado))))))
    (* 0.85861015 (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) 
          (list-lado estado (estado-lado-sgte-jugador estado)))))
    (* -0.798074  (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4)))
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
    (* 0.23994088 (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
          (list-lado estado (estado-lado-sgte-jugador estado)))))
    (* 0.4549408
      (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
            (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
          (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
            (list-lado estado (estado-lado-sgte-jugador estado))))))
  ))
