#lang racket
(require 2htdp/universe)
(require 2htdp/image)

;; Set home scrren
(define (home-screen x)
  (underlay/xy (bitmap "2048-icon.png")
              100
              350
              (text/font "Press i for the info screen" 30 "black"
                         #f 'roman 'normal 'bold #f)))

;; Set info screen
(define (info-screen x)
  (underlay/xy
   (underlay/xy
    (underlay/xy
     (underlay/xy
      (underlay/xy (bitmap "2048-icon.png")
                   150
                   0
                   (text/font "INFO SCREEN" 30 "black"
                              #f 'roman 'normal 'bold #f))
      0
      50
      (text/font "~ Use the arrow keys to move the blocks." 17 "black"
                 #f 'roman 'normal 'bold #f))
     0
     75
     (text/font "~ Moving blocks with similar vaules into eachother combines them." 17 "black"
                #f 'roman 'normal 'bold #f))
    0
    100
    (text/font "~ Each move will add one block to the board." 17 "black"
               #f 'roman 'normal 'bold #f))
   0
   125
   (text/font "~ If you run out of space and can't make any moves, you lose." 17 "black"
              #f 'roman 'normal 'bold #f)))
 
;; Sets key for the info screen
(define info-key "i")

;; Sets the key handler for the main page (may make one specificly for all three pages)
;;   Info window doesn't need a key-handler, at least not right now.
(define (key-event-handler x key)
  (cond
    ((key=? key info-key) (info-page 'true))
    (else x)))

;; Info window
(define (info-page x)
  (if (equal? x 'true)
      (big-bang 0
                (to-draw info-screen))
      x))

;; Home window
(big-bang 0
          (on-key key-event-handler)
          (to-draw home-screen))