# 2048 in Racket

## Zixin Wang

### May 4th, 2017

# Overview

The program is designed to be silmilar with the javascript game 2048. The goal of the game is to make a keystroke move that will move all blocks in that direction, if there is empty space. However if there is a block with the same number value it will instead combine and add the blocks. The game goes on until the user quits or if they run out of empty space and moves to make.

**Authorship note:** All of the code described here was written by myself.

# Libraries Used

The code uses following libraries:

(require 2htdp/universe)
(require 2htdp/image)

The universe library is mainly used for big-bang function thatcould reflect on keyboard event.
The image library is mainly used for creating tiles that needed in the game.

# Key Code Excerpts

Here is a discussion of the most essential procedures, including a description of how they embody ideas from UMass Lowell's COMP.3010 Organization of Programming languages course.

Five examples are shown and they are individually numbered.

## 1. Creating a Game Board

Since we leant list as one of the essential part of our class, I used a list of list as the data structure of the game board. When each time there's a keyboard event happens, we will go through the whole list with recursion to see the status of each elemt in every list.

```
;;rand-list 2:4 == 9:1
(define rand-dice '(2 2 2 2 2 2 2 2 2 4))

;;init board with rand number
(define (init-board n)
    (put-rand-piece (put-rand-piece (make-list n (make-list n 0)))))
```

## 2. Merging

One of the key feature of 2048 is merging numbers together, I use recursion on merge function since my object "board" is a list of list. The merge function will go through each element in a single list and see if the element next to each other is same, if so it will "combine" them, else it will leave it like what it was.
However,since I use "first" and "second" as elemts to compare, this function will aways start dealing with the elements from the first element of the list, and it cause a bug when keyboard event is right. The combine always start at left most number. I realise this problem when I finish the whole project.

```
(define (merge num)
    (cond [(<= (length num) 1) num]
          [(= (first num) (second num))
           (cons (* 2 (first num)) (merge (drop num 2)))]
          [else (cons (first num) (merge (rest num)))]))
```

## 3. Ignoring 0s
Considering we use 0 as empty block, if the list has (4 0 4 2), we need to ignore the 0 and combine 4s together, so I made another function `move-r(move -row)`

I use filter that we learnt in class so that merge function can ignore 0 when merging numbers, then after merging, we need to put all 0s back to where is empty. I use `let*` to create 3 local veriables that we will use for re-building the list. els = n - ls. ls will be the list merging with 0 ignored, els will be a list of (n - lenth of ls) 0s to fill the complete list. left? is a boolean depends on user-action for decising how the list after merge will be like.
In move, the map is for apply move-r function to the entire object.

```
(define (move-r num v left?)
    (let* ([n (length num)]
           [ls (merge (filter (lambda (x) (not (zero? x))) num))]
           [els (make-list (- n (length ls)) v)])
      (if left?
          (append ls els)
          (append els ls))))

(define (move lst v left?)
    (map (lambda (x) (move-r x v left?)) lst))
```

## 4. Moving on 4 directions
Function `move-left` and `move-right` are simple, it basically just merge the list first and then put random piece. However things are different in up and down. Function trans is for reorgnasing the whole list that can apply to move-left/right algorithm. I use apply before map ao that the board object of list will be expanded as 4 lists but not one list of lists. After re-buliding by trans first time now the nth horizonal line becomes the nth row, then depends on user-action, move the re-built board left(for up) or right (for down), then trans the board again to make corresponding row to line.
compose1 is for taking all those functions into an ordered function-chain (start from the most right).

```
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
```
