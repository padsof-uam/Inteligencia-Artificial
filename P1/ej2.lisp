(defun combine-elt-lst (elt lst)
			(mapcar #'(lambda (x) (list elt x)) lst))

(defun combine-lst-lst (lst1 lst2)
			(mapcan #'(lambda (x) (combine-elt-lst x lst2)) lst1))

(defun combine-elt-lst-app (elt lst)
			(mapcar #'(lambda (x) (cons elt x)) lst))

(defun combine-lst-lst-app (lst1 lst2)
			(mapcan #'(lambda (x) (combine-elt-lst-app x lst2)) lst1))

(defun combine-lst-of-lst (lst)
	(if (null (cdr lst))
		(car lst)
	(if (null (cddr lst))
			(combine-lst-lst (car lst) (cadr lst))
	(combine-lst-lst-app (car lst) (combine-lst-of-lst (cdr lst))))))

