# connect_four
Connect 4 board game played in the terminal. Made with Ruby

## Game
-- Handles main game loop, user input and references to other game objects
### Methods
-- #player_input(min, max)
-- #verify_input(min, max)
-- #players_moves
-- #get_players
-- #game_over(winner=nil)
---
## Player
-- Handles move choice
### Human Subclass
-- Gets move from stdin
### Comp Subclass
-- Gets move from rand method
---
## Display
-- Handles intro and anything the user sees
---
## Board
-- Stores the game board in a grid (2D array)
---
## Connector
-- Pseudo graph data structure to find a line of 4
---