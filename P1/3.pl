%
% 3.
% a. Define a predicate to remove from a list all repetitive elements.
%    Eg.: l=[1,2,1,4,1,3,4] => l=[2,3])
% b. Remove all occurrence of a maximum value from a list of integer
% numbers.
%
% a)
%
% is_member(l1..ln, e) = { true, l1 = e                    }
%                        { false, n = 0                    }
%                        { is_member(l2..ln, e), otherwise }
%
is_member([E|_],E):-!.
is_member([_|T],E):-
    is_member(T,E).

% del_rep_elem(l1..ln, e) = { l1...ln, if is_member(l1..ln, e)=false  }
%                           { [], if n=0                              }
%                           { l1 U del_rep_elem(l2..ln,e), if l1 != e }
%                           { del_rep_elem(l2..ln,e), if l1 = e       }
%
%del_rep_elem([H|T],E,[H|T]):-
 %   \+(is_member([H|T],E)).
del_rep_elem([],_,[]).

del_rep_elem([H|T],E,[H|R]):-
    H=\=E,
    del_rep_elem(T,E,R).
del_rep_elem([H|T],E,R):-
    H=:=E,
    del_rep_elem(T,E,R).

% remove_repetitive(l1..ln) = { [], if n=0                           }
%                             { remove_repetitive(del_rep_elem(l1..ln,
%                             l1)), if is_member(l2..ln,l1)=true }
%                             { remove_repetitive(l2..ln), otherwise }
%
remove_repetitive([],[]).
remove_repetitive([H|T],R):-
    is_member(T,H),
    del_rep_elem([H|T],H,R1),
    remove_repetitive(R1,R).
remove_repetitive([H|T],[H|R]):-
    remove_repetitive(T,R).

%
% b)
%
% max_number(x,y) = { x, if x>y }
%                   { y, if y>x }
%
max_number(X,Y,X):-
    X >= Y.
max_number(X,Y,Y):-
    Y > X.

% get_maximum(l1..ln) = { l1, if n=1  }                                }
%                       { max_number(l1, get_maximum(l2..ln)),
%                       otherwise     }
%
%
get_maximum([H],H).
get_maximum([H|T],R):-
    get_maximum(T,R1),
    max_number(H,R1,R).

%
% del_max(l1..ln) = { [], if n=0 }
%                   { del_rep_elem(l1..ln,get_maximum(l1..ln)),
%                   otherwise    }
%
del_max([],[]).
del_max(L,R):-
    get_maximum(L,M),
    del_rep_elem(L,M,R).
