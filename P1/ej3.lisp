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

;; Aplana una lista, eliminando funciones anidadas.
(defun flatten (structure)
	(cond ((null structure) nil)
		((atom structure) (list structure))
		(t (mapcan #'flatten structure))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EJERCICIO: extrae-simbolos
;;
;; RECIBE : fórmula bien formada en cualquier formato (expr)
;; EVAlÚA A: Lista de símbolos atómicos (sin repeticiones)
;; utilizados en la fórmula bien formada. El orden en la lista no es
;; relevante.

(defun extrae-simbolos (expr)
	(remove-duplicates (remove-if-not #'symbol-p (flatten expr))))

(extrae-simbolos '((=> (^ P I) L) (=> (¬ P) (¬ L)) (¬ P) (L)))
(extrae-simbolos '((<=> (¬ (P ^ L)) (v (¬ (=> K P)) K P))))

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

(genera-lista-interpretaciones '(P I L))
(genera-lista-interpretaciones '(A))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auxiliares: implementación de operadores

(defun implies (a b)
  (or (not a) (and a b)))

(defun bicond (a b)
  (and (implies a b) (implies b a)))

(defun myand (&rest r)
  (reduce #'(lambda (x y) (and x y)) r))

(defun myor (&rest r)
  (reduce #'(lambda (x y) (or x y)) r))
  
;; Devuelve la función evaluadora correspondiente para el símbolo.
(defun evaluator (sym)
  (cond 
    ((eql sym +not+) #'not)
    ((eql sym +cond+) #'implies)
    ((eql sym +bicond+) #'bicond)
    ((eql sym +and+) #'myand)
    ((eql sym +or+) #'myor)
    ))

;; Devuelve la interpretación de un símbolo con la lista de interpretaciones dada.
(defun getint (sym int)
  (if (truth-value-p sym)
      sym
      (car (cdar (remove-if 
<<<<<<< HEAD
          #'(lambda (x) (not (eql (car x) sym))) 
=======
          #'(lambda (x) (not (eql (car x) sym)))
>>>>>>> 096b287c97f7a1ec2c613bafc979948545c5a5d2
          int)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AUXILIAR eval-fbf
;;
;; RECIBE   : fórmula bien formada e interpretación
;; EVALÚA A : Valor de verdad de la fbf con la interpretación dada
;;
(defun eval-fbf (fbf int)
   	(if (atom fbf)
         (getint fbf int)
         (apply 
           (evaluator (first fbf)) 
           (mapcar #'(lambda (f) (eval-fbf f int)) (rest fbf)))))

;;(eval-fbf '(<=> T NIL) '())
;;(eval-fbf '(=> A NIL) '((A T)))
;;(eval-fbf '(<=> P (^ A  H)) '((A NIL) (P NIL) (H T)))
;;(eval-fbf '(<=> (v A P H) (^ A P H)) '((A NIL) (P NIL) (H T)))
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EJERCICIO interpretacion-modelo-p
;;
;; RECIBE   : base de conocimiento (KB) e interpretación
;; EVALÚA A : T en caso de que la interpretación sea un modelo de KB
;;            NIL en caso contrario
;;

(defun interpretacion-modelo-p (kb interpretacion) 
  (every #'identity (mapcar #'(lambda (fbf) (eval-fbf fbf interpretacion)) kb)))


(interpretacion-modelo-p  '((<=> A (¬ H)) (<=> P (^ A  H)) (<=> H P))
                         '((A NIL) (P NIL) (H T)))
(interpretacion-modelo-p '((<=> A (¬ H)) (<=> P (^ A  H)) (<=> H P))
                         '((A T) (P NIL) (H NIL)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EJERCICIO: encuentra-modelos
;;
;; RECIBE   : base de conocimiento (KB)
;; EVALÚA A : lista de interpretaciones que son modelo para KB
;;
;;
(defun encuentra-modelos (kb) 
  (remove-if-not 
    #'(lambda (int) (interpretacion-modelo-p kb int)) 
    (genera-lista-interpretaciones (extrae-simbolos kb))))

(encuentra-modelos '((=> A (¬ H)) (<=> P (^ A  H)) (=> H P)))
(encuentra-modelos '((=> (^ P I)  L)  (=> (¬ P) (¬ L)) (¬ P) L))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EJERCICIO SAT-p
;;
;; RECIBE   : base de conocimiento (KB)
;; EVALÚA A : T si existe al menos un modelo para kb
;;            NIL en caso contrario
;;
;;
(defun SAT-p (kb)
  (not (null (encuentra-modelos kb))))

(SAT-p '((=> (^ P I) L) (=> (¬ P) (¬ L)) (¬ P) L)) 
(SAT-p '((v (<=> K (¬ (^ A (M => B))))) (=> (^ K A M B) J) (v (=> (^ J A) T) (<=> A nil))))
(SAT-p '((<=> A (¬ H)) (<=> P (^ A H)) (<=> H P)))
