(setf *heuristics* (list
  ;; Max-list chained es el número máximo de fichas que se pueden robar encadenadamente.
  ;     Distinguimos si vamos perdiendo en el acumulador o no y con el marcador individual.
  #'(lambda (estado) (if (> (get-pts 1) (get-pts 0)) (max-list-chained 0 estado) (max-list-chained 1 estado)))  
  #'(lambda (estado) (if (< (get-pts 1) (get-pts 0)) (max-list-chained 0 estado) (max-list-chained 1 estado)))  
  #'(lambda (estado) (if (> (get-tot 1) (get-tot 0)) (max-list-chained 0 estado) (max-list-chained 1 estado)))  
  #'(lambda (estado) (if (< (get-tot 1) (get-tot 0)) (max-list-chained 0 estado) (max-list-chained 1 estado))) 
  
  ;; El número de fichas de cada jugador.
  #'(lambda (estado) (suma-fila (estado-tablero estado) (estado-lado-sgte-jugador estado)))
  #'(lambda (estado) (suma-fila (estado-tablero estado) (lado-contrario (estado-lado-sgte-jugador estado))))

  ;; El número máximo de semillas en un hoyo de cada jugador
  #'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))

  ;; El número de hoyos con 0 semillas de cada jugador.
  #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) (list-lado estado (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  
  ;; El número de fichas sin 1 semilla. Jugando descubrimos que tener todos los hoyos con 1 ficha era una situación a evitar.
  #'(lambda (estado) (length (remove-if-not #'(lambda (x) (not (= x 1))) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  #'(lambda (estado) (length (remove-if-not #'(lambda (x) (not (= x 1))) (list-lado estado (estado-lado-sgte-jugador estado)))))

  ;; El número de hoyos en los que no nos pueden robar. 
  #'(lambda (estado) (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) (list-lado estado (estado-lado-sgte-jugador estado)))))
  #'(lambda (estado) (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  
  ;; El número de hoyos en los que si se puede robar.
  #'(lambda (estado) (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  #'(lambda (estado) (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) (list-lado estado (estado-lado-sgte-jugador estado)))))
  ))
