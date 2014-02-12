(defun tanhip (z)  
	(let ((x (- 0 z)))
		(/ 
			(- (exp z) (exp x))
			(+ (exp z) (exp x)))))

;;%% code

(defun logit (z) 
	(/ 1
		(+ 1 (exp z))))

;;%% code

(defun h-mapcar (x w sigma) 
	(funcall sigma 
		(reduce #'+
			(mapcar #'* x w))))

;;%% code

(defun h-recursive (x w sigma) 
		(funcall sigma (h-recursive-aux x w 0)))

;;%% code

(defun h-recursive-aux (x w acc)
		(if (null x)
			acc
		(h-recursive-aux (rest x) (rest w) ( + (* (first x)  (first w)) acc))))
