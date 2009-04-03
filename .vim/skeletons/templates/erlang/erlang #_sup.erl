-module(<+FILE NAME ROOT+>).
-author('cooldaemon@gmail.com').

-behaviour(supervisor).

%% External exports
-export([start_link/0, stop/0]).

%% supervisor callbacks
-export([init/1]).

%% External exports
start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

stop() ->
  case whereis(?MODULE) of
    Pid when is_pid(Pid) ->
      exit(Pid, normal),
      ok;
    _Other ->
      not_started
  end.

%% supervisor callbacks
init([]) ->
  {ok, {
    {one_for_one, 2000, 1},
    [
      <+CURSOR+>{Id, {Module, Function, Args}, permanent, infinity, supervisor, []},
      {Id, {Module, Function, Args}, permanent, brutal_kill, worker, []}
    ]
  }}.

