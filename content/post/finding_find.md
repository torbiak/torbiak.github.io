+++
title = "Finding find: Grasping Its Simple Expression Language"
date = "2017-03-08"
tags = ["find", "cli", "unix", "shell"]
description = "The important point that's difficult to glean from the manpage."
+++

## Confusion

I remember the first time I tried to use the `find` command on Linux, over a decade ago. I knew a substring of the name of a file I wanted to find, and found something on the web suggesting I use `find`, and was so disappointed when I couldn't just run `find $SUBSTR` and get my desired result. "Surely such a command exists," I thought. And it basically does, with `locate`, but I was searching directories that hadn't been indexed by `updatedb` and didn't know enough about globbing and quoting in `bash` to effectively give patterns to it. So I did some more searching on the web, learned I needed to give a `-name` predicate to find, and typed a lot of commands like the following over the next few years:

    find . -name "*$SUBSTR*"

[Here I'm using "predicate" to mean a term of an expression. It's the word the GNU manpage uses.]

Much later, after reading the bash manpage a few times, among other things, I wrote a shell function to make this specific task a bit shorter to type, giving me the command I had wished for years before:

    # find files under current directory containing a pattern
    function ff {
        pattern=${1:?No pattern given}; shift
        find . -iname "*${pattern}*" "$@" 2>/dev/null
    }

## Beyond names

Eventually I needed to find files based on their modification times and I started using the `-mtime` predicate. For example, to find files modified within the past 24 hours (`-mtime` takes units of 24 hours):

    find . -mtime -1

When using a condition like this, which could potentially match large numbers of uninteresting files, it quickly becomes obvious that further filtering is necessary. `egrep -v` can be used for this, but to avoid needlessly traversing directories and wasting time, using the `-prune` predicate is desirable. It was difficult to use properly without understanding find's little expression language, though.

## Essence of expressions

The `DESCRIPTION` in the manpage for GNU find makes sense now but it meant nothing to me in 2005. "...evaluating the given expression from left to right, according to the rules of precedence, until the outcome is known, at which point find moves on to the next file name." All it means, though, is that you give find a boolean expression composed of predicates and operators, and each file will get tested against it. Each predicate evaluates to true or false, and they are combined with the AND (`-a`) and OR (`-o`) operators. I don't remember how I came to understand this, but the best explanation I've seen is in chapter 9 of [Unix Power Tools](http://shop.oreilly.com/product/9780596003302.do).

A few pages down in the manpage, in the `EXPRESSION` section, we see there are several classes of predicates: tests, actions, options, and operators. `-mtime` and `-name` are examples of tests, `-print` is the default action, `-maxdepth` is an example of an option, and `-a` (AND) is the default operator. It might seem weird to include actions and options in a boolean expression of tests, and it is, but it works well. They can be shoehorned in with the tests because they also returning boolean values: most actions always return true, and options always return true. `-print`, the most commonly used action, always returns true.

After grasping this key point, that find is just evaluating a boolean expression, it's easy to write elaborate find commands. Starting with something simple, though:

    $ ls
    bar  foo
    $ find . -name foo -a -print
    ./foo
    $ find . -name foo
    ./foo

find reads the current directory, gets `bar`, tests it against `-name foo`, which evaluates to false, and short-circuits on the `-a` operator, continuing on to `foo`, which tests true with `-name foo` and so gets printed by `-print`. By using find's default action and operator we can type a bit less.

## Prune

Back to `-prune`. We're still searching for `foo`, but let's say there's also a directory we don't want to descend into, called `cache`. There's a file called `foo` in it so it's easier to tell if it's getting searched.

    # List files (-type f) under the working directory.
    $ find . -type f
    ./cache/foo
    ./bar
    ./foo

    $ find . -name cache -prune -o -name foo -print
    ./foo

When find is testing `cache`, `-name cache` returns true, so `-prune` gets run, which removes `cache` from the list of directories to descend into and returns true. The return value of the whole expression is then known because the left side of the OR (`-o`) is true, so find moves onto the next file. When testing `foo`, `-name cache` returns false, failing the left side of the OR, so find moves to the right side where `-name foo` returns true, resulting in `./foo` being printed.

## Default action

If an expression doesn't print or execute anything, find treats it as if it were surrounded in parentheses and followed by a print action: `( EXPR ) -print`. For example, if we remove `-print` from the previous command:

    $ find . -name cache -prune -o -name foo
    ./cache
    ./foo

`cache` gets printed because `-prune` returns true, making the overall expression true for it.

## Parens

As with many expression languages, parentheses can be used to force precedence. They need to be escaped or quoted so the shell doesn't treat them specially:

    $ find . -name cache -prune -o \( -name foo -o -name bar \) -print
    ./bar
    ./foo

## Troubleshooting

If an expression isn't behaving as expected, `-exec` or `-printf` can be used to visualize what's actually happening. If portability is important, note that `-printf` is a GNU extension and isn't specified in [POSIX](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/find.html).

    $ find . -name cache -printf "pruning %p\n" -prune -o -name foo -print
    pruning ./cache
    ./foo

    $ find . -name cache -exec echo pruning {} \; -prune -o -name foo -print
    pruning ./cache
    ./foo

## Manpage as reference

find has a lot of useful tests and actions, so check out the manpage on your system for details. Of the POSIX-specified predicates I've found `-perm`, `-user`, and `-size` particularly useful, and for GNU extensions I've frequently used `-maxdepth`, `-mmin`, `-regex`, and `-ls`.
