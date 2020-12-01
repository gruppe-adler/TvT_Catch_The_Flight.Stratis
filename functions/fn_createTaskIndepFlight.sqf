private _position = param [0];
private _title = localize "str_GRAD_INDEP_C_title";
private _content = localize "str_GRAD_INDEP_C_story";
private _condition = localize "str_GRAD_INDEP_C_condition";

player createDiaryRecord ["Diary", [_title, _content]];

private _mainTask = player createSimpleTask [_title];
_mainTask setSimpleTaskDescription [_condition, _title, _title];
_mainTask setSimpleTaskType "run";
_mainTask setSimpleTaskDestination _position;

_mainTask
