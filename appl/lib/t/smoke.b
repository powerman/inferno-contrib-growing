implement T;

include "opt/powerman/tap/module/t.m";
include "../../../module/growing.m";
	growing: Growing;
	Growing1, Growing2, Growing3: import growing;

test()
{
	plan(0);

	growing = load Growing Growing->PATH;
	if(growing == nil)
		bail_out(sprint("load %s: %r",Growing->PATH));

}
