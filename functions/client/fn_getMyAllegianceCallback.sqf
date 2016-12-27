#define PREFIX mission
#define COMPONENT fn

#include "\x\cba\addons\main\script_macros_mission.hpp"

_allegiance = param [0, sideUnknown];

if (!(isNil "task_main_objective")) then {
    player removeSimpleTask task_main_objective;
};

player setVariable ["mission_allegiance", _allegiance, true];

switch (_allegiance) do {
	case resistance: {
        task_main_objective = [_allegiance] call Mission_fnc_createTaskCivProtect;
        player setCurrentTask task_main_objective;
	};
	case opfor: {
        task_main_objective = [_allegiance] call Mission_fnc_createTaskCivKill;
        player setCurrentTask task_main_objective;
	};
	default {
		WARNING_1("bad allegiance %1 from server", _allegiance);
	};
};
