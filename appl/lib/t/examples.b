implement T;

include "opt/powerman/tap/module/t.m";
include "../../../module/growing.m";
	growing: Growing;
	Growing1, Growing2, Growing3: import growing;

Data: adt {
	i: int;
};


test()
{
	plan(2);

	growing = load Growing Growing->PATH;
	if(growing == nil)
		bail_out(sprint("load %s: %r",Growing->PATH));

	g3 := Growing3[ref Data].new(4,16,16);
	g3.set(-2, -5, 3, ref Data(10));
	absent := g3.get(2, 2, 2);	    # return nil
	n := g3.add(2, 2, ref Data(20));    # return 3, because of get above

	ok(absent == nil, "return nil");
	eq_int(n, 3, "return 3");
}
