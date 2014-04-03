(load "motor-inferencia.cl")

(setq *rule-list*
	'(
	(R1 (pertenece ?E (?E . ?_)))
	(R2 (pertenece ?E (?_ . ?Xs)) :- ((pertenece ?E ?Xs)))
	(R3 (encolar () ?E  (?E)))
	(R4 (encolar (?Y . ?L) ?E (?Y . ?Z)) :- ((encolar ?L ?E ?Z)))
	(R7 (concatenar () ?L ?L))
	(R8 (concatenar (?X . ?R) ?L (?X . ?R2)) :- ((concatenar ?R ?L ?R2)))
	(R9 (invertir () ()))
	(R10 (invertir (?X . ?Y) ?Z) :- ((invertir ?Y ?H) (encolar ?H ?X ?Z)))
	(R11 (ordenada ()))
	(R12 (ordenada (?_)))
	(R13 (ordenada (?x ?y . ?zs)) :- ((?= T (?eval (<= ?x ?y))) (ordenada (?y . ?zs))))
	(R14 (productorio () 1))
	(R15 (productorio (?X . ?R) ?Z) :- ((productorio ?R ?P) (?= ?Z (?eval (* ?P ?X)))))
))
;;;; Ejercicio 1.

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
;;res -> (((?XS a b '1 2)))


;;; Ejercicio 2.c


;; Caso base
(set-hypothesis-list '((invertir () ?Zs)))
(motor-inferencia)
;;res -> (((?ZS)))

;; Ejemplo de prueba
(set-hypothesis-list '((invertir (1 2) ?X)))
(motor-inferencia)
;;res -> (((NIL)))

;; Ejemplo de prueba
(set-hypothesis-list '((invertir (1 2 3 4 5) ?X)))
(motor-inferencia)
;;res -> (5 4 3 2 1)


;;;; Parte 2
(unify '(?a ?b (?eval (+ ?a ?b))) '(2 3 ?c))
;;res-> ((?C . 5) (?B . 3) (?A . 2))
(unify '(?a (?eval (+ 2 (* 3 ?a)))) '(2 8))
;;res-> ((?A . 2))
(unify '(?a ?b (?eval (append ?a ?b))) '((1) (2) ?c))
;;res-> ((?C 1 2) (?B 2) (?A 1))
(unify '((?eval (+ ?a 1)) ?a) '(4 3))
;;res-> NIL


;(setq *mundo-abierto* NIL)

(set-hypothesis-list '((ordenada(1 2 3))))
(motor-inferencia)
;;res-> (((NIL)))

(set-hypothesis-list  '((ordenada(2 1 3))))
(motor-inferencia)
;;res-> NIL


(set-hypothesis-list '((productorio () ?R)))
(motor-inferencia)
;;res-> (((?R . 1)))

(set-hypothesis-list '((productorio (10) ?R)))
(motor-inferencia)
;;res-> (((?R . 10)))

(set-hypothesis-list '((productorio (5 10) ?R)))
(motor-inferencia)
;;res-> (((?R . 10)))

(set-hypothesis-list '((productorio (1 2 3 4) ?R)))
(motor-inferencia)
;;res-> (((?R . 24)))

(erase-facts)
(setq *rule-list* '(
	(R16 (posicionN ?X ?_ ?_) :- ((?eval (>= ?X 1))))
	))

(set-hypothesis-list '((posicionN 0 (A B C D E) ?X)))
(motor-inferencia)
;;res-> (((?X . A)))
(set-hypothesis-list '((posicionN 4 (A B C D E) ?X)))
(motor-inferencia)
;;res-> (((?X . D)))
(set-hypothesis-list '((posicionN 3 (4 5) ?X)))
(motor-inferencia)
;;res-> NIL
