
#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"

{
    if (player call Mission_fnc_getAllegiance == opfor) then {
        ["Zielperson an Strand im Norden der Insel gesichtet!"] call Mission_fnc_showHint;
    };
} remoteExec ["BIS_fnc_call", [EAST, CIVILIAN], true];

INFO("opfor & associated alerted to target person being at a beach");
