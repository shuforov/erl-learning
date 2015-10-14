-module(edu_kurator).
-behaviour(supervisor).
-export([start_link/3, init/1]).

start_link(Name,Limit,MFA={_,_,_}) ->
  supervisor:start_link(?MODULE, [Name,Limit,MFA]).

init([Name,Limit,MFA={_,_,_}]) ->
  {ok, {{one_for_one, 10, 60}, []}}.
