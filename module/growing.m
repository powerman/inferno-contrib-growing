Growing: module
{
	PATH: con "/opt/powerman/growing/dis/lib/growing.dis";

	grow: fn[T](a: array of T, size: int): array of T;

	Growing1: adt[T] {
		new:	fn(stepx: int): ref Growing1;
		add:	fn(this: self ref Growing1, t: T): int;
		set:	fn(this: self ref Growing1, x: int, t: T);
		get:	fn(this: self ref Growing1, x: int): T;
		all:	fn(this: self ref Growing1): (array of T, int);

		# internal
		a:	array of T;
		next:	int;
		offset:	int;
		stepx:	int;
	};
	Growing2: adt[T] {
		new:	fn(stepy, stepx: int): ref Growing2;
		add:	fn(this: self ref Growing2, y: int, t: T): int;
		set:	fn(this: self ref Growing2, y: int, x: int, t: T);
		get:	fn(this: self ref Growing2, y: int, x: int): T;
		addrow:	fn(this: self ref Growing2, t: ref Growing1[T]): int;
		setrow:	fn(this: self ref Growing2, y: int, t: ref Growing1[T]);
		getrow:	fn(this: self ref Growing2, y: int): ref Growing1[T];

		# internal
		a:	array of ref Growing1[T];
		next:	int;
		offset:	int;
		stepy:	int;
		stepx:	int;
	};
	Growing3: adt[T] {
		new:	fn(stepz, stepy, stepx: int): ref Growing3;
		add:	fn(this: self ref Growing3, z: int, y: int, t: T): int;
		set:	fn(this: self ref Growing3, z: int, y: int, x: int, t: T);
		get:	fn(this: self ref Growing3, z: int, y: int, x: int): T;
		addrows:fn(this: self ref Growing3, t: ref Growing2[T]): int;
		setrows:fn(this: self ref Growing3, z: int, t: ref Growing2[T]);
		getrows:fn(this: self ref Growing3, z: int): ref Growing2[T];

		# internal
		a:	array of ref Growing2[T];
		next:	int;
		offset:	int;
		stepz:	int;
		stepy:	int;
		stepx:	int;
	};
};
