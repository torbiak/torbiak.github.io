+++
title = "Failing to Write Useful Mouse Keys for X11"
date = "2017-03-07"
tags = ["X11", "linux", "keyboard", "trackpad"]
description = "My mouse keys daemon turned out less useful than expected because of X11's keyboard grab semantics."
+++

## Motivation

I've stuck with Apple laptops primarily because I haven't had a pleasant trackpad experience on anything else. But about a year ago I noticed I was spending all my time in a web browser and tmux and had disabled or was avoiding many of OSX's features, like the Dock, Dashboard, full-screen apps (due to the lengthy animations), Spotlight (because `mdworker` indexing processes have a history of going out of control and pinning CPUs), and iTunes. So I thought I might as well switch to Linux and the [suckless.org](http://suckless.org) desktop (`dwm`, `dmenu`, `st`), as long as I could get the trackpad working well enough.

Initially I had the synaptics touchpad driver installed, but after several hours of fruitless tweakingI gave up on making a usable configuration. It seemed impossible to get enough sensitivity while also adequately ignoring accidental touches using the given configuraiton parameters. So I tried the evdev and libinput drivers and thankfully the libinput driver gives very acceptable behaviour, though it's still a ways off from the magic of Apple's driver, which has never failed to behave as expected when pointing or scrolling.

Anyway, all this fussing over trackpads made me wonder if controlling the pointer using the keyboard could be a better experience. An efficient enough mouse keys implementation could also be useful for people with trackpad-specific RSI, or in the admittedly rare situations where both a trackpad and mouse are unavailable or infeasible, like if you wanted to control a media PC with only a keyboard.

## Existing solution

I tried out the keypad pointer keys in X11 (`setxkbmap -option keypad:pointerkeys`), but they aren't fluid when changing direction and it's a pain to set up pointer keys on keys other than the keypad. Worst of all, accelerating the pointer after a movement key has been pressed down for a while is counter to how I usually point at things: flinging the pointer over to the general area of my target before carefully zeroing in on it. So I started writing my own, calling it [`ptrkeys`](https://github.com/torbiak/ptrkeys).

## Inspiration

Having decided acceleration was the wrong way to make mouse keys efficient, I tried out some schemes where the speed could be changed instantly. My first idea was to have "dual-sticks", two sets of directional keys, one for coarse and the other for fine control, but this was surprisingly difficult to use. It was far more intuitive to use WASD for directional control while using the thumb and pinky or the other hand to change the speed using speed multiplier keys.

dwm served as a model for most of the Xlib interactions I needed to do. Its method of defining X11 key bindings at compile time using C99 struct initializations is surprisingly simple and flexible, and using a similar method has allowed me to try out totally different binding schemes with minimal changes.

The tricky part was understanding exactly how X11 keyboard grabs work. X generally directs keyboard events to the focused window, but a keyboard can be "grabbed" as a whole or on a per-key basis so that its events are sent elsewhere. For example, pressing a key implicitly sets up a single-key grab so the subsequent release event is received by the same window that got the keypress. ptrkeys doesn't create a window that can be focused, so a single-key grab is necessary to setup a "global hotkey" that can be used to enable ptrkeys by grabbing the entire keyboard and thus "activating" the rest of its configured key bindings.

## Downfall

Grabs also ended up being the downfall of the project: any full-featured desktop environment grabs the whole keyboard when opening a menu for a taskbar, menubar, or system tray, so that it can be navigated with the keyboard without changing the currently focused window. If ptrkeys already has the keyboard grabbed, the desktop environment's attempt to grab it fails and the menu typically doesn't open. This severely limits the applicability of ptrkeys. And it doesn't seem like there's a way around grabbing the whole keyboard either since a single-key grab becomes a whole-keyboard grab while it's active.

So, while `ptrkeys` likely isn't useful for anyone using a desktop environment like GNONE, KDE, or XFCE, it might be for those using tiling window managers. [Check it out on github](https://github.com/torbiak/ptrkeys).
