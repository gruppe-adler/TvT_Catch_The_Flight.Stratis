
#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"
#include "missionDefines.hpp"

params ["_player", "_didJIP"];

if (side _player != opfor) then {
	1 enableChannel false;
	2 enableChannel false;
	3 enableChannel false;
	[1, 2, 3] call Mission_fnc_disableMarkerChannels; // TODO: Is this necessary? in MP, blocking the channels should work, actually
};