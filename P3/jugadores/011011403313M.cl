; 3MV1SL28IC
; Top60

(defun mi-f-ev (estado)
  (+ 
    ( * 0.7534673 max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))
    ( * 0.67191815  max-list (list-lado estado (estado-lado-sgte-jugador estado)))
    ( * 0.86767983  (- (suma-fila 
               (estado-tablero estado) 
               (estado-lado-sgte-jugador estado)) 
            (suma-fila 
               (estado-tablero estado) 
               (lado-contrario (estado-lado-sgte-jugador estado)))))
  
    ( * 0.0853672  (if (> (get-pts 1) (get-pts 0))
           (max-list-chained 0 estado)
           (max-list-chained 1 estado)))  

    ( * -0.20095587  (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
    ( * -0.7599144  (max-list (list-lado estado (estado-lado-sgte-jugador estado))))

    ( * 0.2564392  (length (remove-if-not #'(lambda (x) (= x 0)) 
      (list-lado estado (estado-lado-sgte-jugador estado)))))
    ( *  -0.93289447  (length (remove-if-not #'(lambda (x) (= x 0)) 
      (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
    ( * 0.45880747  
      ( - (length (remove-if-not #'(lambda (x) (not (= x 1)))
                (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
          (length (remove-if-not #'(lambda (x) (not (= x 1))) 
                (list-lado estado (estado-lado-sgte-jugador estado))))))
    ( * 0.9019537 (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) 
                              (list-lado estado (estado-lado-sgte-jugador estado)))))
    ( * -0.44900846 (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4)))
                              (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))

    ( * -0.81448364 (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
        (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
          (list-lado estado (estado-lado-sgte-jugador estado))))))

  ))

(defun max-list-chained (lado estado)
  (max-list (cdr (max-list-chained-aux lado estado 0))))

(defun max-list-chained-aux (milado estado cont)
  (if (> cont 7)
    0
    (let ((L2 (chain-ate milado (estado-tablero estado) cont 0 0))
         (L1 (max-list-chained-aux milado estado (+ cont 1))))
        (if (and (consp  L1) (consp  L2))
          (append L1 L2)
          (if (consp L1)
          (append L1 (list L2))
          (list L1 L2)
          )))))
