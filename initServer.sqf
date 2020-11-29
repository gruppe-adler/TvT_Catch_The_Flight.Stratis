#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"
#include "missionDefines.hpp"

mission_state_katzenwache = false;
mission_state_boat_spawned = false;

["Initialize"] call BIS_fnc_dynamicGroups;

GVAR(civPlayerAllegiances) = [] call CBA_fnc_HashCreate;
[] call Mission_fnc_setAllSidesFriendly;
[] spawn Mission_fnc_doTheWeather;