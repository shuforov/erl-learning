-module(poolboy).
-export([start_link/0, stop/0, start_pool/3,
         run/2, sync_queue/2, async_queue/2, stop_pool/1]).

start_link() ->
    poolboy_supersup:start_link().

stop() ->
    poolboy_supersup:stop().

start_pool(Name, Limit, {M,F,A}) ->
    poolboy_supersup:start_pool(Name, Limit, {M,F,A}).

stop_pool(Name) ->
    poolboy_supersup:stop_pool(Name).

run(Name, Args) ->
    poolboy_serv:run(Name, Args).

async_queue(Name, Args) ->
    poolboy_serv:async_queue(Name, Args).

sync_queue(Name, Args) ->
    poolboy_serv:sync_queue(Name, Args).