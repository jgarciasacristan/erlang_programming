-module(frequency).
-export([start/0, stop/0, allocate/0, deallocate/1]).
-export([init/0]).


start()->
    register(frequency, spawn(frequency, init, [])).

init()->
    Frequencies = {get_frequencies(), []},
    loop(Frequencies).

get_frequencies() ->
    [10,11,12,13,14,15].

%% The client functions

stop() ->
    call(stop).

allocate() ->
    call(allocate).

deallocate(Freq) ->
    call({deallocate, Freq}).


call(Message) ->
    frequency ! {request, self(), Message},
    receive 
	{reply, Reply} ->
	    Reply
    end.


%% The main loop

loop(Frequencies) ->
    receive 
	{request, Pid, allocate} ->
            case count_frequencies(Frequencies,Pid) of
		3 -> reply(Pid, max_frequencies_reached),
                     loop(Frequencies);
                _ -> {NewFrequencies, Reply} = allocate(Frequencies, Pid),
		     reply(Pid, Reply),
		     loop(NewFrequencies)
	    end;
	{request, Pid, {deallocate, Freq}} ->
	    {Response,NewFrequencies} = deallocate(Frequencies, {Freq,Pid}),
	    reply(Pid,Response),
	    loop(NewFrequencies);
	{request,Pid,stop} ->
            case Frequencies of 
		{_,[]} -> reply(Pid,ok);
		{_, Allocated} -> reply(Pid, {allocated, Allocated}),
				  loop(Frequencies)
	    end
    end.

reply(Pid, Reply) ->
    Pid ! {reply, Reply}.

allocate({[],Allocated}, _Pid) ->
    {{[],Allocated},{error, no_frequency}};
allocate({[Freq|Free], Allocated}, Pid) ->
    {{Free,[{Freq,Pid}|Allocated]},{ok, Freq}}.


deallocate({Free, Allocated}, {Freq, Pid}) ->
    NewAllocated=lists:delete({Freq,Pid},Allocated),
    case NewAllocated of
	Allocated -> {error,{Free,Allocated}};
	_ -> {ok, {[Freq|Free], NewAllocated}}
    end.

count_frequencies({_, Allocated} = _Frequencies, Pid) ->
    length([F || {F,P} <- Allocated, P == Pid]). 
			
