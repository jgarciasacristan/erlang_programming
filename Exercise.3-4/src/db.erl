-module(db).

-export([new/0, destroy/1, write/3, delete/2, read/2, match/2]).

new() -> [].

destroy(_) -> ok.

write(Key, Element, Db) -> [{Key, Element} | Db].

delete(_,[]) -> [];
delete(Key,[{Key, _}| T]) -> T;
delete(Key, [V |T]) -> [V|delete(Key,T)].

read(_,[]) -> {error,instance};
read(Key,[{Key,Element}|_]) -> {ok, Element};
read(Key, [_|T]) -> read(Key,T).  

match(_,[],Acc) -> Acc;
match(Element,[{Key,Element}|T],Acc) -> match(Element, T, [Key|Acc]); 
match(Element,[_|T],Acc) -> match(Element,T,Acc).

match(Element, Db) -> match(Element, Db, []). 

 
    


