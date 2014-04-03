(load "motor-inferencia.cl")
(erase-facts)
(setq *rule-list* '(
	(R2 (posicionN 1 (?X . ?_) ?X))
	(R3 (posicionN ?X (?_ . ?L) ?R) :- ((?= T (?eval (> ?X 1))) (?= ?P (?eval (- ?X 1))) (posicionN ?P ?L ?R)))
	))

(set-hypothesis-list '((posicionN 0 (A B C D E) ?X)))
(motor-inferencia)
;;res-> (((?X . A)))

(set-hypothesis-list '((posicionN 7 (A B C D E) ?X)))
(motor-inferencia)
;;res-> (((?X . A)))

(set-hypothesis-list '((posicionN 3 () ?X)))
(motor-inferencia)
;;res-> (((?X . A)))

(set-hypothesis-list '((posicionN 4 (A B C D E) ?X)))
(motor-inferencia)
;;res-> (((?X . D)))

(set-hypothesis-list '((posicionN -2 (4 5) ?X)))
(motor-inferencia)
;;res-> NIL

(setq *rule-list* '(
	(R1 (doblar ?X ?R) :- ((?= ?R (?eval (* ?X 2)))))
	(R2 (map ?_ () ()))
	(R3 (map ?Pred (?First . ?Rest) ?Retval) :- (
				 (?Pred ?First ?Dob)
				 (concatenar ?New ?Retval ?Recur)
				 (map ?Pred ?Rest ?Recur)))
	(R7 (concatenar () ?L ?L))
	(R8 (concatenar (?X . ?R) ?L (?X . ?R2)) :- ((concatenar ?R ?L ?R2)))

	))

(set-hypothesis-list '((doblar 2 ?R)))
(motor-inferencia)
;;res-> (((?RS 4)))

(set-hypothesis-list '((map doblar (2 1 3) ?Rs)))
(motor-inferencia)
;;res-> (((?RS 4 2 6)))

(set-hypothesis-list '((map doblar () ?Rs)))
(motor-inferencia)
;;res-> (((?RS)))

