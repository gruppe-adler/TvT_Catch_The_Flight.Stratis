#define PREFIX mission
#define COMPONENT fn
#define DEBUG_MODE_FULL
#include "\x\cba\addons\main\script_macros_mission.hpp"

_player = param [0];

if (side _player != civilian) exitWith {WARN_1("non civ player tried to get allegiance", _player); false};

_getAllegianceRatio = {
	_east = 0;
	_indep = 0;
	[GVAR(registeredCivPlayers), {
		switch (_value) do {
			case opfor: {INCR(_east);};
			case independent: {INCR(_indep);};
			default {WARN_2("civ player %1 registered with neither opfor nor ind allegiance, but  %2", _key, _value);};
		};
	}] CBA_fnc_eachPair;

	_indep / _east
};

_allegiances = GVAR(civPlayerAllegiances);

if (!([_allegiances, _this] call CBA_fnc_hashHasKey)) then {
	_newAllegiance = independent;
	if ((nil call _getAllegianceRatio) > 4) then {
		_newAllegiance = opfor;
	};
	[_allegiances, _this, _newAllegiance] call CBA_fnc_hashSet;
};
_allegiance = [_allegiances, _this] call CBA_fnc_hashGet;
[
	[_allegiance],
	{setplayerallegiance}
] remoteExec["bis_fnc_call", _player];
