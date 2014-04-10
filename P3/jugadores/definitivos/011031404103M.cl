; 3MV1SL28IC
; Oxford-3


(defun mi-f-ev (estado)
  (let ((max-chain-0 (max-list-chained 0 estado)) (max-chain-1 (max-list-chained 1 estado))
      (otro (estado-lado-sgte-jugador estado)) (nos (lado-contrario (estado-lado-sgte-jugador estado))))
    (+
      (* 0.35975838 (if (> (get-pts 1) (get-pts 0)) max-chain-0 max-chain-1))
      (* 0.6688392 (if (< (get-pts 1) (get-pts 0)) max-chain-0 max-chain-1))
      (* -0.64992046 (if (> (get-tot 1) (get-tot 0)) max-chain-0 max-chain-1))
      (* 0.08864951 (if (< (get-tot 1) (get-tot 0)) max-chain-0 max-chain-1))
      
      (* -0.8055403 (max-list (list-lado estado nos)))
      (* 0.8972075 (max-list (list-lado estado otro)))
      
      (* 0.34596753 (suma-fila (estado-tablero estado) otro))
      (* -0.8629296 (suma-fila (estado-tablero estado) nos))
      
      (* -0.7156534 (max-list (list-lado estado nos)))
      (* -0.9596753 (max-list (list-lado estado otro)))
      
      (* -0.07756925 (length (remove-if-not #'(lambda (x) (= x 0)) (list-lado estado otro))))
      (* 0.6770072 (length (remove-if-not #'(lambda (x) (= x 0)) (list-lado estado nos))))
      
      (* -0.8708813 (length (remove-if-not #'(lambda (x) (not (= x 1))) (list-lado estado nos))))
      (* 0.90052795 (length (remove-if-not #'(lambda (x) (not (= x 1))) (list-lado estado otro))))
      
      (* 0.6714654 (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) (list-lado estado otro))))
      (* 0.2314179 (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) (list-lado estado nos))))

      (* 0.8192029 (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) (list-lado estado nos))))
      (* -0.8214476 (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) (list-lado estado otro))))
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
