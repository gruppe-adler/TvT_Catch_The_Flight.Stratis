
_action = ["GRAD_IdCard_showAction", "Show ID Card", "node_modules\grad-leaveNotes\UI\pic\note.paa", {[] spawn GRAD_IdCard_showAction}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

GRAD_IdCard_showAction = {
	_closePeople = player nearEntities ["Man", 5];
	_closePeople = [_closePeople, {isPlayer _this}] call CBA_fnc_select;
	[
		[(name player), count _closePeople, (side player)],
		{
			params ["_name", "_count", "_side"];
			_msg = format ["%1 zeigt seinen Ausweis %2 Leuten.", _name, _count - 1];
			[_msg] call Mission_fnc_showHint;
		}
	] remoteExec ["BIS_fnc_call", _closePeople, true];
};

GRAD_IdCard_demandAction = {
	_msg = format ["Die Person heißt %1", name _target];
	[_msg] call Mission_fnc_showHint;
};

_action = ["GRAD_IdCard_demandAction", "See ID Card", "node_modules\grad-leaveNotes\UI\pic\note.paa", GRAD_IdCard_demandAction, {true}] call ace_interact_menu_fnc_createAction;
["Man", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
