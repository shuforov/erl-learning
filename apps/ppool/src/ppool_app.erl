-module(ppool_app).
-behaviour(application).
-export([start/2, stop/1]).

start(normal, _Args) ->
  ppool:start_link().

stop(_State) ->
  ok.