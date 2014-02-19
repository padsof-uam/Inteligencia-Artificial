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
name ; Name of the search strategy
node-compare-p ; boolean comparison
)
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





(defun f-goal-test-galaxy (state planets-destination) ...)

(f-goal-test-galaxy 'Sirtis *planets-destination*) ;-> T
(f-goal-test-galaxy 'Avalon *planets-destination*) ;-> NIL
(f-goal-test-galaxy 'Urano *planets-destination*) ;-> NIL
