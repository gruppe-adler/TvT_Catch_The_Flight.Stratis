{
    [] call Mission_fnc_update_task_survive;

    _mainObjectiveState = 'CANCELED';
    switch (side player) do {
        case east: {_mainObjectiveState = 'FAILED'};
        case independent: {_mainObjectiveState = 'CANCELED'};
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
