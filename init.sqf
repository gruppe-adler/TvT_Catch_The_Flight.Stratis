#include "missionMacros.h"

DEBUG_MODE = ("DebugMode" call BIS_fnc_getParamValue) == 1;

disableRemoteSensors true;

 tf_no_auto_long_range_radio = true;
 tf_give_personal_radio_to_regular_soldier = false;

 mission_state_katzenwache = false;
 mission_state_boat_spawned = false;

[] call Mission_fnc_limitOffroadSpeed;

if (isServer) then {
    ["Initialize"] call BIS_fnc_dynamicGroups;
	[] call Mission_fnc_setAllSidesFriendly;
};

[] spawn {
    _handle = [] execVM "node_modules\engima-traffic\Init.sqf";
    waitUntil {scriptDone _handle};
    ENGIMA_TRAFFIC_spawnHandler pushBack {
        params ["_unit"];
        diag_log "setting up murder watch for civ";
        _unit call Mission_fnc_setupMurderWatch;
    };
};

[] execVM "node_modules\grad-leaveNotes\initLeaveNotes.sqf";

if (hasInterface) then {
	waitUntil {!isNull player};
	enableSentences false;
    player addEventhandler ["HandleRating", {0}];
    ["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;
    player call Mission_fnc_preventOtherSidesFromStealing;
    player call Mission_fnc_setup_tasks;
    [] call Mission_fnc_setupIDCard;
    [player, 600] call Mission_fnc_limitSwimmingAbility; // doesnt really make sense to do this for AI
};

{ _x call Mission_fnc_setupMurderWatch; } forEach ([allUnits, {local _this }] call CBA_fnc_select);

[] execVM "loadouts.sqf";


1 enableChannel false;
2 enableChannel false;
3 enableChannel false;
[1, 2, 3] call Mission_fnc_disableMarkerChannels; // TODO: Is this necessary? in MP, blocking the channels should work, actually
