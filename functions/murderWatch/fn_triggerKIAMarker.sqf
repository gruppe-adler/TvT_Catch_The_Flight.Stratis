#include "..\..\script_component.hpp"


params [
    ["_deceased", objNull, [objNull]], 
    ["_deceasedAllegiance", sideUnknown, [sideUnknown]]
];
[
    [(name _deceased), (getPos _deceased)],
    {
        params ["_name", "_pos"];
        [
            "marker_death_" + _name,
            _pos,
            "ICON", [1, 1], "COLOR:", "ColorBlack", "TYPE:", "kia", "TEXT:", _name
        ] call CBA_fnc_createMarker;
    }
] remoteExec ["BIS_fnc_call", _deceasedAllegiance, true];
