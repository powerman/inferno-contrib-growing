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
	plan(75);

	growing = load Growing Growing->PATH;
	if(growing == nil)
		bail_out(sprint("load %s: %r",Growing->PATH));

	g1 : ref Growing1[ref Data];
	g2 : ref Growing2[ref Data];
	g3 : ref Growing3[ref Data];

	{ Growing1[ref Data].new(-1); } exception e { "*"=>catched(e); }
	raised("stepx*", nil);
	{ Growing1[ref Data].new( 0); } exception e { "*"=>catched(e); }
	raised("stepx*", nil);
	{ g1 = Growing1[ref Data].new(1); } exception e { "*"=>catched(e); }
	raised(nil, nil);
	
	{ Growing2[ref Data].new( 0,  0); } exception e { "*"=>catched(e); }
	raised("stepy*", nil);
	{ Growing2[ref Data].new(-1,  1); } exception e { "*"=>catched(e); }
	raised("stepy*", nil);
	{ Growing2[ref Data].new( 0,  1); } exception e { "*"=>catched(e); }
	raised("stepy*", nil);
	{ Growing2[ref Data].new( 1, -1); } exception e { "*"=>catched(e); }
	raised("stepx*", nil);
	{ Growing2[ref Data].new( 1,  0); } exception e { "*"=>catched(e); }
	raised("stepx*", nil);
	{ g2 = Growing2[ref Data].new(1, 1); } exception e { "*"=>catched(e); }
	raised(nil, nil);
	
	{ Growing3[ref Data].new( 0,  0,  0); } exception e { "*"=>catched(e); }
	raised("stepz*", nil);
	{ Growing3[ref Data].new(-1,  1,  1); } exception e { "*"=>catched(e); }
	raised("stepz*", nil);
	{ Growing3[ref Data].new( 0,  1,  1); } exception e { "*"=>catched(e); }
	raised("stepz*", nil);
	{ Growing3[ref Data].new( 1, -1,  1); } exception e { "*"=>catched(e); }
	raised("stepy*", nil);
	{ Growing3[ref Data].new( 1,  0,  1); } exception e { "*"=>catched(e); }
	raised("stepy*", nil);
	{ Growing3[ref Data].new( 1,  1, -1); } exception e { "*"=>catched(e); }
	raised("stepx*", nil);
	{ Growing3[ref Data].new( 1,  1,  0); } exception e { "*"=>catched(e); }
	raised("stepx*", nil);
	{ g3 = Growing3[ref Data].new(1, 1, 1); } exception e { "*"=>catched(e); }
	raised(nil, nil);
	
	eq_int(len g1.a, 1, "len g1.a == step");
	eq_int(len g2.a, 1, "len g2.a == step");
	eq_int(len g3.a, 1, "len g3.a == step");

	eq_int(g1.add(ref Data(10)), 0, "[0] added");
	eq_int(g1.add(ref Data(20)), 1, "[1] added");
	eq_int(g1.add(ref Data(30)), 2, "[2] added");
	eq_int(g1.get(0).i, 10, "[0] value");
	eq_int(g1.get(1).i, 20, "[1] value");
	eq_int(g1.get(2).i, 30, "[2] value");
	g1.set(1, ref Data(200));
	eq_int(g1.get(1).i, 200, "[1] modified");
	eq_int(len g1.a, 3, "len g1.a == 3");
	g1.set(-2, ref Data(-20));
	eq_int(len g1.a, 5, "len g1.a == 5");
	eq_int(g1.add(ref Data(40)), 3, "[3] added");
	g1.set(5, ref Data(60));
	eq_int(g1.add(ref Data(70)), 6, "[6] added");
	ok(g1.get(4) == nil, "[4] is nil");
	ok(g1.get(-10) == nil, "[-10] is nil");
	ok(g1.get(10) == nil, "[10] is nil");
	eq_int(g1.add(ref Data(120)), 11, "[11] added");
	eq_int(len g1.a, 14, "len g1.a == 14");

	g1 = Growing1[ref Data].new(4);
	eq_int(len g1.a, 4, "len g1.a == step");
	eq_int(g1.add(ref Data(10)), 0, "[0] added");
	eq_int(g1.add(ref Data(20)), 1, "[1] added");
	eq_int(len g1.a, 4, "len g1.a == 4");
	ok(g1.get(2) == nil, "[2] is nil");
	eq_int(g1.add(ref Data(40)), 3, "[3] added");
	eq_int(len g1.a, 4, "len g1.a == 4");
	eq_int(g1.add(ref Data(50)), 4, "[4] added");
	eq_int(len g1.a, 8, "len g1.a == 8");
	g1.set(7, ref Data(80));
	eq_int(len g1.a, 8, "len g1.a == 8");
	g1.set(8, ref Data(80));
	eq_int(len g1.a, 12, "len g1.a == 12");
	g1.set(13, ref Data(80));
	eq_int(len g1.a, 16, "len g1.a == 16");
	g1.set(100, ref Data(80));
	eq_int(len g1.a, 104, "len g1.a == 104");
	g1.set(-1, ref Data(80));
	eq_int(len g1.a, 108, "len g1.a == 108");
	g1.set(-10, ref Data(80));
	eq_int(len g1.a, 116, "len g1.a == 116");

	eq_int(g3.add(-5, -5, ref Data(-550)), 0, "[-5][-5][0] added");
	eq_int(g3.get(-5, -5, 0).i, -550, "[-5][-5][0] value");
	g3.set(10, 10, 10, ref Data(101010));
	g3.set(-10, -10, -10, ref Data(-101010));
	eq_int(g3.add(-5, -5, ref Data(-551)), 1, "[-5][-5][1] added");
	eq_int(len g3.a, 21, "len g3.a == 21");
	eq_int(len g3.a[0].a, 11, "len g3.a[-10].a == 11");
	eq_int(len g3.a[0].a[0].a, 11, "len g3.a[-10].a[-10].a == 11");
	eq_int(len g3.a[1].a, 1, "len g3.a[-9].a == step");
	eq_int(len g3.a[1].a[0].a, 1, "len g3.a[-9].a[0] == step");

	g3 = Growing3[ref Data].new(2,4,6);
	eq_int(len g3.a, 2, "len g3.a == stepz");
	eq_int(len g3.a[0].a, 4, "len g3.a[0].a == stepy");
	eq_int(len g3.a[1].a, 4, "len g3.a[1].a == stepy");
	eq_int(len g3.a[0].a[0].a, 6, "len g3.a[0].a[0].a == stepx");
	eq_int(len g3.a[1].a[3].a, 6, "len g3.a[1].a[3].a == stepx");
	g3.set(0, 0, 0, ref Data(1));
	g3.set(0, 0, 5, ref Data(1));
	g3.set(0, 3, 0, ref Data(1));
	g3.set(0, 3, 5, ref Data(1));
	g3.set(1, 0, 0, ref Data(1));
	g3.set(1, 0, 5, ref Data(1));
	g3.set(1, 3, 0, ref Data(1));
	g3.set(1, 3, 5, ref Data(1));
	eq_int(len g3.a, 2, "len g3.a == stepz");
	eq_int(len g3.a[0].a, 4, "len g3.a[0].a == stepy");
	eq_int(len g3.a[1].a, 4, "len g3.a[1].a == stepy");
	eq_int(len g3.a[0].a[0].a, 6, "len g3.a[0].a[0].a == stepx");
	eq_int(len g3.a[1].a[3].a, 6, "len g3.a[1].a[3].a == stepx");
	ok(g3.get(12,12,12) == nil, "[12][12][12] is nil");
	eq_int(len g3.a, 14, "len g3.a == 14");
	eq_int(len g3.a[0].a, 4, "len g3.a[0].a == stepy");
	eq_int(len g3.a[12].a, 16, "len g3.a[10].a == 16");
	eq_int(len g3.a[0].a[0].a, 6, "len g3.a[0].a[0].a == stepx");
	eq_int(len g3.a[12].a[12].a, 6, "len g3.a[10].a[10].a == stepx");
}
