-module(sb_game).
-behaviour(gen_server).

%% API
-export([start_link/1, set_state/2, get_state/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	 terminate/2, code_change/3]).

-define(SERVER, ?MODULE).


%%%===================================================================
%%% API
%%%===================================================================

set_state(Name, State) ->
    io:fwrite('set state function called...\n '),  
    io:fwrite('Name type - ~s \n', [script:type_of(Name)]),
    io:fwrite('Name:  ~w \n', [Name]),    
    sb_game_supervisor:start_match(Name),
    gen_server:cast({global, Name}, {set_state, State}).

get_state(Name) ->
    io:fwrite('get state function called...\n '), 
    io:fwrite('Name type - ~s \n', [script:type_of(Name)]),
    io:fwrite('Name:  ~w \n', [Name]),    
    gen_server:call({global, Name}, get_state).
 

start_link(Name) ->
    io:fwrite('sb_game - start_link function called \n'),
    io:fwrite('Name type - ~s \n', [script:type_of(Name)]),
    io:fwrite('Name:  ~w \n', [Name]),    

    gen_server:start_link({global, Name}, ?MODULE, [], []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Initializes the server
%%
%% @spec init(Args) -> {ok, State} |
%%                     {ok, State, Timeout} |
%%                     ignore |
%%                     {stop, Reason}
%% @end
%%--------------------------------------------------------------------
init([]) ->
    io:fwrite('sb_game init...\n '), 

   % set_state(Match_Name, State),
    {ok, []}.


%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling all non call/cast messages
%%
%% @spec handle_info(Info, State) -> {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
handle_info(_Info, State) ->
    {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
%%
%% @spec terminate(Reason, State) -> void()
%% @end
%%--------------------------------------------------------------------
terminate(_Reason, _State) ->
    ok.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Convert process state when code is changed
%%
%% @spec code_change(OldVsn, State, Extra) -> {ok, NewState}
%% @end
%%--------------------------------------------------------------------
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling cast messages
%%
%% @spec handle_cast(Msg, State) -> {noreply, State} |
%%                                  {noreply, State, Timeout} |
%%                                  {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
handle_cast({set_state, NewState}, _State) ->
    io:fwrite('handle cast set state -  ~s ...\n ', [NewState]),   
   % GenEvent.notify({:global, hd(state)}, {:update, map}),
    {noreply, NewState};
handle_cast(_Msg, state) ->
    {noreply, new_state}.


%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling call messages
%%
%% @spec handle_call(Request, From, State) ->
%%                                   {reply, Reply, State} |
%%                                   {reply, Reply, State, Timeout} |
%%                                   {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, Reply, State} |
%%                                   {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
handle_call(get_state, _From, State) ->
    io:fwrite('handle call get state -  ~s ...\n ', [State]),   
    {reply, State, State};
handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.


