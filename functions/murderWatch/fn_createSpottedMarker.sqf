#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"

_unit = param [0, objNull];
_radius = param [1, 0];
_target = param [2];

_pos = getPos _unit;
_name = name _unit;

TRACE_1("creating 'spotted' marker for %1", _unit);

_x = (_pos select 0) - _radius + random _radius;
_y = (_pos select 1) - _radius + random _radius;

[
    [_name, [_x, _y], _radius * 2],
    {
        _formattedTime = {
            _hour = floor daytime;
            _minute = floor ((daytime - _hour) * 60);
            _second = floor (((((daytime) - (_hour))*60) - _minute)*60);

            format ["%1:%2:%3", _hour, _minute, _second];
        };
        params ["_name", "_pos", "_radius"];

        _markerName = ("marker_last_spotted_" + _name);
        INFO_1("creating 'spotted' marker %1 local... ", _markerName);

        deleteMarkerLocal _markerName;
        [
            _markerName,
            _pos,
            "ELLIPSE",
            [_radius, _radius],
            "COLOR:", "ColorRed",
            "TEXT:", (format ["%1 %2", _name, ([] call _formattedTime)])
        ] call CBA_fnc_createMarker;
        _markerName setMarkerAlphaLocal 0.5;
        [(format ["%1 wurde gesichtet.", _name])] call Mission_fnc_showHint;
    }
] remoteExec ["BIS_fnc_call", _target, true];
