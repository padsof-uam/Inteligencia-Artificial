(defun range(n m)
	(if (< m n)
		(reverse (range m n))
		(loop for i from n to m
			collect i)))

;(range 1 3)
;(range 0 10)
;(range 10 10)
;(range 10 0)

(defun range-step (n m step)
	(let ((range-len (/ (- m n) step)))
		(mapcar #'(lambda (x) (+ n (* step x))) (range 0 range-len))))

;(range-step 0 4 0.5)
;(range-step 0 10 2)
;(range-step 1 0 0.1)

; Variables para la función de generación
(setf *w* 40)
(setf *r* 0.04)
(setf *p* 2)
(setf *d* 2)

(defun generate-temp-steps (step-num)
	(append
		(mapcar #'(lambda (x) (/ *w* (+ (expt (* x *r*) *p*) *d*))) (range-step 0 199 (/ 200 step-num)))
		'(0)))

; (generate-temp-steps 500)

(defstruct sa-data
	f-state-generate-from
	f-state-value 
	f-prob-for-change 
	value-threshold
	change-threshold)

(defun simulated-annealing-aux (data remaining-temp state state-val best change-history )
	(print state-val)
	(let ((best (if (<=  state-val (cadr best))
					(list state state-val)
					best)))
		(if (or (null remaining-temp) 
				(<= state-val (sa-data-value-threshold data)) 
				(<= (apply '+ change-history) (sa-data-change-threshold data)))
			best
			(let ((next (funcall (sa-data-f-state-generate-from data) state)))
				(let ((next-val (funcall (sa-data-f-state-value data) next)))
					(if (> 
							(funcall (sa-data-f-prob-for-change data) state-val next-val (first remaining-temp))
							(random 1.0))
						(simulated-annealing-aux data (rest remaining-temp) next next-val best 
							(append (rest change-history) (list (abs (- next-val state-val)))))
						(simulated-annealing-aux data (rest remaining-temp) state state-val best 
							(append (rest change-history) (list 0)))))))))

;; Magnífica función de simulated annealing.
;; Recibe
;; 	initial-state: Estado incial
;; 	f-mierdas: funciones de generación de estados, cálculo del valor de un estado y la de probabilidad de salto.
;;	value-threshold: Si llegamos a este valor o inferior, paramos.
;;  steps: Cuantos "pasos" de temperatura hacemos. Lo pongo entre comillas porque si le pones p.ej. 100 hace bastantes más. 
(defun simulated-annealing (initial-state f-state-generate-from f-state-value 
	f-prob-for-change value-threshold steps change-threshold history-items)
	(let ((data (make-sa-data
					:f-state-generate-from 	f-state-generate-from
					:f-state-value  		f-state-value 
					:f-prob-for-change  	f-prob-for-change 
					:value-threshold 		value-threshold
					:change-threshold 		change-threshold
					)))
		(simulated-annealing-aux 
			data
			(generate-temp-steps steps)
			initial-state
			(funcall f-state-value initial-state)
			(list initial-state '100)
			(make-list history-items :initial-element 99))))

(defun parab-gen-from (state)
	(mapcar #'(lambda (x) (- (+ x (random 2.0)) (random 2.0))) state))

(defun siman-prob (state next temp)
	(if (< next state)
		1
		(if (> temp 0)
			(exp (/ (- state next) temp))
			0)))


; (parab-gen-from '(3 1))

(defun parab-value (state)
	(apply '+ (mapcar #'(lambda (x) (* x x)) state)))

; (parab-value '(3 1))

; (simulated-annealing 
; 	'(3 5) 
; 	'parab-gen-from 
; 	'parab-value 
; 	'siman-prob 
; 	0.00001
; 	2000 
; 	20
; 	10)
