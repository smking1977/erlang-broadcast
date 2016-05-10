-module(sb_application).
-behaviour(application).

-export([
    start/2,
    stop/1
]).

start(_Type, _Args) ->
    io:fwrite('started...\n '),
    case application:get_env(sb, http) of
        {ok, Environment} ->
            Dispatch = cowboy_router:compile([{'_', proplists:get_value(routes, Environment)}]),
            {ok, _} = cowboy:start_http(http, 100, [{port, proplists:get_value(port, Environment)}], [{env, [{dispatch, Dispatch}]}]),
	    sb_game_supervisor:start_link();
        undefined ->
            error_logger:error_msg("Configuration for fixtures http is absent"),
            {error, configuration_missing}
	end.
stop(_State) ->
    ok.

