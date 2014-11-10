%%%%%%%%% UTILITU FUNCTIONS FOR ADD PIECES %%%%%%%%%
pieceType(BOARD, P, P1):-
  P = P1,
  !,
  member(1, BOARD).

pieceType(BOARD):-
  member(2, BOARD).

countPieces(BOARD, P, N):-
  N < 7,
  !,
  pieceType(BOARD, P), %% NOT SURE IF WORKING
  N is N+1,
  countPieces(BOARD, P, N).

countPieces(N):-
  N >= 7, !, fail.

placePiece(BOARD, P, POS1, POS2):-
  checkIfPossible(BOARD, P, POS1, POS2), !,
  addCorrectPiece(BOARD, P, POS1, POS2).

placePiece(BOARD, P):-
  write('You are not allowed to place a piece here'), nl,
  write('please choose another position'), nl, nl,
  addPiece(BOARD, P).

checkIfPossible(BOARD, P, POS1, POS2, LINE1):-
  %checks if there isnt any piece there
  R is POS1 mod 2,
  R \= 0,
  R is POS2 mod 2,
  R \= 0,
  nth0(POS1, BOARD, LINE1),
  ntho(POS2, LINE1, Elem),
  Elem = 0,
  !,
  %looks for a path
  findPath(P, BOARD, POS1, POS2). %%% NOT IMPLEMENTED YET

checkIfPossible:-
  write('This position isnt available to place a new piece').

addCorrectPiece(BOARD, P, P1, POS1, POS2, Line):-
  P = P1, !,
  nth0(POS1, BOARD, Line),
  replace(POS2, 1, Line, Line),
  replace(POS1, Line, Board, Board),
  write('A new piece was sucssecfully placed').

addCorrectPiece(BOARD, POS1, POS2):-
  nth0(POS1, BOARD, Line),
  replace(POS2, 1, Line, Line),
  replace(POS1, Line, Board, Board),
  write('A new piece was sucssecfully placed').

/*
findPath(P, BOARD, POS1, POS2):-  %%%%% NOT IMPLEMENTED YET %%%%%
  .*/
%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLAYING OPTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addPiece(BOARD, P):-
  %count number of pieces in order to check if the player can add another one
  countPieces(BOARD, P),
  !,
  % asking for a position
  write('In which line do you want to add a new piece?'),
  read(POS1),
  write('In which column do you want to add a new piece?'),
  read(POS2),
  placePiece(BOARD, P, POS1, POS2),
  printBoard(BOARD),
  endTurn(BOARD, P).

addPiece(BOARD, P):-
  write('you already have more than 7 pieces in the board.'),
  nl,
  write('please choose another move for this turn'),nl,nl,
  playingMenu(BOARD, P).


movePiece(BOARD, P, POSITION1, POSITION2):-
  %ask for the piece you want to move
  write('Please choose the piece you want to move'),
  askPosition(ORI1, ORI2),
  checkPieceToMove(P, ORI1, ORI2),
  !,
  %ask for the final position of the movement
  POSITION1 = ORI1, %use this for replace once ORI was changed
  POSITION2 = ORI2, %use this for replace once ORI was changed
  write('Please introduce the piece final position'),
  askPosition(POS1, POS2),
  checkMovement(BOARD, ORI1, ORI2, POS1, POS2),
  %moves the piece
  movesPiece(BOARD, POSITION1, POSITION2, POS1, POS2, P),
  printBoard(BOARD),
  addFence(BOARD, POS1, POS2),
  endTurn(BOARD, P).

addFence(BOARD, POS1, POS2):-
  write('Introduce where you want to add a fence')
  ( openFence(BOARD, POS1+1, POS2) = true -> write('down')),
  ( openFence(BOARD, POS1-1, POS2) = true -> write('up')),
  ( openFence(BOARD, POS1, POS2+1) = true -> write('right')),
  ( openFence(BOARD, POS1+1, POS2-1) = true -> write('left')),
  read(X),
  addFenceOptions(X).

addFenceOptions(BOARD, POS1, POS2, X, Line):-
  (
    X = 'down' -> nth0(POS1-1, BOARD, Line),
                  replace(POS2, 5, Line, Line),
                  replace(POS1-1, Line, Board, Board);
    X = 'up' -> nth0(POS1+1, BOARD, Line),
                replace(POS2, 5, Line, Line),
                replace(POS1+1, Line, Board, Board);
    X = 'right' -> nth0(POS1, BOARD, Line),
                  replace(POS2+1, 4, Line, Line),
                  replace(POS1, Line, Board, Board);
    X = 'left' -> nth0(POS1, BOARD, Line),
                  replace(POS2-1, 4, Line, Line),
                  replace(POS1, Line, Board, Board);
    (write('Wrong Choice!'),nl,
    addFence(BOARD, POS1, POS2))
  ).

passTurn(BOARD, P):-
  endTurn(BOARD, P).


%%%%%%%%%%%%%%%%%%%%%%%%%%%% GAME FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
checkGameEnd(BOARD):- %%%%%%%% UNFINISHED %%%%%%%%
  %se nao existirem movimentos possiveis de uma equipa, o jogo acaba
  .*/
/*
lookForWinner():- %not sure if it's needed
  .*/

endTurn(BOARD, P, P1, P2):-
  P = P1,
  !,
  P is P2,
  playingMenu(BOARD, P).

endTurn(BOARD, P, P1):-
  P is P1,
  playingMenu(BOARD, P).

/*
checkAreas():-
  .

checkPossibleMoves():-
  .*/


%%%%%%%%%%%%%%%%%% UTILITY FUNCTIONS FOR MOVE PIECE %%%%%%%%%%%%%%%%%%%%%%%%%%%%
askPosition(POS1, POS2) :-
  write('Choose a line'),
  read(POS1),
  write('Choose a column'),
  read(POS2).

checkPieceToMove(BOARD, POS1, POS2, Line, SPACE):-
  %checks if the position is a piece position and if its empty
  R is POS1 mod 2,
  R \= 0,
  nth0(POS1, BOARD, Line),
  R is POS2 mod 2,
  R \= 0,
  nth0(POS2, BOARD, SPACE),
  SPACE = 0.


checkMovement(BOARD, ORI1, ORI2, POS1, POS2, Line, SPACE):-
  %checks if the position is a piece position and if its empty
  R is POS1 mod 2,
  R \= 0,
  nth0(POS1, BOARD, Line),
  R is POS2 mod 2,
  R \= 0,
  nth0(POS2, BOARD, SPACE),
  SPACE = 0,
  !,
  evaluatePositions(ORI1, ORI2, POS1, POS2).

checkMovement(BOARD, P):-
  write('The introduced position is not valid'),
  movePiece(BOARD, P).

evaluatePositions(ORI1, ORI2, POS1, POS2):-
  POS1 = ORI1,
  POS2 = ORI2.

evaluatePositions(ORI1, ORI2, POS1, POS2):-
  POS1 > ORI1,
  POS2 > ORI2,
  ORI1 is ORI1 + 1,
  openFence(ORI1, ORI2),
  ORI1 is ORI1 + 1,
  emptySpace(ORI1, ORI2),
  evaluatePositions(ORI1, ORI2, POS1, POS2).

evaluatePositions(ORI1, ORI2, POS1, POS2):-
  POS1 < ORI1,
  POS2 < ORI2,
  ORI1 is ORI1 - 1,
  openFence(ORI1, ORI2),
  ORI1 is ORI1 - 1,
  emptySpace(ORI1, ORI2),
  evaluatePositions(ORI1, ORI2, POS1, POS2).

evaluatePositions(ORI1, ORI2, POS1, POS2):-
  POS1 < ORI1,
  POS2 > ORI2,
  ORI2 is ORI2 + 1,
  openFence(ORI1, ORI2),
  ORI2 is ORI2 + 1,
  emptySpace(ORI1, ORI2),
  evaluatePositions(ORI1, ORI2, POS1, POS2).

evaluatePositions(ORI1, ORI2, POS1, POS2):-
  POS1 > ORI1,
  POS2 < ORI2,
  ORI2 is ORI2 - 1,
  openFence(ORI1, ORI2),
  ORI2 is ORI2 - 1,
  emptySpace(ORI1, ORI2),
  evaluatePositions(ORI1, ORI2, POS1, POS2).

evaluatePositions(ORI1, ORI2, POS1, POS2):-
  POS1 > ORI1,
  POS2 = ORI2,
  ORI1 is ORI1 + 1,
  openFence(ORI1, ORI2),
  ORI1 is ORI1 + 1,
  emptySpace(ORI1, ORI2),
  evaluatePositions(ORI1, ORI2, POS1, POS2).

evaluatePositions(ORI1, ORI2, POS1, POS2):-
  POS1 = ORI1,
  POS2 > ORI2,
  ORI2 is ORI2 + 1,
  openFence(ORI1, ORI2),
  ORI2 is ORI2 + 1,
  emptySpace(ORI1, ORI2),
  evaluatePositions(ORI1, ORI2, POS1, POS2).

evaluatePositions(ORI1, ORI2, POS1, POS2):-
  POS1 < ORI1,
  POS2 = ORI2,
  ORI1 is ORI1 - 1,
  openFence(ORI1, ORI2),
  ORI1 is ORI1 - 1,
  emptySpace(ORI1, ORI2),
  evaluatePositions(ORI1, ORI2, POS1, POS2).

evaluatePositions(ORI1, ORI2, POS1, POS2):-
  POS1 = ORI1,
  POS2 < ORI2,
  ORI2 is ORI2 - 1,
  openFence(ORI1, ORI2),
  ORI2 is ORI2 - 1,
  emptySpace(ORI1, ORI2),
  evaluatePositions(ORI1, ORI2, POS1, POS2).

openFence(ORI1, ORI2, BOARD, Line):-
  nth0(ORI1, BOARD, Line),
  nth0(ORI2, Line, Elem),
  Elem = 3.

openFence(ORI1, ORI2, BOARD, Line):-
  nth0(ORI1, BOARD, Line),
  nth0(ORI2, Line, Elem),
  Elem = 6.

emptySpace(ORI1, ORI2, BOARD, Line):-
  nth0(ORI1, BOARD, Line),
  nth0(ORI2, Line, Elem),
  Elem = 0.


movesPiece(BOARD, POSITION1, POSITION2, POS1, POS2, P):-
  POSITION1 = POS1,
  POSITION2 = POS2.

movesPiece(BOARD, POSITION1, POSITION2, POS1, POS2, P):-
  P = P1,
  !,
  %erases original piece
  nth0(POSITION1, BOARD, Line),
  replace(POSITION2, 0, Line, Line),
  replace(POSITION1, Line, Board, Board),
  %places moved piece
  nth0(POS1, BOARD, Line),
  replace(POS2, 1, Line, Line),
  replace(POS1, Line, Board, Board).

movesPiece(BOARD, POSITION1, POSITION2, POS1, POS2, P):-
  %erases original piece
  nth0(POSITION1, BOARD, Line),
  replace(POSITION2, 0, Line, Line),
  replace(POSITION1, Line, Board, Board),
  %places moved piece
  nth0(POS1, BOARD, Line),
  replace(POS2, 1, Line, Line),
  replace(POS1, Line, Board, Board).
