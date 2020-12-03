#include "..\script_component.hpp"

params [
	["_trigger", objNull, [objNull]]
];
 
_destination = getPos _trigger;

_title = localize "str_GRAD_OPFOR_A_avoid_title";
_content = localize "str_GRAD_OPFOR_A_avoid_story";
_condition = localize "str_GRAD_OPFOR_A_avoid_condition";

ISNILS(task_opfor_katzenwache, []);

_task = player createSimpleTask [_title];
_task setSimpleTaskDescription [_condition, _title, _title];
_task setSimpleTaskType "map";
_task setSimpleTaskDestination _destination;

task_opfor_katzenwache pushBack [_trigger, _task];

_task
