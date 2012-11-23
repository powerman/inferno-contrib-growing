implement Growing;

include "../../module/growing.m";


grow[T](a: array of T, size: int): array of T
{
	pos := 0;
	if(size < 0) # grow left
		pos = size = -size;
	new := array[len a + size] of T;
	new[pos:] = a;
	return new;
}

#
# Growing1
#

Growing1[T].new(stepx: int): ref Growing1
{
	if(stepx < 1)
		raise "stepx < 1";
	this := ref Growing1[T];
	this.a		= array[stepx] of T;
	this.next	= 0;
	this.offset	= 0;
	this.stepx	= stepx;
	return this;
}

Growing1[T].add(this: self ref Growing1, t: T): int
{
	x := this.next++;

	i := x + this.offset;
	if(i >= len this.a){
		g := (i - len this.a + this.stepx) / this.stepx * this.stepx;
		this.a = grow(this.a, g);
	}

	this.a[i] = t;
	return x;
}

Growing1[T].set(this: self ref Growing1, x: int, t: T)
{
	if(x >= this.next)
		this.next = x + 1;

	i := x + this.offset;
	if(i < 0){
		g := (i + 1 - this.stepx) / this.stepx * this.stepx * -1;
		this.a = grow(this.a, -g);
		this.offset += g;
		i += g;
	}
	else if(i >= len this.a){
		g := (i - len this.a + this.stepx) / this.stepx * this.stepx;
		this.a = grow(this.a, g);
	}

	this.a[i] = t;
}

Growing1[T].get(this: self ref Growing1, x: int): T
{
	if(x >= this.next)
		this.next = x + 1;

	i := x + this.offset;

	if(i < 0 || i >= len this.a)
		return nil;
	return this.a[i];
}
	
Growing1[T].all(this: self ref Growing1): (array of T, int)
{
	return (this.a[0:this.offset+this.next], -this.offset);
}


#
# Growing2
#

Growing2[T].new(stepy, stepx: int): ref Growing2
{
	if(stepy < 1)
		raise "stepy < 1";
	this := ref Growing2[T];
	this.a		= array[stepy] of { * => Growing1[T].new(stepx) };
	this.next	= 0;
	this.offset	= 0;
	this.stepy	= stepy;
	this.stepx	= stepx;
	return this;
}

Growing2[T].add(this: self ref Growing2, y: int, t: T): int
{
	if(y >= this.next)
		this.next = y + 1;

	i := y + this.offset;
	if(i < 0 || i >= len this.a){
		this.setrow(y, Growing1[T].new(this.stepx)); # may change this.offset!
		i = y + this.offset;
	}

	return this.a[i].add(t);
}

Growing2[T].set(this: self ref Growing2, y: int, x: int, t: T)
{
	if(y >= this.next)
		this.next = y + 1;

	i := y + this.offset;
	if(i < 0 || i >= len this.a){
		this.setrow(y, Growing1[T].new(this.stepx)); # may change this.offset!
		i = y + this.offset;
	}

	this.a[i].set(x, t);
}

Growing2[T].get(this: self ref Growing2, y: int, x: int): T
{
	return this.getrow(y).get(x);
}

Growing2[T].addrow(this: self ref Growing2, t: ref Growing1[T]): int
{
	y := this.next++;

	i := y + this.offset;
	if(i >= len this.a){
		g := (i - len this.a + this.stepy) / this.stepy * this.stepy;
		this.a = grow(this.a, g);
		this.a[len this.a - g:] = array[g] of { * => Growing1[T].new(this.stepx) };
	}

	this.a[i] = t;
	return y;
}

Growing2[T].setrow(this: self ref Growing2, y: int, t: ref Growing1[T])
{
	if(y >= this.next)
		this.next = y + 1;

	i := y + this.offset;
	if(i < 0){
		g := (i + 1 - this.stepy) / this.stepy * this.stepy * -1;
		this.a = grow(this.a, -g);
		this.a[0:] = array[g] of { * => Growing1[T].new(this.stepx) };
		this.offset += g;
		i = y + this.offset;
	}
	else if(i >= len this.a){
		g := (i - len this.a + this.stepy) / this.stepy * this.stepy;
		this.a = grow(this.a, g);
		this.a[len this.a - g:] = array[g] of { * => Growing1[T].new(this.stepx) };
	}

	this.a[i] = t;
}

Growing2[T].getrow(this: self ref Growing2, y: int): ref Growing1[T]
{
	if(y >= this.next)
		this.next = y + 1;
	
	i := y + this.offset;
	if(i < 0 || i >= len this.a){
		this.setrow(y, Growing1[T].new(this.stepx)); # may change this.offset!
		i = y + this.offset;
	}

	return this.a[i];
}

#
# Growing3
#

Growing3[T].new(stepz, stepy, stepx: int): ref Growing3
{
	if(stepz < 1)
		raise "stepz < 1";
	this := ref Growing3[T];
	this.a		= array[stepz] of { * => Growing2[T].new(stepy, stepx) };
	this.next	= 0;
	this.offset	= 0;
	this.stepz	= stepz;
	this.stepy	= stepy;
	this.stepx	= stepx;
	return this;
}

Growing3[T].add(this: self ref Growing3, z: int, y: int, t: T): int
{
	if(z >= this.next)
		this.next = z + 1;
	
	i := z + this.offset;
	if(i < 0 || i >= len this.a){
		this.setrows(z, Growing2[T].new(this.stepy, this.stepx)); # may change this.offset!
		i = z + this.offset;
	}

	return this.a[i].add(y, t);
}

Growing3[T].set(this: self ref Growing3, z: int, y: int, x: int, t: T)
{
	if(z >= this.next)
		this.next = z + 1;
	
	i := z + this.offset;
	if(i < 0 || i >= len this.a){
		this.setrows(z, Growing2[T].new(this.stepy, this.stepx)); # may change this.offset!
		i = z + this.offset;
	}

	this.a[i].set(y, x, t);
}

Growing3[T].get(this: self ref Growing3, z: int, y: int, x: int): T
{
	return this.getrows(z).getrow(y).get(x);
}

Growing3[T].addrows(this: self ref Growing3, t: ref Growing2[T]): int
{
	z := this.next++;

	i := z + this.offset;
	if(i >= len this.a){
		g := (i - len this.a + this.stepz) / this.stepz * this.stepz;
		this.a = grow(this.a, g);
		this.a[len this.a - g:] = array[g] of { * => Growing2[T].new(this.stepy, this.stepx) };
	}

	this.a[i] = t;
	return z;
}

Growing3[T].setrows(this: self ref Growing3, z: int, t: ref Growing2[T])
{
	if(z >= this.next)
		this.next = z + 1;

	i := z + this.offset;
	if(i < 0){
		g := (i + 1 - this.stepz) / this.stepz * this.stepz * -1;
		this.a = grow(this.a, -g);
		this.a[0:] = array[g] of { * => Growing2[T].new(this.stepy, this.stepx) };
		this.offset += g;
		i = z + this.offset;
	}
	else if(i >= len this.a){
		g := (i - len this.a + this.stepz) / this.stepz * this.stepz;
		this.a = grow(this.a, g);
		this.a[len this.a - g:] = array[g] of { * => Growing2[T].new(this.stepy, this.stepx) };
	}

	this.a[i] = t;
}

Growing3[T].getrows(this: self ref Growing3, z: int): ref Growing2[T]
{
	if(z >= this.next)
		this.next = z + 1;

	i := z + this.offset;
	if(i < 0 || i >= len this.a){
		this.setrows(z, Growing2[T].new(this.stepy, this.stepx)); # may change this.offset!
		i = z + this.offset;
	}

	return this.a[i];
}
