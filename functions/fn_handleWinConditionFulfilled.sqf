#include "..\script_component.hpp"

params [["_type", "", [""]]];

if (isServer) then {
	[true] call GRAD_replay_fnc_pauseRecord;
	[{
		[false] call GRAD_replay_fnc_pauseRecord;
		[] call GRAD_replay_fnc_stopRecord;
	}, [], 3] call CBA_fnc_waitAndExecute;
};

if (hasInterface) then {
	if ((taskState taskSurvive) != "FAILED") then {
		task_survive setTaskState "SUCCEEDED";
	};

	private _allegiance = player call Mission_fnc_getAllegiance;
	private _winningFaction = switch (_type) do {
		case "indep_escape": {independent};
		case "opfor_elim": {east};
		case "indep_elim": {				
			// special objective b/c while the mission is technically canceled (VIP did *not* leave the island), it should still count as INDEP win
			if (_allegiance isEqualTo independent) then {
				task_main_objective setTaskState "CANCELED";
				task_main_objective = player createSimpleTask ["kill_opfor"];
				task_main_objective setSimpleTaskDescription [localize "str_GRAD_task_kill_opfor_desc", localize "str_GRAD_task_kill_opfor_title", localize "str_GRAD_task_kill_opfor_title"];
				task_main_objective setTaskState "SUCCEEDED";
			};

			independent
		};
	};

    if (!(isNil "task_opfor_katzenwache")) then {
        {
			_x params [
				["_trigger", objNull, [objNull]],
				["_task", taskNull, [taskNull]]
			];
			private _ts = taskState _task;
			if (_ts != "FAILED" && _ts != "CANCELED") then {
            	_task setTaskState "SUCCEEDED";
			};
        } forEach task_opfor_katzenwache;
    };

	private _mainObjectiveState = switch (_allegiance) do {
		case east: {if (_winningFaction isEqualTo east) then {"SUCCEEDED"} else {"FAILED"}};
		case independent: {if (_winningFaction isEqualTo independent) then {"SUCCEEDED"} else {"FAILED"}};
		default {"CANCELED"};
	};
	task_main_objective setTaskState _mainObjectiveState;

	private _typeTexture = [taskType task_main_objective] call BIS_fnc_taskTypeIcon;
	["task" + _mainObjectiveState + "Icon", [_typeTexture,(taskDescription task_main_objective)#1]] call BIS_fnc_showNotification;

	[
		{REPLAY_FINISHED}, 
		{
			private _alive = "SUCCEEDED" == (taskState task_survive);
			private _missionSuccess = "SUCCEEDED" == (taskState task_main_objective);
			if (_alive && _missionSuccess) exitWith {
				["end1", true] call BIS_fnc_endMission;
			};
			if (!_alive && _missionSuccess) exitWith {
				["deadwin", false] call BIS_fnc_endMission;
			};
			if (!_missionSuccess) exitWith {
				["end1", false] call BIS_fnc_endMission;
			};			
		},
		[]
	] call CBA_fnc_waitUntilAndExecute;
};
