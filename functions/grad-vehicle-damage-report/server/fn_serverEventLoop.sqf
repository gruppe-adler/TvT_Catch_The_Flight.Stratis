#define PREFIX grad
#define COMPONENT vehicleDamageReport

#include "\x\cba\addons\main\script_macros_mission.hpp"

_interval = 10;

[
	{
		_damages = GVAR(serverSideDamageList);

		[_damages, {
			_group = _key;
			_damage = _value;
			TRACE_1("damage group %1", _group);
			{
				_handlerGroup = _x param [0, []];
				_handlerCallback = _x param [1, {}];
				TRACE_1("handler htoup %1", _handlerGroup);
				if (_handlerGroup isEqualTo _group) then {
					TRACE_1("calling handler", true);
					[_damage] call _handlerCallback;
				};
			} forEach GVAR(serverSideHandlers);
		}] call CBA_fnc_hashEachPair;
        GVAR(serverSideDamageList) = [[], 0] call CBA_fnc_hashCreate;
	},
	_interval,
	[]
] call CBA_fnc_addPerFrameHandler;
