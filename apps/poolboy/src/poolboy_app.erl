-module(poolboy_app).
-behaviour(application).
-export([start/2, stop/1]).

start(normal, _Args) ->
  poolboy:start_link().

stop(_State) ->
  ok.