(load "Practica3.cl")
(load "Practica3-SA.cl")
(load "siman.cl")

(setf *random-state* (make-random-state T))

(defun rand-between (a b)
	(let ((interval (- b a)))
		(- (random interval) (/ interval 2))))

(rand-between -1.0 1.0)

(defun mod-bound (value abs-limit)
	(- (mod (+ abs-limit value) (* 2 abs-limit)) abs-limit))

(mod-bound 1.3 1)


; Una función auxiliar
(defun flatten (structure)
	(cond ((null structure) nil)
		((atom structure) (list structure))
		(t (mapcan #'flatten structure))))

(defun repeat-l (ls times)
	(flatten (make-list times :initial-element ls)))

(repeat-l '(0 1 2 3) 3)

; Generación de un nuevo estado a partir de otro.
(defun mancala-gen-from (state)
	(mapcar #'(lambda (x) (mod-bound (+ x (rand-between -1.0 1.0)) 1)) state))

(mancala-gen-from '(1.0 0.1 0.4))

(defstruct mc-evaluator
	starter
	depth
	enemy)

; Generamos todos los evaluadores necesarios para la lista de jugadores y 
; 	profundidad dadas. Más que nada por ser vago y no escribir
(defun generate-evaluators (players max-depth reps)
	(let ((player-num (length players)))
		(repeat-l (mapcar #'(lambda (starter depth enemy)
			(make-mc-evaluator 
				:starter starter
				:depth depth
				:enemy enemy))
		(append (make-list (* player-num max-depth) :initial-element 0)
			(make-list (* player-num max-depth) :initial-element 1))
		(repeat-l (range 1 max-depth) (* 2 player-num))
		(repeat-l (mapcar #'(lambda (x) (make-list max-depth :initial-element x)) players) 2))
		reps)))

(setf *evaluators* 
	(remove-if-not #'(lambda (ev) (= (mc-evaluator-depth ev) 2))
		(generate-evaluators (list *jdr-mmx-Regular-SA* *jdr-mmx-Bueno-SA* *Top50* *Top60*) 2 1)))

; Dar valor a un estado: ejecutamos la partida con cada uno de los jugadores,
;	que reciben el estado como vector de pesos.
(defun mancala-value (state)
	(/ (apply '+ (mapcar #'(lambda (x) (SA-partida 
			(mc-evaluator-starter x)
			(mc-evaluator-depth x)
			(list *jdr-pruebas* (mc-evaluator-enemy x))
			state))
		*evaluators*))
	(length *evaluators*)))

;(mancala-value (make-list (length *heuristics*) :initial-element 0.1))


; Ejecutamos el algoritmo con un estado inicial y un valor mínimo que sea ganar todas las partidas que jugamos.
(defun simancala (steps)
	(let ((hnum (length *heuristics*)))
		(print (simulated-annealing 
			(make-list hnum :initial-element (/ 1 hnum))
			'mancala-gen-from 
			'mancala-value 
			'siman-prob 
			(- 0 (length *evaluators*)) 
			steps
			0.2
			20))))

(setf result (simancala 1000))
(setf wths (first result))
(format T "~&>>>RBG ~%")
(format T "Average: ~a ~%" (second result))
(format T "Results: ~%")
(format T "Enemy ~1,10T ~2,10TDepth ~3,10TStarts ~4,10TResult ~5,10T ~%")
(mapcar #'(lambda (x)
	(format T "~a ~1,10T ~a ~2,10T ~a ~3,10T ~a ~4,10T ~%"
		(jugador-nombre (mc-evaluator-enemy x))
		(mc-evaluator-depth x)
		(= (mc-evaluator-starter x) 0)
		(SA-partida 
			(mc-evaluator-starter x)
			(mc-evaluator-depth x)
			(list *jdr-pruebas* (mc-evaluator-enemy x))
			wths)))
		*evaluators*)
(format T "Weights: ~a" wths)
;(print 'end)
