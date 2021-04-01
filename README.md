# Prolog Puzzle Project

## Overview
The "funnest" way I can think of to practice logic programming is to use it to solve a logic puzzle. 
A logic puzzle is typically presented as a mystery and list of clues that can be used to infer facts such as "who done it". 

For this assignment, we will use the [Printable Logic Puzzles](https://www.printable-puzzles.com/printable-logic-puzzles.php) website to find two puzzles to solve. One will be a "challenging" puzzle and the other will be a "Very Hard" puzzle. 


For this assignment, you will write all of the clues as rules in a prolog program. 

Your prolog file must obey the folowing format:

1.  The name of the prolog files must be 'challenging.pl' and 'veryhard.pl' 
2.  Your prolog file must provide a `url/1` fact to get the URL of the puzzle being solced. 
3.  Your prolog file must also provide a `solution/1` fact with the correct solution hardcoded in. You will get the correct solution from the [Printable Logic Puzzles](https://www.printable-puzzles.com/printable-logic-puzzles.php) website.
4.  Your prolog file must provide a `solve/1` rule that uses the clues to find one, and only one, table that is the solution. 
5.  Your puzzle must have a sereis of `clueX(T)` rules that are satisfied whenever the solution in `T` is consistent with clue X.  
6.  Your puzzle must include the `check` rule as follows:
```
check :- solution(S), solve(S), aggregate_all(count, (solve(_T)), Count), format("Found ~w solutions~n", [Count]), Count=1. 
```


To receive credit, your puzzle must find one, and only one, solution to the puzzle. 

Your assignment will be checked by running swipl in the docker container as follows:

```
swipl -q -g check -g halt challenging.pl 
```
or 
```
swipl -q -g check -g halt veryhard.pl 
```

which will use your `solve` and `solution` predicates to make sure you find exactly one solution and that it is the correct solution. 

You can, of course, work on your solution using  [SWISH](https://swish.swi-prolog.org/) in which case you may want to also use their [table rendering plugin](https://swish.swi-prolog.org/example/render_table.swinb) to display your solution.  Once you have a solution, however, you should confirm that it runs properly in the container. This may mean commenting out the part where you load the plugin. 

## Checking Your Solution
You will not be able to solve the veryhard puzzle without optimizing your solution. 
1.   Type `solution(S), solve(S)` to make sure you dont rule out the correct solution. This is always fast. 
2.   Type `soltuion(S), solve(T), T\=S` to find your first incorrect solution. This is usually fast enough. 
3.   Copy the incorrect soltuion from above and use     `T=<pasted from abov>, clueX(T)` to debug a clue.  

When you think you have it, use

```
make check
```
or 
```
make check-challenging
make check-veryhard
```

All of these MUST pass before you submit the assignment. 

## Submitting your solution

Submit a link to your fork of this repo to canvas. 



