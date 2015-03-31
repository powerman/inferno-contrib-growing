# Description

This module provide dynamically growing arrays supporting up to 3
dimensions, which can be addressed both with positive and negative
indexes.


# Install

Make directory with this module available in /opt/powerman/growing/.

Install system-wide:

```
# git clone https://github.com/powerman/inferno-contrib-growing.git $INFERNO_ROOT/opt/powerman/growing
```

or in your home directory:

```
$ git clone https://github.com/powerman/inferno-contrib-growing.git $INFERNO_USER_HOME/opt/powerman/growing
$ emu
; bind opt /opt
```

or locally for your project:

```
$ git clone https://github.com/powerman/inferno-contrib-growing.git $YOUR_PROJECT_DIR/opt/powerman/growing
$ emu
; cd $YOUR_PROJECT_DIR_INSIDE_EMU
; bind opt /opt
```

If you want to run commands and read man pages without entering full path
to them (like `/opt/VENDOR/APP/dis/cmd/NAME`) you should also install and
use https://github.com/powerman/inferno-opt-setup 

## Dependencies

* https://github.com/powerman/inferno-contrib-tap (only for tests)


# Usage

Such include path will let you compile your application using both host OS
and native limbo without additional options if this module was installed
locally in your project, but if you installed this module system-wide,
then you'll need to use `-I$INFERNO_ROOT` for host OS limbo and `-I/` for
native limbo.

```
include "opt/powerman/growing/module/growing.m";
	growing: Growing;
	Growing1, Growing2, Growing3: import growing;
growing = load Growing Growing->PATH;
```

