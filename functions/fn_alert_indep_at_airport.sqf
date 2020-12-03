#include "..\script_component.hpp"

{
    if (player call Mission_fnc_getAllegiance == opfor) then {
        ["Zielperson am Flughafen gesichtet!"] call Mission_fnc_showHint;
    };
} remoteExec ["BIS_fnc_call", [EAST, CIVILIAN], true];

INFO("opfor & associates alerted to target person being at airport");
