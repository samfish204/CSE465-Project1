% Samuel Fisher
% CSE465
% Project 1
% Dr. Femiani
% Due March 28, 2022

url("https://logic.puzzlebaron.com/pdf/B970MB.pdf").

solution([
[1984,	'Miranda',	'Caprica',		'Trinidad'],
[1985,	'Greg',		'Farralon',		'Barbados'],
[1986,	'Ollie',	'Neptunia',		'Jamaica'],
[1987,	'Andre',	'Baroness',		'Saint Lucia'],
[1988,	'Eugene',	'Azure Seas',	'Grenada'],
[1989,	'Cory',		'Trinity',		'Aruba']
  ]).

names(['Miranda', 'Greg', 'Ollie', 'Andre', 'Eugene', 'Cory']).
cruise(['Caprica', 'Farralon', 'Neptunia', 'Baroness', 'Azure Seas', 'Trinity']).
destinations(['Trinidad', 'Barbados', 'Jamaica', 'Saint Lucia', 'Grenada', 'Aruba']).

solve(T) :- 
    T = [ [1984, N1, C1, D1],
          [1985, N2, C2, D2],
          [1986, N3, C3, D3],
          [1987, N4, C4, D4],
          [1988, N5, C5, D5],
          [1989, N6, C6, D6]
        ],
    names(Names), permutation(Names, [N1, N2, N3, N4, N5, N6]),
    clue4(T),  % N, _, _
    destinations(Destinations), permutation(Destinations, [D1, D2, D3, D4, D5, D6]),
    clue5(T),  % N, _, D
    clue8(T),  % N, _, D
    clue9(T),  % N, _, D
    clue10(T), % N, _, D
    clue11(T), % N, _, D
    cruise(Cruise), permutation(Cruise, [C1, C2, C3, C4, C5, C6]),
    clue1(T),  % N, C, _
    clue2(T),  % N, C, _
    clue3(T),  % N, C, D
    clue6(T),  % N, C, D
    clue7(T),  % N, C, _
    clue12(T), % N, C, D
    clue13(T), % N, C, D
	true.

% 4. Cory wasn't on the 1988 cruise.
clue4(T) :-
   member([Y1, 'Cory', _, _], T),
   Y1 \= 1988.

% 5. Greg didn't go to Saint Lucia.
clue5(T) :-
   member([_, 'Greg', _, D1], T),
   D1 \= 'Saint Lucia'.
    
% 8. Neither the traveler who took the 1985 cruise 
% nor the person who went to Trinidad is Eugene.
clue8(T) :-
    member([1985, N1, _, D1], T),
    member([Y2, N2, _, 'Trinidad'], T),
    N1 \= 'Eugene', N2 \= 'Eugene',
    D1 \= 'Trinidad', Y2 \= 1985.

% 9. The person who took the 1987 cruise is either
% Eugene or the person who went to Saint Lucia.
clue9(T) :-
    member([1987, N1, _, D1], T),
    (   N1 = 'Eugene', D1 \= 'Saint Lucia' ; D1 = 'Saint Lucia', N1 \= 'Eugene').

% 10. The person who took the 1985 cruise is either
% the traveler who went to Barbados or Cory.
clue10(T) :-
    member([1985, N1, _, D1], T),
    (   N1 = 'Cory', D1 \= 'Barbados' ; D1 = 'Barbados', N1 \= 'Cory').

% 11. Miranda set sail 4 years before the person who went to Grenada.
clue11(T) :-
    member([Y1, 'Miranda', _, _], T),
    member([Y2, _, _, 'Grenada'], T),
    Y2 - 4 =:= Y1.

% 1. Of the person who took the 1988 cruise and Ollie,
% one took the Neptunia cruise and the other took the 
% Azure Seas cruise.
clue1(T) :-
    member([1988, _, C1, _], T),
    member([_, 'Ollie', C2, _], T),
    (   C1 = 'Neptunia', C2 = 'Azure Seas' ; C1 = 'Azure Seas', C2 = 'Neptunia').

% 2. Of the traveler who took the 1986 cruise and Andre, 
% one took the Baroness cruise and the other took the Neptunia cruise.
clue2(T) :-
    member([1986, _, C1, _], T),
    member([_, 'Andre', C2, _], T),
    (   C1 = 'Baroness', C2 = 'Neptunia' ; C1 = 'Neptunia', C2 = 'Baroness').

% 3. The traveler who took the Neptunia cruise set sail 3 years 
% before the traveler who went to Aruba.
clue3(T) :-
    member([Y1, _, 'Neptunia', _], T),
    member([Y2, _, _, 'Aruba'], T),
    Y2 - 3 =:= Y1.

% 6. Miranda is either the person who went to 
% Jamaica or the traveler who took the Caprica cruise.
clue6(T) :-
    member([_, 'Miranda', C1, D1], T),
    (   C1 = 'Caprica', D1 \= 'Jamaica' ; D1 = 'Jamaica', C1 \= 'Caprica').

% 7. Cory wasn't on the Farralon cruise.
clue7(T) :-
    member([_, 'Cory', C1, _], T),
    C1 \= 'Farralon'.

% 12. The person who went to Saint Lucia set sail 3 
% years after the person who took the Caprica cruise.
clue12(T) :-
    member([Y1, _, _, 'Saint Lucia'], T),
    member([Y2, _, 'Caprica', _], T),
    Y2 + 3 =:= Y1.

% 13. Cory is either the person who took the Azure Seas
% cruise or the person who went to Aruba.
clue13(T) :-
    member([_, 'Cory', C1, D1], T),
    (   C1 = 'Azure Seas', D1 \= 'Aruba' ; D1 = 'Aruba', C1 \= 'Azure Seas').


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
