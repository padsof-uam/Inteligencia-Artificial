(defun minimax-1 (estado profundidad devolver-movimiento profundidad-max f-eval)
  (cond ((>= profundidad profundidad-max)
         (unless devolver-movimiento  (funcall f-eval estado)))
        (t
         (let* ((sucesores (generar-sucesores estado))
               (mejor-valor -99999)
                (mejor-sucesor nil))
           (cond ((null sucesores)
                  (unless devolver-movimiento  (funcall f-eval estado)))
                 (t
                  (loop for sucesor in sucesores do
                    (let* ((resultado-sucesor (minimax-1 sucesor (1+ profundidad)
                                        nil profundidad-max f-eval))
                           (valor-nuevo (- resultado-sucesor)))
                      ;(format t "~% Mmx-1 Prof:~A valor-nuevo ~4A de sucesor  ~A" profundidad valor-nuevo (estado-tablero sucesor))
                      (when (> valor-nuevo mejor-valor)
                        (setq mejor-valor valor-nuevo)
                        (setq mejor-sucesor  sucesor ))))
                  (if  devolver-movimiento mejor-sucesor mejor-valor)))))))

(defun minimax (estado profundidad-max f-eval)
  (let* ((oldverb *verb*)  (*verb* nil)
         (estado2 (minimax-1 estado 0 t profundidad-max f-eval))
         (*verb* oldverb))
    estado2))


(defun f-j-mmx (estado profundidad-max f-eval)
   (minimax estado profundidad-max f-eval))


(setf *Simon* (make-jugador
                        :nombre   '|Simon|
                        :f-juego  #'f-j-mmx
                        :f-eval   #'mi-f-ev))

(defun mi-f-ev (estado)
  (+ 
    (* 0.19824123 ( - (suma-fila 
                        (estado-tablero estado) 
                        (estado-lado-sgte-jugador estado)) 
                      (suma-fila 
                        (estado-tablero estado) 
                        (lado-contrario (estado-lado-sgte-jugador estado)))))
    (*  -0.74062204 (max-list-chained 0 estado))
    (*  0.4447801 (max-list-chained 1 estado))  
    (* 0.16666222 (max-list (list-lado estado 
         (lado-contrario (estado-lado-sgte-jugador estado)))))
    (* 0.925256 (max-list (list-lado estado (estado-lado-sgte-jugador estado))))
    (* -0.89839506 (length (remove-if-not #'(lambda (x) (= x 0)) 
          (list-lado estado (estado-lado-sgte-jugador estado)))))
    (* -0.6152954 (length (remove-if-not #'(lambda (x) (= x 0)) 
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
    (* -0.030327797
      ( - (length (remove-if-not #'(lambda (x) (not (= x 1)))
                (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
          (length (remove-if-not #'(lambda (x) (not (= x 1))) 
                (list-lado estado (estado-lado-sgte-jugador estado))))))
    (* 0.5465987 (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) 
          (list-lado estado (estado-lado-sgte-jugador estado)))))
    (* 0.15208268  (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4)))
          (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
    (* -0.040797234 (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
          (list-lado estado (estado-lado-sgte-jugador estado)))))
    (* 0.6847365
      (-  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4)))
            (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
          (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) 
            (list-lado estado (estado-lado-sgte-jugador estado))))))
  ))
