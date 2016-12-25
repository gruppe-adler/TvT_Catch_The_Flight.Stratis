["elimination win for opfor triggered"] call Mission_fnc_showHint;

{
	[] call Mission_fnc_update_task_survive;
} remoteExec ["BIS_fnc_call", [WEST, EAST, CIVILIAN, RESISTANCE], true];

{
	_mainObjectiveState = 'CANCELED';
	switch (side player) do {
		case east: {_mainObjectiveState = 'SUCCEEDED'};
		case independent: {_mainObjectiveState = 'FAILED'};
		default { };
	};

	task_main_objective setTaskState _mainObjectiveState;

	[
		{
			["end1", ('SUCCEEDED' == (taskState task_main_objective) )] call BIS_fnc_endMission;
		},
		[],
		5
	]  call CBA_fnc_waitAndExecute;

} remoteExec ["BIS_fnc_call", [WEST, EAST, CIVILIAN, RESISTANCE], true];
