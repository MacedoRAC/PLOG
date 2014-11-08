% --------------------------------- MENUS --------------------------------------
fines:-
  mainMenu,
  read(X),
  mainMenuOption(X).

mainMenu:-
  nl,nl,
  write('============================================'),nl,
  write('WELCOME TO FINES'),nl,nl,
  write('1- Player Vs Player'), nl,
  write('2- Player Vs AI'), nl,
  write('3- AI Vs AI'), nl,
  write('4- Exit'), nl.

mainMenuOption(X):-
  (
    X = 1 -> playersMenu;
    X = 2 -> players_AI_Menu;
    X = 3 ->aI_AI_Menu;
    X = 4 -> write('See you next time!');
    (write('Wrong Choice!'),nl,fines)
  ).

% --------------------------------PLAYERS MENU----------------------------------
playersMenu:-
  nl,nl,
  write('============================================'),nl,
  write('TIME TO CHOOSE YOUR BATTLE NAME'),nl,nl,
  write('Player 1 -x- '),
  read(X),
  P1=[X, 1], nl, %creates player using a list (1st element == name, 2nd element == number of pieces in the board, 3rd element == if is player's turn is 'T' else is 'F')
  write('Player 2 -o- '),
  read(Y),
  P2=[Y, 1], nl, %creates player using a list (1st element == name, 2nd element == number of pieces in the board, 3rd element == if is player's turn is 'T' else is 'F')
  startGame(P1, P2).

players_AI_Menu:-
  nl,nl,
  write('============================================'),nl,
  write('TIME TO CHOOSE YOUR BATTLE NAME'),nl,nl,
  write('Player 1 -x- '),
  read(X),
  P1=[X, 1], nl, %creates player using a list (1st element == name, 2nd element == number of pieces in the board, 3rd element == if is player's turn is 'T' else is 'F')
  AI,
  startGame(P1, AI).

aI_AI_Menu:-
  nl,nl,
  write('============================================'),nl,
  AI1,
  AI2,
  startGame(AI1, AI2).


% ----------------------- PLAYER AGAINST PLAYER MODE ---------------------------
startGame(P1, P2):-
  nl, nl,
  write('============================================'),nl,
  write('       YOU ARE NOW PLAYING FINES'),nl,
  write('============================================'),nl,nl,
  initialBoard(BOARD), %creates initial board
  P is P1.
  playingMenu(BOARD, P).

playingMenu(BOARD, P):-
  checkGameEnd(BOARD),
  !,
  write('Game Ended !'), nl,
  countPoints(BOARD, Pp1, Pp2),
  write('Players1 pontuation: '), write(Pp1), nl,
  write('Players2 pontuation: '), write(Pp2), nl, nl
  write('The winner is ').

playingMenu(BOARD, P):-
  nl, nl,
  write('============================================'),nl,
  write('IS YOUR TURN'),nl,nl,
  printBoard(BOARD),
  write('1- Add Piece'), nl,
  write('2- Move Piece'), nl,
  write('3- Add Fence'), nl, %not sure if u must add a piece after you move
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



  % ----------------------- PLAYER AGAINST AI MODE ---------------------------
  startGame(P1, AI):-
    nl, nl,
    write('============================================'),nl,
    write('       YOU ARE NOW PLAYING FINES'),nl,
    write('============================================'),nl,nl,
    initialBoard(BOARD), %creates initial board
    P is P1.
    playingMenu(BOARD, P).

  playingMenu(BOARD, P):-
    checkGameEnd(BOARD),
    !,
    write('Game Ended !'), nl,
    countPoints(BOARD, Pp1, C),
    write('Player1 pontuation: '), write(Pp1), nl,
    write('Computer pontuation: '), write(C), nl, nl
    write('The winner is ').

  playingMenu(BOARD, P):-
    P == P1,
    !,
    nl, nl,
    write('============================================'),nl,
    write('IS YOUR TURN'),nl,nl,
    printBoard(BOARD),
    write('1- Add Piece'), nl,
    write('2- Move Piece'), nl,
    write('3- Add Fence'), nl, %not sure if u must add a piece after you move
    write('4- End Game'), nl,
    read(X),
    gameMenuOption(X).

  playingMenu(BOARD, P):-
    printBoard(BOARD),
    write('Computer will play'),
    AI_turn(), %%%%%%%%%% NOT IMPLEMENTED YET %%%%%%%%%%%
    printBoard(BOARD),
    endTurn(BOARD, P).

  gameMenuOption(X):-
    (
      X = 1 -> addPiece;
      X = 2 -> movePiece;
      X = 3 -> addFence;
      X = 4 -> (write('Game Ended!'),nl, fines);
      (write('Wrong Choice!'),nl,playingMenu)
    ).



% ----------------------- AI AGAINST AI MODE ---------------------------
startGame(AI1, AI2):-
  nl, nl,
  write('============================================'),nl,
  write('       YOU ARE NOW PLAYING FINES'),nl,
  write('============================================'),nl,nl,
  initialBoard(BOARD), %creates initial board
  P is AI1.
  playingMenu(BOARD, P).

playingMenu(BOARD, P):-
  checkGameEnd(BOARD),
  !,
  write('Game Ended !'), nl,
  countPoints(BOARD, C1, C2),
  write('Player1 pontuation: '), write(C1), nl,
  write('Computer pontuation: '), write(C2), nl, nl
  write('The winner is ').

playingMenu(BOARD, P):-
  printBoard(BOARD),
  write('Computer will play'),
  AI_turn(), %%%%%%%%%% NOT IMPLEMENTED YET %%%%%%%%%%%
  printBoard(BOARD),
  endTurn(BOARD, P).
