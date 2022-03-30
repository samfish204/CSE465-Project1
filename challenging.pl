% Samuel Fisher
% CSE465
% Project 1
% Dr. Femiani
% Due March 28, 2022

url("https://logic.puzzlebaron.com/pdf/B627ZQ.pdf").

solution([
['January',		'York',		'X-ray',	'Zenmoto'],
['February',	'Bauer',	'Romeo',	'Jaorm'],
['March',		'Charles',	'Oscar',	'Quenray'],
['April',		'Gilbert',	'Foxtrot',	'Nyeos'],
['May',			'Peters',	'Tango',	'Loald']
  ]).

commanders(['York', 'Bauer', 'Charles', 'Gilbert', 'Peters']).
battalions(['X-ray', 'Romeo', 'Oscar', 'Foxtrot', 'Tango']).
locations(['Zenmoto', 'Jaorm', 'Quenray', 'Nyeos', 'Loald']).

solve(T) :-
    T = [ ['January', C1, B1, L1],
          ['February', C2, B2, L2],
          ['March', C3, B3, L3],
          ['April', C4, B4, L4],
          ['May', C5, B5, L5]
        ],
    battalions(Battalions), permutation(Battalions, [B1, B2, B3, B4, B5]),
    clue9(T),  % _, B, _
    commanders(Commanders), permutation(Commanders, [C1, C2, C3, C4, C5]),
    clue2(T),  % C, B, _
    clue4(T),  % C, B, _
    clue6(T),  % C, B, _
    clue8(T),  % C, B, _
    clue11(T), % C, B, _
    locations(Locations), permutation(Locations, [L1, L2, L3, L4, L5]),
    clue1(T),  % C, B, L
    clue3(T),  % C, B, L
    clue5(T),  % _, B, L
    clue7(T),  % C, B, L
    clue10(T), % C, B, L
	true.

number('January', 1).
number('February', 2).
number('March', 3).
number('April', 4).
number('May', 5).

% 9. Neither the battalion deploying in January nor the 
% battalion deploying in March is Romeo Battalion..
clue9(T) :-
    member(['January', _, B1, _], T),
    member(['March', _, B2, _], T),
    B1 \= 'Romeo',
    B2 \= 'Romeo'.

% 2. The battalion led by Commander Gilbert isn't X-ray Battalion..
clue2(T) :-
    member([_, 'Gilbert', B1, _], T),
    B1 \= 'X-ray'.

% 4. Romeo Battalion will deploy sometime before 
% the battalion led by Commander Charles..
clue4(T) :-
    member([M1, _, 'Romeo', _], T),
    member([M2, 'Charles', _, _], T),
    number(M1, N1),
    number(M2, N2),
    N1 < N2.

% 6. The battalion led by Commander York won't deploy in February..
clue6(T) :-
    member([M1, 'York', _, _], T),
    M1 \= 'February'.

% 8. The battalion led by Commander Charles is either 
% Romeo Battalion or the battalion deploying in March..
clue8(T) :-
    member([M1, 'Charles', B1, _], T),
    (   B1 = 'Romeo' ; M1 = 'March').

% 11. Of the battalion led by Commander Peters and Oscar Battalion,
% one will deploy in March and the other will deploy in
% May..
clue11(T) :-
    member([M1, 'Peters', _, _], T),
    member([M2, _, 'Oscar', _], T),
    (   M1 = 'March', M2 = 'May' ; M1 = 'May', M2 = 'March').

% 1. The battalion led by Commander Gilbert will deploy 
% 1 month after the group deploying to Quenray..
clue1(T) :-
    member([M1, 'Gilbert', _, _], T),
    member([M2, _, _, 'Quenray'], T),
    number(M1, N1),
    number(M2, N2),
    (   N2 + 1) =:= N1.

% 3. The battalion led by Commander Charles will deploy to Quenray..
clue3(T) :-
    member([_, 'Charles', _, L1], T), 
    L1 = 'Quenray'.

% 5. The battalion deploying in May won't deploy to Zenmoto..
clue5(T) :-
    member(['May', _, _, L1], T),
    L1 \= 'Zenmoto'.

% 7. The battalion led by Commander Bauer will deploy to Jaorm..
clue7(T) :-
    member([_, 'Bauer', _, L1], T),
    L1 = 'Jaorm'.

% 10. Of the battalion led by Commander Gilbert and Tango Battalion,
% one will deploy to Nyeos and the other will deploy in
% May..
clue10(T) :-
    member([M1, 'Gilbert', _, D1], T),
    member([M2, _, 'Tango', D2], T),
    (   M1 = 'May', D2 = 'Nyeos' ; D1 = 'Nyeos', M2 = 'May').



check :- 
	% Confirm that the correct solution is found
	solution(S), (solve(S); not(solve(S)), writeln("Fails Part 1: Does  not eliminate the correct solution"), fail),
	% Make sure S is the ONLY solution 
	not((solve(T), T\=S, writeln("Failed Part 2: Does not eliminate:"), print_table(T))),
	writeln("Found 1 solutions").

print_table([]).
print_table([H|T]) :- atom(H), format("~|~w~t~20+", H), print_table(T). 
print_table([H|T]) :- is_list(H), print_table(H), nl, print_table(T). 


% Show the time it takes to conform that there are no incorrect solutions
checktime :- time((not((solution(S), solve(T), T\=S)))).
