[] call Mission_fnc_update_task_survive;

_mainObjectiveState = 'CANCELED';
switch (side player) do {
    case east: {_mainObjectiveState = 'FAILED'};
    case independent: {_mainObjectiveState = 'CANCELED'};
    default { };
};

task_main_objective setTaskState _mainObjectiveState;