implement T;

include "opt/powerman/tap/module/t.m";
include "../../../module/growing.m";
	growing: Growing;
	Growing1: import growing;

Data: adt {
	i: int;
};


test()
{
	plan(15);

	growing = load Growing Growing->PATH;
	if(growing == nil)
		bail_out(sprint("load %s: %r",Growing->PATH));

	g1 : ref Growing1[ref Data];
	a: array of ref Data;
	offset: int;

	g1 = Growing1[ref Data].new(4);
	(a,offset) = g1.all();
	eq_int(len a, 0, nil);
	eq_int(offset, 0, nil);

	g1.add(ref Data(10));
	(a,offset) = g1.all();
	eq_int(len a, 1, nil);
	eq_int(offset, 0, nil);

	g1.set(2, ref Data(20));
	(a,offset) = g1.all();
	eq_int(len a, 3, nil);
	eq_int(offset, 0, nil);

	g1.set(-2, ref Data(-20));
	(a,offset) = g1.all();
	eq_int(len a, 7, nil);
	eq_int(offset, -4, nil);

	ok(a[0] == nil,		"a[0]=nil");
	ok(a[1] == nil,		"a[1]=nil");
	eq_int(a[2].i, -20,	"a[2]=-20");
	ok(a[3] == nil,		"a[3]=nil");
	eq_int(a[4].i, 10,	"a[4]=10");
	ok(a[5] == nil,		"a[5]=nil");
	eq_int(a[6].i, 20,	"a[6]=20");
}
