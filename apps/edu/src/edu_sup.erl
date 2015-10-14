-module(edu_sup).
-behaviour(supervisor).

-export([init/1]).



init([]) ->
  {ok, {{one_for_one, 5, 10}, [

    {dekan,
      {edu_dekan, start_link, []},
      permanent,
      infinity,
      supervisor,
      []}

  ]}}.


%% {
%% imagick_sup,
%% {imagick_sup, start_link, []},
%% permanent, infinity, supervisor, []
%% },