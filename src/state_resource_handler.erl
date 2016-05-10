-module(state_resource_handler).

-export([init/3, handle/2, terminate/3]).



init(_Type, Req, _Opts) ->
    io:fwrite('state resource handler called...\n '),
    {ok, Req, no_state}.
   

 get_state(Req, Binding) ->
    cowboy_req:reply(200, [], sb_game:get_state(Binding), Req).


handle(Req, State) ->
    io:fwrite('state resource - handle\n '),
    {Method, Req2} = cowboy_req:method(Req),
    {Binding, Req3} = cowboy_req:binding(id, Req2),
    io:fwrite('state resource handler method: ~s, binding ~s, type of ~s ~n ', [Method, Binding,  script:type_of(Binding)]),

    case Method of
	<<"POST">> ->  
	    {ok, Body, Req4} = cowboy_req:body(Req3),
	    sb_game:set_state(Binding, Body), 
	    gproc:send({p, l, Binding},  {sb_update, Binding, Body}),
	    io:fwrite('state set about to return'),
	    {ok, Req5} = cowboy_req:reply(200, Req4),
	    {ok, Req5, State};
	<<"GET">> -> 
	    {ok, Req5} = get_state(Req, Binding),
	    {ok, Req5, State}
    end.


terminate(_Reason, _Req, _State) ->
        io:fwrite('state resource handler terminate.\n '),

    ok.
