#define DEBUG_MODE_FULL
#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"

private _unit = _this;
private _name = name _unit;

_allegiances = [] call CBA_fnc_hashCreate;

private _tmp;
_tmp = _unit getVariable ["mission_allegiance_guer", false];
if ([_tmp] call CBA_fnc_isHash) then {
    [_allegiances, independent, _tmp] call CBA_fnc_hashSet;
};

_tmp = _unit getVariable ["mission_allegiance_east", false];
if ([_tmp] call CBA_fnc_isHash) then {
    [_allegiances, opfor, _tmp] call CBA_fnc_hashSet;
};

onIDCardLoadParameters = [
    _name,
    _allegiances
];

onIDCardLoad = {
    private _display = param [0];

    private _top = 0.3;
    private _height = 0.2;
    private _nextControlID = 21;

    TRACE_1("this is id card load event handler for %1", _display);

    _intToDescription = {
        TRACE_1("_intToDescription param", _this);
        private _descriptions = ["hostile", "neutral", "friendly"];
        private _idx = _this + 1;
        (_descriptions select _idx);
    };

    _sideToBoss = {
        switch (_this) do {
            case independent: { "Smuggler Schellnhuber"};
            case opfor: {"Military command"};
            default {"Great Unknown"};
        };
    };

    private _getControlForBackground = {
        private _backgroundCheck = param [0, []];
        private _side = param [1, sideUnknown];

        TRACE_1("background check %1", _backgroundCheck);
        _isPublic = [_backgroundCheck, "isPublic", false] call CBA_fnc_hashGet;
        if ((_side != side player) && (!_isPublic)) exitWith {
            TRACE_1("player not alloweed to see allegiances according to %1", _side);
            controlNull;
        };

        private _ctrl = _display ctrlCreate ["RscStructuredText", _nextControlID];
        INC(_nextControlID);

        private _publicInfo = "(This is NOT public information)";
        if (_isPublic) then {
            _publicInfo = "(This is public information)";
        };

        _ctrl ctrlSetPosition [0, _top, 1, _height];
        ADD(_top, _height);

        _ctrl ctrlSetStructuredText parseText format [
            "<t font='RobotoCondensedLight' align='left'>The <t font='RobotoCondensedBold'> %1 performed a background check</t>, and it said:<br /> %2 is probably <t underline='1'>%3</t> toward the army, and <t underline='1'>%4</t> toward the INDEP. <br /> %5</t>",
            _side call _sideToBoss,
            _name,
            (([_backgroundCheck, opfor, 0] call CBA_fnc_hashGet) call _intToDescription),
            (([_backgroundCheck, independent, 0] call CBA_fnc_hashGet) call _intToDescription),
            _publicInfo
        ];
        _ctrl ctrlSetBackgroundColor [0.9, 0.9, 0.9, 0.9];
        _ctrl ctrlSetTextColor [0.1, 0.1, 0.1,1];
        TRACE_1("committing glorious control %1", _ctrl);
        _ctrl ctrlCommit 0;
    };


    _name = onIDCardLoadParameters param [0, ""];
    _allegiances = onIDCardLoadParameters param [1, [[]]];

    TRACE_2("id card load event handler for name %1, alleg %2", _name, _allegiances);
    private _ctrl = _display displayCtrl 11;
    _ctrl ctrlSetText _name;
    _ctrl ctrlCommit 10;
    _ctrl ctrlAddEventHandler ["KeyDown", {cutText ["", "PLAIN"]; diag_log "ctrl key event";}];
    ctrlSetFocus _ctrl;

    if ([_allegiances, independent] call CBA_fnc_hashHasKey) then {
        TRACE_1("calling background check description %1", independent);
        [([_allegiances, independent] call CBA_fnc_hashGet), independent] call _getControlForBackground;
    };

    if ([_allegiances, opfor] call CBA_fnc_hashHasKey) then {
        TRACE_1("calling background check description %1", opfor);
        [([_allegiances, opfor] call CBA_fnc_hashGet), opfor] call _getControlForBackground;
    };
};

cutRsc ["IDCard","PLAIN"];
