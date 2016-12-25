_title = localize "str_GRAD_OPFOR_H_title";
_content = localize "str_GRAD_OPFOR_H_story";
_condition = localize "str_GRAD_OPFOR_H_condition";

player createDiaryRecord ["Diary", [_title, _content]];

_mainTask = player createSimpleTask [_title];
_mainTask setSimpleTaskDescription [_condition, _title, _title];
_mainTask setSimpleTaskType "meet";
_mainTask setSimpleTaskDestination (getMarkerPos "marker_opfor_a_spawn");

_mainTask
