{
    [] call Mission_fnc_update_task_survive;

    _mainObjectiveState = 'CANCELED';
    switch (side player) do {
        case east: {_mainObjectiveState = 'FAILED'};
        case independent: {_mainObjectiveState = 'SUCCEEDED'};
        default { };
    };

    task_main_objective setTaskState _mainObjectiveState;
} remoteExec ["BIS_fnc_call", [WEST, EAST, CIVILIAN, RESISTANCE], true];

sleep 5;

{
	["end1", ('SUCCEEDED' == (taskState task_main_objective) )] call BIS_fnc_endMission
} remoteExec ["BIS_fnc_call", [WEST, EAST, CIVILIAN, RESISTANCE], true];
