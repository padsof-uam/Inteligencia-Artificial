(defun tanhip (z)  
  (/ 
    ())
; (defun logit (z) ...)

;x,w son listas de números reales de igual tamaño no vacías.

(defun h-recursive (x w sigma) 
		(funcall sigma (h-recursive-aux x w 0))
	)

(defun h-recursive-aux (x w acc)
		(if (null x)
			acc
		(h-recursive-aux (rest x) (rest w) ( + (* (first x)  (first w)) acc))))
