-module(poolboy_supersup).
-behaviour(supervisor).
-export([start_link/0, stop/0, start_pool/3, stop_pool/1]).
-export([init/1]).

start_link() ->
  supervisor:start_link({local, zzz}, ?MODULE, []).

stop() ->
  case whereis(zzz) of
    P when is_pid(P) ->
      exit(P, kill);
    _ -> ok
  end.

start_pool(Name, Limit, MFA) ->
  ChildSpec = {Name,
    {poolboy_sup, start_link, [Name, Limit, MFA]},
    permanent, 10500, supervisor, [poolboy_sup]},
  supervisor:start_child(zzz, ChildSpec).

stop_pool(Name) ->
  supervisor:terminate_child(zzz, Name),
  supervisor:delete_child(zzz, Name).

init([]) ->
  {ok, {{one_for_one, 6, 3600}, [
%%
%%     {zzz2,
%%       {poolboy_sup, start_link, [defl, 10, []]},
%%       permanent, 10500, supervisor,[poolboy_sup]
%%     }

    ]}}.