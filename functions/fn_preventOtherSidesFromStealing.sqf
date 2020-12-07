#include "..\script_component.hpp"

/**
 * When different sides are friends, you can usually access their inventories.
 *
 * Prevent people from opening inventories belonging to another military (!) side
 */


_unit = _this;

_unit addEventHandler ["InventoryOpened", {
	params ["_unit", "_container", "_secondaryContainer"];

	_militarySides = [Blufor, Opfor, Resistance];

	_vehicle = vehicle player;
	_preventOpening = false;

	{
		if ((_x in _militarySides) && (_x != side player)) then {
			_preventOpening = true;
			(format ["Can't access %1, I'm being watched here", _container]) call cba_fnc_notify;
		};
	} forEach [side _vehicle, side _container, side _secondaryContainer];

	_preventOpening

}];
