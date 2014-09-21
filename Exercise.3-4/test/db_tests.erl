-module(db_tests).
-include_lib("eunit/include/eunit.hrl").

setup() ->
    Db1 = db:write(francesco,london,db:new()),
    Db2 = db:write(lelle, stockholm, Db1),
    db:write(joern, stockholm, Db2).

write_test_() ->
        [?_assertEqual([{joern, stockholm},{lelle,stockholm},{francesco,london}], setup())].

read_test_() ->
        Db = setup(),
        [?_assertEqual({ok,london}, db:read(francesco,Db)),
        ?_assertEqual({ok,stockholm},db:read(joern,Db)),
        ?_assertEqual({error,instance}, db:read(jose,Db))].

match_test_() ->
        Db = setup(),
        [?_assertEqual([lelle, joern], db:match(stockholm,Db)),
        ?_assertEqual([francesco],db:match(london,Db)),
        ?_assertEqual([], db:match(dublin,Db))].

delete_test_() ->
        Db = setup(),
        [?_assertEqual([{joern, stockholm},{francesco,london}], db:delete(lelle,Db)),
         ?_assertEqual([{joern, stockholm},{lelle,stockholm},{francesco,london}], db:delete(foo,Db))].



