(defun tanhip (z)  
	(let ((x (- 0 z)))
		(/ 
			(- (exp z) (exp x))
			(+ (exp z) (exp x)))))

(defun logit (z) 
	(/ 1
		(+ 1 (exp z))))
; (defun h-recursive (x v sigma) ...)
; (defun h-mapcar (x w sigma) ...)
