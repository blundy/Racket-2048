# Racket-2048

### Statement
2048 is a game that involves a block of 16 slots that the user must find some way to move that will result in blocks with the same value being added together. Each legal move the player makes will also result in a new block taking up the space of a blank spot and if all 16 slots are full and no legal moves can be made the player loses. When the blocks are added together they are combined, reducing the number of blocks by one. The game is not meant to be "won" but to last longer and to improve your high score.
 
### Analysis
- Will you use data abstraction? How?

The whole game should be abstracted away. The user shouldn't have access to anything that could potentially change anything within the game. 
- Will you use recursion? How? 

If there is any recursion then it will most likely be in drawing the images to the board each time the player makes a move.
- Will you use map/filter/reduce? How?

I donot beleive there will be any use of map/filter/reduse.
- Will you use object-orientation? How?

I intend to make the blocks into objects that hold a few pieces of data.
- Will you use functional approaches to processing your data? How?

We are uncertain at this time if we will use any functional approaches to process our data.
- Will you use state-modification approaches? How? (If so, this should be encapsulated within objects. `set!` pretty much should only exist inside an object.)

The block objects and the board will use state-modification, for the data in the block objects and the condition of the board.
- Will you build an expression evaluator, like we did in the symbolic differentatior and the metacircular evaluator?

No we will not.
- Will you use lazy evaluation approaches?

I do not believe so.

### External Technologies
The only thing that may classify as External Technologies is that we will be using sound effects for when the blocks combine.

### Data Sets or other Source Materials
The only Data sets or other Source Material we may use would be for the background music, and thats only if time permits us to add background music. 

### Deliverable and Demonstration
At the end we will have a fully playable game. It will be interactable and will rely on a human player to actually perform. Start of the game will involve two blocks randomly being added to the board and the user will have free rein from there to move the blocks. 

### Evaluation of Results
We will know if we are successful if the game runs and nothing makes it crash, and if the high score can be saved and pulled to and from a file.

## Architecture Diagram
![Architecture_Diagram](/2048-diagram.png?raw=true "Architecture Diagram")

Brett will be working on the block objects and Zixin will write the code for the keyboard events. The two parts will come together and then the game board will start and the user will give commands to the game and the board will update to reflect what the user inputed. 

## Schedule

### First Milestone (Sun Apr 9)
Have the Title Screen and Help/Info Screen done, and have the block objects drawn onto the game screen.

### Second Milestone (Sun Apr 16)
To have the keyboard events coded into the game and have the block objects able to combine. Also will have the sound effects coded in and have a current score display along with an all-time high score saved to a file and displayed.

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])
Error/bug checking what we will most likely be spending the remaining time on. If time permits I(Brett Lundy) would like to try to add background music.

## Group Responsibilities

### Brett Lundy @blundy
- [ ] write the code for the block objects
- [ ] handle the sound effects for when the blocks combine.
- [ ] display current score
- [ ] save high score and display high score

### Zixin Wang @iris-w
- [ ] create the title screen
- [ ] create the help/info screen
- [ ] create the game screen
- [ ] write code for the keyboard events
### Group
- [ ] handle how the blocks combine
