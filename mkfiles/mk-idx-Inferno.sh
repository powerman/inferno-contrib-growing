#!/dis/sh
load std

for (d in $MANDIRS) {
	echo $d.idx-Inferno:V: `{ls $d | grep -v '/INDEX$'}
}
