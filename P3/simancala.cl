(load "mancala7_mod.cl")
(load "siman.cl")

; Generación de un nuevo estado a partir de otro.
(defun mancala-gen-from (state)
	(mapcar #'(lambda (x) (- (+ x (random 2.0)) (random 2.0))) state))

(defstruct mc-evaluator
	starter
	depth
	enemy)

; Una función auxiliar
(defun flatten (structure)
	(cond ((null structure) nil)
		((atom structure) (list structure))
		(t (mapcan #'flatten structure))))

; Generamos todos los evaluadores necesarios para la lista de jugadores y 
; 	profundidad dadas. Más que nada por ser vago y no escribir
(defun generate-evaluators (players max-depth)
	(let ((player-num (length players)))
		(mapcar #'(lambda (starter depth enemy)
			(make-mc-evaluator 
				:starter starter
				:depth depth
				:enemy enemy))
		(append (make-list (* player-num max-depth) :initial-element 0)
				(make-list (* player-num max-depth) :initial-element 1))
		(flatten (make-list (* 2 player-num) :initial-element (range 1 max-depth)))
		(flatten (make-list 2 :initial-element (mapcar #'(lambda (x) (make-list max-depth :initial-element x)) players))))))

(setf *evaluators* 
	(generate-evaluators (list *jdr-mmx-Regular-SA*) 2))

; Dar valor a un estado: ejecutamos la partida con cada uno de los jugadores,
;	que reciben el estado como vector de pesos.
(defun mancala-value (state)
	(apply '+ (mapcar #'(lambda (x) (SA-partida 
							(mc-evaluator-starter x)
							(mc-evaluator-depth x)
							(list *jdr-Avara-SA* (mc-evaluator-enemy x))
							state))
				*evaluators*)))

(mancala-value '(1 0.3 0.1))

; Ejecutamos el algoritmo con un estado inicial y un valor mínimo que sea ganar todas las partidas que jugamos.
(simulated-annealing '(0.3 0.3 0.3) 'mancala-gen-from 'mancala-value 'siman-prob (- 0 (length *evaluators*)) 100)
