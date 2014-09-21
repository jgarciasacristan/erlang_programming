-module(create_lists_tests).
-include_lib("eunit/include/eunit.hrl").

create_test_() ->
        [?_assertEqual([1,2,3,4], create_lists:create(4)),
        ?_assertEqual([1], create_lists:create(1)),
        ?_assertEqual([], create_lists:create(0)),
        ?_assertError(function_clause, create_lists:create(-3))].

reverse_create_test_() ->
        [?_assertEqual([4,3,2,1], create_lists:reverse_create(4)),
        ?_assertEqual([1], create_lists:reverse_create(1)),
        ?_assertEqual([], create_lists:reverse_create(0)),
        ?_assertError(function_clause, create_lists:reverse_create(-3))].

