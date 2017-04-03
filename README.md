# Racket-2048

### Statement
2048 is a game that involves a block of 16 slots that the user must find some way to move that will result in blocks with the same value being added together. Each legal move the player makes will also result in a new block taking up the space of a blank spot and if all 16 slots are full and no legal moves can be made the player loses. When the blocks are added together they are combined, reducing the number of blocks by one. The game is not meant to be "won" but to last longer and to improve your high score.
 
### Analysis

- Will you use data abstraction? How?
- Will you use recursion? How?
- Will you use map/filter/reduce? How? 
- Will you use object-orientation? How?
- Will you use functional approaches to processing your data? How?
- Will you use state-modification approaches? How? (If so, this should be encapsulated within objects. `set!` pretty much should only exist inside an object.)
- Will you build an expression evaluator, like we did in the symbolic differentatior and the metacircular evaluator?
- Will you use lazy evaluation approaches?

### External Technologies
The only thing that may classify as External Technologies is that we will be using sound effects for when the blocks combine.

### Data Sets or other Source Materials
If you will be working with existing data, where will you get those data from? (Dowload from a website? Access in a database? Create in a simulation you will build? ...)

How will you convert your data into a form usable for your project?  

If you are pulling data from somewhere, actually go download it and look at it before writing the proposal. Explain in some detail what your plan is for accomplishing the necessary processing.

If you are using some other starting materials, explain what they are. Basically: anything you plan to use that isn't code.

### Deliverable and Demonstration
Explain exactly what you'll have at the end. What will it be able to do at the live demo?

What exactly will you produce at the end of the project? A piece of software, yes, but what will it do? Here are some questions to think about (and answer depending on your application).

Will it run on some data, like batch mode? Will you present some analytical results of the processing? How can it be re-run on different source data?

Will it be interactive? Can you show it working? This project involves a live demo, so interactivity is good.

### Evaluation of Results
We will know if we are successful if the game runs and nothing makes it crash, and if the high score can be saved and pulled to and from a file.

## Architecture Diagram
![Architecture_Diagram](/2048-diagram.png?raw=true "Architecture Diagram")

Create several paragraphs of narrative to explain the pieces and how they interoperate.

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
