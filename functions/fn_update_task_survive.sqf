_taskSurviveState = 'SUCCEEDED';
if (!alive player) then {
    _taskSurviveState = 'FAILED';
};
if (!((side player) in [west, east, independent])) then {
    _taskSurviveState = 'FAILED' /*why? are dead players/spectators civ?*/
};
task_survive setTaskState _taskSurviveState;
