-module(rsa).
-export([generate_key/0]).
-export([encrypt/2]).
-export([decrypt/2]).

-import(mathUtil, [int_pow/2]).
-import(primes, [make_prime/1, find_coprime/1]).


generate_key() -> 
    Length = 10, 
    PrimeN = primes:make_prime(Length),
    PrimeQ = primes:make_prime(Length),
    Totient = (PrimeN - 1) * (PrimeQ - 1),
    Coprime_e = primes:find_coPrime(Totient),
    Inverse = mathUtil:inv(Coprime_e, Totient),
    {{PrimeN, Coprime_e}, {PrimeN, Inverse}}.

encrypt(Message, {PrimeN, Coprime_e}) ->
    Encrypted_message = mathUtil:int_pow_mod(Message, Coprime_e, PrimeN),
    Encrypted_message. 

decrypt(Encrypted_message, {PrimeN, Inverse_d}) ->
    Message = mathUtil:int_pow_mod(Encrypted_message, Inverse_d, PrimeN),
    Message.
