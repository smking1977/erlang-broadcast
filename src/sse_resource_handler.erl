-module(sse_resource_handler).
%-behaviour(cowboy_http_handler).

%-define(WSKey,{pubsub,wsbroadcast}).

-export([
	 init/3,
	 info/3,
	 terminate/3
	]).

init(_Type, Req, _Opts) ->
    io:fwrite('sse resource handler called...\n '),
      {Binding, Req2} = cowboy_req:binding(id, Req),

    gproc:reg({p, l, Binding}),
    Headers = [{<<"content-type">>, <<"text/event-stream">>}],
    {ok, Req3} = cowboy_req:chunked_reply(200, Headers, cors_headers:allow_origin(Req2)),
    {loop, Req3, #{counter => 1}}.

info({sb_update, _, Message}, Req, #{counter := Counter} = S) ->
    io:fwrite('sse info  called...\n '),

    case chunk(Req, { Message, Counter}) of
	ok ->
	    {loop, Req, S#{counter => Counter + 1}};        
	{error, _} ->
	    {ok, Req, S}
    end.

 chunk(Req, { Message, Counter}) ->
      cowboy_req:chunk(["id: ",
		     integer_to_list(Counter),
		     "\nevent: message",
		     "\ndata: ",
		      Message, 
		      "\n\n"], Req).
		   %%  jsx:encode(maps:without([message_type, message_id], Message), []), "\n\n"], Req).

terminate(_Reason, _Req, _State) ->
    gproc:goodbye().




    
