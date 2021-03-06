%%==============================================================================
%% Copyright 2015 Erlang Solutions Ltd.
%% Licensed under the Apache License, Version 2.0 (see LICENSE file)
%%==============================================================================
-module(amoc).

-define(INTERARRIVAL_DEFAULT, 30).
-define(INTERARRIVAL,
    application:get_env(amoc, interarrival, ?INTERARRIVAL_DEFAULT)).

-export([do/1]).

%% ------------------------------------------------------------------
%% Start scenario via shell script (run.sh)
%% ------------------------------------------------------------------
do([Scenario, Count]) ->
    do([Scenario, '1', Count]);
do([Scenario, Start, End]) ->
    application:ensure_all_started(amoc),
    S = list_to_integer(atom_to_list(Start)),
    E = list_to_integer(atom_to_list(End)),
    case amoc_local:do(Scenario, S, E) of
        ok ->
            ok;
        {error, _} ->
            exit(1)
    end.
