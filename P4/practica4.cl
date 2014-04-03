(load "motor-inferencia.cl")

(setq *rule-list*
	'((R1 (pertenece ?E (?E . ?_)))
		(R2 (pertenece ?E (?_ . ?Xs)) :- ((pertenece ?E ?Xs)))
))

;;;; Ejercicio 1.
(erase-facts)

; Prueba de si pertenencia.
(set-hypothesis-list '((pertenece 1 (2 5 1 6 7))))
(motor-inferencia)
;; res-> (((NIL))), es decir, sí pertenece porque devuelve una lista vacía.

(set-hypothesis-list '((pertenece 1 (2 5 6 7))))
(motor-inferencia)
;; res-> NIL, es decir, no pertenece.

(set-hypothesis-list '((pertenece ?x (2 5 3 6 Y))))
(motor-inferencia)
;; res-> (((?X . 2)) ((?X . 5)) ((?X . 3)) ((?X . 6)) ((?X . Y)))

(set-hypothesis-list '((pertenece ?x (2 5 3 y))))
(motor-inferencia)

;;;; Ejercicio 2.

;;; Ejercicio 2.a
(erase-facts)

(setq *rule-list*
	'((R1 (encolar () ?E  (?E)))
	  (R2 (encolar (?Y . ?L) ?E (?Y . ?Z)) :- ((encolar ?L ?E ?Z)))
))

;; Caso base: encolamos 1 elemento a una lista vacía.
(set-hypothesis-list '((encolar () 1 ?L)))
(motor-inferencia)
;;res -> (((?L 1)))

;; Caso base: encolamos 1 elemento a una lista vacía.
(set-hypothesis-list '((encolar () 1 (1))))
(motor-inferencia)
;;res -> (((NIL)))

;; Caso recursivo: encolamos 1 elemento a una lista no vacía.
(set-hypothesis-list '((encolar (1 2 3) 4 ?Rs)))
(motor-inferencia)
;;res -> (((?RS 1 2 3 4)))

;;; Ejercicio 2.b
(erase-facts)

(setq *rule-list*
	'  ((R1 (concatenar () ?L ?L))
		(R2 (concatenar (?X . ?R) ?L (?X . ?R2)) :- ((concatenar ?R ?L ?R2)))
))


;; Caso base: añadimos una lista de un elemento a una lista vacía.
(set-hypothesis-list '((concatenar 	() (5) ?Xs)))
(motor-inferencia)
;;res -> (((?XS 5)))

;; Caso base: añadimos una lista de 1 elemento a una lista no vacía (como encolar).
(set-hypothesis-list '((concatenar 	(6 7) (5) ?Xs)))
(motor-inferencia)
;;res -> (((?XS 6 7 5)))

;; Caso recursivo: 2 listas no vacías
(set-hypothesis-list '((concatenar 	() (1 2) ?Xs)))
(motor-inferencia)
;;res -> (((?XS 1 2)))

;; Caso recursivo: 2 listas no vacías
(set-hypothesis-list '((concatenar 	(a b) (1 2) ?Xs)))
(motor-inferencia)
;;res -> (((?XS a b 1 2)))
