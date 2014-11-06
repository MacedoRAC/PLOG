%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INCLUDES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-use_module(library(lists)),
consult(menus),
consult(playing).


% -------------------------BOARD INITIALIZATION---------------------------------

translateChar(0,' '). %empty space
translateChar(1,'x').
translateChar(2,'o').
translateChar(3,' '). %no fence
translateChar(4,'|').
translateChar(5,'_').
translateChar(6, '+').

initialBoard([
            [0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0], % pieces
            [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3], %fences line
            [0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0], % pieces
            [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3], %fences line
            [0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0], % pieces
            [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3], %fences line
            [0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0], % pieces
            [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3], %fences line
            [0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0], % pieces
            [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3], %fences line
            [0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0], % pieces
            [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3], %fences line
            [0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0], % pieces
            ]).


% -------------------------------BOARD PRINTING---------------------------------
printBoard([]).
printBoard_line([]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MARIO VÊ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
printBoard_line([H|T]):-
  translateChar(H,X),
  write(X),
  printBoard_line(T).

printBoard([H|T]):-
  printBoard_line(H),
  nl,
  printBoard(T).
