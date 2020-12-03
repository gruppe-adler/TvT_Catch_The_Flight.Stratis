#include "..\script_component.hpp"

_taskSurviveState = 'FAILED';
if (alive player) then {
    _taskSurviveState = 'SUCCEEDED';
};

task_survive setTaskState _taskSurviveState;
