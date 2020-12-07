#include "..\script_component.hpp"

_title = localize "str_GRAD_OPFOR_A_title";
_content = localize "str_GRAD_OPFOR_A_story";
_condition = localize "str_GRAD_OPFOR_A_condition";

player createDiaryRecord ["Diary", [_title, _content]];

_mainTask = player createSimpleTask [_title];
_mainTask setSimpleTaskDescription [_condition, _title, _title];
_mainTask setSimpleTaskType "kill";
_mainTask setSimpleTaskDestination (getMarkerPos "marker_indep_c_spawn");

_mainTask
