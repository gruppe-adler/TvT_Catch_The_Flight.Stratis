#define PREFIX mission
#define COMPONENT fn
#define DEBUG_MODE_FULL
#include "\x\cba\addons\main\script_macros_mission.hpp"

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

    _intToDescription = {
        _descriptions = ["hostile", "neutral", "friendly"];
        (_descriptions select (_this + 1));
    };

    _allegianceDataString = {
        _fromSide = _this;
        _varname = format ["mission_allegiance_%1", toLower str _fromSide];

        _allegiances = _target getVariable [_varname, []];
        TRACE_2("getting background data; varname %1, val %2 ",_varname, _bgData);

        if (!([_allegiances] call CBA_fnc_isHash)) exitWith { "" };
        _isPublic = [_allegiances, "isPublic", false] call CBA_fnc_hashGet;
        if ((_fromSide != side player) && (!_isPublic)) exitWith {""};

        private _publicInfo = "This is NOT public information.";
        if (_isPublic) then {
            _publicInfo = "This is public information.";
        };

        format ["%1 think he feels %2 towards the army, and %3 to the INDEP C. %4",
            _fromSide,
            (([_allegiances, opfor, 0] call CBA_fnc_hashGet) call _intToDescription),
            (([_allegiances, independent, 0] call CBA_fnc_hashGet) call _intToDescription),
            _publicInfo
        ];
    };

    _allegiances = [[independent, opfor], {_x call _allegianceDataString}] call CBA_fnc_filter;

	_msg = format ["Die Person heißt %1. %2",
        name _target,
        (_allegiances joinString " ")
    ];
	[_msg] call Mission_fnc_showHint;
};

_action = ["GRAD_IdCard_demandAction", "See ID Card", "node_modules\grad-leaveNotes\UI\pic\note.paa", GRAD_IdCard_demandAction, {true}] call ace_interact_menu_fnc_createAction;
["Man", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
