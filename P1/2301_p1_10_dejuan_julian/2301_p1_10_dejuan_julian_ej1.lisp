(defun tanhip (z)  
	(let ((x (- 0 z)))
		(/ 
			(- (exp z) (exp x))
			(+ (exp z) (exp x)))))

(defun logit (z) 
	(/ 1
		(+ 1 (exp z))))

(defun h-mapcar (x w sigma) 
	(funcall sigma 
		(reduce #'+
			(mapcar #'* x w))))

(defun h-recursive-aux (x w acc)
		(if (null x)
			acc
		(h-recursive-aux (rest x) (rest w) ( + (* (first x)  (first w)) acc))))

(defun h-recursive (x w sigma) 
		(funcall sigma (h-recursive-aux x w 0)))

