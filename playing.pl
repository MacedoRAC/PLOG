%%%%%%%%%%%%%%%%%%%%%%%%%%% UTILITY FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
askPosition(POS1, POS2) :-
  write('Choose a column'),
  read(POS1),
  write('Choose a line'),
  read(POS2).

calcPOS(POS1, POS2, POS):-
  POS = POS1 + POS2 - 1. %%%%%%%% UNFINISHED %%%%%%%%

checkPiece(BOARD, P, Pos1, Pos2):-
  BOARD.get(pos1).get(pos2) = P.PecaJogador, !,
  addPiece(Board, P).

checkIfPossible(BOARD, POS1, POS2):-

  .


checkGameEnd(BOARD):-
  .



%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLAYING OPTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addPiece(BOARD, P):-
  %count number of pieces in order to check if the player can add another one
  count(BOARD, P),
  % asking for a position
  write('In which column do you want to add a new piece?'),
  read(POS1),
  write('In which line do you want to add a new piece?'),
  read(POS2),
  checkIfPossible(BOARD, POS1, POS2), !,
  calcPOS(POS1, POS2, POS),
  replace(BOARD, POS, P.getSymbol, BOARD),
  printBoard(BOARD),
  endTurn().

movePiece(BOARD, P):-
  %ask for the piece you want to move
  write(),
  askPosition(ORI1, ORI2),
  checkPiece(ORI1, ORI2),
  calcPOS(ORI1, ORI2, ORI),
  write(),
  askPosition(Pos1, Pos2),
  calcPOS(Pos1, Pos2, POS),
  checkMovement(POS),
  replace(), %remove piece from ORI
  replace(), %add piece to POS
  printBoard(BOARD),
  endTurn(P).

addFence(BOARD, P):-

  .

%%%%%%%%%%%%%%%%%%%%%%%%%%%% GAME FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lookForWinner():- %not sure if it's needed
.

endTurn(BOARD, P):-
  P == P1, !,
  P is P2,
  playingMenu(BOARD, P).

endTurn(BOARD, P):-
  P is P1,
  playingMenu(BOARD, P).

checkAreas():-
  .
