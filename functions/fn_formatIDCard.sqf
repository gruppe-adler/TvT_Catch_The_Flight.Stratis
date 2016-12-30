#define DEBUG_MODE_FULL
#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"

private _unit = _this;
private _name = name _unit;

_indepAllegiance = _unit getVariable "mission_allegiance_guer";
_opforAllegiance = _unit getVariable "mission_allegiance_opfor";

_name = "Jason Miles";

_indepAllegiance = [] call CBA_fnc_hashCreate;
[_indepAllegiance, independent, 1] call CBA_fnc_hashSet;
[_indepAllegiance, opfor, -1] call CBA_fnc_hashSet;
[_indepAllegiance, "isPublic", true] call CBA_fnc_hashSet;

_allegiances = [] call CBA_fnc_hashCreate;
[_allegiances, independent, _indepAllegiance] call CBA_fnc_hashSet;
[_allegiances, opfor, _indepAllegiance] call CBA_fnc_hashSet;

onIDCardLoadParameters = [
    _name,
    _allegiances
];

onIDCardLoad = {
    private _display = param [0];

    private _top = 0.3;
    private _height = 0.1;
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
            case independent: { "INDEP Boss"};
            case opfor: {"military command"};
            default {"Great Unknown"};
        };
    };

    _getControlForBackground = {
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

        private _publicInfo = "<br />(This is NOT public information)";
        if (_isPublic) then {
            _publicInfo = "<br />(This is public information)";
        };

        _ctrl ctrlSetPosition [0, _top, 1, _height];
        ADD(_height, 0.1);

        _ctrl ctrlSetStructuredText parseText format [
            "<t font='EtelkaMonospacePro' align='left'>The %1 performed a background check, and it said:<br /> %2 is probably %3 toward the army, and %4 toward the INDEP</t>",
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
