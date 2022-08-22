# Mastermind

For this project I use numbers to represente each color, thus the player can enter the code of colors following the instructions at the start.
The specific rules to play this game can be found [here](https://en.wikipedia.org/wiki/Mastermind_(board_game))

## Breaker mode

In this mode the user needs to guess a code that the computer has randomly generated. The player has a default number of attempts out of 12. Each element of the code must be in the range of the six colors.

## Setter mode

Here the player has to set a valid code for the computer to break. The algorithim that I used was a simple one:

1. Initialy there's a set of posibilities that are all the combinations of colors.
2. A initial code is set to red, red, blue, blue (or `1122`).
3. The algorithim asks if the guess is correct or if there is no more attempts, if it is the game is over, otherwise goes to next step.
4. Here a elimination task begin, allowing only the posible combinations that, compared with the last guess, return the same answer as the feedback given to the last guess.
5. A new guess is picked. Here I just sample one combination randomly from the filtered set of combinations.
6. The third step is taken until one of the conditions are met.