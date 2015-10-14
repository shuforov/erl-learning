-module(edu_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_,_) ->
  supervisor:start_link({local, edu_sup}, edu_sup, []).

stop(_) ->
  ok.
