_title = "";
_content = "";
_condition = "";
_title = "";

switch (side player) do {
	case east: {
        _title = localize "str_GRAD_OPFOR_A_title";
        _content = localize "str_GRAD_OPFOR_A_story";
        _condition = localize "str_GRAD_OPFOR_A_condition";

        if (faction player == "OPF_G") then {
            _title = localize "str_GRAD_OPFOR_H_title";
            _content = localize "str_GRAD_OPFOR_H_story";
            _condition = localize "str_GRAD_OPFOR_H_condition";
        };
	};
	case resistance: {
		_title = localize "str_GRAD_INDEP_H_title";
		_content = localize "str_GRAD_INDEP_H_story";
		_condition = localize "str_GRAD_INDEP_H_condition";

        if (!(isNil "unit_indep_c")) then {
            if (player == unit_indep_c) then {
                _title = localize "str_GRAD_INDEP_C_title";
                _content = localize "str_GRAD_INDEP_C_story";
            };
            _condition = localize "str_GRAD_INDEP_C_condition";
        };
	};
};

player createDiaryRecord ["Diary", [_title, _content]];

task_main_objective = player createSimpleTask [_title];
task_main_objective setSimpleTaskDescription [_condition, _title, _title];
player setCurrentTask task_main_objective;

task_survive = player createSimpleTask ['dont_die'];
task_survive setSimpleTaskDescription [localize "str_GRAD_task_dd_desc", localize "str_GRAD_task_dd_title", localize "str_GRAD_task_dd_title"];

player createDiarySubject ["scenario", localize "str_GRAD_scenario_subject"];

player createDiaryRecord ["scenario", [localize "str_GRAD_scenario_equipment_title", localize "str_GRAD_scenario_equipment"]];
player createDiaryRecord ["scenario", [localize "str_GRAD_scenario_environment_title", localize "str_GRAD_scenario_environment"]];
player createDiaryRecord ["scenario", [localize "str_GRAD_scenario_story_title", localize "str_GRAD_scenario_story"]];
player createDiaryRecord ["scenario", [localize "str_GRAD_scenario_background_title", localize "str_GRAD_scenario_background"]];
