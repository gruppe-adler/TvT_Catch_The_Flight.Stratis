
#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"

_units = _this;

TRACE_1("calling allegiance with %1", _this);

_returnArray = true;
if (typeName _units != "ARRAY") then {
    _returnArray = false;
    _units = [_units];
};

_getUnitAllegiance = {
    _allegiance = _this getVariable ["mission_allegiance", sideUnknown];
    if (_allegiance == sideUnknown) then {

        _allegiance = _this getVariable ["mission_side", sideUnknown];
        if (_allegiance == sideUnknown) then {
            if (alive _this) then {
                _allegiance = side _this;
            } else {
                _allegiance = side (group _this);
            };
        };

    };

    TRACE_2("allegiance of %1 has been determined as %2", _this, _allegiance);

    _allegiance
};

_allegiances = [_units, {_x call _getUnitAllegiance}] call CBA_fnc_filter;

if (_returnArray) then {
    _allegiances
} else {
    _allegiances select 0;
};
