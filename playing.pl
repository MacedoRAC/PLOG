%%%%%%%%% UTILITU FUNCTIONS FOR ADD PIECES %%%%%%%%%
pieceType(BOARD, P):-
  P = P1,
  !,
  member(1, BOARD).

pieceType(BOARD, P):-
  member(2, BOARD).

countPieces(BOARD, P, N):-
  N < 7,
  !,
  pieceType(BOARD, P),
  N is N+1,
  countPieces(BOARD, P, N).

countPieces(BOARD, P, N):-
  N >= 7, !, fail.

countPieces(BOARD, P, N):-
  .

placePiece(BOARD, P, POS1, POS2):-
  checkIfPossible(BOARD, P, POS1, POS2), !,
  addCorrectPiece(BOARD, P, POS1, POS2).

placePiece(BOARD, P, POS1, POS2):-
  write('You are not allowed to place a piece here'), nl,
  write('please choose another position'), nl, nl
  addPiece(BOARD, P).

checkIfPossible(BOARD, P, POS1, POS2):-
  %checks if there isnt any piece there
  R is POS1 mod 2,
  R /= 0,
  R is POS2 mod 2,
  R /= 0,
  nth0(POS1, BOARD, 1sline),
  ntho(POS2, 1sline, Elem),
  Elem = 0,
  !,
  %looks for a path
  findPath(P, BOARD, POS1, POS2). %%% NOT IMPLEMENTED YET

checkIfPossible(BOARD, P, POS1, POS2):-
  write('This position isnt available to place a new piece').

addCorrectPiece(BOARD, P, POS1, POS2):-
  P = P1, !,
  %%% calculate index
  replace(BOARD, INDEX, 1, BOARD), %%% NOT SURE IF REPLACE WILL WORK PROPERLY %%%
  write('A new piece was sucssecfully placed').

addCorrectPiece(BOARD, P, POS1, POS2):-
  %%% calculate index
  replace(BOARD, INDEX, 2, BOARD), %%% NOT SURE IF REPLACE WILL WORK PROPERLY %%%
  write('A new piece was sucssecfully placed').

findPath(P, BOARD, POS1, POS2):-  %%%%% NOT IMPLEMENTED YET %%%%%
  .
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
  write('please choose another move for this turn'),nl,nl
  playingMenu(BOARD, P).


movePiece(BOARD, P):-
  %ask for the piece you want to move
  write('Please choose the piece you want to move')
  askPosition(ORI1, ORI2),
  checkPieceToMove(P, ORI1, ORI2),
  !,
  %ask for the final position of the movement
  write('Please introduce the piece final position'),
  askPosition(POS1, POS2),
  checkMovement(BOARD, ORI1, ORI2, POS1, POS2), %%% NOT IMPLEMENTED %%%
  %moves the piece
  replace(), %remove piece from ORI
  replace(), %add piece to POS
  printBoard(BOARD),
  addFence(BOARD, P), %%% NOT SURE IF I MUST IMPLEMENT THIS HERE
  endTurn(BOARD, P).

addFence(BOARD, P):-

  .

%%%%%%%%%%%%%%%%%%%%%%%%%%%% GAME FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

checkGameEnd(BOARD):- %%%%%%%% UNFINISHED %%%%%%%%
  %se nao existirem movimentos possiveis de uma equipa, o jogo acaba
  .

lookForWinner():- %not sure if it's needed
  .

endTurn(BOARD, P):-
  P = P1, !,
  P is P2,
  playingMenu(BOARD, P).

endTurn(BOARD, P):-
  P is P1,
  playingMenu(BOARD, P).

checkAreas():-
  .

checkPossibleMoves():-
  .


%%%%%%%%%%%%%%%%%% UTILITY FUNCTIONS FOR MOVE PIECE %%%%%%%%%%%%%%%%%%%%%%%%%%%%
askPosition(POS1, POS2) :-
  write('Choose a line'),
  read(POS1),
  write('Choose a column'),
  read(POS2).

checkPieceToMove(BOARD, P, POS1, POS2):-
  %checks if the position is a piece position and if its empty
  R is POS1 mod 2,
  R /= 0,
  nth0(POS1, BOARD, Line),
  R is POS2 mod 2,
  R /= 0,
  nth0(POS2, BOARD, SPACE),
  SPACE = 0.

checkMovement(BOARD, ORI1, ORI2, POS1, POS2):-
  %checks if the position is a piece position and if its empty
  R is POS1 mod 2,
  R /= 0,
  nth0(POS1, BOARD, Line),
  R is POS2 mod 2,
  R /= 0,
  nth0(POS2, BOARD, SPACE),
  SPACE = 0,
  !,
  % verify path to destination
  .
