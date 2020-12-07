
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
[] call Mission_fnc_setupACEInteractVehicleRelease;
[_player] call Mission_fnc_limitSwimmingAbility; // doesnt really make sense to do this for AI

[
	{
		if (side player == east) then {
			["ace_map_bft_enabled", true, 1, "mission"] call CBA_settings_fnc_set
		};
		if (side player == independent && rank player == "CAPTAIN") then {
			player setVariable ["ACE_Name", "Schlemihl Schellnhuber", true];
		};
	}, 
	[], 
	5
] call CBA_fnc_waitAndExecute;

GVAR(drowningTimeout) = 600;

// TODO hacky hack, must be made obsolete by future grad-civs fixes
_player addEventHandler ["SeatSwitchedMan", {
	params ["_player", "_potentialCiv", "_vehicle"];
	if (_potentialCiv getVariable ["grad_civs_primaryTask", ""] != "") then {
		private _gradCiv = _potentialCiv;
		if ("Driver" in (assignedVehicleRole _player)) then {
			INFO("player switched place with a grad-civ  driver, whom i will now eject.");
			// uh oh, someone has removed the grad-civs driver, thus effectively stealing the vehicle.
			// we need to make sure this is recognized - which it currently is not if the civ were to stay in the vehicle
			// ... also, the civ would lock up and never get out of the state they're in. so --- eject after a carjacking!
			private _stateMachine = grad_civs_common_stateMachines getVariable ["emotions", locationNull];
			if (isNull _stateMachine) exitWith {
				WARNING("grad civs state machine 'emotions' not found!");
			};
			[
				_gradCiv,
				_stateMachine,
				"emo_relaxed",
				"emo_panic",
				{
					moveOut _this;
				}				
			] call CBA_statemachine_fnc_manualTransition;
		};
		
	};
}];
