#include "..\script_component.hpp"

GVAR(rankCompare_gte) = {
    private _rank1 = param [0];
    private _rank2 = param [1];
    private _ranks = ["PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"];

    (_ranks find _rank1) >= (_ranks find _rank2);
};

GRAD_IdCard_backgroundCheck_getAllegiance = {
    private _unit = param [0, objNull];
    private _checkedSide = param [1, sideUnknown];
    private _otherSide = if (_checkedSide isEqualTo opfor) then {independent} else {opfor};

    private _realAllegiance = _unit call Mission_fnc_getAllegiance;
    if (_realAllegiance == sideUnknown) then {
        WARNING_1("player %1 doesnt seem to have allegiance", _unit);
    };

    _random = random 1;

    if (_realAllegiance == _checkedSide && _random < 0.1) exitWith {-1};
    if (_realAllegiance == _checkedSide && _random < 0.9) exitWith {1};
    if (_realAllegiance == _otherSide && _random < 0.1) exitWith {1};
    if (_realAllegiance == _otherSide && _random < 0.9) exitWith {-1};

    0
};

GRAD_IdCard_doBackgroundCheck = {
    private _varname = format ["mission_allegiance_%1", toLower str side player];

    private _backgroundCheck = _target getVariable [_varname, []];
    if ([_backgroundCheck] call CBA_fnc_isHash) exitWith {

            private _intToDescription = {
                private _descriptions = ["hostile", "neutral", "friendly"];
                private _idx = _this + 1;
                (_descriptions select _idx);
            };

            [
                [format["Background already exists on %1", name _target], 1.5, [1, 1, 0, 1]], 
                ["Likely political views"],
                [format ["Towards military:  <t underline='1'>%1</t>", ([_backgroundCheck, opfor, 0] call CBA_fnc_hashGet) call _intToDescription]],
                [format ["Towards Schellnhuber:<t underline='1'> %1</t>", ([_backgroundCheck, independent, 0] call CBA_fnc_hashGet) call _intToDescription]]
            ] call CBA_fnc_notify;
    };

    private _duration = "BackgroundCheckDuration" call BIS_fnc_getParamValue;

    [
        _duration,
        [_target, _varname],
        {
            private _args = param [0, []];
            private _target = _args param [0, objNull];
            private _varname = _args param [1, ""];

            private _allegiances = [] call CBA_fnc_hashCreate;
            private _attitudeTowardsOpfor = [_target, opfor] call GRAD_IdCard_backgroundCheck_getAllegiance;
            private _attitudeTowardsIndepdendent = [_target, independent] call GRAD_IdCard_backgroundCheck_getAllegiance;
            [_allegiances, opfor, _attitudeTowardsOpfor] call CBA_fnc_hashSet;
            [_allegiances, independent,_attitudeTowardsIndepdendent] call CBA_fnc_hashSet;
            [_allegiances, "isPublic", false] call CBA_fnc_hashSet;

            TRACE_3("setting  background data to %1; varname %2, val %3 ", _target, _varname, _allegiances);
            _target setVariable [_varname, _allegiances, true];

            private _intToDescription = {
                private _descriptions = ["hostile", "neutral", "friendly"];
                private _idx = _this + 1;
                (_descriptions select _idx);
            };

            [
                [format["Background check finished on %1", _target], 1.5, [1, 1, 0, 1]], 
                ["Likely political views"],
                [format ["Towards military:  <t underline='1'>%1</t>", _attitudeTowardsOpfor call _intToDescription]],
                [format ["Towards Schellnhuber:<t underline='1'> %1</t>", _attitudeTowardsIndepdendent call _intToDescription]]
            ] call CBA_fnc_notify;
        },
        {
            ["background check canceled"] call CBA_fnc_notify;
        },
        (format ["Performing background check on %1", name _target]),
        {true}
    ] call ace_common_fnc_progressBar;
};

private _action = [
    "GRAD_IdCard_doBackgroundCheck",
    "Perform background check",
    "",
    GRAD_IdCard_doBackgroundCheck,
    {
        [rank player, "CAPTAIN"] call GVAR(rankCompare_gte)
    }
] call ace_interact_menu_fnc_createAction;
["C_Man_1", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

_action = ["GRAD_IdCard_Actions", "ID actions", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["GRAD_IdCard_Actions_publishBackgrounds", "publish background information about... ", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "GRAD_IdCard_Actions"], _action] call ace_interact_menu_fnc_addActionToObject;
