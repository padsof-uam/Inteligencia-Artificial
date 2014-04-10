; 3MV1SL28IC
; SimonDice1


(defun mi-f-ev (estado)
  (let ((max-chain-0 (max-list-chained 0 estado)) (max-chain-1 (max-list-chained 1 estado))
      (otro (estado-lado-sgte-jugador estado)) (nos (lado-contrario (estado-lado-sgte-jugador estado))))
    (+
      (* -0.5188751 (if (> (get-pts 1) (get-pts 0)) max-chain-0 max-chain-1))
      (* 0.29566216 (if (< (get-pts 1) (get-pts 0)) max-chain-0 max-chain-1))
      (* -0.3912425 (if (> (get-tot 1) (get-tot 0)) max-chain-0 max-chain-1))

      (* 0.58438087 (suma-fila (estado-tablero estado) otro))
      (* -0.718034 (suma-fila (estado-tablero estado) nos))

      (* -0.6776824 (max-list (list-lado estado nos)))
      (* 0.16488528 (max-list (list-lado estado otro)))

      (* -0.51216626 (length (remove-if-not #'(lambda (x) (= x 0)) (list-lado estado otro))))
      (* 0.80660224 (length (remove-if-not #'(lambda (x) (= x 0)) (list-lado estado nos))))
      (* -0.044154882 (length (remove-if-not #'(lambda (x) (not (= x 1))) (list-lado estado otro))))

      (* 0.88342667 (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) (list-lado estado otro))))
      (* -0.5262935 (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) (list-lado estado nos))))
      (* 0.21590137 (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) (list-lado estado nos))))
      (* -0.83475757 (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) (list-lado estado otro))))
  )))

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
