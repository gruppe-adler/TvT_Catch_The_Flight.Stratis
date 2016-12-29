
#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"
#include "missionMacros.h"

disableRemoteSensors true;

tf_no_auto_long_range_radio = true;
tf_give_personal_radio_to_regular_soldier = false;

mission_state_katzenwache = false;
mission_state_boat_spawned = false;

[] call Mission_fnc_limitOffroadSpeed;

if (isServer) then {
	["Initialize"] call BIS_fnc_dynamicGroups;

	GVAR(civPlayerAllegiances) = [] call CBA_fnc_HashCreate;
	[] call Mission_fnc_setAllSidesFriendly
};

[] execVM "setup_vehicle_damagen_petzen.sqf";
[] execVM "loadouts.sqf";

[] spawn {
	_handle = [] execVM "node_modules\engima-traffic\Init.sqf";
	waitUntil {scriptDone _handle};
	ENGIMA_TRAFFIC_spawnHandler pushBack {
		params ["_unit"];
		_unit call Mission_fnc_setupMurderWatch;
	};
	ENGIMA_TRAFFIC_vehicleSpawnHandler pushBack {
		_this call GRAD_vehicleDamageReport_fnc_registerVehicle;
        _this call Mission_fnc_setupVehicleTheftWatch;
	};
};

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

        ace_map_BFT_Enabled = false;
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

    } forEach ([playableUnits + switchableUnits, {local _this}] call CBA_fnc_select);

#endif
