-module(randomUtil).
-export([make_random/1]).
-export([make_random_less_than/2]).
-export([make_random_odd/1]).

-import(mathUtil, [int_pow/2]).

make_random(DigitsLong) ->
    make_random(0, DigitsLong).


make_random(CurrentValue, CurrentDigits) when CurrentDigits > 0 ->
    NewValue = CurrentValue + mathUtil:int_pow(generate_random_digit(), CurrentDigits),
    NewDigits = CurrentDigits - 1,
    make_random(NewValue, NewDigits);

make_random(CurrentValue, CurrentDigits) when CurrentDigits == 0 ->
    CurrentValue.


make_random_less_than(DigitsLong, Value) ->
    CurrentCandidate = make_random(DigitsLong),
    case CurrentCandidate < Value of 
        true -> CurrentCandidate;
        false -> make_random_less_than(DigitsLong-1, Value)
    end.


make_random_odd(DigitsLong) ->
    OddCandidate = make_random(DigitsLong),
    case OddCandidate rem 2 of
        0 -> make_random_odd(DigitsLong);
        _ -> OddCandidate
    end.

generate_random_digit() ->
    rand:uniform(9).