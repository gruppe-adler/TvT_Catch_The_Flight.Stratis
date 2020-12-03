#include "..\..\script_component.hpp"


_allegiance = param [0, sideUnknown];

if (!(isNil "task_main_objective")) then {
    player removeSimpleTask task_main_objective;
};

player setVariable ["mission_allegiance", _allegiance, true];

switch (_allegiance) do {
	case resistance: {
        task_main_objective = [_allegiance] call Mission_fnc_createTaskCivProtect;
        player setCurrentTask task_main_objective;
		player setVariable ["grad_replay_color", {[0.1, 1.0, 1.0, 1]}, true];
	};
	case opfor: {
        task_main_objective = [_allegiance] call Mission_fnc_createTaskCivKill;
        { [_x] call Mission_fnc_createTaskOpforAvoidArea; } forEach [trigger_civ_katzenwache];
        player setCurrentTask task_main_objective;
		player setVariable ["grad_replay_color", {[1.0, 0.1, 1.0, 1]}, true];
	};
	default {
		WARNING_1("bad allegiance %1 from server", _allegiance);
	};
};
