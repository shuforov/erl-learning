-module(edu_dekan).
-behaviour(supervisor).
-export([start_link/0, init/1]).
-export([create_group/3, delete_group/1, get_group/1, all/0]).

start_link() ->
  supervisor:start_link({local,?MODULE},?MODULE, []).

init([]) ->
  {ok, {{one_for_one, 10, 60}, []}}.

create_group(Name,Limit,MFA={_,_,_}) ->
  {ok, Pid} = supervisor:start_child(?MODULE,

    {
    make_ref(),
    {edu_kurator, start_link, [Name,Limit,MFA]},
    permanent, infinity, supervisor, []
    }

  ),

  Pid.

delete_group(Pid) ->
  supervisor:delete_child(self(), Pid).

get_group(_) ->
  ok.

all() ->
  ok.