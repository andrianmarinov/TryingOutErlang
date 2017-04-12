-module(encoder).
-export([encode/2]).


encode(Int, Alphabet) when is_integer(Int) ->
    Base = length(Alphabet),
    encode(Int, Alphabet, Base, []).

encode(Int, Alphabet, Base, Result) when Int =< Base-1 ->
    NewResult = [lists:nth(Int+1, Alphabet) | Result],
    printResult(lists:reverse(NewResult));

encode(Int, Alphabet, Base, Result) ->
    New_int = Int div Base,
    Remainder = Int rem Base,
    NewResult = [lists:nth(Remainder+1, Alphabet) | Result],
    encode(New_int, Alphabet, Base, NewResult).


printResult([]) ->
    io:format("~n");


printResult([Head | Tail]) ->
    io:format("~c", [Head]),
    printResult(Tail).
