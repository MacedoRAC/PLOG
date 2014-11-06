%playing options

addPiece():-
  %ask for new position
  %checkPosition, !, cut.
  %checkPostion, addPiece.
  .

movePiece():-
  %ask for new position
  %checkmovement, !, replace(),


  .

addFence():-

  .

%game functions

lookForWinner():- %not sure if it's needed
.

endTurn(P):-
  P(P1), !, P is P2.
  P is P1.

checkAreas():-
  .
