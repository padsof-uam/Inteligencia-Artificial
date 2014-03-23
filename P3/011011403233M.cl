; 3MV1SL28IC
; Simon

(defun mi-f-ev (estado)
  (+ 
    (* 0.19824123 ( - (suma-fila 
                        (estado-tablero estado) 
                        (estado-lado-sgte-jugador estado)) 
                      (suma-fila 
                        (estado-tablero estado) 
                        (lado-contrario (estado-lado-sgte-jugador estado)))))
    (*  -0.74062204 (max-list-chained 0 estado))
    (*  0.4447801 (max-list-chained 1 estado))  
    (* 0.16666222 (max-list (list-lado estado 
         (lado-contrario (estado-lado-sgte-jugador estado)))))
    (* 0.925256 (max-list (list-lado estado (estado-lado-sgte-jugador estado))))
    (* -0.89839506 (length (remove-if-not #'(lambda (x) (= x 0)) 
          (list-lado estado (estado-lado-sgte-jugador estado)))))
    (* -0.6152954 (length (remove-if-not #'(lambda (x) (= x 0)) 
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
    (* -0.030327797
      ( - (length (remove-if-not #'(lambda (x) (not (= x 1)))
                (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
          (length (remove-if-not #'(lambda (x) (not (= x 1))) 
                (list-lado estado (estado-lado-sgte-jugador estado))))))
    (* 0.5465987 (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) 
          (list-lado estado (estado-lado-sgte-jugador estado)))))
    (* 0.15208268  (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4)))
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
    (* -0.040797234 (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
          (list-lado estado (estado-lado-sgte-jugador estado)))))
    (* 0.6847365
      (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
            (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
          (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
            (list-lado estado (estado-lado-sgte-jugador estado))))))
  ))
