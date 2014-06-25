# Battleships

Battleships - the classic pen-and-paper game.

## Simple Text Version

There is a text version that fills in the computer grid and allows the player
to attack it.

## Graphic Version using Gosu / gosu_enhanced_

The Gosu graphic version first allows the user to place their ships

    1 x 5 square Aircraft Carrier
    1 X 4 square Battleship 
    2 x 3 square Cruiser
    2 x 2 square Destroyers
    2 x 1 square Submarines
    
The computer also gets a set of ships placed semi-randomly on their grid, but
those are initially invisible, of course :-)

After the ships have been placed, the player and computer take turns to 
attack each other.

Gameplay is self-explanatory, assisted by the on-screen help.

After the computer or player has won

    Press R to Restart
    Press Esc to Exit

### Pretty Font

There is an option to use freeware font 'Good Times' from Typodermic Fonts, Inc.
It can be downloaded [here](http://www.1001fonts.com/sans-serif-fonts.html)
and put into the media directory. Otherwise, the Gosu default font is used.

### Installation of required gem

use either

    bundle

or

    gem install gosu_enhanced
