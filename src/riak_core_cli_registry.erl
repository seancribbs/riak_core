%% -------------------------------------------------------------------
%%
%% Copyright (c) 2014 Basho Technologies, Inc.  All Rights Reserved.
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% -------------------------------------------------------------------
%% @doc This module tracks registrations for riak_cli integrations.

-module(riak_core_cli_registry).

-define(CLI_MODULES, [
                      riak_core_cluster_cli,
                      riak_core_handoff_cli,
                      riak_core_handoff_status
                     ]).

-export([
         register_node_finder/0,
         register_cli/0
        ]).

-spec register_node_finder() -> true.
register_node_finder() ->
    F = fun() ->
                {ok, MyRing} = riak_core_ring_manager:get_my_ring(),
                riak_core_ring:all_members(MyRing)
        end,
    riak_cli:register_node_finder(F).

-spec register_cli() -> ok.
register_cli() ->
   riak_cli:register(?CLI_MODULES).
