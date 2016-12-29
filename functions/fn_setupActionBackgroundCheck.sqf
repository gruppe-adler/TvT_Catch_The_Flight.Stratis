#define DEBUG_MODE_FULL
#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"

GVAR(rankCompare_gte) = {
    private _rank1 = param [0];
    private _rank2 = param [1];
    private _ranks = ["PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"];

    (_ranks find _rank1) >= (_ranks find _rank2);
};

GRAD_IdCard_backgroundCheck_getAllegiance = {
    _unit = param [0, objNull];
    _checkedSide = param [1, sideUnknown];

    _realAllegiance = _unit call Mission_fnc_getAllegiance;
    if (_realAllegiance == sideUnknown) then {
        WARNING_1("player %1 doesnt seem to have allegiance", _unit);
    };

    _random = random 1;

    if (_realAllegiance == _checkedSide && _random < 0.1) exitWith {-1};
    if (_realAllegiance == _checkedSide && _random < 0.8) exitWith {1};
    if (_realAllegiance != _checkedSide && _random < 0.1) exitWith {1};
    if (_realAllegiance != _checkedSide && _random < 0.8) exitWith {-1};

    0
};

GRAD_IdCard_doBackgroundCheck = {
    private _varname = format ["mission_allegiance_%1", toLower str side player];

    private _background = _target getVariable _varname;
    if ([_background] call CBA_fnc_isHash) exitWith {
        ["background check already been done"] call Mission_fnc_showHint;
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
            [_allegiances, opfor, ([_target, opfor] call GRAD_IdCard_backgroundCheck_getAllegiance)] call CBA_fnc_hashSet;
            [_allegiances, independent, ([_target, independent] call GRAD_IdCard_backgroundCheck_getAllegiance)] call CBA_fnc_hashSet;
            [_allegiances, "isPublic", false] call CBA_fnc_hashSet;

            TRACE_3("setting  background data to %1; varname %2, val %3 ", _target, _varname, _allegiances);
            _target setVariable [_varname, _allegiances, true];

            _addPublishNode = {
                _unit = param [0, objNull];
                _varname = param [1, ""];
                TRACE_2("debug var passing", _unit, _varname);
                _action = [
                    "GRAD_IdCard_publish",
                    (name _unit),
                    "",
                    {
                        TRACE_1("debug var passing2", _this);
                        _args = param [2, []];
                        _unit = _args param [0, objNull];
                        _varname = _args param [1, ""];

                        _hash = _unit getVariable _varname;

                        TRACE_3("publishing info on %1, varname %2, val %3", _unit, _varname, _hash);

                        [_hash, "isPublic", true] call CBA_fnc_hashSet;
                        _unit setVariable [_varname, _hash, true];
                    },
                    {
                        _args = param [2, []];
                        _unit = _args param [0, objNull];
                        _varname = _args param [1, ""];

                        _hash = _unit getVariable _varname;

                        (! ([_hash, "isPublic", false] call CBA_fnc_hashGet))
                    },
                    {},
                    [_unit, _varname]
                ] call ace_interact_menu_fnc_createAction;
                [player, 1, ["ACE_SelfActions", "GRAD_IdCard_Actions", "GRAD_IdCard_Actions_publishBackgrounds"], _action] call ace_interact_menu_fnc_addActionToObject;
            };

            [_target, _varname] call _addPublishNode;

            ["background check finished. information about allegiance is shown with the ID card now."] call Mission_fnc_showHint;
        },
        {
            ["background check canceled"] call Mission_fnc_showHint;
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
        private _varname = format ["mission_allegiance_%1", toLower str side player];
        _hasBeenChecked = [(_target getVariable [_varname, []])]  call CBA_fnc_isHash;
        ([rank player, "CAPTAIN"] call GVAR(rankCompare_gte)) && !(_hasBeenChecked)
    }
] call ace_interact_menu_fnc_createAction;
["C_Man_1", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

_action = ["GRAD_IdCard_Actions", "ID actions", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["GRAD_IdCard_Actions_publishBackgrounds", "publish background information about... ", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "GRAD_IdCard_Actions"], _action] call ace_interact_menu_fnc_addActionToObject;
