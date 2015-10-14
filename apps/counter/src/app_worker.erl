-module(app_worker).
-behaviour(gen_server).
-export([start_link/0, init/1]).
-export([handle_call/3,handle_cast/2,handle_info/2,terminate/2, code_change/3]).
-export([get/0,up/0]).

-record(state,{counter}).

get() -> gen_server:call(?MODULE,{get}).
up() -> up(1).
up(Up_one)-> gen_server:call(?MODULE,{up, Up_one}).
start_link() ->
  gen_server:start_link({local, ?MODULE},?MODULE,[],[]).

init(_Args)->
  {ok,#state{counter = 0}}.

handle_call({get}, _From, State = #state{counter = Counter}) ->
  {reply, Counter, State};
handle_call({up, Up_one}, _From, State = #state{counter = Counter}) ->
  NewCounter = Counter + Up_one,
  {reply, NewCounter, State#state{counter=NewCounter}}.

handle_cast(_Msg, State) ->
  {noreply, State}.

handle_info(_Info, State)->
  {noreply, State }.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

terminate(_Reason, _State) ->
  ok.