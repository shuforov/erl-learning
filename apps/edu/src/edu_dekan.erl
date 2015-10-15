-module(edu_dekan).
-behaviour(supervisor).
-export([start_link/0, init/1]).
-export([create_group/3, delete_group/1, get_group/1, all/0]).

start_link() ->
  supervisor:start_link({local,?MODULE},?MODULE, []).

init([]) ->
  ets:new(?MODULE, [set, named_table, public]),
%%   ets:insert(?MODULE,{Ref,Pid}) = supervisor:which_children(edu_dekan),
  {ok, {{one_for_one, 10, 60}, []}}.

create_group(Name,Limit,MFA={_,_,_}) ->
  Ref = make_ref(),

  {ok, Pid} = supervisor:start_child(?MODULE, {
    Ref,
    {edu_kurator, start_link, [Name,Limit,MFA]},
      transient, brutal_kill, supervisor, []
    }
  ),

  {Pid, Ref}.

delete_group(Ref) ->
  supervisor:delete_child({local, ?MODULE}, Ref).

get_group(Name) ->
  supervisor:get_childspec(Name).

all() ->
  ok.