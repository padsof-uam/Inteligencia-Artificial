(defconstant +bicond+ '<=>) 
(defconstant +cond+ '=>) 
(defconstant +and+ '^) 
(defconstant +or+ 'v) 
(defconstant +not+ '¬)

(defun truth-value-p (x)
	(or (eql x T) (eql x NIL)))

(defun unary-connector-p (x) 
	(eql x +not+))

(defun binary-connector-p (x) 
	(or (eql x +bicond+)
		(eql x +cond+)))

(defun n-ary-connector-p (x) 
	(or (eql x +and+)
		(eql x +or+)))

(defun connector-p (x)
	(or (unary-connector-p x) (binary-connector-p x)
		(n-ary-connector-p x)))

(setf Delta '((=> (^ P I) L) (=> (¬ P) (¬ L)) (v P) (L)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EJERCICIO: extrae-simbolos
;;
;; RECIBE : fórmula bien formada en cualquier formato (expr)
;; EVAlÚA A: Lista de símbolos atómicos (sin repeticiones)
;; utilizados en la fórmula bien formada. El orden en la lista no es
;; relevante.
;;
(defun flatten (structure)
	(cond ((null structure) nil)
		((atom structure) (list structure))
		(t (mapcan #'flatten structure))))

(defun extrae-simbolos (expr)
	(remove-duplicates (remove-if #'connector-p (flatten expr))))

(extrae-simbolos Delta)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EJERCICIO: genera-lista-interpretaciones
;;
;;
;; RECIBE   : Lista de N símbolos atómicos
;; EVALÚA A : Lista de 2^N posibles interpretaciones
;;             (lista de pares (<símbolo> <valor de verdad>))
;;
;;
;;
(defun genera-lista-interpretaciones (lst) 
	(genera-lista-interpretaciones-aux lst ()))

(defun genera-lista-interpretaciones-aux (symblist ints)
	(let ((true-int (cons (first symblist) T))
		(false-int (cons (first symblist) nil)))
	(genera-lista-interpretaciones-aux (rest symblist)
		(cons 
			(mapcan #'(lambda (int) (cons true-int int)) ints)
			(mapcan #'(lambda (int) (cons false-int int)) ints)))))

