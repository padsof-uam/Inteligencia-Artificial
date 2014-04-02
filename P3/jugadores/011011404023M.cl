; 3MV1SL28IC
; Crazymonk

(defun mi-f-ev (estado)
  (apply '+
    (mapcar #'(lambda (w f) (* (funcall f estado) w))
      '(0.7880688 -0.668489 0.79436946 -0.78768563 0.065045595 0.2920618
        0.97934103 0.8868735 0.20814347)
      (list 
        #'(lambda (estado) (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
        #'(lambda (estado) (max-list (list-lado estado (estado-lado-sgte-jugador estado))))
        #'(lambda (estado) (-
            (suma-fila 
              (estado-tablero estado) 
              (estado-lado-sgte-jugador estado)) 
            (suma-fila 
              (estado-tablero estado) 
              (lado-contrario (estado-lado-sgte-jugador estado)))))
        #'(lambda (estado) (max-list (list-lado estado 
            (lado-contrario (estado-lado-sgte-jugador estado)))))
        #'(lambda (estado) (max-list (list-lado estado 
            (estado-lado-sgte-jugador estado))))
        #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
            (list-lado estado (estado-lado-sgte-jugador estado)))))
        #'(lambda (estado) (length (remove-if-not #'(lambda (x) (= x 0)) 
            (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
        #'(lambda (estado) (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) 
            (list-lado estado (estado-lado-sgte-jugador estado)))))
        #'(lambda (estado) (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4)))
            (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))  
        ))))

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


(defun chain-ate (milado tablero pos total cont)
  (if (> cont 7)
    total
    (let ((mis-fichas (get-fichas tablero milado pos)) 
     (sus-fichas (get-fichas tablero (mod (+ milado 1) 2) pos)))
    (if (or (= mis-fichas 0) (>= sus-fichas 4))
     (+ total sus-fichas)
     (chain-ate milado tablero (mod (+ pos sus-fichas) 8) (+ total sus-fichas) (+ cont 1))))))
