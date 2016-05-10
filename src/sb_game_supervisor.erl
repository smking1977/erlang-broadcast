-module(sb_game_supervisor).
-behaviour(supervisor).

%% API
-export([start_link/0, start_match/1]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%%===================================================================
%%% API functions
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Starts the supervisor
%%
%% @spec start_link() -> {ok, Pid} | ignore | {error, Error}
%% @end
%%--------------------------------------------------------------------
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%%===================================================================
%%% Supervisor callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Whenever a supervisor is started using supervisor:start_link/[2,3],
%% this function is called by the new process to find out about
%% restart strategy, maximum restart frequency and child
%% specifications.
%%
%% @spec init(Args) -> {ok, {SupFlags, [ChildSpec]}} |
%%                     ignore |
%%                     {error, Reason}
%% @end
%%--------------------------------------------------------------------
init([]) ->
    io:fwrite('sb_game_supervisor- init ...\n '),

    RestartStrategy = one_for_one,
    MaxRestarts = 1000,
    MaxSecondsBetweenRestarts = 3600,

    SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},

    {ok, {SupFlags, []}}.


start_match(Match_Name)->
    io:fwrite('sb_game_supervisor- start_match ...\n '),

    Restart = permanent,
    Shutdown = 2000,
    Type = worker,
    supervisor:start_child(?MODULE, {Match_Name,
				     {sb_game,  start_link, [Match_Name]},
                          Restart, Shutdown ,Type ,[sb_game]}).


%%%===================================================================
%%% Internal functions
%%%===================================================================
