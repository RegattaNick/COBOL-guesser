	IDENTIFICATION DIVISION.
	PROGRAM-ID. COBOL-guesser.
	AUTHOR. lukeroot.

	DATA DIVISION.
	WORKING-STORAGE SECTION.
	01 Now PIC 9(8). *> Slice of CURRENT-DATE
	01 Rand USAGE FLOAT. *> Random float (using Now as seed)
	01 NumToGuess PIC 99. *> Random number from 1-100
	01 GuessCount PIC 99. *> Number of guesses used
	01 Guess PIC 99. *> Current guess
	01 Again PIC X. *> Play again flag

	PROCEDURE DIVISION.


	StartDisplay. *> Welcome message
	DISPLAY "Welcome to COBOL-guesser.".
	DISPLAY "You have 5 guesses to correctly guess the number.".
	DISPLAY "Good luck!".
	DISPLAY " ".

	PERFORM Main. *> Run guesser
	STOP RUN.


	Main.
	PERFORM Init. *> Initialise guesser
	PERFORM AttemptGuess. *> Guess loop


	Init.
	PERFORM GenerateNumber. *> Sets random 1-100 number
	COMPUTE GuessCount = 0. *> Sets guess count


	GenerateNumber. *> Generates number to guess by using time as seed
	MOVE FUNCTION CURRENT-DATE(9:8) TO Now. *> Get current date
	MOVE FUNCTION RANDOM(Now) TO Rand. *> Generate random float
	COMPUTE NumToGuess = Rand * 100. *> Convert float to int


	AttemptGuess.
	DISPLAY " ".
	DISPLAY "Please guess a number between 1-100".
	DISPLAY " ".

	ACCEPT Guess. *> Store user input
	PERFORM Check. *> Check function
	STOP RUN.


	Check.
	IF Guess EQUALS NumToGuess THEN *> Correct guess
		DISPLAY "Fantastic stuff, you guessed correctly"
		PERFORM Replay.

	COMPUTE GuessCount = GuessCount + 1. *> Guess count inc

	IF GuessCount EQUALS 5 THEN *> Guess count exceeded
		DISPLAY "Oh dear, no more guesses, the number was"
		DISPLAY NumToGuess
		PERFORM Replay.

	IF Guess LESS THAN NumToGuess THEN *> Guess too low
		DISPLAY "Guess was too small, try a bigger number.".

	IF Guess GREATER THAN NumToGuess THEN *> Guess too high
		DISPLAY "Guess was too large, try a smaller number.".

	PERFORM AttemptGuess.


	Replay.
	DISPLAY "Would you like to play again? (y/n)".
	ACCEPT Again. *> Store play again flag

	*> y restarts, anything else ends the game
	IF Again EQUALS "y" THEN
		PERFORM Main
		ELSE PERFORM Finish.


	Finish.
	DISPLAY "Thanks for playing COBOL-guesser. We hope you had fun".
	STOP RUN.
