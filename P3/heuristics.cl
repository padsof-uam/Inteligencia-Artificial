(setf *heuristics* (list
  ; Cuidado con estas que son lentas.
  #'(lambda (estado) (if (> (get-pts 1) (get-pts 0)) (max-list-chained 0 estado) (max-list-chained 1 estado)))  
  #'(lambda (estado) (if (< (get-pts 1) (get-pts 0)) (max-list-chained 0 estado) (max-list-chained 1 estado)))  
  #'(lambda (estado) (if (> (get-tot 1) (get-tot 0)) (max-list-chained 0 estado) (max-list-chained 1 estado)))  
  ;#'(lambda (estado) (if (< (get-tot 1) (get-tot 0)) (max-list-chained 0 estado) (max-list-chained 1 estado))) 
  
  #'(lambda (estado) (suma-fila (estado-tablero estado) (estado-lado-sgte-jugador estado)))
  #'(lambda (estado) (suma-fila (estado-tablero estado) (lado-contrario (estado-lado-sgte-jugador estado))))

  #'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))

  #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) (list-lado estado (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  ;#'(lambda (estado) (length (remove-if-not #'(lambda (x) (not (= x 1))) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  #'(lambda (estado) (length (remove-if-not #'(lambda (x) (not (= x 1))) (list-lado estado (estado-lado-sgte-jugador estado)))))

  #'(lambda (estado) (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) (list-lado estado (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  #'(lambda (estado) (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  #'(lambda (estado) (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) (list-lado estado (estado-lado-sgte-jugador estado)))))
  ))
