#define PREFIX mission
#define COMPONENT fn
#define DEBUG_MODE_FULL
#include "\x\cba\addons\main\script_macros_mission.hpp"

_player = param [0];

if (side _player != civilian) exitWith {WARNING_1("non civ player tried to get allegiance", _player); false};

_getAllegianceRatio = {
	_east = 0;
	_indep = 0;
	[GVAR(civPlayerAllegiances), {
		switch (_value) do {
			case opfor: {INC(_east);};
			case independent: {INC(_indep);};
			default {WARNING_2("civ player %1 registered with neither opfor nor ind allegiance, but  %2", _key, _value);};
		};
	}] call CBA_fnc_hashEachPair;

    if (_east == 0) then {
        1000000;
    } else {
        _indep / _east;
    }
};

_allegiances = GVAR(civPlayerAllegiances);

if (!([_allegiances, _player] call CBA_fnc_hashHasKey)) then {
    TRACE_1("creating allegiance for %1", _player);
	_newAllegiance = independent;
	if (([] call _getAllegianceRatio) > 4) then {
        TRACE_1("allegiance for %1 will be opfor!", _player);
		_newAllegiance = opfor;
	};
	[_allegiances, _player, _newAllegiance] call CBA_fnc_hashSet;
};
_allegiance = [_allegiances, _player] call CBA_fnc_hashGet;
[_allegiance] remoteExec["Mission_fnc_getMyAllegianceCallback", _player];

_allegiance
