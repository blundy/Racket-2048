# Racket-2048

### Statement
2048 is a game that involves a block of 16 slots that the user must find some way to move that will result in blocks with the same value being added together. Each legal move the player makes will also result in a new block taking up the space of a blank spot and if all 16 slots are full and no legal moves can be made the player loses. When the blocks are added together they are combined, reducing the number of blocks by one. The game is not meant to be "won" but to last longer and to improve your high score.
 
### Analysis
- Will you use data abstraction? How?

The whole game is abstracted away. The user shouldn't have access to anything that could potentially change anything within the game. 
- Will you use recursion? How? 

One of the places we used resursion is with the score. it uses a function that uses fold on the car of a given list of lists, and then sums the remainder of the list through resursion.
- Will you use map/filter/reduce? How?

We used filter in one of our move functions and we used foldr for the score.
- Will you use object-orientation? How?

The only thing we used that may count as object orientation would be our game-board-app, since it holds a board object and makes changes to it.
- Will you use functional approaches to processing your data? How?

It its unclear.
- Will you use state-modification approaches? How? (If so, this should be encapsulated within objects. `set!` pretty much should only exist inside an object.)

We did not use state-modification.
- Will you build an expression evaluator, like we did in the symbolic differentatior and the metacircular evaluator?

No we did not.
- Will you use lazy evaluation approaches?

We did not.

### External Technologies
The only thing that may classify as External Technologies is that we may impliment sound effects for when the blocks combine during the final week.

### Data Sets or other Source Materials
The only Data sets or other Source Material we may use would be for the background music, and thats only if time permits us to add background music. 

### Deliverable and Demonstration
We completed a fully playable game. It will is interactable and relies on a human player to actually perform. Start of the game involves two blocks randomly being added to the board and the user has free rein from there to move the blocks. 

### Evaluation of Results
The game runs and we have yet to find a way to make it crash. The only thing let is to decide if we want to implement sound effects and background music.

## Architecture Diagram
![Architecture_Diagram](/2048-diagram.png?raw=true "Architecture Diagram")

Brett worked on the block objects and Zixin wrote the code for the handling the block objects i.e. combining and moving. The two parts were added together and the game board starts when the user gives it the command to. The game and the board updates to reflect what the user inputed. 

## Schedule

### First Milestone (Sun Apr 9)
We got the Title Screen and Help/Info Screen done, and have the list of list of numbers for the board.

### Second Milestone (Sun Apr 16)
For this milestone we got the random function for the board list done, the random function to place the random number onto the board list done and the board drawn. 

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])
For the last milestone we got the handler for the move/combine function and the score handler done.Error/bug checking is also what we spent the remaining time on. If time permits I(Brett Lundy) would like to try to add background music and sound effects for the final turn in.

## Group Responsibilities

### Brett Lundy @blundy
- [X] create the title screen
- [X] create the help/info screen
- [X] create the game screen
- [X] display current score
- [X] write the code for the block objects

### Zixin Wang @iris-w
- [X] write the code for the block objects
- [X] handle how the blocks combine
- [X] handle how the blocks move
- [X] write code for the keyboard events

### The Group
- [X] fix minor bugs
- [X] aesthetics
