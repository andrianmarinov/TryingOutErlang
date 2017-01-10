-module(decoder).
-export([decode/2]).

decode(String, Alphabet) ->
    Base = string:len(Alphabet),
    decode(String, Alphabet, Base, 0, 0).


decode([], _, _, _, Result) ->
    Result;

decode([Head | Tail], Alphabet, Base, CurIndex, Result) ->
    IndexOf = string:chr(Alphabet, Head)-1,
    NewResult = Result + IndexOf * math:pow(Base, CurIndex),
    decode(Tail, Alphabet, Base, CurIndex+1, NewResult).








