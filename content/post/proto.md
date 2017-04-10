+++
title = "File Management on Windows with Proto"
date = "2017-03-06"
tags = ["windows", "tools"]
description = "Everything I've needed to know about Proto."
+++

Dissatisfied with `explorer.exe`? Find drag-and-drop and manual window placement tedious? Like using the keyboard? Don't want to choose between the hundreds of Norton Commander clones? You should try [Proto](http://miechu.pl/proto/).

Proto is a fast, weird, original, keyboard-controlled file manager written by Mieszko Lassota. You get tabs, incremental subsequence filtering everywhere (eg. 'mp3' matches things like 'my panda <3' and 'badtimes.mp3'), renaming using regexes, an application launcher, and a nifty way to select groups of files, even if they're across filters or directories.

## Install

Proto doesn't seem to use the registry so just put it somewhere comfortable and run the executable.

## Help

We're on Windows, so press **F1** to get help in the form of key bindings for the current tab. There are different types of tabs, like file manager, program launcher, calculator, etc., and help is context sensitive, bringing up the commands for the current tab. Type some characters to filter the commands. Press **Escape** to escape help.

Unlike in most of the other tab types which filter by subsequence, in help filtering is done by substring.

## Invoke

Once it's running you can call up the Proto window by pressing **Alt-\`** (that's a backtick). This key can be changed in `$PROTODIR/Settings/Proto.xml`.

## Tabs

**Ctrl-t** opens a new file manager tab. **Ctrl-shift-t** duplicates the current tab. **Shift-return** opens a directory in a new tab.

**Ctrl-w** closes a tab.

**Ctrl-tab**, **ctrl-shift-tab**, **ctrl-<arrow>**, and **ctrl-<number>** let you select tabs. **Ctrl-shift-<arrow>** reorders a tab.

## Navigate

Use the arrow keys to change which item in the tab is highlighted. To descend into a highlighted directory, press **enter**. Press **backspace** to go up a directory. Pressing **enter** will also open a highlighted file with its default program. Press **tab** to bring up the launcher and open the highlighted item with a different program. If any items are selected they will be opened instead of the highlighted item.

## Select

Selected items are prepended by a bullet. If no items are selected the currently highlighted item is used as the selection for commands that take a filepath.

**Space** selects the currently highlighted item. **Ctrl-a** selects all the items, and pressing it again when everying is already selected deselects everything.  **Alt-a** toggles between selecting all files and directories. **Shift-down** selects the current item and highlights the next one. **Shift-right** behaves similarly, but on columns.

## Filtering

You can type a few characters to filter the contents of a tab using subsequence search. **Backspace** does what you'd expect. **Ctrl-Backspace** clears the filter. You can't usually have spaces in your filter because the space key selects the current item in the tab.

## File management

Cut, copy, and paste behave differently in Proto than they do in Explorer. Copy (**Ctrl-c**) puts filepaths in the clipboard, and then the clipboard is used as input for the cut and paste commands. Cut (**Ctrl-x**) moves the files in the clipboard to the tab's current location, while paste (**Ctrl-v**) copies files. So instead of choosing up front whether you're going to move or copy files like in Explorer, in Proto you first choose which paths you want to work with, and then choose whether to copy or move after navigating to the destination.

**Alt-c** appends the selection to the clipboard.

**Delete** deletes the selection. 

**Ctrl-n** creates a new directory. **Ctrl-space** displays the size of the selection in the lower right.

## Rename

**Ctrl-r** lets you rename the highlighted item. **Ctrl-Shift-r** lets you rename the selection using regular expressions. Captured groups can be accessed in the replacement using `$1`, `$2`, etc.

## Launcher

The launcher can be invoked from inside or outside of Proto using **Alt-space**. To get Proto to index the Start Menu so the launcher is useful, ensure `settings.links.indexMenuStart` is set to `True` in `$PROTODIR/Settings/AppLauncher.xml`. 

## Bookmarks

**Alt-1** opens a tab of bookmarks to your favourite directories and files. **Ctrl-b** adds a bookmark to the highlighted directory.

## Find

**Ctrl-f** searches recursively for files using wildcards (`*` and `?`) or regular expressions.

The grep ("Regex search IN files") function doesn't seem to work, unfortunately. It always crashes for me.

## Other shortcuts I use

* **Ctrl-s**: Change sort key.
* **Ctrl-.**: Open the windows context menu.
* **Ctrl-End**: Kill proto job, such as calculating file size. The current job shows up in the lower left corner of the Proto window.
* **Ctrl-h**: edit text file, quickview image (use arrows for folder slideshow)
* **Ctrl-g**: disk space chart
