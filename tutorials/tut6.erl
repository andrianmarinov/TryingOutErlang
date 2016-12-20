-module(tut6).
-export([find_max/1]).

find_max([Head | Tail]) ->
    find_max(Tail, Head).


find_max([Head | Tail], Max) when Head > Max ->
           find_max(Tail, Head);


find_max([], Max) -> 
    Max;

find_max([_ | Tail], Max) ->
    find_max(Tail, Max).

