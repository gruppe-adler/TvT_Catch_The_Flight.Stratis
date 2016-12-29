
#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"

private _action = ["GRAD_IdCard_showAction", "Show ID Card", "", {[] spawn GRAD_IdCard_showAction}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

GRAD_IdCard_showAction = {
	_closePeople = player nearEntities ["Man", 5];
	_closePeople = [_closePeople, {(isPlayer _this) && (player != _this)}] call CBA_fnc_select;
	[
		[(name player), count _closePeople],
		{
			params ["_name", "_count"];
			_msg = format ["%1 zeigt seinen Ausweis %2 Leuten.", _name, _count];
			[_msg] call Mission_fnc_showHint;
		}
	] remoteExec ["BIS_fnc_call", _closePeople + [player], true];
};

GRAD_IdCard_demandAction = {

    _intToDescription = {
        TRACE_1("_intToDescription param", _this);
        private _descriptions = ["hostile", "neutral", "friendly"];
        private _idx = _this + 1;
        (_descriptions select _idx);
    };

    _allegianceDataString = {
        private _fromSide = _this;
        private _varname = format ["mission_allegiance_%1", toLower str _fromSide];

        private _allegiances = _target getVariable [_varname, []];
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

    private _allegiances = [[independent, opfor], {_x call _allegianceDataString}] call CBA_fnc_filter;

	private _msg = format ["Die Person heißt %1. %2",
        name _target,
        (_allegiances joinString " ")
    ];
	[_msg] call Mission_fnc_showHint;
};

_action = ["GRAD_IdCard_demandAction", "See ID Card", "", GRAD_IdCard_demandAction, {true}] call ace_interact_menu_fnc_createAction;
["Man", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
