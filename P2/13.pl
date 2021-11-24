%
% a. Given a linear numerical list write a predicate to remove all
% sequences of consecutive values.
%
% b. For a heterogeneous list, formed from integer numbers and list of
% numbers; write a predicate to delete from every sublist all sequences
% of consecutive values
%
% a)
%
% remove_consecutive(l1..ln) = { [], n=0             }
%                              { l1, n=1             }
%                              { [], n=2 and l2=l1+1 }
%                              { remove_consecutive(l2..ln), l2=l1+1 and
%                              l3=l2+1               }
%                              { remove_consecutive(l3..ln), l2=l1+1 and
%                              l3!=l2+1              }
%                              { l1 U remove_consecutive(l2..ln),
%                              l2!=l1+1              }
%
% remove_consecutive(L: list, R: list)
% remove_consecutive(i,o)

remove_consecutive([],[]).
remove_consecutive([H],[H]).
remove_consecutive([H1,H2],[]):-
    H2 =:= H1+1.
remove_consecutive([H1,H2],[H1,H2]):-
    H2 =\= H1+1.
remove_consecutive([H1,H2,H3|T],R):-
    H2 =:= H1+1,
    H3 =:= H2+1,
    remove_consecutive([H2,H3|T],R).
remove_consecutive([H1,H2,H3|T],R):-
    H2 =:= H1+1,
    H3 =\= H2+1,
    remove_consecutive([H3|T],R).
remove_consecutive([H1,H2|T],[H1|R]):-
    H2 =\= H1+1,
    remove_consecutive([H2|T],R).
%
%
% b)
%
% delete_seq(l1..ln) = { [], n=0                            }
%                      { remove_consecutive(l1) U delete_seq(l2..ln), if
%                      is_list(l1)=true                     }
%                      { l1 U delete_seq(l2..ln), otherwise }
%
% delete_seq(L: list, R: list)
% delete_seq(i,o)
%  [1, [2, 3, 5], 9, [1, 2, 4, 3, 4, 5, 7, 9], 11, [5, 8, 2], 7]
delete_seq([],[]).
delete_seq([H|T],[H1|R]):-
    is_list(H),
    remove_consecutive(H,H1),
    delete_seq(T,R).
delete_seq([H|T],[H|R]):-
    delete_seq(T,R).
