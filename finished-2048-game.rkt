#lang racket

(require 2htdp/universe)
(require 2htdp/image)

;; Usedfor the Graphics part of the board ;;;;;;;;;;;;;;;;;;;;;
(define block-amount 4)
(define text-size 30)
(define block-side 110)
(define board-spacing 5)
(define board-side (+ (* block-amount block-side)
                       (* (add1 block-amount) board-spacing)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;rand-list 2:4 == 9:1
(define rand-dice '(2 2 2 2 2 2 2 2 2 4))

;;init board with rand numbers
(define (init-board n)
    (put-rand-piece (put-rand-piece (make-list n (make-list n 0)))))
  
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

;; merge numbers
(define (merge num)
    (cond [(<= (length num) 1) num]
          [(= (first num) (second num))
           (cons (* 2 (first num)) (merge (drop num 2)))]
          [else (cons (first num) (merge (rest num)))]))

(define (move-r num v left?)
    (let* ([n (length num)]
           [ls (merge (filter (lambda (x) (not (zero? x))) num))]
           [els (make-list (- n (length ls)) v)])
      (if left?
          (append ls els)
          (append els ls))))

(define (move lst v left?)
    (map (lambda (x) (move-r x v left?)) lst))

;; move-functions
(define (move-left lst)
    (put-rand-piece (move lst 0 #t)))
(define (move-right lst)
    (put-rand-piece (move lst 0 #f)))
(define (trans lsts)
    (apply map list lsts))
(define (move-up lst)
    ((compose1 trans move-left trans) lst))
(define (move-down lst)
    ((compose1 trans move-right trans) lst))

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

;; END OF GRPAHICS SECTION;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; append function for images made
(define (append-image image position overlap)
    (if (<= (length image) 1)
        (car image)
        (let* ([a (first image)]
               [b (second image)]
               [img (apply overlay/xy
                           (append (list a) (position a overlap) (list b)))])
          (append-image (cons img (drop image 2)) position overlap))))

(define (append-horizontal image [overlap 0])
    (append-image image
                  (lambda (img obj) (list (- (image-width img) obj) 0))
                  overlap))

(define (append-vertical image [overlap 0])
    (append-image image
                  (lambda (img obj) (list 0 (- (image-height img) obj)))
                  overlap))

;; check if the game should finish
(define all-direct (list move-right move-down move-left move-up))

(define (finished? lst)
    (andmap (lambda (direction) (equal? lst (direction lst))) all-direct))

;; key reflection
(define (key->ops pressed)
    (cond
      [(key=? pressed "left")  move-left]
      [(key=? pressed "right") move-right]
      [(key=? pressed "up")    move-up]
      [(key=? pressed "down")  move-down]
      [else (lambda (x) x)]))

(define (get-score board)
  (if (null? board) 0
      (+ (foldr (lambda (x sum) (+ x sum)) 0 (car board)) (get-score (cdr board)))))

;; game board in image
(define (game-board-app board)
  (underlay/xy 
   (underlay/xy 
    (underlay/xy (square 512 'solid "white")
                 52 52
                 (let ([image (for/list ([ln board])
                                (append-horizontal (map make-complete-block ln) -5))])
                   (append-vertical image -5)))
    52 22
    (text/font "Score: " 30 "black"
               #f 'roman 'normal 'bold #f))
   150 22
   (text/font (number->string (get-score board)) 30 "black"
               #f 'roman 'normal 'bold #f)))

;; game-over overlay
(define (game-over board)
    (let* ([game-board (game-board-app board)]
           [layer (square (image-width game-board) 'solid *default-tile-bg-color*)])
      (overlay (text "Game Over!" 40 *default-tile-fg-color*) layer)))

;; user pressed key / making action
(define (user-action board key)
    ((key->ops key) board))

;; Set home scrren
(define (home-screen x)
  (underlay/xy (bitmap "2048-icon.png")
              75
              350
              (text/font "Press i for info and p to play" 30 "black"
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
(define play-key "p")

;; Sets the key handler for the main page (may make one specificly for all three pages)
;;   Info window doesn't need a key-handler, at least not right now.
(define (key-event-handler x key)
  (cond
    ((key=? key info-key) (info-page 'true))
    ((key=? key play-key) (game-start 4))
    (else x)))

 ;;game start function
(define (game-start n)
    (big-bang (init-board n)
              (to-draw game-board-app)
              (on-key user-action)
              (stop-when finished? game-over)
              (name "2048-racket")))

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
