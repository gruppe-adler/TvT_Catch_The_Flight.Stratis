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
	if (isServer) then {
		INFO_1("neutral civilian has been killed by %1", _killer);
		[civilian, _killer] call Mission_fnc_killedHandler;
	};	
}] call CBA_fnc_addEventHandler;

["grad_civs_vehicleTheft", {
	params ["_vehicle", "_thief"];
	if (isNull _thief) exitWith {};
	if (isServer) then {
		INFO_2("neutral civilian vehicle %1 might have been stolen by %2, will wait for confirmation (i.e. switch to driver seat...)", _vehicle, _thief);
		_vehicle setVariable ["grad_civs_knownThief", objNull, true];
		_vehicle setVariable ["grad_civs_knownStolen", false, true];
		[
			{
				params ["_vehicle", "_thief"];
				(driver vehicle _thief) == _thief //  disembarked *or* switched to driver
			},
			{
				params ["_vehicle", "_thief"];
				if (vehicle _thief == _vehicle) then { // if driver...
					_vehicle setVariable ["grad_civs_knownThief", _thief, true];
					_vehicle setVariable ["grad_civs_knownStolen", true, true];
					INFO_2("neutral civilian vehicle %1 has been stolen by %2", _vehicle, _thief);
					switch (_thief call Mission_fnc_getAllegiance) do {
						case independent: { [opfor, _vehicle, 1] call Mission_fnc_giveUpgradeToSide; };
						case opfor: { [independent, _vehicle, 1] call Mission_fnc_giveUpgradeToSide; };		
					};
					_vehicle call GRAD_vehicleDamageReport_fnc_registerVehicle;
				};
			},
			[_vehicle, _thief],
			1000,
			{
				// player has become good friends with civ driver by now... just do nothing :P
				INFO("player has been sitting in car for a veerry long time. probably bought it by now. it's ok.");
			}
		] call CBA_fnc_waitUntilAndExecute;
	};
}] call CBA_fnc_addEventHandler;

mission_winConditionFulfilledHandle = [
	"mission_winConditionFulfilled", 
	{
		["mission_winConditionFulfilled", mission_winConditionFulfilledHandle] call CBA_fnc_removeEventHandler;
		_this call Mission_fnc_handleWinConditionFulfilled;
	}
] call CBA_fnc_addEventHandler;

{ _x call Mission_fnc_setupMurderWatch; } forEach ([allUnits, {local _this}] call CBA_fnc_select);
{ _x call Mission_fnc_setupVehicleTheftWatch; } forEach ([vehicles, {(local _this) && (_this isKindOf "Car") }] call CBA_fnc_select);
