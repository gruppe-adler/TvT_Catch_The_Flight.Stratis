
#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"

private _action = ["GRAD_IdCard_showAction", "Show ID Card", "", {[] spawn GRAD_IdCard_showAction}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

GRAD_IdCard_showAction = {
	_closePeople = player nearEntities ["Man", 5];
	_closePeople = [_closePeople, {(isPlayer _this) && (player != _this)}] call CBA_fnc_select;
	[
		[name player, count _closePeople],
		{
			params ["_name", "_count"];
			_msg = format ["%1 möchte seinen Ausweis %2 Leuten zeigen.", _name, _count];
			[_msg] call Mission_fnc_showHint;
		}
	] remoteExec ["BIS_fnc_call", _closePeople + [player], true];
};

GRAD_IdCard_demandAction = {
    _target call Mission_fnc_formatIDCard;
};

_action = ["GRAD_IdCard_demandAction", "See ID Card", "", GRAD_IdCard_demandAction, {true}] call ace_interact_menu_fnc_createAction;
["Man", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
