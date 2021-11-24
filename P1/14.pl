% a) Write a predicate to test equality of two sets without using the
% set difference.
%
% b) Write a predicate to select the n-th element of a given list.
%
% a)
%
% is_member(l1l2...ln, elem) = { false, if n=0                    }
%                              { true, if l1=elem                 }
%                              { member(l2...ln, elem), otherwise }
%
% is_member(L: list, E: number)
% is_member(i,i)
%
is_member([E|_],E):-!.
is_member([_|T],E):-
    is_member(T,E).

% list_length(l1l2...ln) = { 0, if n=0                         }
%                          { 1+list_length(l2...ln), otherwise }
%
% list_length(L: list, N: number)
% list_length(i,o)

list_length([],0).
list_length([_|T],L):-
    list_length(T,L1),
    L is L1+1.

% remove_element(l1l2...ln, elem) = { [], if n=0 }
%                                   { l1 U remove_element(l2...ln,
%                                   elem), if l1 != e }
%                                   { remove_element(l2...ln, elem), if
%                                   l1 = elem }
%
% remove_element(L: list, N: number, R: list)
% remove_element(i,i,o)
%
remove_element([],_,[]).
remove_element([H|T],E,R):-
    H=:=E, remove_element(T,E,R).
remove_element([H|T],E,[H|R]):-
    H=\=E, remove_element(T,E,R).

% check_set_equality(s1s2...sn, t1t2...tm) =
%               { true, if n=m=0                                }
%               { check_set_equality(remove_element(s2..sn, t1),
%               remove_element(t2..tm, s1)), if is_member(s1..sn,
%               t1)=true and is_member(t1..tm, s1)=true and n=m }
%               { false, otherwise                              }
%
% check_set_equality(S: list, T: list)
% check_set_equality(i,i)
%
check_set_equality([],[]).
check_set_equality([HS|TS], [HT|TT]):-
    list_length(TS,X),
    list_length(TT,Y),
    X=:=Y,
    is_member([HS|TS],HT),
    is_member([HT|TT],HS),
    remove_element(TS, HT, R1),
    remove_element(TT, HS, R2),
    check_set_equality(R1, R2).

% b)
% select_nth_number(l1l2...ln, nr) = { l1, nr=1 }
%{
% select(l1l2...ln,nr-1), otherwise }
%
% select_nth_number(L: list, N: number, R: number)
% select_nth_number(i,i,o)

select_nth_number([H|_], 1, H). %if N=1, we will select the head of the list
select_nth_number([_|T], N, R):-
    N1 is N-1,
    select_nth_number(T, N1, R).
