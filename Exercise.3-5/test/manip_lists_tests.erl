-module(manip_lists_tests).
-include_lib("eunit/include/eunit.hrl").


filter_test_() ->
        [?_assertEqual([1,2,3], manip_lists:filter([1,2,3,4,5],3))].


reverse_test_() ->
        [?_assertEqual([1,2,3], manip_lists:reverse([3,2,1]))].


concatenate_test_() ->
        [?_assertEqual([1,2,3,4,five], manip_lists:concatenate([[1,2,3],[],[4,five]]))].
