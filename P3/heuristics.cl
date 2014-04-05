(setf *heuristics* (list
#'(lambda (estado) (suma-fila 
       (estado-tablero estado) 
       (estado-lado-sgte-jugador estado)))))