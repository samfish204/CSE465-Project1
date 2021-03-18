
% TODO: url/1.
% TODO: solution/1.
% TODO: solve/1. 

check :- 
	solution(S), solve(S), 
	aggregate_all(count, (solve(_T)), Count), format("Found ~w solutions~n", [Count]), 
	Count=1. 


