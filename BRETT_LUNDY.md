# 2048 in Racket

## Brett Lundy
### April 29, 2017

# Overview
The program is designed to be silmilar to the android/iphone game 2048. The goal of the game is to make a keystroke move that will move all blocks in that direction, if there is empty space. However if there is a block with the same number value it will instead combine and add the blocks. The game goes on until the user quits or if they run out of empty space and moves to make.

**Authorship note:** All of the code described here was written by Myself(Brett Lundy) and my partner Zixin Wang, with the exception of the lookup function and the color scheme which was pulled from https://github.com/danprager/racket-2048/blob/master/2048.rkt.

# Libraries Used
The code uses two libraries:

```
(require 2htdp/universe)
(require 2htdp/image)
```

# Key Code Excerpts

Here is a discussion of the most essential procedures, including a description of how they embody ideas from 
UMass Lowell's COMP.3010 Organization of Programming languages course.

Five examples are shown and they are individually numbered. 


## 1. Generating a List
While This was a very simple task, generating and operating on lists was some of the foundation for this course. Also this one list just so happens to be the most important piece of code in the program, because this list is actually the list representation of our board and it will be the object we will be calling and working with thought the entire game.
```
;;init board with rand numbers
(define (init-board n)
    (put-rand-piece (put-rand-piece (make-list n (make-list n 0)))))
```

An example of a board object that this init function could make is as follows:
```
'((0 0 0 0) (0 0 0 0) (0 0 0 0) (0 2 0 2))
```

## 2. Abstraction
The following code is used as "material" to create a block object. The reason all of the dimensions are abstarcted away is because the user shouldn't have direct control over the board/block objects. The user should be able to influence the state of the board using keystroke movements, but they never get access to go and actually create a block/board. I didn't include the lookup function in this part of the write up because it is not fully my own.

```
;; Used for the Graphics part of the board ;;;;;;;;;;;;;;;;;;;;;
(define block-amount 4)
(define text-size 30)
(define block-side 110)
(define board-spacing 5)
(define board-side (+ (* block-amount block-side)
                       (* (add1 block-amount) board-spacing)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
```
 
## 3. Using Fold and Recursion to Obtain a Score
The code below is used to find a score for the game. It is given a list of lists of numbers and using fold sums a single list and resursivly sums each list of numbers until the null character is found. 

```
(define (get-score board)
  (if (null? board) 0
      (+ (foldr (lambda (x sum) (+ x sum)) 0 (car board)) (get-score (cdr board)))))
```

## 4. Use of Let/Map
This function was written by both myself and Zixin I included it bcause I like the use of let in this function that sets the image for the board to be printed to the scene. Also Map was used to apply the make-complete-block(see excerpt #2) function to our board list. 

```
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
```
