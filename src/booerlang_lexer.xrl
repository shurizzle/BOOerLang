%%% File    : booerlang.xrl
%%% Author  : shura
%%% Purpose : Token definitions for boolean expressions.

Definitions.

WS  = [\000-\s]
C   = [a-zA-Z0-9]

Rules.

\^    : {token,{'xor', TokenLine}}.
!     : {token,{'not',TokenLine}}.
\&\&  : {token,{'and',TokenLine}}.
\|\|  : {token,{'or',TokenLine}}.
[()]  : {token,{list_to_atom(TokenChars),TokenLine}}.
{C}+  : {token,{tag,TokenLine,TokenChars}}.
{WS}+ : skip_token.

Erlang code.
