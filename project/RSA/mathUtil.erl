-module(mathUtil).
-export([int_pow/2]).
-export([int_pow/3]).
-export([int_pow_mod/3]).
-export([gcd/2]).
-export([inv/2]).

int_pow(_X, 0) ->
             1;

int_pow(X, N) when N > 0 ->
             int_pow(X, N, 1).

int_pow(X, N, R) when N < 2 ->
              R * X;

int_pow(X, N, R) ->
              int_pow(X * X, N bsr 1, case N band 1 of 1 -> R * X; 0 -> R end).


int_pow_mod(B, E, M) ->
    case E of
        0 -> 1;
        _ -> case ((E rem 2) == 0) of
                 true  -> (int_pow(int_pow_mod(B, (E div 2), M), 2)) rem M;
                 false -> (B*int_pow_mod(B, E-1, M)) rem M
             end
    end.

inv(A, B) ->
         case solve(A, B) of
             {X, _} ->
                 if X < 0 -> X + B;
                    true  -> X
                 end;
             _ ->
                 no_inverse
         end.

gcd(A, 0) -> A;
 
gcd(A, B) -> gcd(B, A rem B).

solve(A, B) ->
    case catch s(A,B) of
        insoluble -> insoluble;
        {X, Y} ->
            case A * X - B * Y of
                1     -> {X, Y};
                _ -> error
            end
    end.

s(_, 0)  -> throw(insoluble);
s(_, 1)  -> {0, -1};
s(_, -1) -> {0, 1};
s(A, B)  ->
    K1 = A div B,
    K2 = A - K1*B,
    {Tmp, X} = s(B, -K2),
    {X, K1 * X - Tmp}.