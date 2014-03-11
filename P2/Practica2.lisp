;;; Ignore ;;%%
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

(setf *planets-destination* '(Sirtis))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem definition
;;
(defstruct problem
    states             ; List of states
    initial-state     ; Initial state
    fn-goal-test     ; Function (in fn format) that determines; whether a state fulfills the goal
    fn-h             ; Function (in fn format) that evaluates; to the value of the heuristic of a state
    operators)         ; list of operators (in fn format); to generate succesors
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
    name             ; Name of the search strategy
    node-compare-p) ; boolean comparison
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; fn format for functions
;;

(defstruct fn
    name         ; Function name
    lst-args)     ; List of additional arguments
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;UNA VEZ DEFINIDAS LAS ESTRUCTURAS VAMOS CON LAS FUNCIONES:

;;%%


;;;;
;; Comprueba que si planeta pasado como argumento es una meta.
;;
;; IN:     state: planeta actual
;;         planets-destination: lista de planetas de destino
;; OUT: T si el planeta actual es una meta.
;; 
;; pseudocode
;; comprobar si state está en planets-destination

(defun fn-f-goal-test-galaxy (lst-args)
    (f-goal-test-galaxy (car lst-args) (cdr lst-args)))

(defun f-goal-test-galaxy (state planets-destination) 
  (not (null (member state planets-destination))))

;; Examples

(f-goal-test-galaxy 'Sirtis '(Sirtis)) ;-> T 
(f-goal-test-galaxy 'Avalon '(Sirtis)) ;-> NIL 
(f-goal-test-galaxy 'Urano '(Sirtis)) ;-> NIL
(f-goal-test-galaxy 'Urano '()) ;-> NIL

;; end


;;;;
;; Devuelve el valor de la heurística en el planeta actual.
;; 
;; IN:     state: planeta actual
;;         sensors: lista de tuplas planeta-heurística
;; OUT: valor de la heurística en el planeta actual
;;
;; pseudocode

(defun f-h-galaxy (state sensors)
  (if (null sensors)
      nil
      (let ((sensor (first sensors)))
        (if (equal state (car sensor))
            (cadr sensor)
            (f-h-galaxy state (rest sensors))))))

;; Examples

(f-h-galaxy 'Sirtis *sensors*) ;-> 0
(f-h-galaxy 'Avalon *sensors*) ;-> 5

;; end


;;;;
;; Función genérica para crear las acciones a partir de una lista de rutas
;;
;; IN:    state: planeta actual
;;        routes: lista de rutas
;;         is-route-func: función que decide si una ruta parte del planeta destino
;;        get-dest-func: función que devuelve el destino a partir del triplete
;;        name: nombre de la función que genera las rutas
;; OUT:    Lista con las acciones correspondientes a las rutas posibles.
;; 
;; pseudocode
;; por cada ruta en (filtrar routes con is-route-func):
;;     crear nueva acción con:
;;        nombre: name
;;        origen: state
;;        final: (get-dest-func ruta)
;;        coste: ruta[3]
;;

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

;; Examples

(navigate-worm-hole 'Katril *worm-holes*)

;; (#S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN KATRIL :FINAL DAVION :COST 1)
;;  #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN KATRIL :FINAL MALLORY :COST 5)
;;  #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN KATRIL :FINAL SIRTIS :COST 10))

(navigate-white-hole 'Kentares *white-holes*)

;; (#S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN KENTARES :FINAL AVALON :COST 3)
;;  #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN KENTARES :FINAL KATRIL :COST 2)
;;  #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN KENTARES :FINAL PROSERPINA :COST 2))

(navigate-worm-hole 'Kentares *worm-holes*)

;; (#S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN KENTARES :FINAL AVALON :COST 4)
;;  #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN KENTARES :FINAL PROSERPINA :COST 1))

;; end

;;; Ignore ;;%%

(setf *uniform-cost*
    (make-strategy
        :name 'uniform-cost
        :node-compare-p 'node-g-<=))

(defun node-g-<= (node-1 node-2)
    (<= (node-g node-1)    (node-g node-2)))


;; end


;;%%

;;;;
;; Estrategia A*
;;
;; IN:     node-1 y node-2 a comparar.
;;     
;; OUT: 
;; 
;; pseudocode
;;     Comparamos los valores de la f de cada nodo

(setf *A-star*
    (make-strategy 
        :name 'A-star
        :node-compare-p 'node-f-compare))

(defun node-f-compare (node-1 node-2)
    (<= (node-f node-1) (node-f node-2)))

;; Examples

;; end


;;;;
;; Ejercicio 5
;; IN:
;; OUT:

(setf *galaxy-M35*
    (make-problem
        :states *planets*
        :initial-state 'PROSERPINA
        :fn-goal-test (make-fn
                :name 'fn-f-goal-test-galaxy
                :lst-args *planets-destination*)
        :fn-h (make-fn
                :name 'f-h-galaxy
                :lst-args *sensors*)
        :operators (list
                    (make-fn
                        :name 'navigate-worm-hole 
                        :lst-args *worm-holes*)
                    (make-fn
                        :name 'navigate-white-hole
                        :lst-args *white-holes*))))

;; Examples

;; end

;;; Ignore ;;%%
(setf *node-00*
    (make-node
        :state 'Proserpina 
        :depth 12 
        :g 10 
        :f 20))

(setf *node-08*
    (make-node
        :state 'Proserpina 
        :depth 12 
        :g 10 
        :f 20))

(defun fncall (f &rest args)
  (funcall (fn-name f) (append args (fn-lst-args f))))


;;%%

;;;; 
;; Expande el nodo dado. Para ello buscaremos en las estructuras de problem 
;; la información sobre a qué planetas podemos viajar (qué nodos son los sucesores) 
;; y crearemos una estructura nodo para cada sucesor con toda la información necesaria.  No comprobamos si el nodo es solución (que es lo primero antes de expandir nodo).
;; Dejamos esa comprrobación para la tarea superior.
;;
;; IN:     node: el nodo a expandir
;;        problem: estructura con toda la información necesaria
;; OUT: lista de los nodos hijos
;; pseudocode:
;; Iterar atomo en planetas_destino
;;     make-nodo (node,atomo)
;;

(defun expand-node (nodeArg problem)
    (let ((lst
            (mapcan
                #'(lambda(x)  
                    (funcall 
                        (fn-name x) (node-state nodeArg) (fn-lst-args x))) 
                (problem-operators problem))))
            (mapcar #'(lambda(x) 
                (let (
                    (g (+ (action-cost x) (node-g nodeArg)))
                    (h (funcall 
                            (fn-name (problem-fn-h problem)) 
                            (action-final x) 
                            ( fn-lst-args (problem-fn-h problem)))))
                        (make-node
                            :state (action-final x)
                            :parent nodeArg
                            :action x
                            :depth (+ 1 (node-depth nodeArg))
                            :g g
                            :h h
                            :f (+ g h)))) lst)))

;; Examples
(setf *lst-nodes-0*
    (expand-node *node-00* *galaxy-M35*))

;; (#S(NODE :STATE MALLORY
;;  :PARENT  #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;;  :ACTION  #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN PROSERPINA :FINAL MALLORY :COST 6)
;;  :DEPTH 13 :G 16 :H 7 :F 23)
;; #S(NODE :STATE SIRTIS
;;  :PARENT  #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;;  :ACTION  #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN PROSERPINA :FINAL SIRTIS :COST 7)
;;  :DEPTH 13 :G 17 :H 0 :F 17)
;; #S(NODE :STATE KENTARES
;;  :PARENT  #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;;  :ACTION  #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN PROSERPINA :FINAL KENTARES :COST 1)
;;  :DEPTH 13 :G 11 :H 4 :F 15)
;; #S(NODE :STATE MALLORY
;;  :PARENT  #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;;  :ACTION  #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN PROSERPINA :FINAL MALLORY :COST 7)
;;  :DEPTH 13 :G 17 :H 7 :F 24)
;; #S(NODE :STATE AVALON
;;  :PARENT  #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;;  :ACTION  #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN PROSERPINA :FINAL AVALON :COST 2)
;;  :DEPTH 13 :G 12 :H 5 :F 17)
;; #S(NODE :STATE DAVION
;;  :PARENT  #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;;  :ACTION  #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN PROSERPINA :FINAL DAVION :COST 4)
;;  :DEPTH 13 :G 14 :H 1 :F 15)
;; #S(NODE :STATE SIRTIS
;;  :PARENT  #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;;  :ACTION  #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN PROSERPINA :FINAL SIRTIS :COST 10)
;;  :DEPTH 13 :G 20 :H 0 :F 20))


;; end


;;; Ignore ;;%%
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


;;%%

;;;;
;; Inserta una lista de nodos en otra (ya ordenada) de acuerdo con una estrategia.
;;
;; IN:     nodes: lista de nodos para insertar.
;;        lst-nodes:    lista de nodos en la que insertar.
;;        strategy:    estrategia que seguir a la hora de insertar.
;; OUT:    una lista de nodos ordenados de acuerdo a la estrategia.
;;
;; pseudocode:
;;    insert-nodes(nodes lst strategy)
;;        iterar at1 en nodes
;;            iterar at2 en lst
;;                si ato1 < at2
;;                    insertar ato1 y desplazar el resto
;;
;;
;; Opción b (que encontramos mejor,
;; porque modificar una lista sobre la que estamos iterando es peligroso):
;;
;;
;;    insert-nodes(nodes lst strategy acc)
;;        iterar at1 en nodes
;;            iterar at2 en lst
;;                si ato1 < at2
;;                    insertar ato1 en acc
;;                    insert-nodes 
;;                          (rest(nodes) lst-nodes strategy acc)
;;                sino
;;                    insertar ato2 en acc
;;                    insertar-nodes (nodes rest(lst-nodes) strategy acc)

(defun _aux-insert-nodes (nodes lst-nodes acc strategy)
    (if (null nodes)
        (append acc lst-nodes)
        (if (null lst-nodes)
            (append acc nodes)
            (if  (funcall (strategy-node-compare-p strategy) (car nodes) (car lst-nodes))

                (_aux-insert-nodes 
                    (cdr nodes)
                    lst-nodes
                    (append acc (list (car nodes)))
                    strategy)
                (_aux-insert-nodes
                    nodes
                    (cdr lst-nodes)
                    (append acc (list (car lst-nodes)))
                    strategy)))))

(defun insert-nodes (nodes lst-nodes strategy)
    (_aux-insert-nodes nodes lst-nodes '() strategy))

;; Examples
(insert-nodes 
    (list *node-00* *node-01* *node-02*) 
    (insert-nodes 
        (list *node-00* *node-01* *node-02*) 
        *lst-nodes-0*
        *uniform-cost*)
    *uniform-cost*)

;;(#S(NODE :STATE PROSERPINA 
;;  :PARENT NIL
;;  :ACTION NIL
;;  :DEPTH 12 :G 10 :H NIL :F 20)
;; #S(NODE :STATE AVALON 
;;  :PARENT NIL
;;  :ACTION NIL
;;  :DEPTH 0 :G 0 :H NIL :F 0)
;; #S(NODE :STATE MALLORY
;;  :PARENT #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;;  :ACTION #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN PROSERPINA :FINAL MALLORY :COST 6)
;;  :DEPTH 13 :G 16 :H 7 :F 23)
;; #S(NODE :STATE SIRTIS
;;  :PARENT #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;;  :ACTION #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN PROSERPINA :FINAL SIRTIS :COST 7)
;;  :DEPTH 13 :G 17 :H 0 :F 17)
;; #S(NODE :STATE KENTARES
;;  :PARENT #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;;  :ACTION #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN PROSERPINA :FINAL KENTARES :COST 1)
;;  :DEPTH 13 :G 11 :H 4 :F 15)
;; #S(NODE :STATE MALLORY
;;  :PARENT #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;;  :ACTION #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN PROSERPINA :FINAL MALLORY :COST 7)
;;  :DEPTH 13 :G 17 :H 7 :F 24)
;; #S(NODE :STATE AVALON
;;  :PARENT #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;;  :ACTION #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN PROSERPINA :FINAL AVALON :COST 2)
;;  :DEPTH 13 :G 12 :H 5 :F 17)
;; #S(NODE :STATE DAVION
;;  :PARENT #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;;  :ACTION #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN PROSERPINA :FINAL DAVION :COST 4)
;;  :DEPTH 13 :G 14 :H 1 :F 15)
;; #S(NODE :STATE SIRTIS
;;  :PARENT #S(NODE :STATE PROSERPINA :PARENT NIL :ACTION NIL :DEPTH 12 :G 10 :H NIL :F 20)
;;  :ACTION #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN PROSERPINA :FINAL SIRTIS :COST 10)
;;  :DEPTH 13 :G 20 :H 0 :F 20)
;; #S(NODE :STATE KENTARES :PARENT NIL :ACTION NIL :DEPTH 2 :G 50 :H NIL :F 50))


;; end


;;;;
;; Realiza la búsqueda en un problema según una estrategia
;;
;;    IN: problem     estructura con la información del problema.
;;        strategy     estrategia a seguir para la búsqueda.
;;    OUT: Evalúa a un único nodo meta o nil si no hay solución.
;;
;;    Utilizamos una auxiliar recursiva con la lista de nodos.
;;
;;    pseudocode:
;;
;;    aux_fun(problema estrategia lista_nodos)
;;        si lista_nodos no está vacía
;;            si ( es_solución first lista_nodos)
;;                first lista_nodos
;;            sino
;;                nueva_lista_nodos = insertar
;;                          (lista_nodos (expandir_nodo first lista_nodos) estrategia)
;;                aux_fun (problema estrategia nueva_lista_nodos)
;;    

(defun tree-search-aux (problem strategy open-nodes)
    (let ((n (first open-nodes)))
        (if ( or (null open-nodes) (null n))
            nil
            (if  (fncall (problem-fn-goal-test problem) (node-state n))
              n
              (tree-search-aux problem strategy  
                    (insert-nodes 
                        (cdr open-nodes)
                        (expand-node n problem)
                        strategy))))))

(defun tree-search (problem strategy)
  (tree-search-aux problem strategy (list (make-node
                                          :state (problem-initial-state problem)
                                          :depth 0
                                          :g 0
                                          :f 0))))

;; Examples
(tree-search *galaxy-M35* *A-STAR*)

;;#S(NODE :STATE SIRTIS
;;   :PARENT
;;   #S(NODE :STATE DAVION
;;      :PARENT
;;      #S(NODE :STATE KATRIL
;;         :PARENT
;;         #S(NODE :STATE KENTARES
;;            :PARENT
;;            #S(NODE :STATE AVALON :PARENT NIL :ACTION NIL :DEPTH 0 :G 0 :H NIL
;;               :F 0)
;;            :ACTION
;;            #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN AVALON :FINAL KENTARES
;;               :COST 4)
;;            :DEPTH 1 :G 4 :H 4 :F 8)
;;         :ACTION
;;         #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN KENTARES :FINAL KATRIL
;;            :COST 2)
;;         :DEPTH 2 :G 6 :H 3 :F 9)
;;      :ACTION
;;      #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN KATRIL :FINAL DAVION :COST 1)
;;      :DEPTH 3 :G 7 :H 1 :F 8)
;;   :ACTION
;;   #S(ACTION :NAME NAVIGATE-W

;; end


;;; Ignore ;;%%
; Realiza la búsqueda A* para el problema dado
; Evalúa:
;    Si no hay solución: NIL
; Si hay solución: el nodo correspondiente al estado-objetivo ;

;(a-star-search *galaxy-M35*
;               (tree-search *galaxy-M35* *A-star*));->
;
; #S(NODE :STATE SIRTIS
; :PARENT
;         #S(NODE :STATE ...


;; end

;;%%

;;;;
;;    Devuelve el camino a recorrer para llegar desde un nodo origen. En la lista devuelta, el primer elemento es el destino, y el último el origen.
;;    a un estado meta (por defecto también del problema *galaxy-m35*)
;; 
;;    IN:node: nodo del que iniciar la búsqueda
;;    OUT: Una lista de los nombres de los planetas que forman el camino
;;
;;    pseudocode:
;;    Utilizando una función auxiliar de la forma:
;;    aux_fun (nodo acumulador)
;;        si (nodo no es nulo)
;;            añadir el nodo al acumulador
;;            aux_fun(padre(nodo) acumulador)
;;        sino
;;            devolver acumulador.
;;

(defun get-states (node acc)
    (if (null node)
        acc
        (get-states (node-parent node) (append acc (list (node-state node))))))

(defun tree-path (node)
    (get-states (tree-search-aux *galaxy-M35* *A-star* (list node)) ()))

;; Examples 

(tree-path *node-01*)

;;(SIRTIS DAVION KATRIL KENTARES AVALON)

;; end



;;;;
;; Obtención de la secuencia de acciones de un camino, desde un nodo origen hasta un nodo meta
;;     (definido por *galaxy-M35*, según la estrategia *A-star*)
;; 
;; IN:  node: nodo origen desde el que empezar la búsqueda.
;;
;; OUT: una lista de acciones que llevan desde el nodo origen hasta el destino.
;;
;; pseudocode:
;; Utilizando una función auxiliar de la forma:
;; aux_fun (nodo acumulador)
;;        si (nodo no es nulo)
;;            añadir acción(nodo) al acumulador
;;            aux_fun(padre(nodo) acumulador)
;;        sino
;;            devolver acumulador

(defun  _aux_action-sequence (node acc)
    (if (null (node-action node))
        acc
        (_aux_action-sequence (node-parent node) (append acc (list (node-action node))))))

(defun  action-sequence (node)
    (_aux_action-sequence (tree-search-aux *galaxy-M35* *A-star* (list node)) ()))

;; Examples

(action-sequence *node-01*)

;; (#S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN DAVION :FINAL SIRTIS :COST 8)
;;  #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN KATRIL :FINAL DAVION :COST 1)
;;  #S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN KENTARES :FINAL KATRIL :COST 2)
;;  #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN AVALON :FINAL KENTARES :COST 4))

;; end


;;; Ignore ;;%%

(setf *depth-first*
    (make-strategy
        :name 'depth-first
        :node-compare-p 'depth-first-node-compare-p))

(defun depth-first-node-compare-p (node-1 node-2)
    (>= (node-depth node-1) (node-depth node-2)))

(tree-path (tree-search *galaxy-M35* *depth-first*))


(setf *breadth-first*
    (make-strategy
        :name 'breadth-first
        :node-compare-p 'breadth-first-node-compare-p))

(defun breadth-first-node-compare-p (node-1 node-2)
    (<= (node-depth node-1) (node-depth node-2)))

(tree-path (tree-search *galaxy-M35* *breadth-first*))

;;%%