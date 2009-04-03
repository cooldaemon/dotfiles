-module(<+FILE NAME ROOT+>).
-author("Masahito Ikuta <cooldaemon@gmail.com>").

-behaviour(gen_server).

%% External API
-export([start_link/0, stop/0]).
<+CURSOR+>%-export([foo/1]).

%% gen_server callbacks
 -export([
  init/1,
  handle_call/3, handle_cast/2, handle_info/2,
  terminate/2, code_change/3
]).

%% External API
start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

stop() ->
  gen_server:call(?MODULE, stop).

%foo() ->
%  gen_server:cast(?MODULE, foo).

%% gen_server callbacks
init(_Args) ->
  {ok, State}.

handle_call(stop, _From, State) ->
  {stop, normal, stopped, State};

handle_call(_Message, _From, State) ->
  {reply, ok, State}.

%handle_cast(foo, State) ->
%  {noreply, State};

handle_cast(_Message, State) ->
  {noreply, State}.

terminate(Reason, _State) ->
  io:fwrite("Stop ~s (~p):~s~n", [?MODULE, self(), Reason]),
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%% Internal Functions

