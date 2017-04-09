#lang racket

(require 2htdp/universe)
(require 2htdp/image)

(define rand-dice '(2 2 2 2 2 2 2 2 2 4))

(define (init-board n)
  (make-list n (make-list n 0)))

(define board (init-board 4)) ;;make an empty board 4x4