switch (side player) do {
	case east: {
		{ [_x] call Mission_fnc_createTaskOpforAvoidArea; } forEach [getPos trigger_opfor_katzenwache_1, getPos trigger_opfor_katzenwache_2, getPos trigger_opfor_katzenwache_3];

        task_main_objective = [] call Mission_fnc_createTaskOpfor;
        player setCurrentTask task_main_objective;
	};
	case resistance: {
        task_main_objective = [(getPos trigger_indep_airport)] call Mission_fnc_createTaskIndepFlight;
        player setCurrentTask task_main_objective;
	};
	case civilian: {
		[player] remoteExecCall ["Mission_fnc_getMyAllegiance", 2];
	};
};

[] call Mission_fnc_createTaskSurvival;
