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

(setf *planets* 
'(Avalon Davion Manory Kentares Katril Proserpina Sirtis))

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
;;
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

;(navigate-worm-hole 'Katril *worm-holes*)
;(navigate-white-hole 'Kentares *white-holes*)
;(navigate-worm-hole 'Kentares *worm-holes*)

(setf *uniform-cost*
	(make-strategy
		:name 'uniform-cost
		:node-compare-p 'node-g-<=))

(defun node-g-<= (node-1 node-2)
	(<= (node-g node-1)	(node-g node-2)))


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
		:operators (list
					(make-fn
						:name 'navigate-worm-hole 
						:lst-args *worm-holes*)
					(make-fn
						:name 'navigate-white-hole
						:lst-args *white-holes*))))

(setf *node-00*
	(make-node
		:state 'Proserpina 
		:depth 12 
		:g 10 
		:f 20))

;;;; 
;; Expande el nodo dado. Para ello buscaremos en las estructuras de problem 
;; la información sobre a qué planetas podemos viajar (qué nodos son los sucesores) 
;; y crearemos una estructura nodo para cada sucesor 
;; con toda la información necesaria.
;;
;; No comprobamos si el nodo es solución (que es lo primero antes de expandir nodo).
;; Dejamos esa comprrobación para la tarea superior.
;;
;; IN: 	node: el nodo a expandir
;;		problem: estructura con toda la información necesaria
;; OUT: lista de los nodos hijos. En el problema de la galaxia, lista de los nodos planeta a los que podemos viajar
;; pseudocode:
;; Iterar atomo en planetas_destino
;; 	make-nodo (node,atomo)
;;

(defun expand-node (nodeArg problem)
	(let ((lst
        	(mapcan
	        	#'(lambda(x)  (funcall (fn-name x) (node-state nodeArg) (fn-lst-args x))) (problem-operators problem))))
			(mapcar #'(lambda(x) 
				(let ((g (+ (action-cost x) (node-g nodeArg)))
					(h (f-h-galaxy (action-final x) *sensors*)))
						(make-node
							:state (action-final x)
							:parent nodeArg
							:action x
							:depth (+ 1 (node-depth nodeArg))
							:g g
							:h h
							:f (+ g h)))) lst)))

;; Examples
(print 
	(setf *lst-nodes-0*
		(expand-node *node-00* *galaxy-M35*)))

; (#S(NODE :STATE MALLORY
;    :PARENT  #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;    :ACTION  #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN PROSERPINA :FINAL MALLORY :COST 6)
;    :DEPTH 13 :G 16 :H 7 :F 23)
; #S(NODE :STATE SIRTIS
;    :PARENT  #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;    :ACTION  #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN PROSERPINA :FINAL SIRTIS :COST 7)
;    :DEPTH 13 :G 17 :H 0 :F 17)
; #S(NODE :STATE KENTARES
;    :PARENT  #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;    :ACTION  #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN PROSERPINA :FINAL KENTARES :COST 1)
;    :DEPTH 13 :G 11 :H 4 :F 15)
; #S(NODE :STATE MALLORY
;    :PARENT  #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;    :ACTION  #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN PROSERPINA :FINAL MALLORY :COST 7)
;    :DEPTH 13 :G 17 :H 7 :F 24)
; #S(NODE :STATE AVALON
;    :PARENT  #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;    :ACTION  #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN PROSERPINA :FINAL AVALON :COST 2)
;    :DEPTH 13 :G 12 :H 5 :F 17)
; #S(NODE :STATE DAVION
;    :PARENT  #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;    :ACTION  #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN PROSERPINA :FINAL DAVION :COST 4)
;    :DEPTH 13 :G 14 :H 1 :F 15)
; #S(NODE :STATE SIRTIS
;    :PARENT  #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;    :ACTION  #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN PROSERPINA :FINAL SIRTIS :COST 10)
;    :DEPTH 13 :G 20 :H 0 :F 20))



;;;;
;; Inserta una lista de nodos en otra (ya ordenada) de acuerdo con una estrategia.
;;
;; IN: 	nodes: lista de nodos para insertar.
;;		lst-nodes:	lista de nodos en la que insertar.
;;		strategy:	estrategia que seguir a la hora de insertar.
;; OUT:	una lista de nodos ordenados de acuerdo a la estrategia.
;;
;; pseudocode:
;;	insert-nodes(nodes lst strategy)
;;		iterar at1 en nodes
;;			iterar at2 en lst
;;				si ato1 < at2
;;					insertar ato1 y desplazar el resto
;;				

(defun _aux-insert-nodes (nodes lst-nodes acc strategy)
	(if (funcall (strategy-node-compare-p strategy) (car nodes) (car lst-nodes))
			(_aux-insert-nodes (cdr nodes) lst-nodes (append acc (car nodes)) strategy)
		(_aux-insert-nodes nodes (cdr lst-nodes) (append acc (car lst-nodes)) strategy)))

(defun insert-nodes-strategy (nodes lst-nodes strategy)
	(_aux-insert-nodes nodes lst-nodes () strategy))


(setf *node-01*
	(make-node
		:state 'Avalon 
		:depth 0 
		:g 0 
		:f 0))

(setf *node-02*
	(make-node
		:state 'Kentares 
		:depth 2 
		:g 50 
		:f 50))


(print
	(insert-nodes-strategy (list *node-00* *node-01* *node-02*) 
		*lst-nodes-0*
		*uniform-cost*))