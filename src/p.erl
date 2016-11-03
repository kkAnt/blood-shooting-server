%% -*- coding: utf-8 -*-
%% Automatically generated, do not edit
%% Generated by gpb_compile version 3.26.3
-module(p).

-export([encode_msg/1, encode_msg/2]).
-export([decode_msg/2, decode_msg/3]).
-export([merge_msgs/2, merge_msgs/3]).
-export([verify_msg/1, verify_msg/2]).
-export([get_msg_defs/0]).
-export([get_msg_names/0]).
-export([get_enum_names/0]).
-export([find_msg_def/1, fetch_msg_def/1]).
-export([find_enum_def/1, fetch_enum_def/1]).
-export([enum_symbol_by_value/2, enum_value_by_symbol/2]).
-export([get_service_names/0]).
-export([get_service_def/1]).
-export([get_rpc_names/1]).
-export([find_rpc_def/2, fetch_rpc_def/2]).
-export([get_package_name/0]).
-export([gpb_version_as_string/0, gpb_version_as_list/0]).

-include("p.hrl").
-include("gpb.hrl").



-spec encode_msg(_) -> binary().
encode_msg(Msg) -> encode_msg(Msg, []).


-spec encode_msg(_, list()) -> binary().
encode_msg(Msg, Opts) ->
    case proplists:get_bool(verify, Opts) of
      true -> verify_msg(Msg, Opts);
      false -> ok
    end,
    TrUserData = proplists:get_value(user_data, Opts),
    case Msg of
      #'Person'{} -> e_msg_Person(Msg, TrUserData)
    end.



e_msg_Person(Msg, TrUserData) ->
    e_msg_Person(Msg, <<>>, TrUserData).


e_msg_Person(#'Person'{name = F1, id = F2, email = F3},
	     Bin, TrUserData) ->
    B1 = begin
	   TrF1 = id(F1, TrUserData),
	   e_type_string(TrF1, <<Bin/binary, 10>>)
	 end,
    B2 = begin
	   TrF2 = id(F2, TrUserData),
	   e_type_int32(TrF2, <<B1/binary, 16>>)
	 end,
    if F3 == undefined -> B2;
       true ->
	   begin
	     TrF3 = id(F3, TrUserData),
	     e_type_string(TrF3, <<B2/binary, 26>>)
	   end
    end.



e_type_int32(Value, Bin)
    when 0 =< Value, Value =< 127 ->
    <<Bin/binary, Value>>;
e_type_int32(Value, Bin) ->
    <<N:64/unsigned-native>> = <<Value:64/signed-native>>,
    e_varint(N, Bin).

e_type_string(S, Bin) ->
    Utf8 = unicode:characters_to_binary(S),
    Bin2 = e_varint(byte_size(Utf8), Bin),
    <<Bin2/binary, Utf8/binary>>.

e_varint(N, Bin) when N =< 127 -> <<Bin/binary, N>>;
e_varint(N, Bin) ->
    Bin2 = <<Bin/binary, (N band 127 bor 128)>>,
    e_varint(N bsr 7, Bin2).



decode_msg(Bin, MsgName) when is_binary(Bin) ->
    decode_msg(Bin, MsgName, []).

decode_msg(Bin, MsgName, Opts) when is_binary(Bin) ->
    TrUserData = proplists:get_value(user_data, Opts),
    case MsgName of
      'Person' -> d_msg_Person(Bin, TrUserData)
    end.



d_msg_Person(Bin, TrUserData) ->
    dfp_read_field_def_Person(Bin, 0, 0,
			      id(undefined, TrUserData),
			      id(undefined, TrUserData),
			      id(undefined, TrUserData), TrUserData).

dfp_read_field_def_Person(<<10, Rest/binary>>, Z1, Z2,
			  F1, F2, F3, TrUserData) ->
    d_field_Person_name(Rest, Z1, Z2, F1, F2, F3,
			TrUserData);
dfp_read_field_def_Person(<<16, Rest/binary>>, Z1, Z2,
			  F1, F2, F3, TrUserData) ->
    d_field_Person_id(Rest, Z1, Z2, F1, F2, F3, TrUserData);
dfp_read_field_def_Person(<<26, Rest/binary>>, Z1, Z2,
			  F1, F2, F3, TrUserData) ->
    d_field_Person_email(Rest, Z1, Z2, F1, F2, F3,
			 TrUserData);
dfp_read_field_def_Person(<<>>, 0, 0, F1, F2, F3, _) ->
    #'Person'{name = F1, id = F2, email = F3};
dfp_read_field_def_Person(Other, Z1, Z2, F1, F2, F3,
			  TrUserData) ->
    dg_read_field_def_Person(Other, Z1, Z2, F1, F2, F3,
			     TrUserData).

dg_read_field_def_Person(<<1:1, X:7, Rest/binary>>, N,
			 Acc, F1, F2, F3, TrUserData)
    when N < 32 - 7 ->
    dg_read_field_def_Person(Rest, N + 7, X bsl N + Acc, F1,
			     F2, F3, TrUserData);
dg_read_field_def_Person(<<0:1, X:7, Rest/binary>>, N,
			 Acc, F1, F2, F3, TrUserData) ->
    Key = X bsl N + Acc,
    case Key of
      10 ->
	  d_field_Person_name(Rest, 0, 0, F1, F2, F3, TrUserData);
      16 ->
	  d_field_Person_id(Rest, 0, 0, F1, F2, F3, TrUserData);
      26 ->
	  d_field_Person_email(Rest, 0, 0, F1, F2, F3,
			       TrUserData);
      _ ->
	  case Key band 7 of
	    0 ->
		skip_varint_Person(Rest, 0, 0, F1, F2, F3, TrUserData);
	    1 -> skip_64_Person(Rest, 0, 0, F1, F2, F3, TrUserData);
	    2 ->
		skip_length_delimited_Person(Rest, 0, 0, F1, F2, F3,
					     TrUserData);
	    5 -> skip_32_Person(Rest, 0, 0, F1, F2, F3, TrUserData)
	  end
    end;
dg_read_field_def_Person(<<>>, 0, 0, F1, F2, F3, _) ->
    #'Person'{name = F1, id = F2, email = F3}.

d_field_Person_name(<<1:1, X:7, Rest/binary>>, N, Acc,
		    F1, F2, F3, TrUserData)
    when N < 57 ->
    d_field_Person_name(Rest, N + 7, X bsl N + Acc, F1, F2,
			F3, TrUserData);
d_field_Person_name(<<0:1, X:7, Rest/binary>>, N, Acc,
		    _, F2, F3, TrUserData) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_Person(Rest2, 0, 0, NewFValue, F2,
			      F3, TrUserData).


d_field_Person_id(<<1:1, X:7, Rest/binary>>, N, Acc, F1,
		  F2, F3, TrUserData)
    when N < 57 ->
    d_field_Person_id(Rest, N + 7, X bsl N + Acc, F1, F2,
		      F3, TrUserData);
d_field_Person_id(<<0:1, X:7, Rest/binary>>, N, Acc, F1,
		  _, F3, TrUserData) ->
    <<NewFValue:32/signed-native>> = <<(X bsl N +
					  Acc):32/unsigned-native>>,
    dfp_read_field_def_Person(Rest, 0, 0, F1, NewFValue, F3,
			      TrUserData).


d_field_Person_email(<<1:1, X:7, Rest/binary>>, N, Acc,
		     F1, F2, F3, TrUserData)
    when N < 57 ->
    d_field_Person_email(Rest, N + 7, X bsl N + Acc, F1, F2,
			 F3, TrUserData);
d_field_Person_email(<<0:1, X:7, Rest/binary>>, N, Acc,
		     F1, F2, _, TrUserData) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_Person(Rest2, 0, 0, F1, F2,
			      NewFValue, TrUserData).


skip_varint_Person(<<1:1, _:7, Rest/binary>>, Z1, Z2,
		   F1, F2, F3, TrUserData) ->
    skip_varint_Person(Rest, Z1, Z2, F1, F2, F3,
		       TrUserData);
skip_varint_Person(<<0:1, _:7, Rest/binary>>, Z1, Z2,
		   F1, F2, F3, TrUserData) ->
    dfp_read_field_def_Person(Rest, Z1, Z2, F1, F2, F3,
			      TrUserData).


skip_length_delimited_Person(<<1:1, X:7, Rest/binary>>,
			     N, Acc, F1, F2, F3, TrUserData)
    when N < 57 ->
    skip_length_delimited_Person(Rest, N + 7, X bsl N + Acc,
				 F1, F2, F3, TrUserData);
skip_length_delimited_Person(<<0:1, X:7, Rest/binary>>,
			     N, Acc, F1, F2, F3, TrUserData) ->
    Length = X bsl N + Acc,
    <<_:Length/binary, Rest2/binary>> = Rest,
    dfp_read_field_def_Person(Rest2, 0, 0, F1, F2, F3,
			      TrUserData).


skip_32_Person(<<_:32, Rest/binary>>, Z1, Z2, F1, F2,
	       F3, TrUserData) ->
    dfp_read_field_def_Person(Rest, Z1, Z2, F1, F2, F3,
			      TrUserData).


skip_64_Person(<<_:64, Rest/binary>>, Z1, Z2, F1, F2,
	       F3, TrUserData) ->
    dfp_read_field_def_Person(Rest, Z1, Z2, F1, F2, F3,
			      TrUserData).






merge_msgs(Prev, New) -> merge_msgs(Prev, New, []).

merge_msgs(Prev, New, Opts)
    when element(1, Prev) =:= element(1, New) ->
    TrUserData = proplists:get_value(user_data, Opts),
    case Prev of
      #'Person'{} -> merge_msg_Person(Prev, New, TrUserData)
    end.

merge_msg_Person(#'Person'{email = PFemail},
		 #'Person'{name = NFname, id = NFid, email = NFemail},
		 _) ->
    #'Person'{name = NFname, id = NFid,
	      email =
		  if NFemail =:= undefined -> PFemail;
		     true -> NFemail
		  end}.



verify_msg(Msg) -> verify_msg(Msg, []).

verify_msg(Msg, Opts) ->
    TrUserData = proplists:get_value(user_data, Opts),
    case Msg of
      #'Person'{} ->
	  v_msg_Person(Msg, ['Person'], TrUserData);
      _ -> mk_type_error(not_a_known_message, Msg, [])
    end.


-dialyzer({nowarn_function,v_msg_Person/3}).
v_msg_Person(#'Person'{name = F1, id = F2, email = F3},
	     Path, _) ->
    v_type_string(F1, [name | Path]),
    v_type_int32(F2, [id | Path]),
    if F3 == undefined -> ok;
       true -> v_type_string(F3, [email | Path])
    end,
    ok.

-dialyzer({nowarn_function,v_type_int32/2}).
v_type_int32(N, _Path)
    when -2147483648 =< N, N =< 2147483647 ->
    ok;
v_type_int32(N, Path) when is_integer(N) ->
    mk_type_error({value_out_of_range, int32, signed, 32},
		  N, Path);
v_type_int32(X, Path) ->
    mk_type_error({bad_integer, int32, signed, 32}, X,
		  Path).

-dialyzer({nowarn_function,v_type_string/2}).
v_type_string(S, Path) when is_list(S); is_binary(S) ->
    try unicode:characters_to_binary(S) of
      B when is_binary(B) -> ok;
      {error, _, _} ->
	  mk_type_error(bad_unicode_string, S, Path)
    catch
      error:badarg ->
	  mk_type_error(bad_unicode_string, S, Path)
    end;
v_type_string(X, Path) ->
    mk_type_error(bad_unicode_string, X, Path).

-spec mk_type_error(_, _, list()) -> no_return().
mk_type_error(Error, ValueSeen, Path) ->
    Path2 = prettify_path(Path),
    erlang:error({gpb_type_error,
		  {Error, [{value, ValueSeen}, {path, Path2}]}}).


prettify_path([]) -> top_level;
prettify_path(PathR) ->
    list_to_atom(string:join(lists:map(fun atom_to_list/1,
				       lists:reverse(PathR)),
			     ".")).



-compile({inline,id/2}).
id(X, _TrUserData) -> X.




get_msg_defs() ->
    [{{msg, 'Person'},
      [#field{name = name, fnum = 1, rnum = 2, type = string,
	      occurrence = required, opts = []},
       #field{name = id, fnum = 2, rnum = 3, type = int32,
	      occurrence = required, opts = []},
       #field{name = email, fnum = 3, rnum = 4, type = string,
	      occurrence = optional, opts = []}]}].


get_msg_names() -> ['Person'].


get_enum_names() -> [].


fetch_msg_def(MsgName) ->
    case find_msg_def(MsgName) of
      Fs when is_list(Fs) -> Fs;
      error -> erlang:error({no_such_msg, MsgName})
    end.


-spec fetch_enum_def(_) -> no_return().
fetch_enum_def(EnumName) ->
    erlang:error({no_such_enum, EnumName}).


find_msg_def('Person') ->
    [#field{name = name, fnum = 1, rnum = 2, type = string,
	    occurrence = required, opts = []},
     #field{name = id, fnum = 2, rnum = 3, type = int32,
	    occurrence = required, opts = []},
     #field{name = email, fnum = 3, rnum = 4, type = string,
	    occurrence = optional, opts = []}];
find_msg_def(_) -> error.


find_enum_def(_) -> error.


-spec enum_symbol_by_value(_, _) -> no_return().
enum_symbol_by_value(E, V) ->
    erlang:error({no_enum_defs, E, V}).


-spec enum_value_by_symbol(_, _) -> no_return().
enum_value_by_symbol(E, V) ->
    erlang:error({no_enum_defs, E, V}).



get_service_names() -> [].


get_service_def(_) -> error.


get_rpc_names(_) -> error.


find_rpc_def(_, _) -> error.



-spec fetch_rpc_def(_, _) -> no_return().
fetch_rpc_def(ServiceName, RpcName) ->
    erlang:error({no_such_rpc, ServiceName, RpcName}).


get_package_name() -> undefined.



gpb_version_as_string() ->
    "3.26.3".

gpb_version_as_list() ->
    [3,26,3].
