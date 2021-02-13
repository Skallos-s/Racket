Pocket Frogs Search Minigame Tool Version 1.0

<Made by Skallos>
<Special thanks to evalynn and jtgroth for frog patterns>

<Instructions>
"R" Reset the app and all input settings.
"C" Clear the lilypads.
"0-9" Input frog level.
"Backspace" Works like backspace for frog levels.

<Setting Up Application>
Right side is the 5x5 lilypad grid. This is where you input current information, and where you read out optimal spots.
Left side is where you input the game information.

Type in the level of the frog you chose to search with (0-9).
This will show all applicable frogs (Current level plus previous 4).
Backspace works as expected. A value of "0" shows all frogs.
Scroll on each column to look through breeds.
Click on a name to select the breed.
The top left corner will show the current frog patterns.

<Using Application>
Input the information from your game into the board by clicking on the lilypads.
Select the red or blue circles on the bottom left to select what frog to input into the board.
The yellow star is a flower, meaning no frog is present. The brown "X" is to remove/undo placements.
Clicking on a lilypad will replace/remove what is currently placed.

<Reading off Application>
A black circle indictates the most likely option a frog can appear in.
A brown cross indicates that no frog can possibly appear in this spot.
A gold check indicates that a frog is guaranteed in this spot.

<Compilation instructions>
Download DrRacket here: "https://racket-lang.org/download/"
Use the "Racket" distribution and "Regular" variant.
Select the platform you use.
Once you install and open DrRacket, on the bottom left
select "Determine langauge from source".
Paste in the source code and now you can run the code.
To compile into an application, in the menu at the top of the screen,
go under "Racket", and then "Create Executable...".
Any type should work. Select "GRacket" as the base.
Press on the "+" and select "FrogIcon.ico" as the executable icon.
If you are on a Mac or Linux, you'll need to convert the supplied .png to the correct format.

Enjoy!

<Use Consolas font for best results. Courier New also works>
             ________________________________________________________________
       _.-'``                                                                `*-._
     .'                                                                           `-.
   .'                                                                                '.
  /                                                                                    \
 /                                                                                      \
/                                         _______                                        \
|                                  _.-~```       ```-._                                  |
|                               .-(   @)           (@  `T._                              |
|                             .'  |   `             `   |  '.                            |
|                           .'    |                     \    '.                          |
|                          /   _./_                     .\._   \                         |
|                        .'  .`.'  `.  .-``-  .```.  .'` `-_\   \                        |
|                       /|  ( /      ) |    `.`   ) (       \)  |\                       |
|                       /|   \      /  \          /  \     .'   | \                      |
|                      / |    `T---`    |         |   `---`.     \ \                     |
|             .'``.   / /      |        /         \        \      \ \   (``.             |
|              '. '. | /      /        /     .     \       \      \ \  .'_.`             |
|                '. \/ /      |       /     / \    \        \      \ \/ /                |
|                  \/ /       |       /    /   \    \       |       \\ /                 |
|           .``---~`|/        |      /     |   |     \      \       \ \`---```.          |
|           `.-*;'  //       /       /     |   |     \      |        \\ '.-.-`           |
|              /   |/        |      /      /   \     \      \         \|   \             |
|              (   |         /     /      /    \      \      \         |   )             |
|         .--. \   |        /     /       /     \      \      \        |   / .-.         |
|  .-*-   \  |  \  |        |     (      (       |      |     |       /  .' (  .)  .-`-  |
|  `._ `._  \ \  `-.\       |     |      |       |      |     |       /-`   / /  _.` _/  |
|     `-. `-.) `,.---\      |     |      \      /       |     |      /.._.-` `-~` .'`    |
|        `)  .-`      \     |     |       \     /       |     |     /     ``-.  (`       |
|   .--.-`  /          '.   |     |       |    |        |     \   .'          \  `-..-.  |
|  (  .--``(-._          './      |       \    /        |     \.-'           .) `-._  )  |
|   ``      \  `-._         `-._  |        \   /        |  _.-`         _.-*` /     ``   |
|            '._    `---...____.:`*--..____\__/__....---`=:________..-*`   _.'           |
|               `-._                 _.`          `-._                 _.-`              |
|                   `*~--........--~`                 `~-..._____..-**`                  |
\                                                                                        /
 \                                                                                      /
  \                                                                                    /
   '.                                                                                .'
     `._                                                                          _.'
        `-.___                                                              ___.-'
              ``````````````````````````````````````````````````````````````