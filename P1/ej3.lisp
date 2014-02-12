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

(defun symbol-p (x)
  (not (or (connector-p x) (truth-value-p x))))

(setf Delta '((=> (^ P I) L) (=> (¬ P) (¬ L)) (¬ P) (L)))

;;%% Code

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
	(remove-duplicates (remove-if-not #'symbol-p (flatten expr))))

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

;;%% Code

(defun genera-lista-interpretaciones (lst) 
	(combine-lst-of-lst (mapcar #'(lambda (x) (combine-elt-lst x '(T NIL))) lst)))

(defun implies (a b)
  (or (not a) (and a b)))

(defun bicond (a b)
  (and (implies a b) (implies b a)))

(defun myand (&rest r)
  (reduce #'(lambda (x y) (and x y)) r))

(defun myor (&rest r)
  (reduce #'(lambda (x y) (or x y)) r))
  
(defun evaluator (sym)
  (cond 
    ((eql sym +not+) #'not)
    ((eql sym +cond+) #'implies)
    ((eql sym +bicond+) #'bicond)
    ((eql sym +and+) #'myand)
    ((eql sym +or+) #'myor)
    ))

(defun getint (sym int)
  (car (cdar (remove-if 
          #'(lambda (x) (not (eql (car x) sym)))
          int))))

(defun eval-fbf (fbf int)
   	(if (atom fbf)
         (getint fbf int)
         (apply 
           (evaluator (first fbf)) 
           (mapcar #'(lambda (f) (eval-fbf f int)) (rest fbf)))))

(defmacro feval (lst int)
  (mapcar #'(lambda (x) 
             (cond
			    ((eql x +not+) 'not)
			    ((eql x +cond+) 'implies)
			    ((eql x +bicond+) 'bicond)
			    ((eql x +and+) 'and)
			    ((eql x +or+) 'or)
       			(t (getint x int)))) lst))
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EJERCICIO interpretacion-modelo-p
;;
;; RECIBE   : base de conocimiento (KB) e interpretación
;; EVALÚA A : T en caso de que la interpretación sea un modelo de KB
;;            NIL en caso contrario
;;

;;%% Code

(defun interpretacion-modelo-p (kb interpretacion) 
  (every #'identity (mapcar #'(lambda (fbf) (eval-fbf fbf interpretacion)) kb)))


(interpretacion-modelo-p  '((<=> A (¬ H)) (<=> P (^ A  H)) (<=> H P))
                         '((A NIL) (P NIL) (H T)))
;;; NIL
(interpretacion-modelo-p '((<=> A (¬ H)) (<=> P (^ A  H)) (<=> H P))
                         '((A T) (P NIL) (H NIL)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EJERCICIO: encuentra-modelos
;;
;; RECIBE   : base de conocimiento (KB)
;; EVALÚA A : lista de interpretaciones que son modelo para KB
;;
;;
;;%% Code

(defun encuentra-modelos (kb) 
  (remove-if-not 
    #'(lambda (int) (interpretacion-modelo-p kb int)) 
    (genera-lista-interpretaciones (extrae-simbolos kb))))

(encuentra-modelos '((=> A (¬ H)) (<=> P (^ A  H)) (=> H P)))
;;; (((A T) (P NIL) (H NIL)) ((A NIL) (P NIL) (H NIL)))
(encuentra-modelos '((=> (^ P I)  L)  (=> (¬ P) (¬ L)) (¬ P) L))
;;; NIL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EJERCICIO SAT-p
;;
;; RECIBE   : base de conocimiento (KB)
;; EVALÚA A : T si existe al menos un modelo para kb
;;            NIL en caso contrario
;;
;;

;;%% Code


(defun SAT-p (kb)
  (not (null (encuentra-modelos kb))))

(SAT-p '((<=> A (¬ H)) (<=> P (^ A H)) (<=> H P))) ;; T
(SAT-p '((=> (^ P I) L) (=> (¬ P) (¬ L)) (¬ P) L)) ;; NIL
