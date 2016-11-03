-module(blood_shooting_main).
-export([start/1, stop/1, loop/3, socket/2, player_timer/2, player_talker/2]).
%-record(person, {name, id, email}).
-include("p.hrl").

start(Port) ->
	{ok, Socket} = gen_udp:open(Port, [list, {active,false}]),
	Map = [20, 20, [(rand:uniform(10) div 10) || _ <- lists:seq(1, 400)]],
	spawn(?MODULE, socket, [Socket, self()]),
	loop(Socket, [], Map).

stop(Socket) ->
	gen_udp:close(Socket).

loop(Socket, Players, Map) ->
	io:format("Players: ~w~n", [Players]),
	receive
		{user_message, {Ip, Port, Packet}} ->
			io:format("Ip ~w, port ~w, message ~w~n", [Ip, Port, Packet]),
			case lists:keyfind({Ip, Port}, 1, Players) of
				false -> 
					Timer = spawn(?MODULE, player_timer, [self(), {Ip, Port}]),
					Talker = spawn(?MODULE, player_talker, [Socket, {Ip, Port}]),
					Talker ! [map, Map],
					loop(Socket, lists:flatten([{{Ip, Port}, {timer, Timer}, {talker, Talker}} | Players]), Map);
				{_, Handler} -> 
					Handler ! ok,
					loop(Socket, Players, Map)
			end;
		{annihilate, Player} ->
			loop(Socket, lists:keydelete(Player, 1, Players), Map) 
	end.


socket(Socket, Loop) ->
	case gen_udp:recv(Socket, 0, 5000) of
		{ok, Message} ->
			Loop ! {user_message, Message},
			socket(Socket, Loop);
			%ToSend = p:encode_msg(#'Person'{name="abc def", id=345, email="a@example.com"}),
			%gen_udp:send(Socket, Ip, Port, Message),
		{error, _} ->
			io:format("No activity at ~w~n", [Socket]),
			socket(Socket, Loop)
	end.	

player_timer(Loop, Player) ->
	receive
		ok -> player_timer(Loop, Player)
	after
		30000 ->
			Loop ! {annihilate, Player}
	end.

player_talker(Socket, {Ip, Port}) ->
	receive
		annihilate -> ok;
		[map, Message] -> gen_udp:send(Socket, Ip, Port, list_to_binary([10 | Message]))
	end.