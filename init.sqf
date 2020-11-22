
#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"
#include "missionDefines.hpp"

disableRemoteSensors true;

tf_no_auto_long_range_radio = true;
tf_give_personal_radio_to_regular_soldier = false;

mission_state_katzenwache = false;
mission_state_boat_spawned = false;

[] call Mission_fnc_limitOffroadSpeed;

if (isServer) then {
	["Initialize"] call BIS_fnc_dynamicGroups;

	GVAR(civPlayerAllegiances) = [] call CBA_fnc_HashCreate;
	[] call Mission_fnc_setAllSidesFriendly;
    [] spawn Mission_fnc_doTheWeather;
};

[] execVM "setup_vehicle_damagen_petzen.sqf";
[] execVM "loadouts.sqf";

[] call GRAD_replay_fnc_init;

["grad_civs_civKilled", { 
	params ["_deathPos", "_killer"]; 
	[civilian, _killer] call Mission_fnc_killedHandler;
}] call CBA_fnc_addEventHandler;
["grad_civs_vehicleTheft", {
	params ["_vehicle", "_thief"];
	if (isNull _thief) exitWith {};
	switch (_thief call Mission_fnc_getAllegiance) do {
		case independent: { [opfor, _vehicle, 1] call Mission_fnc_giveUpgradeToSide; };
		case opfor: { [independent, _vehicle, 1] call Mission_fnc_giveUpgradeToSide; };		
	};
	_vehicle call GRAD_vehicleDamageReport_fnc_registerVehicle;
}] call CBA_fnc_addEventHandler;

mission_winConditionFulfilledHandle = [
	"mission_winConditionFulfilled", 
	{
		["mission_winConditionFulfilled", mission_winConditionFulfilledHandle] call CBA_fnc_removeEventHandler;
		_this call Mission_fnc_handleWinConditionFulfilled;
	}
] call CBA_fnc_addEventHandler;

if (hasInterface) then {
	waitUntil {!isNull player};
	enableSentences false;
	player addEventHandler ["HandleRating", {0}];
	["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;
	player call Mission_fnc_preventOtherSidesFromStealing;
	player call Mission_fnc_setupTasks;
	[] call Mission_fnc_setupIDCard;
    [] call Mission_fnc_setupActionBackgroundCheck;
    [] call Mission_fnc_setupACEInteractVehicleRelease;
	[player, 600] call Mission_fnc_limitSwimmingAbility; // doesnt really make sense to do this for AI

	if (side player != opfor) then {
		1 enableChannel false;
		2 enableChannel false;
		3 enableChannel false;
		[1, 2, 3] call Mission_fnc_disableMarkerChannels; // TODO: Is this necessary? in MP, blocking the channels should work, actually

		player setVariable ["ace_map_hideBlueForceMarker", true, true];
	};
};

{ _x call Mission_fnc_setupMurderWatch; } forEach ([allUnits, {local _this }] call CBA_fnc_select);
{ _x call Mission_fnc_setupVehicleTheftWatch; } forEach ([vehicles, {(local _this) && (_this isKindOf "Car") }] call CBA_fnc_select);


#ifdef DEBUG_MODE_FULL
// FOR LOCAL TESTING
    {
        if (_forEachIndex mod 4 == 0) then {
            _x setVariable ["mission_allegiance", opfor, true];
        } else {
            _x setVariable ["mission_allegiance", independent, true];
        };
		if (side _x != east) then {
			_x setVariable ["ace_map_hideBlueForceMarker", true, true];
		};

    } forEach ([playableUnits + switchableUnits - [player], {local _this}] call CBA_fnc_select);

#endif
