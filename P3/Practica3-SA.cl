(load "Practica3.cl")
(load "heuristics.cl")

;;;; Definición de funciones necesarias para la evaluación de un estado según nuestras heurísticas poderadas con argumento.

(defun minimax-1-SA(estado profundidad devolver-movimiento profundidad-max f-eval valores)
  (cond ((>= profundidad profundidad-max)
         (unless devolver-movimiento  (funcall f-eval estado valores)))
        (t
         (let* ((sucesores (generar-sucesores estado))
               (mejor-valor -99999)
                (mejor-sucesor nil))
           (cond ((null sucesores)
                  (unless devolver-movimiento  (funcall f-eval estado valores)))
                 (t
                  (loop for sucesor in sucesores do
                    (let* ((resultado-sucesor (minimax-1-SA sucesor (1+ profundidad)
                                        nil profundidad-max f-eval valores))
                           (valor-nuevo (- resultado-sucesor)))
                      ;(format t "~% Mmx-1 Prof:~A valor-nuevo ~4A de sucesor  ~A" profundidad valor-nuevo (estado-tablero sucesor))
                      (when (> valor-nuevo mejor-valor)
                        (setq mejor-valor valor-nuevo)
                        (setq mejor-sucesor  sucesor ))))
                  (if  devolver-movimiento mejor-sucesor mejor-valor)))))))


(defun minimax-SA (estado profundidad-max f-eval valores )
  (let* ((oldverb *verb*)  (*verb* nil)
         (estado2 (minimax-1-SA estado 0 t profundidad-max f-eval valores))
         (*verb* oldverb))
    estado2))

(defun SA-local-loop (estado lado-01 profundidad-max lst-jug valores)
  "bucle de movimientos alternos hasta conclusion de la partida"
  (when *verb* (format t "~%Local game ~A-~A depth=~A " (jugador-nombre (first lst-jug)) (jugador-nombre (second lst-jug)) profundidad-max))
  (loop
    (act-marcador (estado-tablero estado) :return-pts T)
    (when (and *verb* (estado-accion estado))
      (format t "~%[J ~A] ~A juega ~A "
        *njugada* (jugador-nombre (nth (mod (+ 1 lado-01) 2) lst-jug)) (estado-accion estado)))
    (let ((curr-plyr (nth lado-01 lst-jug)))
        (cond
         ((or (juego-terminado-p)                              ; si juego terminado o tablas
              (tablas-p (* 2 *long-fila*) (get-pts 0) (get-pts 1)))
          (when *verjugada* (muestra-tablero estado T))
          (return (informa-final-de-juego estado lst-jug)))
         (T                                                    ; llamada al jugador que tiene el turno
          (cond
           ((estado-debe-pasar-turno estado)                   ; TBD No registra accion!
            (setf estado (cambia-lado-sgte-jugador (copia-estado estado) nil)))
           (T
            (if *verjugada*
                (progn
                  (muestra-tablero estado)
                  (format t "~%[J ~A] El turno es de ~A~%" *njugada* (jugador-nombre curr-plyr)))
              (if *vermarcador*
                  (format t "~%~3d ~a-~a" *njugada* (get-pts 0) (get-pts 1))
                (when (= (mod *njugada* 10) 0)
                  (to-logfile (format nil " ~d" *njugada*) 4 T))))
            (setf estado
              (funcall (jugador-f-juego curr-plyr)
                                        estado
                                        profundidad-max
                                        (jugador-f-eval curr-plyr)
                                        valores))))
          (when (null estado)                                  ; => abandono, error o return nil|-infinito
            (return (values (winner (nth lado-01 lst-jug) lst-jug) "Error en func. o abandono")))
          (when (eql estado 'timeout)                          ; timeout de jugada
            (return (values (winner (nth lado-01 lst-jug) lst-jug) "Timeout jugada")))
          (setf lado-01 (mod (1+ lado-01) 2))                  ; inversion: pasa al otro jugador / convierte 1-2 0-1
          )))))

(defun SA-partida (lado profundidad-max lst-jug valores &optional filas)
  (let* ((lado-01 (mod lado 2))
         (estado (crea-estado-inicial lado-01 filas))
         (boast (/= (jugador-port (second lst-jug)) 0))
         (chall (/= (jugador-port (first lst-jug)) 0)) )
    (reset-contadores (* 2 *long-fila*))
    (if (or *tournament* (and (< *debug-level* 2) (not boast) (not chall)))
        (setq *verjugada* nil *vermarcador* nil)
      (if *verjugada* (format t "~%  Juego: (1) ~a vs ~a (2) "
                        (jugador-nombre (first lst-jug)) (jugador-nombre (second lst-jug)))))

    (cond
     ((and chall boast)
      (@stop "Ambos jugadores son remotos. Uno de ellos debe ser local"))

     (chall                                                       ; Challenger Role
      (setf (jugador-host *boaster-remoto*) *bhost*)              ; recarga por si ha cambiado
      (chall-p2p-loop estado lado-01 profundidad-max lst-jug))    ; TBD take role out

     (boast                                                       ; Boaster Role
      (let ((bname (fullname (jugador-nombre (first lst-jug)))))
        (format t "~%Boaster ~A registers in majordomo, port ~A " bname *mport*)
        (setf (get '*bname* :plyr) bname)
        (subscr-bst bname "new")
        ))
     (t (SA-local-loop estado lado-01 profundidad-max lst-jug valores)))))



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

; El máximo que robo desde la posición en la que estoy.
(defun chain-ate (milado tablero pos total cont)
  (if (> cont 7)
    total
   (let ((mis-fichas (get-fichas tablero milado pos)) 
         (sus-fichas (get-fichas tablero (mod (+ milado 1) 2) pos)))
      (if (or (= mis-fichas 0) (>= sus-fichas 4))
         (+ total sus-fichas)
         (chain-ate milado tablero (mod (+ pos sus-fichas) 8) (+ total sus-fichas) (+ cont 1))))))


;;;;;;;;;;;;;;;;====== FUNCIONES DE EVALUACIÓN ======;;;;;;;;;;;;;;;;;;;;;

(defun f-eval-pruebas-SA (estado weights)
   (reduce #'+ 
      (mapcar
         '*
         (mapcar #'(lambda (x) (funcall x estado)) *heuristics*)
         weights)))

(defun f-j-mmx-SA (estado profundidad-max f-eval weights)
   (minimax-SA estado profundidad-max f-eval weights))

(defun f-eval-pruebas (estado)
   (+
      (- 
            (suma-fila 
               (estado-tablero estado) 
               (estado-lado-sgte-jugador estado))
            (suma-fila 
               (estado-tablero estado) 
               (lado-contrario (estado-lado-sgte-jugador estado))))
      ; Evitamos tener muchas fichas en un mismo hoyo.
      (* 0.3 (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))))



;;; Jugador Bueno (pero tramposo: juega con un nivel mas de evaluacion)
;;; ------------------------------------------------------------------------------------------
(defun f-eval-Bueno-SA (estado weights)
  (if (juego-terminado-p estado)
      -50                              ;; Condicion especial de juego terminado
    ;; Devuelve el maximo del numero de fichas del lado enemigo menos el numero de propias
    (max-list (mapcar #'(lambda(x)
                          (- (suma-fila (estado-tablero x) (lado-contrario (estado-lado-sgte-jugador x)))
                                    (suma-fila (estado-tablero x) (estado-lado-sgte-jugador x))))
                (generar-sucesores estado)))))



(defun f-eval-Regular-SA (estado weights)
  (- (suma-fila (estado-tablero estado) (estado-lado-sgte-jugador estado))
    (suma-fila (estado-tablero estado) (lado-contrario (estado-lado-sgte-jugador estado)))))


(defun mi-f-eval (estado whgs )
  (+ 
    ( * 0.7534673 (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
    ( * 0.67191815  (max-list (list-lado estado (estado-lado-sgte-jugador estado))))
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


(defun oxford-eval (estado w)
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



(defun f-ox-eval (estado w)
  (+
  (* 0.6369469  (if (> (get-pts 1) (get-pts 0)) (max-list-chained 0 estado) (max-list-chained 1 estado)))  
  (* -0.6356125  (if (> (get-tot 1) (get-tot 0)) (max-list-chained 0 estado) (max-list-chained 1 estado)))  
  (* -0.6221688  (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  (* 0.18836808  (max-list (list-lado estado (estado-lado-sgte-jugador estado))))
  (* 0.53891873  (suma-fila (estado-tablero estado) (estado-lado-sgte-jugador estado)))
  (* -0.8880861  (suma-fila (estado-tablero estado) (lado-contrario (estado-lado-sgte-jugador estado))))
  (* 0.28905392  (max-list (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado)))))
  (* -0.73657346  (length (remove-if-not #'(lambda (x) (= x 0)) (list-lado estado (estado-lado-sgte-jugador estado)))))
  (* -0.815063  (length (remove-if-not #'(lambda (x) (= x 0)) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  (* -0.57688975  (length (remove-if-not #'(lambda (x) (not (= x 1))) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  (* -0.1341896  (length (remove-if-not #'(lambda (x) (not (= x 1))) (list-lado estado (estado-lado-sgte-jugador estado)))))
  (* 0.9039304  (length (remove-if #'(lambda (x) (or (= x 0) (>= x 4))) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  (* 0.8639517 (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) (list-lado estado (lado-contrario (estado-lado-sgte-jugador estado))))))
  (* 0.29104614  (length (remove-if #'(lambda (x) (and (>= x 1) (< x 4))) (list-lado estado (estado-lado-sgte-jugador estado)))))
  ))


(defun f-80-eval (estado weights)
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


;;;;;;;;;;;;;;;;====== JUGADORES ======;;;;;;;;;;;;;;;;;;;;;


(setf *jdr-pruebas* (make-jugador
                        :nombre   '|Jugador de pruebas|
                        :f-juego  #'f-j-mmx-SA
                        :f-eval   #'f-eval-pruebas-SA))


(setf *Simon* (make-jugador
                        :nombre   '|Simon|
                        :f-juego  #'f-j-mmx-SA
                        :f-eval   #'f-eval-pruebas))

(setf *Simon-ab* (make-jugador
                        :nombre   '|Simon|
                        :f-juego  #'f-j-mmx-ab
                        :f-eval   #'f-eval-pruebas))
(setf *Top60* (make-jugador
                        :nombre   '|Ju-Mmx-Top60-SA|
                        :f-juego  #'f-j-mmx-SA
                        :f-eval   #'oxford-eval))


(setf *Top50* (make-jugador
                        :nombre   '|Ju-Mmx-Top50-SA|
                        :f-juego  #'f-j-mmx-SA
                        :f-eval   #'f-ox-eval))


(setf *Top80* (make-jugador
                        :nombre   '|Ju-Mmx-Top80-SA|
                        :f-juego  #'f-j-mmx-SA
                        :f-eval   #'f-80-eval))



(setf *jdr-mmx-Bueno-SA* (make-jugador
                        :nombre   '|Ju-Mmx-Bueno-SA|
                        :f-juego  #'f-j-mmx-SA
                        :f-eval   #'f-eval-Bueno-SA))

(setf *jdr-mmx-Regular-SA* (make-jugador
                        :nombre   '|Ju-Mmx-Regular-SA|
                        :f-juego  #'f-j-mmx-SA
                        :f-eval   #'f-eval-Regular-SA))


;;; ------------------------------------------------------------------------------------------
;;;   FUNCIONES AUXILIARES PARA PROBAR JUGADORES
;;; ------------------------------------------------------------------------------------------

(defun partida-SA-all-games (weights)
  (list
   (SA-partida 0 1 (list *jdr-pruebas* *jdr-mmx-Regular-SA*) weights)
   (SA-partida 1 1 (list *jdr-pruebas* *jdr-mmx-Regular-SA*) weights)
   (SA-partida 0 2 (list *jdr-pruebas* *jdr-mmx-Regular-SA*) weights)
   (SA-partida 1 2 (list *jdr-pruebas* *jdr-mmx-Regular-SA*) weights)
   (SA-partida 0 1 (list *jdr-pruebas* *jdr-mmx-bueno-SA*) weights)
   (SA-partida 1 1 (list *jdr-pruebas* *jdr-mmx-bueno-SA*) weights)
   (SA-partida 0 2 (list *jdr-pruebas* *jdr-mmx-bueno-SA*) weights)
   (SA-partida 1 2 (list *jdr-pruebas* *jdr-mmx-bueno-SA*) weights)))

(defun partida-all-games-50 ()
  (list
   (partida 0 1 (list *Top50* *jdr-mmx-Regular*))
   (partida 1 1 (list *Top50* *jdr-mmx-Regular*))
   (partida 0 2 (list *Top50* *jdr-mmx-Regular*))
   (partida 1 2 (list *Top50* *jdr-mmx-Regular*))
   (partida 0 1 (list *Top50* *Top60*))
   (partida 1 1 (list *Top50* *Top60*))
   (partida 0 2 (list *Top50* *Top60*))
   (partida 1 2 (list *Top50* *Top60*))
   (partida 0 1 (list *Top50* *jdr-mmx-bueno*))
   (partida 1 1 (list *Top50* *jdr-mmx-bueno*))
   (partida 0 2 (list *Top50* *jdr-mmx-bueno*))
   (partida 1 2 (list *Top50* *jdr-mmx-bueno*))))

(defun partida-all-games-60 ()
  (list
   (partida 0 1 (list *Top60* *jdr-mmx-Regular*))
   (partida 1 1 (list *Top60* *jdr-mmx-Regular*))
   (partida 0 2 (list *Top60* *jdr-mmx-Regular*))
   (partida 1 2 (list *Top60* *jdr-mmx-Regular*))
   (partida 0 1 (list *Top60* *Top50*))
   (partida 1 1 (list *Top60* *Top50*))
   (partida 0 2 (list *Top60* *Top50*))
   (partida 1 2 (list *Top60* *Top50*))
   (partida 0 1 (list *Top60* *jdr-mmx-bueno*))
   (partida 1 1 (list *Top60* *jdr-mmx-bueno*))
   (partida 0 2 (list *Top60* *jdr-mmx-bueno*))
   (partida 1 2 (list *Top60* *jdr-mmx-bueno*))))

(defun partida-SA-all-games-player (player weights)
  (list
   (SA-partida 0 1 (list player *jdr-mmx-Regular-SA*) weights)
   (SA-partida 1 1 (list player *jdr-mmx-Regular-SA*) weights)
   (SA-partida 0 2 (list player *jdr-mmx-Regular-SA*) weights)
   (SA-partida 1 2 (list player *jdr-mmx-Regular-SA*) weights)
   (SA-partida 0 1 (list player *Top60*) weights)
   (SA-partida 1 1 (list player *Top60*) weights)
   (SA-partida 0 2 (list player *Top60*) weights)
   (SA-partida 1 2 (list player *Top60*) weights)
   (SA-partida 0 1 (list player *jdr-mmx-bueno-SA*) weights)
   (SA-partida 1 1 (list player *jdr-mmx-bueno-SA*) weights)
   (SA-partida 0 2 (list player *jdr-mmx-bueno-SA*) weights)
   (SA-partida 1 2 (list player *jdr-mmx-bueno-SA*) weights)))
