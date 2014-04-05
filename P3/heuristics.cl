(setf *heuristics* (list
#'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))))