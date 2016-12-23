_sides = [east, west, resistance, civilian];
{
	_leftSide = _x;
	{
		_leftSide setFriend [_x, 1];
	} forEach _sides;
} forEach _sides;
