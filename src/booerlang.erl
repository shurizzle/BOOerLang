-module(booerlang).
-export([in_list/2, bin_list/2, parse/1, eval/1]).

parse(Str) ->
  {ok, Tokens, _} = booerlang_lexer:string(Str),
  {ok, ErlBoolTokens} = booerlang_parser:parse(Tokens),
  ETokens = [{'fun', 1},
      {'(', 1},
      {var, 1, 'T'},
      {')', 1},
      {'->', 1},
      {var, 1, 'Tags'},
      {'=', 1},
      {atom, 1, lists},
      {':', 1},
      {atom, 1, sort},
      {'(', 1},
      {var, 1, 'T'},
      {')', 1},
      {',', 1}
    ] ++ ErlBoolTokens ++ [
      {'end', 1},
      {dot, 1}
    ],
    erl_parse:parse_exprs(ETokens).

eval(Str) ->
  {ok, ErlForms} = parse(Str),
  {value, Func, _} = erl_eval:exprs(ErlForms, erl_eval:new_bindings()),
  {ok, Func}.

in_list([H|_], H) ->
  true;
in_list([], _) ->
  false;
in_list([_|R], E) ->
  in_list(R, E).

bin_list(List, Key) ->
  binsearch(List, Key, 1, length(List)) >= 0.

binsearch(_, _, Lower, Upper) when Upper < Lower ->
  -1;
binsearch(List, Key, Lower, Upper) ->
  Mid = (Lower + Upper) div 2,
  Item = lists:nth(Mid, List),
  if
    Key < Item ->
      binsearch(List, Key, Lower, Mid - 1);
    Key > Item ->
      binsearch(List, Key, Mid + 1, Upper);
    true ->
      Mid
  end.
