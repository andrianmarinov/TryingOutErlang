-module(tut5).
-export([format_temps/1]).


format_temps([]) ->
    ok;

format_temps([Head | Tail]) ->
    print_temp(convert_temp(Head)),
    format_temps(Tail).



convert_temp({Name, {Temp, c}}) ->
    {Name, {Temp, c}};

convert_temp({Name, {Temp, f}}) ->
    {Name, {(Temp - 32) * 5 / 9, c}}.

print_temp({Name, {Temp, c}}) ->
    io:format(" ~-15w ~w c~n", [Name, Temp]).
