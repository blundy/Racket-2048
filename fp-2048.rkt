#lang racket

(require 2htdp/universe)
(require 2htdp/image)

;;rand-list 2:4 == 9:1
(define rand-dice '(2 2 2 2 2 2 2 2 2 4))

;;init board with all 0s
(define (init-board n)
  (make-list n (make-list n 0)))
  
;; get random piece from rand-dice list
(define (choice ls)
  (if (list? ls) (list-ref ls (random (length ls)))
    (vector-ref ls (random (vector-length ls)))))

(define (get-piece)
    (choice rand-dice))
    
;; see if the place is able to put new number
(define (able? lst)
    (if (list? lst)
        (ormap able? lst)
        (zero? lst)))
        
(define (get-empty lst zero-fun?)
    (for/list ([item lst]
               [i (range (length lst))]
               #:when (zero-fun? item))
      i))
(define (put-rand-piece lst)
    (if (able? lst)
        (if (list? lst)
            (let* ([i (choice (get-empty lst able?))]
                   [v (list-ref lst i)])
              (append (take lst i)
                      (cons (put-rand-piece v) (drop lst (add1 i)))))
            (get-piece))
        lst))

;;make an empty board 4x4
(define board (init-board 4)) 
