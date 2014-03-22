(defun range(n m)
	(if (< m n)
		(reverse (range m n))
		(loop for i from n to m
			collect i)))

(range 1 3)
(range 0 10)
(range 10 10)
(range 10 0)

(defun range-step (n m step)
	(let ((range-len (/ (- m n) step)))
		(mapcar #'(lambda (x) (+ n (* step x))) (range 0 range-len))))

(range-step 0 4 0.5)
(range-step 0 10 2)
(range-step 1 0 0.1)

; Variables para la función de generación
(setf *w* 40)
(setf *r* 0.04)
(setf *p* 2)
(setf *d* 2)

(defun generate-temp-steps (step-num)
	(append
		(mapcar #'(lambda (x) (/ *w* (+ (expt (* x *r*) *p*) *d*))) (range-step 0 199 (/ 200 step-num)))
		'(0)))

(generate-temp-steps 500)

(defun simulated-annealing-aux (remaining-temp state state-val f-state-generate-from f-state-value f-prob-for-change value-threshold best)
	(let ((best (if (<=  state-val (cadr best))
					(list state state-val)
					best)))
		(if (or (null remaining-temp) (<= state-val value-threshold))
			best
			(let ((next (funcall f-state-generate-from state)))
				(let ((next-val (funcall f-state-value next)))
					(if (> 
							(funcall f-prob-for-change state-val next-val (first remaining-temp))
							(random 1.0))
						(simulated-annealing-aux (rest remaining-temp) (print next) (print next-val) 
							f-state-generate-from f-state-value f-prob-for-change value-threshold best)
						(simulated-annealing-aux (rest remaining-temp) (print state) (print state-val) 
							f-state-generate-from f-state-value f-prob-for-change value-threshold best)))))))

;; Magnífica función de simulated annealing.
;; Recibe
;; 	initial-state: Estado incial
;; 	f-mierdas: funciones de generación de estados, cálculo del valor de un estado y la de probabilidad de salto.
;;	value-threshold: Si llegamos a este valor o inferior, paramos.
;;  steps: Cuantos "pasos" de temperatura hacemos. Lo pongo entre comillas porque si le pones p.ej. 100 hace bastantes más. 
(defun simulated-annealing (initial-state f-state-generate-from f-state-value f-prob-for-change value-threshold steps)
	(simulated-annealing-aux 
		(generate-temp-steps steps)
		initial-state
		(funcall f-state-value initial-state)
		f-state-generate-from f-state-value f-prob-for-change value-threshold
		(list initial-state '100)))

(defun parab-gen-from (state)
	(mapcar #'(lambda (x) (- (+ x (random 2.0)) (random 2.0))) state))

(defun siman-prob (state next temp)
	(if (< next state)
		1
		(if (> temp 0)
			(exp (/ (- state next) temp))
			0)))


(parab-gen-from '(3 1))

(defun parab-value (state)
	(apply '+ (mapcar #'(lambda (x) (* x x)) state)))

(parab-value '(3 1))

(simulated-annealing '(3 5) 'parab-gen-from 'parab-value 'siman-prob 0.001 10)
