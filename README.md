mt-shorthand
============

Provides short handed template tags. e.g. &lt;mt:h hoge&gt; stands for &lt;mt:var name="hoge"&gt; escape="html">.

## Tags Output Variable

### mt:v

It is short for mt:var.
You can use attribute 'n' as 'name'.

### mt:e

Alias of mt:v. e means echo.

### mt:h

It if short for mt:var with escape="html".

## Tags Set Variable

### mt:s

s means set.
Set variables about each attribute.

`<mt:s foo="bar" hoge="fuga">` sets $foo as 'bar' and $hoge as 'fuga'.

### mt:d

d means defaults.
Set variables about each attribute if empty.

`<mt:s foo="bar" hoge="fuga">` sets $foo as 'bar' and $hoge as 'fuga' **if undef or empty string**.

### mt:sb

It is short for mt:SetVarBlock.

`<mt:sb n="foo" append="1">Hello</mt:sb>` appends 'Hello' to foo.

## Others

### mt:dump

It is a utility tag.
