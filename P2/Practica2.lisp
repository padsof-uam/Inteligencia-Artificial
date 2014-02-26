(setf *planets* '(Avalon Davion Manory Kentares Katril Proserpina Sirtis))

(setf *white-holes*
'((Avalon Mallory 2) (Avalon Proserpina 2) 
  (Mallory Katril 6) (Mallory Proserpina 7)
  (Katril Mallory 6) (Katril Davion 2)
  (Davion Proserpina 4) (Davion Sirtis 1) 
  (Sirtis Proserpina 10) (Sirtis Davion 1)
  (Proserpina Mallory 7) (Proserpina Avalon 2) (Proserpina Davion 4) (Proserpina Sirtis 10)
  (Kentares Avalon 3) (Kentares Katril 2)
  (Kentares Proserpina 2)))

(setf *worm-holes*
'((Avalon Kentares 4) (Avalon Mallory 7) (Davion Katril 1)
 (Mallory Katril 5) (Mallory Proserpina 6) (Katril Sirtis 10)
 (Davion Sirtis 8) (Sirtis Proserpina 7) (Proserpina Kentares 1)))

(setf *sensors*
'((Avalon 5) (Mallory 7) (Kentares 4) (Davion 1) (Proserpina 4) (Katril 3) (Sirtis 0)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem definition
;;
(defstruct problem
	states 			; List of states
	initial-state 	; Initial state
	fn-goal-test 	; Function (in fn format) that determines; whether a state fulfills the goal
	fn-h 			; Function (in fn format) that evaluates; to the value of the heuristic of a state
	fn-strategy 	; Function (in fn format) that inserts a node in; a list of nodes, according to a specified strategy
	operators) 		; list of operators (in fn format); to generate succesors
;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Node in search tree
;;
(defstruct node
	state     ; state label
	parent    ; parent node
	action    ; action that generated the current node from its parent
	(depth 0) ; depth in the search tree
	(g 0)     ; cost of the path from the initial state to this node
	h         ; value of the heurstic
	(f 0))    ; g + h
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Actions
;;
(defstruct action
	Name   ; Name of the operator that generated the action
	origin ; State on which the action is applied
	final  ; State that results from the application of the action
	cost ) ; Cost of the action
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Search strategies
;;
(defstruct strategy
	name 			; Name of the search strategy
	node-compare-p) ; boolean comparison
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; fn format for functions
;;

(defstruct fn
	name 		; Function name
	lst-args) 	; List of additional arguments
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;UNA VEZ DEFINIDAS LAS ESTRUCTURAS VAMOS CON LAS FUNCIONES:

;;;;
;; Comprueba que si planeta pasado como argumento es una meta.
;;
;; IN: 	state: planeta actual
;; 		planets-destination: lista de planetas de destino
;; OUT: T si el planeta actual es una meta.
;; 
;; pseudocode
;; comprobar si state está en planets-destination
(defun f-goal-test-galaxy (state planets-destination) 
  (not (null (member state planets-destination))))

(f-goal-test-galaxy 'Sirtis '(Sirtis)) ;-> T 
(f-goal-test-galaxy 'Avalon '(Sirtis)) ;-> NIL 
(f-goal-test-galaxy 'Urano '(Sirtis)) ;-> NIL
(f-goal-test-galaxy 'Urano '()) ;-> NIL

;;;;
;; Devuelve el valor de la heurística en el planeta actual.
;; 
;; IN: 	state: planeta actual
;; 		sensors: lista de tuplas planeta-heurística
;; OUT: valor de la heurística en el planeta actual
(defun f-h-galaxy (state sensors)
  (if (null sensors)
      nil
	  (let ((sensor (first sensors)))
	    (if (equal state (car sensor))
	        (cadr sensor)
	        (f-h-galaxy state (rest sensors))))))

(f-h-galaxy 'Sirtis *sensors*) ;-> 0
(f-h-galaxy 'Avalon *sensors*) ;-> 5

;;;;
;; Función genérica para crear las acciones a partir de una lista de rutas
;; IN:	state: planeta actual
;;		routes: lista de rutas
;; 		is-route-func: función que decide si una ruta parte del planeta destino
;;		get-dest-func: función que devuelve el destino a partir del triplete
;;		name: nombre de la función que genera las rutas
;; OUT:	Lista con las acciones correspondientes a las rutas posibles.
;; 
;; pseudocode
;; por cada ruta en (filtrar routes con is-route-func):
;; 	crear nueva acción con:
;;		nombre: name
;;		origen: state
;;		final: (get-dest-func ruta)
;;		coste: ruta[3]
(defun navigate-generic (state routes is-route-func get-dest-func name)
  (mapcar 
    #'(lambda (x)
       (make-action :Name name
                    :origin state
                    :final (funcall get-dest-func x)
                    :cost (third x)))
       (remove-if-not is-route-func routes)))

(defun navigate-worm-hole (state worm-holes) 
  (navigate-generic state 
                    worm-holes
                    #'(lambda (x) (or (eql state (first x)) 
                                      (eql state (second x))))
                    #'(lambda (x) (if (eql state (first x)) 
                                      (second x)
                                      (first x)))
                    'navigate-worm-hole)) 

(defun navigate-white-hole (state white-holes)
  (navigate-generic state 
                    white-holes
                    #'(lambda (x) (eql state (first x)))
                    #'(lambda (x) (second x))
                    'navigate-white-hole))

(navigate-worm-hole 'Katril *worm-holes*)
(navigate-white-hole 'Urano *white-holes*)
(navigate-worm-hole 'Kentares *worm-holes*)

;;;;
;; 
;;
;; IN: 	node-1 y node-2 a comparar.
;; 	
;; OUT: 
;; 
;; pseudocode
;; 	Comparamos los valores de la f de cada nodo

(setf *A-star*
    (make-strategy 
    	:name 'A-star
    	:node-compare-p 'node-f-compare))

(defun node-f-compare (node-1 node-2)
	(<= (node-f node-1) (node-f node-2)))


;;;;Ejercicio 5

(setf *galaxy-M35* 
	(make-problem
		:states *planets*
		:initial-state	'Sirtis
		:fn-goal-test 'f-goal-test-galaxy
		:fn-h 'f-h-galaxy
		:fn-strategy 'insert-nodes
		:operators 'expand-node))

;;;; 
;; Expande el nodo dado. Para ello buscaremos en las estructuras de problem para saber a qué planetas podemos viajar (qué nodos son los sucesores) y crearemos 
;; una estructura nodo para cada sucesor con toda la información necesaria.
;;
;; IN: 	node: el nodo a expandir
;;		problem: estructura con toda la información necesaria
;; OUT: lista de los nodos hijos. En el problema de la galaxia, lista de los nodos planeta a los que podemos viajar
;; pseudocode:
;; Iterar atomo en (concatenar navigate-white-hole(node problem-whiteHoles) navigate-worm-hole(node problem-worm-holes))
;; 	make-nodo (node,atomo)
;;
;;REVISAR APPEND
(defun expand-node (nodeArg problem)
	(mapcar #'(lambda(x) (make-node
							:state (action-final x)
							:parent nodeArg
							:action x
							:depth (+ 1 node-depth nodeArg)
							:g (+ (action-cost x) (node-g nodeArg))
							:h (f-h-galaxy (action-final x))
							:f (+ g h))) ; ¿Esto se puede hacer?
         	(append (navigate-white-hole (node-state nodeArg) *white-holes*) 
                  	(navigate-worm-hole (node-state nodeArg) *worm-holes*))))

(defun insert-nodes (nodes lst-nodes strategy))
