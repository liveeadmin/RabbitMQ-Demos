%%   The contents of this file are subject to the Mozilla Public License
%%   Version 1.1 (the "License"); you may not use this file except in
%%   compliance with the License. You may obtain a copy of the License at
%%   http://www.mozilla.org/MPL/
%%
%%   Software distributed under the License is distributed on an "AS IS"
%%   basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
%%   License for the specific language governing rights and limitations
%%   under the License.
%%
%%   The Original Code is RabbitMQ Management Console.
%%
%%   The Initial Developer of the Original Code is VMware, Inc.
%%   Copyright (c) 2010-2011 VMware, Inc.  All rights reserved.
%%

-module(rabbit_mgmt_test_all).

-export([all_tests/0]).

all_tests() ->
    ok = eunit:test(rabbit_mgmt_test_unit,[verbose]),
    ok = eunit:test(rabbit_mgmt_test_http,[verbose]),
    io:format("Starting second node...~n"),
    ok = rabbit_mgmt_test_clustering:start_second_node(),
    io:format("...done.~n"),
    try
        ok = eunit:test(rabbit_mgmt_test_clustering,[verbose])
    after
        ok = rabbit_mgmt_test_clustering:stop_second_node()
    end,
    ok = rabbit_mgmt_test_db:test().
