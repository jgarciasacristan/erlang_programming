-module(sum_tests).
-include_lib("eunit/include/eunit.hrl").

sum_1_test_() ->
        [?_assertEqual(15, sum:sum(5)),
        ?_assertEqual(0, sum:sum(0)),
        ?_assertError(function_clause, sum:sum(-2))].

sum_2_test_() ->
        [?_assertEqual(6, sum:sum(1,3)),
        ?_assertEqual(6, sum:sum(6,6)),
        ?_assertError(function_clause, sum:sum(7,4))].

