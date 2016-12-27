#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"

_unit = _this;

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

TRACE_1("allegiance of %1 has been determined as %2", _this, _allegiance);

_allegiance
