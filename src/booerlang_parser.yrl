Nonterminals
expressions element.

Terminals '(' ')' 'and' 'or' 'xor' 'not'
tag.

Rootsymbol expressions.

expressions -> element : '$1'.
expressions -> 'not' expressions : trans('$1') ++ '$2'.
expressions -> '(' expressions ')' : trans('$1') ++ '$2' ++ trans('$3').
expressions -> expressions 'and' expressions : '$1' ++ trans({'andalso', line_of('$2')}) ++ '$3'.
expressions -> expressions 'or' expressions : '$1' ++ trans({'orelse', line_of('$2')}) ++ '$3'.
expressions -> expressions 'xor' expressions : '$1' ++ trans({'xor', line_of('$2')}) ++ '$3'.

element -> tag : trans('$1').

Erlang code.

line_of({_, L}) ->
  L.

trans(Term = {_, _}) ->
  [Term];
trans({tag, L, Tag}) ->
  [
    {atom, L, booerlang},
    {':', L},
    {atom, L, bin_list},
    {'(', L},
    {var, L, 'Tags'},
    {',', L},
    {string, L, Tag},
    {')', L}
  ].
