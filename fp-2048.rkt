#lang racket

(require 2htdp/universe)
(require 2htdp/image)

;; Usedfor the Graphics part of the board ;;;;;;;;;;;;;;;;;;;;;
(define block-amount 4)
(define text-size 20)
(define block-side 50)
(define board-spacing 5)
(define board-side (+ (* block-amount block-side)
                       (* (add1 block-amount) board-spacing)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;; GRAPHICS SECITON FOR THE BOARD;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Color scheme 
;;
;; From https://github.com/danprager/racket-2048/blob/master/2048.rkt
;; Originally From https://github.com/gabrielecirulli/2048/blob/master/style/main.css
;;
(define board-color (color #xbb #xad #xa0))
(define *default-tile-bg-color* (color #x3c #x3a #x32))
(define *default-tile-fg-color* 'white)
(define *tile-bg-colors*
  (map (lambda (x)
         (match-define (list n r g b) x)
         (list n (color r g b)))
       '((0 #xcc #xc0 #xb3)
         (2 #xee #xe4 #xda)
         (4 #xed #xe0 #xc8)
         (8 #xf2 #xb1 #x79)
         (16 #xf5 #x95 #x63)
         (32 #xf6 #x7c #x5f)
         (64 #xf6 #x5e #x3b)
         (128 #xed #xcf #x72)
         (256 #xed #xcc #x61)
         (512 #xed #xc8 #x50)
         (1024 #xed #xc5 #x3f)
         (2048 #xed #xc2 #x2e))))

(define *tile-fg-colors*
  '((0 dimgray)
    (2 dimgray)
    (4 dimgray)
    (8 white)
    (16 white)
    (32 white)
    (64 white)
    (128 white)
    (256 white)
    (512 white)
    (1024 white)
    (2048 white)))

;; Used to look up from "table"
(define (lookup key lst default)
  (let ([value (assoc key lst)])
    (if value (second value) default)))

;; Makes a regular block with no text in it
(define (make-block n)
    (square block-side 
          'solid 
          (lookup n *tile-bg-colors* *default-tile-bg-color*)))

;; Makes the text for the block 
(define (make-block-text n)
   (text (if (equal? n 0) "" (number->string n))
                  text-size
                  (lookup n *tile-fg-colors* *default-tile-fg-color*)))

;; Overlays the blocks text onto the block
(define (make-complete-block n)
  (overlay
   (make-block-text n)
   (make-block n)))

;; Makes a list of blocks given a list of block values
(define (make-block-list init lst accum)
  (cond ((null? lst) init) 
        ((not (pair? lst)) (make-complete-block lst)) 
        (else (accum  
               (make-block-list init (car lst) accum) 
               (make-block-list init (cdr lst) accum)))))

;; Makes a grid of blocks given a block image list
(define (make-grid-of-blocks init lst x y)
  (cond ((null? lst) init) 
        ((not (pair? lst)) lst) 
        (else (overlay/xy
               (make-grid-of-blocks init (car lst) 0 (+ y 55))
               x y
               (make-grid-of-blocks init (cdr lst) x y)))))

;; empty block list 
(define starting-block-list (make-block-list '() board cons))

;; Makes the board that will contain nothing
(define make-empty-board
  (square board-side 'solid board-color))

;; Makes the starting board that will contain an empty grid
;; The reason I made a "starting board" is to have a base for when we
;;    add a reset button we can just always have a empty grid ready
(define make-starting-board
  (overlay/xy
   (make-grid-of-blocks (square 0 'solid "black") starting-block-list 55 0)
   -5 -5
   make-empty-board))
;; END OF GRPAHICS SECTION;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
