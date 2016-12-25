_title = localize "str_GRAD_INDEP_H_title";
_content = localize "str_GRAD_INDEP_H_story";
_condition = localize "str_GRAD_INDEP_H_condition";

player createDiaryRecord ["Diary", [_title, _content]];

_mainTask = player createSimpleTask [_title];
_mainTask setSimpleTaskDescription [_condition, _title, _title];
_mainTask setSimpleTaskType "defend";
_mainTask setSimpleTaskDestination (getMarkerPos "marker_indep_c_spawn");

_mainTask
