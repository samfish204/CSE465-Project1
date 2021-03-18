%  Solves a challenging puzzle


% Replace this with the URL of your puzzle
url("https://logic.puzzlebaron.com/pdf/R164KS.pdf").

% Put the hard-coded solution to your puzzle here
% TODO -- use a nested list as your table.. 
solution([['March 8',    'Edwin',  'PBS',      'Black and white'],
	  ['June 6',     'Itzel',  'CNN',      'Peanut butter'],
 	  ['August 1',   'Jordan', 'Showtime', 'Chocolate chip'],
 	  ['October 16', 'Aubrey', 'Cinemax',  'Almond']]).


% Put the predicate that solves your puzzle here
% TODO
solve(Table) :-	
	Table = [['March 8', Name1, Channel1, Cookies1],
	         ['June 6',  Name2, Channel2, Cookies2],
		 ['August 1', Name3, Channel3, Cookies3], 
		 ['October 16', Name4, Channel4, Cookies4]], 
	permutation([Name1, Name2, Name3, Name4], ['Edwin', 'Itzel', 'Jordan', 'Aubrey']),
	permutation([Channel1, Channel2, Channel3, Channel4], ['PBS', 'CNN', 'Showtime', 'Cinemax']),
	permutation([Cookies1, Cookies2, Cookies3, Cookies4], ['Black and white', 'Peanut butter', 'Chocolate chip', 'Almond']),
	clue1(Table), 
	clue2(Table), 
	%clue3(Table),
	%clue3(Table), 
	%clue4(Table), 
	%clue5(Table),
	%clue6(Table), 
	%clue7(Table), 
	%clue8(Table),
	%clue9(Table),
	true. 


% This rule checks your solution
check :- solution(S), solve(S),  aggregate_all(count, (solve(_T)), Count), ( Count = 1, format("Solved~n"); format("Found ~w solutions~n", [Count])). 
check :- format("Failedi~n"). 


% Make a rule for each clue below here. 


%1. Of the person who watched PBS and the baker who made almond cookies, one left for vacation on March 8 and the
%   other left for vacation on October 16.
clue1(T) :- member([D1, _, 'PBS', K1], T), member([D2, _, C2, 'Almond'], T), C2 \= 'PBS', K1 \= 'Almond', permutation([D1, D2], ['March 8', 'October 16']). 

%2. The person who watched PBS went on vacation before Jordan.
dates(['March 8', 'June 6', 'August 1', 'October 16']). 
before(D1, D2) :- dates(D), nth0(N1, D, D1), nth0(N2, D, D2), N1 < N2. 
clue2(T) :- member([D1, _, 'PBS', _], T), member([D2, 'Jordan', _, _], T), before(D1, D2). 

%3. The vacationer who left on March 8 is Edwin.
%4. Either the person who watched Showtime or the person who watched Cinemax is Jordan.
%5. The baker who made peanut butter cookies didn't watch PBS.
%6. Jordan didn't watch Cinemax and didn't leave for vacation on June 6.
%7. The person who watched CNN went on vacation before the person who watched Cinemax.
%8. The baker who made chocolate chip cookies watched Showtime.
%9. The person who watched CNN is not Aubrey.
