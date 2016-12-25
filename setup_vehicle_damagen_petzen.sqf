#define PREFIX mission
#define COMPONENT fn

#include "\x\cba\addons\main\script_macros_mission.hpp"

[] call GRAD_vehicleDamageReport_fnc_init;

[{
	_instigator = param [3, objNull];
	[(str side _instigator)]
}] call GRAD_vehicleDamageReport_fnc_addDamageTrackingGroup;

{
	[_x] call GRAD_vehicleDamageReport_fnc_registerVehicle;
 } forEach ([vehicles, {_this isKindOf "Car" }] call CBA_fnc_select);

GVAR(collected_east_damage) = 0;
GVAR(collected_guer_damage) = 0;

if (isServer) then {
	[["east"], {
		_damage = param [0, 0];
		TRACE_1("damage by east", _damage);
		ADD(GVAR(collected_guer_damage), _damage);

		_numUpgrades = floor (GVAR(collected_guer_damage) / 4);
		GVAR(collected_guer_damage) = GVAR(collected_guer_damage) mod 4;

		LOG_1("triggering %1 upgrades for guer", _numUpgrades);
		systemChat ("triggering upgrade for guer " + (str _damage));

		for "_i" from 1 to _numUpgrades do {
			[independent, objNull] call Mission_fnc_giveUpgradeToSide;
		};
	}] call GRAD_vehicleDamageReport_fnc_addServerSideDamageHandler;
	[["guer"], {
		_damage = param [0, 0];
		ADD(GVAR(collected_guer_damage), _damage);
		TRACE_1("damage by guer", _damage);
		if (GVAR(collected_guer_damage) > 4) then {
			LOG("triggering upgrade for east");
			systemChat "triggering upgrade for east";
			[{ [unit_indep_c, Mission_fnc_setupMurderWatch_var_unit_indep_c_radius, opfor] call Mission_fnc_setupMurderWatch_createSpottedMarker; }, [], (random [15, 35, 90])]  call CBA_fnc_waitAndExecute;
			GVAR(collected_guer_damage) = 0;
		};
	}] call GRAD_vehicleDamageReport_fnc_addServerSideDamageHandler;
};
