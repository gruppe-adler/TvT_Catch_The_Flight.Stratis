_taskSurviveState = 'FAILED';
if (alive player) then {
    _taskSurviveState = 'SUCCEEDED';
};

task_survive setTaskState _taskSurviveState;
