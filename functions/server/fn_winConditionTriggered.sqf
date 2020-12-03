#include "..\..\script_component.hpp"

params [
	["_trigger", objNull, [objNull]],
	["_winName", "", [""]]
];

INFO_2("win %1 detected by %2", _winName, _trigger);

["mission_winConditionFulfilled", [_winName]] call CBA_fnc_globalEvent;