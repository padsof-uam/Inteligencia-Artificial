;;;;
;; Comprueba que si planeta pasado como argumento es una meta.
;;
;; IN: 	state: planeta actual
;; 		planets-destination: lista de planetas de destino
;; OUT: T si el planeta actual es una meta.
;; 
;; pseudocode
;; comprobar si state está en planets-destination
(defun f-goal-test-galaxy (state planets-destination) 
  (not (null (member state planets-destination))))

(f-goal-test-galaxy 'Sirtis *planets-destination*) ;-> T 
(f-goal-test-galaxy 'Avalon *planets-destination*) ;-> NIL 
(f-goal-test-galaxy 'Urano *planets-destination*) ;-> NIL

;;;;
;; Devuelve el valor de la heurística en el planeta actual.
;; 
;; IN: 	state: planeta actual
;; 		sensors: lista de tuplas planeta-heurística
;; OUT: valor de la heurística en el planeta actual
(defun f-h-galaxy (state sensors)
  (if (null sensors)
      nil
	  (let (sensor (first sensors))
	    (if (eql state (car sensor))
	        (cdr sensor)
	        (f-h-galaxy state (rest sensors))))))

(f-h-galaxy 'Sirtis *sensors*) ;-> 0
(f-h-galaxy 'Avalon *sensors*) ;-> 5


(defun navigate-worm-hole (state worm-holes) 
  ) 

(defun navigate-white-hole (state white-holes) )
