; 3MV1SL28IC
; SimonDice

(defun mi-f-ev (estado)
  (+
  (* -0.8994589 (if (> (get-pts 1) (get-pts 0)) (max-list-chained 0 estado) (max-list-chained 1 estado)))  
  (* 0.4557817 (if (> (get-tot 1) (get-tot 0)) (max-list-chained 0 estado) (max-list-chained 1 estado)))    
  (* -0.6944761 (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  (* -0.3170042 (max-list (list-lado estado (estado-lado-sgte-jugador estado))))
  (* 0.9912045 (suma-fila (estado-tablero estado) (estado-lado-sgte-jugador estado)))
  (* -0.5252774 (suma-fila (estado-tablero estado) (lado-contrario (estado-lado-sgte-jugador estado))))
  (* -0.31688595 (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  (* 0.46690035 (length (remove-if-not #'(lambda (x) (= x 0)) (list-lado estado (estado-lado-sgte-jugador estado)))))
  (* 0.18874097 (length (remove-if-not #'(lambda (x) (= x 0)) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  (* -0.65226316 (length (remove-if-not #'(lambda (x) (not (= x 1))) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  (* -0.72952914 (length (remove-if-not #'(lambda (x) (not (= x 1))) (list-lado estado (estado-lado-sgte-jugador estado)))))
  (* 0.36823273 (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  (* 0.4678042 (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  (* -0.33338356 (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))  (list-lado estado (estado-lado-sgte-jugador estado)))))
  (* 0.45209908 (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  (* -0.84877205 (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) (list-lado estado (estado-lado-sgte-jugador estado)))))
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
