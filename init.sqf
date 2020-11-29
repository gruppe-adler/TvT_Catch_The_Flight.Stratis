
#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"
#include "missionDefines.hpp"

disableRemoteSensors true;

tf_no_auto_long_range_radio = true;
tf_give_personal_radio_to_regular_soldier = false;

[] call Mission_fnc_limitOffroadSpeed;

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

{ _x call Mission_fnc_setupMurderWatch; } forEach ([allUnits, {local _this }] call CBA_fnc_select);
{ _x call Mission_fnc_setupVehicleTheftWatch; } forEach ([vehicles, {(local _this) && (_this isKindOf "Car") }] call CBA_fnc_select);
