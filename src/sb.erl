-module(sb).

-export([
    start/0,
    make/0,
    publish/1,
    subscribe/0
]).

start() ->
    application:ensure_all_started(?MODULE).

make() ->
    make:all([load]).

-define(SCOPE, l).

publish(Message) ->
    gproc_ps:publish(?SCOPE, ?MODULE, Message).

subscribe() ->
    gproc_ps:subscribe(?SCOPE, ?MODULE).
