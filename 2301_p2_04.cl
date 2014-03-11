
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                       ;
;               PRACTICA 2              ;
;                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;
;;;Inicializamos las estructuras de nuestro problema en variables
;;;

(setf *planets* '(Avalon Davion Katril Kentares Mallory Proserpina Sirtis))

(setf *planets-tests* '(Davion Katril Kentares Mallory Proserpina Sirtis))


(setf *white-holes* '((Avalon Mallory 2) (Avalon Proserpina 2)
  (Davion Proserpina 4) (Davion Sirtis 1)
  (Katril Davion 2) (Katril Mallory 6)
  (Kentares Avalon 3) (Kentares Proserpina 2) (Kentares Katril 2)
  (Mallory Katril 6) (Mallory Proserpina 7)
  (Proserpina Avalon 2) (Proserpina Mallory 7) (Proserpina Davion 4) (Proserpina Sirtis 10)
  (Sirtis Proserpina 10) (Sirtis Davion 1)))

(setf *white-holes-tests* '((Proserpina Sirtis 5) (Sirtis Proserpina 6)
 (Sirtis Davion 3) (Davion sirtis 2)))



(setf *worm-holes* 
  '((Avalon Kentares 4) (Avalon Mallory 7)
    (Davion Katril 1) (Davion Sirtis 8)
    (Katril Mallory 5) (Katril Sirtis 10)
    (Kentares Proserpina 1)
    (Mallory Proserpina 6) 
    (Proserpina Sirtis 7)))

(setf *worm-holes-tests* 
  '((Kentares Katril 2) (Kentares Proserpina 1) (Katril Mallory 3) (Proserpina Mallory 3)
   (Proserpina Sirtis 5) (Mallory Davion 4) (Davion Sirtis 2)))


(setf *sensors*
  '((Avalon 5) (Davion 1) (Katril 3) (Kentares 4) (Proserpina 4) (Sirtis 0) (Mallory 7)))

(setf *sensors-tests* '( (Davion 1) (Katril 4) (Kentares 4) (Proserpina 4) (Sirtis 0) (Mallory 4)))

(setf *planet-origin* 'Kentares)

(setf *planets-destination* '(Sirtis))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;fn format for functions
;;
(defstruct fn
    name ; Function name
    lst-args) ; List of additional arguments
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;Problem definition
;;
(defstruct problem
  states ; List of states
  initial-state; Initial state
  fn-goal-test ; Function (in fn format) that determines whether a state fulfills the goal
  fn-h ; Function (in fn format) that evaluates to the value of the heuristic of a state
  operators) ; list of operators (in fn format)to generate succesors
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;Node in search tree
;;
(defstruct node 
    state ; state label
    parent ; parent node
    action ; action that generated the current node from its parent
    (depth 0) ; depth in the search tree
    (g 0) ; cost of the path from the initial state to this node
    h ; value of the heurstic
    (f 0)) ; g + h

;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;Actions
;;
(defstruct action 
  name ; Name of the operator that generated the action
  origin ; State on which the action is applied
  final ; State that results from the application of the action
  cost) ; Cost of the action
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;Search strategies
;;
(defstruct strategy
  name ; Name of the search strategy
  node-compare-p) ; boolean comparison
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; EJERCICIO 1 ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; FUNCTION: f-goal-test-galaxy
;; INPUT: 
;;  - state: estado que se va a comprobar
;;  - planets-destination: lista de estados (planetas) que se consideran destino del problema
;;      
;; OUTPUT: T si el estado recibido se encuentra en la lista, NIL en caso contrario
;;


(defun f-goal-test-galaxy (state planets-destination)
  (when (member state planets-destination) t))

;; Tests
(f-goal-test-galaxy 'Sirtis *planets-destination*)
(f-goal-test-galaxy 'Avalon *planets-destination*)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; EJERCICIO 2 ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; FUNCTION: f-h-galaxy
;; INPUT: 
;;  - state: estado del cual se quiere obtener la heurística.
;;  - sensors: lista de pares (<estado> <heurística>) que define el problema.
;;      
;; OUTPUT: La heurística del estado (planeta) recibido y NIL si no se encuentra en la lista.
;;


(defun f-h-galaxy (state sensors)
  (second (assoc state sensors)))

;; Tests
(f-h-galaxy 'Sirtis *sensors*) ;-> 0
(f-h-galaxy 'Avalon *sensors*) ;-> 5
(f-h-galaxy 'Pluton *sensors*) ;-> NIL





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; EJERCICIO 3 ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; DESC: navigate-worm-hole y navigate-white-hole devuelven una lista de acciones posibles desde el estado actual.

;; FUNCTION: navigate-worm-hole
;; INPUT: 
;;  - state: estado desde el cual se comienza
;;  - worm-holes: lista de worm-holes del grafo en la forma (<worm hole 1> <worm-hole 2> <cost>)
;;      
;; OUTPUT: lista de acciones posibles en el grafo navegando a traves de worm-holes desde 'state'. NIL si el planeta no existe
;;

(defun navigate-worm-hole (state worm-holes) 
  (mapcan #'(lambda (x)
   (cond 
    ((eql state (first x)) (list ( make-action :name 'navigate-worm-hole :origin state :final (second x) :cost (third x))))
    ((eql state (second x)) (list ( make-action :name 'navigate-worm-hole :origin state :final (first x) :cost (third x)))))) worm-holes))




;; FUNCTION: navigate-white-hole
;; INPUT: 
;;  - state: estado desde el cual se comienza
;;  - white-holes: lista de white-holes del grafo en la forma (<white hole 1> <white-hole 2> <cost>)
;;      
;; OUTPUT: lista de acciones posibles en el grafo navegando a traves de white-holes desde 'state'. NIL si el planeta no existe
;;

(defun navigate-white-hole (state white-holes) 
  (mapcan #'(lambda (x)
    (when (eql state (first x)) 
      (list ( make-action :name 'navigate-white-hole :origin state :final (second x) :cost (third x))))) white-holes))


;; Tests
(navigate-white-hole 'Urano *white-holes*)
(navigate-white-hole 'Proserpina *white-holes*)
(navigate-worm-hole 'Katril *worm-holes*)
(navigate-worm-hole 'Pluton *worm-holes*)







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; EJERCICIO 4 ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(setf *A-star* (make-strategy :name 'A-star :node-compare-p 'node-f-cmp))


;; FUNCTION: node-f-cmp
;; INPUT:
;;  - node-1: primer nodo a comparar
;;  - node-2: segundo nodo a comparar
;;      
;; OUTPUT: T si 'node-1' es menor o igual que 'node-2'. NIL en caso contrario.
;;

(defun node-f-cmp (node-1 node-2)
  (<= (node-f node-1) (node-f node-2)))


;;Tests
(setf nodo-menor (make-node :state 'Avalon :depth 0 :g 0 :f 0))
(setf nodo-mayor (make-node :state 'Sirtis :depth 0 :g 0 :f 50))

(node-f-cmp nodo-menor nodo-mayor) ;; caso verdadero
(node-f-cmp nodo-mayor nodo-menor) ;; caso contrario


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; EJERCICIO 5 ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setf *galaxy-M35* (make-problem 
  :states *planets*
  :initial-state *planet-origin*
  :fn-goal-test (make-fn :name 'f-goal-test-galaxy :lst-args *planets-destination*)
  :operators (list (make-fn :name 'navigate-white-hole :lst-args *white-holes*)
               (make-fn :name 'navigate-worm-hole :lst-args *worm-holes*))))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; EJERCICIO 6 ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; FUNCTION: _possible-actions
;; INPUT: 
;;  - node: nodo desde el cual se van a comprobar todas las acciones posibles
;;  - problem: problema en base al cual se va a realizar la busqueda
;;      
;; OUTPUT: lista de acciones posibles dado el nodo node y especificado el problema problem.
;;

(defun _possible-actions (node problem)
  (mapcan #'(lambda (x) (funcall (fn-name x) (node-state node) (fn-lst-args x) )) (problem-operators problem)))


;; Tests
(setf node-00 (make-node :state 'Proserpina :depth 12 :g 10 :f 20) )

(_possible-actions node-00 *galaxy-M35*)



;; FUNCTION: expand-node
;; INPUT: 
;;  - node: nodo a expandir
;;  - problem: problema en base al cual se va a realizar la expansion
;;      
;; OUTPUT: Lista de nodos que resultan de expandir el nodo node bajo las especificaciones del problema problem
;;

(defun expand-node (node problem)
  (mapcar #'(lambda (x) (make-node :state (action-final x)
    :parent node
    :action x
    :depth (+ (node-depth node) 1)
    :g (+ (node-g node) (action-cost x))
    :h (f-h-galaxy (action-final x) *sensors*)
    :f (+ (+ (node-g node) (action-cost x)) (f-h-galaxy (action-final x) *sensors*)))) (_possible-actions node problem)))


;; Tests
(setf lst-nodes-0 (expand-node node-00 *galaxy-M35*))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; EJERCICIO 7 ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; DESC: Ordena las listas de nodos e inserta una lista de nodos dentro de otra

;; FUNCTION: insert-nodes-strategy
;; INPUT: 
;;  - nodes: lista de nodos principal
;;  - lst-nodes: lista de nodos secundaria
;;  - strategy: estrategia utilizada para ordenar
;;      
;; OUTPUT: lista de nodos que mezcla ambas listas de forma ordenada conforme a la estrategia recibida
;;

(defun insert-nodes-strategy (nodes lst-nodes strategy) 
  (merge 'list 
         (sort nodes (strategy-node-compare-p strategy)) 
         (sort lst-nodes (strategy-node-compare-p strategy))
         (strategy-node-compare-p strategy)))


;; Tests
(defun node-g-<= (node-1 node-2) 
  (<= (node-g node-1) (node-g node-2)))

(setf *uniform-cost* (make-strategy :name 'uniform-cost :node-compare-p 'node-g-<=))
(setf node-01 (make-node :state 'Avalon :depth 0 :g 0 :f 0) )
(setf node-02 (make-node :state 'Kentares :depth 2 :g 50 :f 50) )

(print (insert-nodes-strategy (list node-00 node-01 node-02) lst-nodes-0 *uniform-cost*))






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; EJERCICIO 8 ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; DESC: Realiza la busqueda en arbol para el problema dado utilizando la estrategia que se indique.

;; FUNCTION: tree-search
;; INPUT:
;;  - problem: problema donde se va a buscar (estructura tipo 'problem') IMPORTANTE: debe tener estado inicial definido
;;  - strategy: estrategia de busqueda (estructura tipo 'strategy')
;;      
;; OUTPUT: Nodo meta si se ha podido llegar hasta el con la estrategia dada. NIL en caso contrario.
;;
(defun tree-search (problem strategy) 
  (tree-recursion (list (make-node :state (problem-initial-state problem))) problem strategy))



;; FUNCTION: tree-recursion
;; INPUT:
;;  - open-nodes: lista de nodos abiertos
;;  - problem: problema donde se va a buscar (estructura tipo 'problem')
;;  - strategy: estrategia de busqueda (estructura tipo 'strategy')
;;      
;; OUTPUT: Nodo meta si se ha podido llegar hasta el con la estrategia dada. NIL en caso contrario.
;;
(defun tree-recursion (open-nodes problem strategy) 
  (unless (null open-nodes) 
    (let ((nodo (first open-nodes)))
     (let ((test-objetivo (problem-fn-goal-test problem)))
      (if (funcall (fn-name test-objetivo) (node-state nodo) (fn-lst-args test-objetivo))
        nodo
        (tree-recursion (insert-nodes-strategy (rest open-nodes) (expand-node nodo problem) strategy) problem strategy))))))
    
;; Tests
(tree-search *galaxy-M35* *A-star*)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; EJERCICIO 9 ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; FUNCTION: a-star-search
;; INPUT:
;;  - problem: problema donde se va a buscar (estructura tipo 'problem') IMPORTANTE: debe tener estado inicial definido
;;      
;; OUTPUT: Nodo meta si se ha podido llegar hasta el usando la estrategia *A-star*. NIL en caso contrario.
;;
(defun a-star-search (problem)
  (tree-search problem *A-star*))

;; Tests
(a-star-search *galaxy-M35*)

;; FUNCTION: tree-path
;; INPUT: 
;;  -node: nodo hoja cuyo camino desde la raiz queremos conocer
;;      
;; OUTPUT: lista de los campos state de los nodos que conforman el camino desde la raiz hasta el nodo node.
;;
(defun tree-path (node)
  (if(null (node-parent node))
    (list (node-state node))
    (append (tree-path (node-parent node)) (list (node-state node)))))

(tree-path (a-star-search *galaxy-M35*))


;; FUNCTION: action-sequence
;; INPUT:
;;  -node: nodo cuya secuencia de acciones desde la raiz queremos conocer 
;;      
;; OUTPUT: lista de la secuencia de acciones que nos lleva desde el nodo raiz hasta el nodo node.
;;
(defun action-sequence (node)
  (if(null (node-parent (node-parent node)))
    (list (node-action node))
    (append (action-sequence (node-parent node)) (list (node-action node)))))

(action-sequence (a-star-search *galaxy-M35*))


(setf *depth-first* (make-strategy :name 'depth-first :node-compare-p 'depth-first-node-compare-p))
(setf *breadth-first* (make-strategy :name 'breadth-first :node-compare-p 'breadth-first-node-compare-p))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; CODIGO LISP PARA LAS CUESTIONES ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; FUNCTION:depth-first-node-compare-p
;; INPUT: Par de nodos cuyos campos depth se van a comparar y ordenar en orden decreciente.
;;  -node-1 
;;  -node-2
;;      
;; OUTPUT:T si node-1 tiene el campo depth mayor que node-2 
;;

(defun depth-first-node-compare-p (node-1 node-2)
  (>= (node-depth node-1) (node-depth node-2)))

;; FUNCTION:breadth-first-node-compare-p
;; INPUT: Par de nodos cuyos campos depth se van a comparar y ordenar en orden creciente.
;;  -node-1 
;;  -node-2
;;      
;; OUTPUT:T si node-1 tiene el campo depth menor que node-2 
;;

(defun breadth-first-node-compare-p (node-1 node-2)
  (<= (node-depth node-1) (node-depth node-2)))

;;Tests correspondiente al codigo que se plantea escribir en las cuestiones de la memoria
;; en relacion a busqueda-en-profundidad y busqueda-en-anchura

(tree-path (tree-search *galaxy-M35* *depth-first*))
(tree-path (tree-search *galaxy-M35* *breadth-first*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;; Tests con galaxia M36 y otras variables definidas en la cabecera ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(f-h-galaxy 'Sirtis *sensors-tests*) ;
(f-h-galaxy 'Davion *sensors-tests*) 

(navigate-white-hole 'Urano *white-holes-tests*)
(navigate-white-hole 'Proserpina *white-holes-tests*)
(navigate-worm-hole 'Katril *worm-holes-tests*)
(navigate-worm-hole 'Mallory *worm-holes-tests*)

(setf *galaxy-M36* (make-problem 
  :states *planets-tests*
  :initial-state *planet-origin*
  :fn-goal-test (make-fn :name 'f-goal-test-galaxy :lst-args *planets-destination*)
  :operators (list (make-fn :name 'navigate-white-hole :lst-args *white-holes-tests*)
               (make-fn :name 'navigate-worm-hole :lst-args *worm-holes-tests*))))

(setf node-00-tests (make-node :state 'Proserpina :depth 12 :g 10 :f 20) )

(_possible-actions node-00-tests *galaxy-M36*)

(setf lst-nodes-0-tests (expand-node node-00-tests *galaxy-M36*))

(setf *uniform-cost* (make-strategy :name 'uniform-cost :node-compare-p 'node-g-<=))
(setf node-01-tests (make-node :state 'Katril :depth 0 :g 0 :f 0) )
(setf node-02-tests (make-node :state 'Kentares :depth 2 :g 50 :f 50) )

(print (insert-nodes-strategy (list node-00-tests node-01-tests node-02-tests) lst-nodes-0-tests *uniform-cost*))

(tree-search *galaxy-M36* *A-star*)
(a-star-search *galaxy-M36*)
(tree-path (a-star-search *galaxy-M36*))
(action-sequence (a-star-search *galaxy-M36*))
(tree-path (tree-search *galaxy-M36* *depth-first*))
(tree-path (tree-search *galaxy-M36* *breadth-first*))






