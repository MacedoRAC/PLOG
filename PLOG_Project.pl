:-use_module(library(lists)).


% ---------------------------------MAIN MENU------------------------------------
fines:-
	mainMenu,
	read(X),
	mainMenuOption(X).

mainMenu:-
	nl,nl,
	write('============================================'),nl,
	write('WELCOME TO FINES'),nl,nl,
	write('1- Player vs Player'), nl,
	write('2- Exit'), nl.

mainMenuOption(X):-
	(
		X = 1 -> playersMenu;
		X = 2 -> write('See you next time!');
		(write('Wrong Choice!'),nl,fines)
	).

% --------------------------------PLAYERS MENU----------------------------------
playersMenu:-
	nl,nl,
	write('============================================'),nl,
	write('TIME TO CHOOSE YOUR BATTLE NAME'),nl,nl,
	write('Player 1 -x- '),
	read(X),
	P1=[X, 1, 'T'], nl, %creates player using a list (1st element == name, 2nd element == number of pieces in the board, 3rd element == if is player's turn is 'T' else is 'F')
	write('Player 2 -o- '),
	read(Y),
	P2=[Y, 1, 'F'], nl, %creates player using a list (1st element == name, 2nd element == number of pieces in the board, 3rd element == if is player's turn is 'T' else is 'F')
	startGame.


% ---------------------------------GAME MENU------------------------------------
startGame:-
	nl, nl,
	write('============================================'),nl,
	write('       YOU ARE NOW PLAYING FINES'),nl,
	write('============================================'),nl,nl,
	initialBoard(BOARD), %creates initial board
	playingMenu.

playingMenu:-
	nl, nl,
	write('============================================'),nl,
	member('T', P1) == 0 ->write('PLAYER 1 '),
	member('T', P2) == 0 ->write('PLAYER 2 '), 
	write('IS YOUR TURN'),nl,nl,
	printBoard(BOARD),
	write('1- Add Piece'), nl,
	write('2- Move Piece'), nl,
	write('3- Add Fence'), nl,
	write('4- End Game'), nl,
	read(X),
	gameMenuOption(X).

gameMenuOption(X):-
	(
		X = 1 -> addPiece;
		X = 2 -> movePiece;
		X = 3 -> addFence;
		X = 4 -> (write('Game Ended!'),nl, fines);
		(write('Wrong Choice!'),nl,playingMenu)
	).


% -----------------------------------BOARD--------------------------------------
initialBoard([[0,0,7,0,8,0,9,0,10,0,11,0,12,0,13,0,14,0,15,0,16,0,17,0,18,0,19,0,0,0],
						[6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6],
						[7,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4],
						[8,4,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,4],
						[9,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4],
						[10,4,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,4],
						[11,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4],
						[12,4,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,4],
						[13,4,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,4],
						[14,4,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,4],
						[15,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4],
						[16,4,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,4],
						[17,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4],
						[18,4,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,5,0,0,0,4],
						[19,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4],
						[20,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4]]).


% ---------------------------------PRINT BOARD----------------------------------
printBoard([]).
printBoard-line([]).
translateChar(0,' ').
translateChar(1,'x').
translateChar(2,'o').
translateChar(3,'-').
translateChar(4,'|').
translateChar(5,'+').
translateChar(6,'_').
translateChar(7,'A').
translateChar(8,'B').
translateChar(9,'C').
translateChar(10,'D').
translateChar(11,'E').
translateChar(12,'F').
translateChar(13,'G').
translateChar(14,'H').
translateChar(15,'I').
translateChar(16,'J').
translateChar(17,'K').
translateChar(18,'L').
translateChar(19,'M').
translateChar(20,'N').

printBoard_line([H|T]):-
	translateChar(H,X),
	write(X),
	printBoard_line(T).

printBoard([H|T]):-
	printBoard_line(H),
	nl,
	printBoard(T).


%---------------------------------PLAYING RULES---------------------------------

endOfTurn:-
	member('T', P1), !, endOfTurnAction1.
	endOfTurnAction2.

endOfTurnAction1:-
	replace(P1, 2, 'F', P1)),
	replace(P2, 2, 'T', P2)).

endOfTurnAction2:-
	replace(P2, 2, 'F', P2)),
	replace(P1, 2, 'T', P1)).
