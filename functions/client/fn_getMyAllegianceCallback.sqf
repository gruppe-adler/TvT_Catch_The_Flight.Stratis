#define PREFIX mission
#define COMPONENT fn
#define DEBUG_MODE_FULL
#include "\x\cba\addons\main\script_macros_mission.hpp"

_allegiance = param [0, sideUnknown];

switch (_allegiance) do {
	case resistance: {

		_title = localize "str_GRAD_INDEP_H_title";
		_content = localize "str_GRAD_INDEP_H_story";
		_condition = localize "str_GRAD_INDEP_H_condition";
		[_title, _content, _condition] call Mission_fnc_create_tasks;
	};
	case opfor: {
		_title = localize "str_GRAD_OPFOR_H_title";
		_content = localize "str_GRAD_OPFOR_H_story";
		_condition = localize "str_GRAD_OPFOR_H_condition";

		[_title, _content, _condition] call Mission_fnc_create_tasks;
	};
	default {
		WARN_1("bad allegiance %1 from server", _allegiance);
	};
};

