%%%%%%%%%%%%%%%%%%%%%%%%%%% UTILITY FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
askPosition(POS1, POS2) :-
  write('Choose a column'),
  read(POS1),
  write('Choose a line'),
  read(POS2).

calcPOS(POS1, POS2, POS):-

  .

checkIfPossible(BOARD, POS1, POS2):-

  .



%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLAYING OPTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addPiece(BOARD, P):-
  % asking for a position
  write('In which column do you want to add a new piece?'),
  read(POS1),
  write('In which line do you want to add a new piece?'),
  read(POS2),
  checkIfPossible(BOARD, POS1, POS2), !,
  calcPOS(POS1, POS2, POS),
  replace(BOARD, POS, P.getSymbol, BOARD).

movePiece(BOARD, P):-
  %ask for the piece you want to move
  write(),
  askPosition(ORI1, ORI2),
  checkPiece(ORI1, ORI2),
  calcPOS(ORI),
  write(),
  askPosition(Pos1, Pos2),
  calcPOS(POS),
  checkMovement(POS),
  replace(), %remove piece from ORI
  replace(), %add piece to POS
  endTurn(P).

addFence(BOARD, P):-

  .

%%%%%%%%%%%%%%%%%%%%%%%%%%%% GAME FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lookForWinner():- %not sure if it's needed
.

endTurn(P):-
  P(P1), !, P is P2.
  P is P1.

checkAreas():-
  .
