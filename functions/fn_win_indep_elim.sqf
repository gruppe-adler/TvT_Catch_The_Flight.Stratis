{
	[] call Mission_fnc_update_task_survive;

	_mainObjectiveState = 'CANCELED';

    _allegiance = player call Mission_fnc_getAllegiance;
	switch (_allegiance) do {
		case east: {_mainObjectiveState = 'FAILED'};
		case independent: {_mainObjectiveState = 'CANCELED'};
		default { };
	};

	task_main_objective setTaskState _mainObjectiveState;

	// special objective b/c while the mission is technically canceled, it should still count as INDEP win
	if (_allegiance == independent) then {
		task_main_objective = player createSimpleTask ['kill_opfor'];
		task_main_objective setSimpleTaskDescription [localize "str_GRAD_task_kill_opfor_desc", localize "str_GRAD_task_kill_opfor_title", localize "str_GRAD_task_kill_opfor_title"];
		task_main_objective setTaskState 'SUCCEEDED';
	};

	[
		{
			["end1", ('SUCCEEDED' == (taskState task_main_objective) )] call BIS_fnc_endMission;
		},
		[],
		5
	]  call CBA_fnc_waitAndExecute;

} remoteExec ["BIS_fnc_call", [WEST, EAST, CIVILIAN, RESISTANCE], true];
