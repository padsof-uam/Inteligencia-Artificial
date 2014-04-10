(load "motor-inferencia.cl")
(erase-facts)


(setq *rule-list* '(
	(R1 (doblar ?X ?R) :- ((?= ?R (?eval (* ?X 2)))))
	(R2 (map ?_ () ()))
	(R4 (map ?Pred (?X) ?Y) :- ((?Pred ?X ?Z) (concatenar (?Z) () ?Y)))
	(R3 (map ?Pred (?First . ?Rest) ?Retval) :- (
				 (?Pred ?First ?Dob)
				 (concatenar (?Dob) ?Retval ?Recur)
				 (map ?Pred ?Rest ?Recur)
				 ))
	(R7 (concatenar () ?L ?L))
	(R8 (concatenar (?X . ?R) ?L (?X . ?R2)) :- ((concatenar ?R ?L ?R2)))
	))
;;; Prueba de doblar
(set-hypothesis-list '((doblar 2 ?R)))
(motor-inferencia)
;;res-> (((?RS 4)))

(set-hypothesis-list '((map doblar () ?Rs)))
(motor-inferencia)

;;; Caso base
(set-hypothesis-list '((map doblar (1) ?Rs)))
(motor-inferencia)
;;res-> (((?RS)))

;;; Caso normal.
(set-hypothesis-list '((map doblar (2 1) ?Rs)))
(motor-inferencia)
;;res-> (((?RS 4 2 6)))
