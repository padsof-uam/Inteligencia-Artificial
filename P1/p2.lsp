(defun combine-elt-lst (elt lst)
			(mapcar #'(lambda (x) (cons elt x)) lst))

;;%% code

(defun combine-lst-lst (lst1 lst2)
			(mapcan #'(lambda (x) (combine-elt-lst_red x lst2)) lst1))

;;%% code

(defun combine-lst-of-lst (lst)
	(if (null (cddr lst))
		(combine-lst-lst (car lst) (car (cdr lst)))
		(combine-lst-lst (car lst) (combine-lst-of-lst (cdr lst)))))