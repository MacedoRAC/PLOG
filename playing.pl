% -------------------------BOARD INITIALIZATION---------------------------------
initialBoard([
            [3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 3],
            [4, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 4], % pieces
            [4, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 4], %fences line
            [4, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 4], % pieces
            [4, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 4], %fences line
            [4, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 4], % pieces
            [4, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 4], %fences line
            [4, 1, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 2, 4], % pieces
            [4, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 4], %fences line
            [4, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 4], % pieces
            [4, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 4], %fences line
            [4, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 4], % pieces
            [4, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 4], %fences line
            [4, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 4], % pieces
            [4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4]
            ]).


% -------------------------------BOARD PRINTING---------------------------------
translateChar(0,' '). %empty space
translateChar(1,'x').
translateChar(2,'o').
translateChar(3,' '). %no fence
translateChar(4,'|').
translateChar(5,'_').
translateChar(6, '+').

printBoard_line([H|T]):-
  translateChar(H,X),
  write(X),
  printBoard_line(T).

printBoard([H|T]):-
  printBoard_line(H),
  nl,
  printBoard(T).

printBoard([]).
printBoard_line([]).



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


movePiece(BOARD, P):-
  %ask for the piece you want to move
  write('Please choose the piece you want to move'),
  askPosition(ORI1, ORI2),
  checkPieceToMove(P, ORI1, ORI2),
  !,
  POSITION1 = ORI1, %use this for replace once ORI was changed
  POSITION2 = ORI2, %use this for replace once ORI was changed
  %ask for the final position of the movement
  write('Please introduce the piece final position'),
  askPosition(POS1, POS2),
  checkMovement(BOARD, ORI1, ORI2, POS1, POS2),
  %moves the piece
  movesPiece(BOARD, POSITION1, POSITION2, POS1, POS2, P),
  printBoard(BOARD),
  %adding a fence
  addFence(BOARD, POS1, POS2),
  endTurn(BOARD, P).

movePiece(BOARD, P):-
  write('you cant move the selected piece'),
  playingMenu(BOARD, P).

addFence(BOARD, POS1, POS2):-
  write('Introduce where you want to add a fence'),
  ( openFence(BOARD, POS1+1, POS2) = true -> write('down')),
  ( openFence(BOARD, POS1-1, POS2) = true -> write('up')),
  ( openFence(BOARD, POS1, POS2+1) = true -> write('right')),
  ( openFence(BOARD, POS1, POS2-1) = true -> write('left')),
  read(X),
  addFenceOptions(X).

addFenceOptions(BOARD, POS1, POS2, X, Line):-
  (
    X = 'down' -> nth0(POS1+1, BOARD, Line),
                  replace(POS2, 5, Line, Line),
                  replace(POS1+1, Line, Board, Board);
    X = 'up' -> nth0(POS1-1, BOARD, Line),
                replace(POS2, 5, Line, Line),
                replace(POS1-1, Line, Board, Board);
    X = 'right' -> nth0(POS1, BOARD, Line),
                  replace(POS2+1, 4, Line, Line),
                  replace(POS1, Line, Board, Board);
    X = 'left' -> nth0(POS1, BOARD, Line),
                  replace(POS2-1, 4, Line, Line),
                  replace(POS1, Line, Board, Board);
    (write('Wrong Choice!'),nl, addFence(BOARD, POS1, POS2))
  ).

passTurn(BOARD, P):-
  endTurn(BOARD, P).


%%%%%%%%%%%%%%%%%%%%%%%%%%%% GAME FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
checkGameEnd(BOARD, P):-
  %se nao existirem movimentos possiveis de uma jogador
  \+ playersCanMove(BOARD, P, 1).

checkGameEnd(BOARD, P):-
  NPieces = 0,
  countPieces(NPieces, 0),
  %check if all areas are surrounded
  checkAllAreas(NPieces, BOARD, 0).

% CONTA O NUMERO TOTAL DE PEÇAS NO TABULEIRO
countPieces(NPieces, L):-
  L =< 13,
  nth0(L, Board, Line),
  !,
  checkPieceLine(Line, NPieces, L).

countPieces(NPieces, L):-
  L > 13,
  !.

checkPieceLine(Line, NPieces, L):-
  nth0(Pposition, Line, 1),
  !,
  NPieces is NPieces + 1,
  replace(Pposition, 0, Line, Line),
  checkPieceLine(Line, NPieces).

checkPieceLine(Line, NPieces, L):-
  nth0(Pposition, Line, 2),
  !,
  NPieces is NPieces + 1,
  replace(Pposition, 0, Line, Line),
  checkPieceLine(Line, NPieces).

checkPieceLine(Line, NPieces, L):-
  L is L + 1,
  countPieces(NPieces, L).


%%%%%%%%%%% CALCULATE SCORES EXACTLY EQUAL, BUT SAVES SCORES OF EACH PLAYER %%%%
checkAllAreas(NPieces, BOARD, Counter):-
  Counter < NPieces,
  %copia tabuleiro para board2,
  copy_term(BOARD, Board2),
  findPiecePosition(POS1, POS2, 1),
  %calcArea(POS1, POS2, S1),
  deletePiece(POS1, POS2, Board2),
  Counter is Counter + 1,
  checkAllAreas(NPieces, Board2, Counter).

checkAllAreas(NPieces, BOARD, Counter):-
  Counter = NPieces,
  !.

findPiecePosition(POS1, POS2, IndLine, Board2):-
  IndLine =< 13,
  nth0(IndLine, Board2, Line),
  member(1, Line),
  ntho(POS2, Line, 1).

findPiecePosition(POS1, POS2, IndLine, Board2):-
  IndLine =< 13,
  nth0(IndLine, Board2, Line),
  member(2, Line),
  ntho(POS2, Line, 2).

findPiecePosition(POS1, POS2, IndLine, Board2):-
  IndLine < 13,
  IndLine is IndLine + 2,
  findPiecePosition(POS1, POS2, IndLine).

deletePiece(POS1, POS2, Board2):-
  nth0(POS1, Board2, Line),
  nth0(POS2, Line, 0),
  replace(POS1, Line, Board2, Board2).

/*calcArea():-
  .*/

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

playersCanMove(BOARD, P, IndL):-
  IndL =< 13,
  nth0(IndL, Board, Line),
  member(1, Line),
  !,
  checkLine(Line, IndL). %no final incrementar Line

playersCanMove(BOARD, P, IndL):-
  IndL =< 13,
  nth0(IndL, Board, Line),
  member(2, Line),
  !,
  checkLine(Line, IndL).

playersCanMove(BOARD, P, IndL):-
  IndL < 13,
  !,
  IndL is IndL+2,
  playersCanMove(BOARD, P, IndL).


checkLine(Line, IndL, BOARD):-
  copy_term(BOARD, Board2),
  findPiecePosition(POS1, POS2, 1, Board2),
  !,
  canMove(POS1, POS2, 0),
  deletePiece(POS1, POS2, Board2),
  checkLine(Line, IndL, Board2).

canMove(IndL, Col, Index):-
  IndL < 13,
  Index is IndL+1,
  nth0(Index, Board, LineB),
  nth0(Col, LineB, 3),
  Index is Indl+2,
  nth0(Index, Board, LineB),
  nth0(Col, LineB, 0).

canMove(IndL, Col, Index):-
  IndL > 1,
  Index is IndL-1,
  nth0(Index, Board, LineB),
  nth0(Col, LineB, 3),
  Index is Indl-2,
  nth0(Index, Board, LineB),
  nth0(Col, LineB, 0).

canMove(IndL, Col, Index):-
  Col < 13,
  nth0(IndL, Board, LineB),
  Index is Col+1,
  nth0(Index,LineB, 3),
  nth0(IndL, Board, LineB),
  Index is Col+2,
  nth0(Index, LineB, 0).

canMove(IndL, Col, Index):-
  Col > 1,
  nth0(IndL, Board, LineB),
  Index is Col-1,
  nth0(Column1, LineB, 3),
  nth0(IndL, Board, LineB),
  Index is Col-2,
  nth0(Column2, LineB, 0).


endTurn(BOARD, P):-
  P = 1,
  P1 is 2,
  playingMenu(BOARD, P1).

endTurn(BOARD, P):-
  P = 2,
  P1 is 1,
  playingMenu(BOARD, P1).


%%%%%%%%% UTILITU FUNCTIONS FOR ADD PIECES %%%%%%%%%
pieceNumber(P, Np):-
  P=1,
  !,
  nth0(1, P1, Np).

pieceNumber(P, Np):-
  nth0(1, P2, Np).

countPieces(BOARD, P):-
  pieceNumber(P, Np),
  Np < 7,
  !,
  addPiece(P).

countPieces(BOARD, P):-
  write('you cant add any more pieces'),
  playingMenu(BOARD, P).

placePiece(BOARD, P, POS1, POS2):-
  checkIfPossible(BOARD, P, POS1, POS2), !,
  addCorrectPiece(BOARD, P, POS1, POS2),
  updateNumeberOfPieces(P).

updateNumeberOfPieces(P):-
  P = 1,
  nth0(1, P1, NumbP),
  NumbP is NumbP + 1,
  replace(1, NumbP, P1, P1).

updateNumeberOfPieces(P):-
  P = 2,
  nth0(1, P2, NumbP),
  NumbP is NumbP + 1,
  replace(1, NumbP, P2, P2).

placePiece(BOARD, P):-
  write('You are not allowed to place a piece here'), nl, nl,
  playingMenu(BOARD, P).

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
  P = 1,
  nth0(POS1, BOARD, Line),
  replace(POS2, 1, Line, Line),
  replace(POS1, Line, Board, Board),
  write('A new piece was sucssecfully placed').

addCorrectPiece(BOARD, POS1, POS2):-
  P = 2,
  nth0(POS1, BOARD, Line),
  replace(POS2, 2, Line, Line),
  replace(POS1, Line, Board, Board),
  write('A new piece was sucssecfully placed').

/*
findPath(P, BOARD, POS1, POS2):-  %%%%% NOT IMPLEMENTED YET %%%%%
  %looks for pieces in the board

  %for each piece get its position

  %checks if its posible the movement between any piece
  %on the board and the final position
  checkMovement().

findPath(P, BOARD, POS1, POS2):-
  %looks for pieces in the board

  %for each piece get its position

  %checks if its posible the movement between the final
  %position and some piece on the board
  checkMovement().
*/


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
  playingMenu(BOARD, P).

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
  P = 1,
  %erases original piece
  nth0(POSITION1, BOARD, Line),
  replace(POSITION2, 0, Line, Line),
  replace(POSITION1, Line, Board, Board),
  %places moved piece
  nth0(POS1, BOARD, Line),
  replace(POS2, 1, Line, Line),
  replace(POS1, Line, Board, Board).

movesPiece(BOARD, POSITION1, POSITION2, POS1, POS2, P):-
  P = 2,
  %erases original piece
  nth0(POSITION1, BOARD, Line),
  replace(POSITION2, 0, Line, Line),
  replace(POSITION1, Line, Board, Board),
  %places moved piece
  nth0(POS1, BOARD, Line),
  replace(POS2, 2, Line, Line),
  replace(POS1, Line, Board, Board).
