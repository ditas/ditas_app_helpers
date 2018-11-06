%%%-------------------------------------------------------------------
%%% @author dmitryditas
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Окт. 2018 8:28
%%%-------------------------------------------------------------------
-module(types_helper).
-author("dmitryditas").

%% API
-export([
    val_to_list/1,
    val_to_float/1,
    val_to_integer/1
]).

val_to_list(Val) when is_float(Val) ->
    float_to_list(Val);
val_to_list(Val) when is_integer(Val) ->
    integer_to_list(Val);
val_to_list(Val) when is_binary(Val) ->
    binary_to_list(Val);
val_to_list(Val) ->
    Val.

val_to_float(Val) when is_float(Val) ->
    Val;
val_to_float(Val) when is_integer(Val) ->
    float(Val);
val_to_float(Val) when is_binary(Val) ->
    case (catch binary_to_float(Val)) of
        Float ->
            Float;
        {'EXIT', _Reason} ->
            case is_numeric(Val) of
                true ->
                    float(binary_to_integer(Val));
                false ->
                    0.0
            end
    end;
val_to_float(Val) when is_list(Val) ->
    val_to_float(list_to_binary(Val)).

val_to_integer(Val) when is_integer(Val) ->
    Val;
val_to_integer(Val) when is_float(Val) ->
    round(Val);
val_to_integer(Val) when is_binary(Val) ->
    case (catch binary_to_integer(Val)) of
        Int ->
            Int;
        {'EXIT', _Reason} ->
            case is_numeric(Val) of
                true ->
                    round(binary_to_float(Val));
                false ->
                    0
            end
    end;
val_to_integer(Val) when is_list(Val) ->
    val_to_integer(list_to_binary(Val)).

is_numeric(Val) ->
    Float = (catch binary_to_float(Val)),
    Int = (catch binary_to_integer(Val)),
    is_number(Float) orelse is_number(Int).