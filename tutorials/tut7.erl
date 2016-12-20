-module(tut7).
-export([reverse/1]).

reverse(List) ->
    reverse(List, []).


reverse([], Tail) ->
    Tail;


reverse([Head |Tail], NewList) ->
    reverse(Tail, [Head | NewList]).
