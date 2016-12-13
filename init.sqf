#include "missionMacros.h"

DEBUG_MODE = ("DebugMode" call BIS_fnc_getParamValue) == 1;

disableRemoteSensors true;

 tf_no_auto_long_range_radio = true;
 tf_give_personal_radio_to_regular_soldier = false;

[] call Mission_fnc_limitOffroadSpeed;

if (isServer) then {
	[] call Mission_fnc_setAllSidesFriendly;
};

if (hasInterface) then {
	waitUntil {!isNull player};
	enableSentences false;
};

[] execVM "loadouts.sqf";


1 enableChannel false;
2 enableChannel false;
3 enableChannel false;
[1, 2, 3] call Mission_fnc_disableMarkerChannels;
