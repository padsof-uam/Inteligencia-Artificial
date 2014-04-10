; 3MV1SL28IC
; Top82

(defun mi-f-ev (estado)
  (+ 
  (* 0.46744132 ( - (suma-fila 
                           (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)) 
                        (suma-fila 
                           (estado-tablero estado) 
                           (lado-contrario (estado-lado-sgte-jugador estado)))))
  
  (*  0.054709673 (max-list-chained 0 estado))
  (*  -0.55915236 (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  (*  -0.62158394 (max-list (list-lado estado (estado-lado-sgte-jugador estado))))
  (*  0.36024094
    ( - (length (remove-if-not #'(lambda (x) (not (= x 1)))
              (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
        (length (remove-if-not #'(lambda (x) (not (= x 1))) 
              (list-lado estado (estado-lado-sgte-jugador estado))))))
   (* 0.008761644 (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) 
                             (list-lado estado (estado-lado-sgte-jugador estado)))))
   (* -0.29862142 (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4)))
                             (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  (* 0.07100725
    (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
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


(defun chain-ate (milado tablero pos total cont)
  (if (> cont 7)
    total
   (let ((mis-fichas (get-fichas tablero milado pos)) 
         (sus-fichas (get-fichas tablero (mod (+ milado 1) 2) pos)))
      (if (or (= mis-fichas 0) (>= sus-fichas 4))
         (+ total sus-fichas)
         (chain-ate milado tablero (mod (+ pos sus-fichas) 8) (+ total sus-fichas) (+ cont 1))))))

