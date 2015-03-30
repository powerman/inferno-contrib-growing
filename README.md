This module provide dynamically growing arrays supporting up to 3 dimensions, which can be addressed both with positive and negative indexes.

Dependencies:
  * http://code.google.com/p/inferno-contrib-tap/ (only for tests)


---


To install system-wide (if your Inferno installed in your home directory or if you root):

```
# mkdir -p $INFERNO_ROOT/opt/powerman/
# hg clone https://inferno-contrib-growing.googlecode.com/hg/ $INFERNO_ROOT/opt/powerman/growing
```

To install locally for some project:

```
$ cd $YOUR_PROJECT_DIR
$ mkdir -p opt/powerman/
$ hg clone https://inferno-contrib-growing.googlecode.com/hg/ opt/powerman/growing
$ emu
; cd $YOUR_PROJECT_DIR_INSIDE_EMU
; bind opt /opt
```

Using it in your application (this will allow you to compile your application using both host OS and native limbo without additional options if it was installed locally, but if you installed this module system-wide, you'll need to use `-I$INFERNO_ROOT` for host OS limbo and `-I/` for native limbo):

```
include "opt/powerman/growing/module/growing.m";
	growing: Growing;
	Growing1, Growing2, Growing3: import growing;
growing = load Growing Growing->PATH;
```