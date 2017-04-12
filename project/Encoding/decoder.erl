-module(decoder).
-export([decode/2]).


decode(String, Alphabet) ->
    Base = string:len(Alphabet),
    decode(String, Alphabet, Base, 0, 0).


decode([], _, _, _, Result) ->
    Result;

decode([Head | Tail], Alphabet, Base, CurIndex, Result) ->
    IndexOf = string:chr(Alphabet, Head)-1,
    NewResult = Result + IndexOf * int_pow(Base, CurIndex),
    decode(Tail, Alphabet, Base, CurIndex+1, NewResult).

int_pow(_X, 0) ->
        1;
int_pow(X, N) when N > 0 ->
        int_pow(X, N, 1).

int_pow(X, N, R) when N < 2 ->
        R * X;
int_pow(X, N, R) ->
        int_pow(X * X, N bsr 1, case N band 1 of 1 -> R * X; 0 -> R end).



