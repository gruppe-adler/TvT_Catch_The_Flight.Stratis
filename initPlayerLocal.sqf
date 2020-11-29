
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

enableSentences false;
_player addEventHandler ["HandleRating", {0}];
["InitializePlayer", [_player, true]] call BIS_fnc_dynamicGroups;
_player call Mission_fnc_preventOtherSidesFromStealing;
_player call Mission_fnc_setupTasks;
[] call Mission_fnc_setupIDCard;
[] call Mission_fnc_setupActionBackgroundCheck;
[] call Mission_fnc_setupACEInteractVehicleRelease;
[_player, 600] call Mission_fnc_limitSwimmingAbility; // doesnt really make sense to do this for AI

[
	{
		if (side player == east) then {
			["ace_map_bft_enabled", true, 1, "mission"] call CBA_settings_fnc_set
		};
	}, 
	[], 
	5
] call CBA_fnc_waitAndExecute;