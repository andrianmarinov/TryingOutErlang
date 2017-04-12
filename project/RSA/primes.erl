-module(primes).
-export([make_prime/1]).
-export([miller_rabin/2]).
-export([find_coPrime/1]).

-import(mathUtil, [int_pow/2]).
-import(randomUtil, [make_random/1, make_random_less_than/2, make_random_odd/1]).


make_prime(DigitsLong) ->
    PrimeCandidate = randomUtil:make_random_odd(DigitsLong),

    NumberOfIterations = 6,
    {D, R} = find_d_r(PrimeCandidate-1, 0),
    case primality_check(PrimeCandidate, {D, R}, NumberOfIterations) of 
        true -> PrimeCandidate;
        false -> make_prime(DigitsLong)
    end.


primality_check(PrimeCandidate, {D, R}, NumberOfIterations) when NumberOfIterations == 1 ->
    miller_rabin(PrimeCandidate, {D, R});

primality_check(PrimeCandidate, {D, R}, NumberOfIterations) when NumberOfIterations > 1 ->
    case miller_rabin(PrimeCandidate, {D, R}) of
        true -> primality_check(PrimeCandidate, {D, R}, NumberOfIterations -1);
        false -> false
    end.

find_d_r(EvenNumber, Power) ->
    case EvenNumber rem 2 of
        0 -> find_d_r(EvenNumber div 2, Power + 1);
        _ -> {EvenNumber, Power}
    end. 


miller_rabin(PrimeCandidate, {D, R}) -> 

    RandomLength = rand:uniform(617),
    RandomNumber = make_random_less_than(RandomLength, PrimeCandidate),
    EvenNumber = PrimeCandidate-1,
    X = mathUtil:int_pow_mod(RandomNumber, D, PrimeCandidate),
    case X of 
        1 -> true;
        EvenNumber -> true;
        _ -> additional_primality_check(X, PrimeCandidate, R)
    end.


additional_primality_check(_, _, R) when R == 0 ->
    false;

additional_primality_check(X, PrimeCandidate, R) ->
    NewX = X * X rem PrimeCandidate,
    EvenNumber = PrimeCandidate-1,
    case NewX of
        1 -> false;
        EvenNumber -> true;
        _ -> additional_primality_check(NewX, PrimeCandidate, R-1)
    end.


find_coPrime(Totient) ->
    Length = length(integer_to_list(Totient)) - 1,
    CoPrime = check_coPrime(Totient, Length),
    CoPrime.

check_coPrime(Totient, Length) ->
    Candidate = randomUtil:make_random(Length),
    if 
        Candidate < Totient ->
            case mathUtil:gcd(Totient, Candidate) of 
                1 -> Candidate;
                _ -> check_coPrime(Totient, Length)
            end;
        true ->
            check_coPrime(Totient, Length)          
    end.