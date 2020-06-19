print_solution([H|Tail]) :-
	write(H),
	nl,
	print_solution(Tail).


solution(S) :-
	S = [[Country1, FName1, LName1, Figure1],
             [Country2, FName2, LName2, Figure2],
             [Country3, FName3, LName3, Figure3],
	     [Country4, FName4, LName4, Figure4]],

	% Four countries are represented. 
	Countries = [usa, brazil, france, spain],
	Countries = [Country1, Country2, Country3, Country4],

	FNames = [italo, kolohe, jose, michel],
	permutation(FNames, [FName1, FName2, FName3, FName4]),

	LNames = [andino, carpio, bourez, ferreira],
	permutation(LNames, [LName1, LName2, LName3, LName4]),

	Figures = [layback, tube, aerial, snapback],
	permutation(Figures, [Figure1, Figure2, Figure3, Figure4]),

	% The star surfer for the USA was a man who realized a tube
	% but his first name wasn’t Michel.
	member([usa, FName1, _, tube], S), FName1 \= michel,

	% The Brazil’ star player was Italo, who hadn't made a Lay Back.
	member([brazil, italo, _, Figure2], S), Figure2 \= layback,

	% The one who made an Aerial wasn't a french.
	member([france, _, _, Figure3], S), Figure3 \= aerial,

	% Michel’s last name wasn’t Andino.
	member([_, michel, UnknownLName1, _], S), UnknownLName1 \= andino,

	% Jose’s last name was Carpio.
	member([_, jose, carpio, _], S),

	% Kolohe did not do an Aerial.
	member([_, kolohe, _, UnknownFigure1], S), UnknownFigure1 \= aerial,

	% The one who made a Snap Back had a last name of Ferreira but he wasn't spanish.
	member([UnknownCountry1, _, ferreira, snapback], S), UnknownCountry1 \= spain,

	% The surfer whose last name was Bourez represented France.
	member([france, _, bourez, _], S),

	% The american wasn’t Jose.
	member([_, UnknownFName1, _, tube], S), UnknownFName1 \= jose,

	print_solution(S).