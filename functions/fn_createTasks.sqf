params ["_title", "_content", "_condition"];

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
