#!/bin/bash
for d in $MANDIRS; do
	echo $d.idx-os:V: $(ls -1 $d/* 2>/dev/null | grep -v '/INDEX$')
done
