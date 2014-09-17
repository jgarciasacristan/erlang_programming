-module(bool_tests).
-include_lib("eunit/include/eunit.hrl").

bool_test_() ->
       [?_assert(bool:b_not(false) =:= true),
        ?_assert(bool:b_not(true) =:= false),
        ?_assert(bool:b_and(true,true) =:= true),
	?_assert(bool:b_and(false,true) =:= false),
	?_assert(bool:b_and(false,false) =:= false),
	?_assert(bool:b_and(true,false) =:= false),
	?_assert(bool:b_or(true,true) =:= true),
	?_assert(bool:b_or(false,true) =:= true),
	?_assert(bool:b_or(false,false) =:= false),
	?_assert(bool:b_or(true,false) =:= true),
	?_assert(bool:b_nand(true,true) =:= false),
	?_assert(bool:b_nand(false,true) =:= true),
	?_assert(bool:b_nand(false,false) =:= true),
	?_assert(bool:b_nand(true,false) =:= true)
       ].
