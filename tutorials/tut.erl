-module(tut).
-export([double/1]).
-export([fac/1]).
-export([mult/2]).
-export([convert/2]).
-export([convert_length/1]).
-export([list_length/1]).

fac(1) ->
    1;

fac(X) ->
    X * fac(X-1).


double(X) -> 
    2 * X.


mult(X, Y) ->
    X * Y.


convert(X, inch) ->
    X / 2.54;

convert(Y, centimeter) ->
    Y * 2.54.

convert_length({centimeter, X}) ->
    {inch, X / 2.54};

convert_length({inch, Y}) ->
    {centimeter, Y * 2.54}.

list_length([]) -> 
    0;

list_length([_ | Rest]) ->
    1 + list_length(Rest).


