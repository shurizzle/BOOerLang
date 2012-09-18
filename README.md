This example is self-explanatory:

```
{ok, Func} = booerlang:eval("(one || two) && !three"). % {ok, #Fun<erl_eval.[...]>}
Func(["one", "three"]). % false
Func(["two", "three"]). % false
Func(["one", "two", "three"]). % false
Func(["one"]). % true
Func(["two"]). % true
Func(["one", "two"]). % true
Func(["one", "two", "banana"]). % true
{ok, Func2} = booerlang:eval("(one ^ two) && !three"). % {ok, #Fun<erl_eval.[...]>}
Func2(["one", "two"]). % false
Func2(["one"]). % true
Func2(["two"]). % true
```
