#lang racket

(require 2htdp/universe)
(require 2htdp/image)

(define rand-dice '(2 2 2 2 2 2 2 2 2 4))

(define (init-board n)
  (make-list n (make-list n 0)))
  
(define (choice ls)
  (if (list? ls) (list-ref ls (random (length ls)))
    (vector-ref ls (random (vector-length ls)))))
    
(define (get-piece)
    (choice rand-dice))

(define board (init-board 4)) ;;make an empty board 4x4
