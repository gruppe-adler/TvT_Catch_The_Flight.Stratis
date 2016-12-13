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

[
    {
        _value = param [0];
        if (_value == "rds_uniform_Woodlander1") then {
            _value = selectRandom [
				"rds_uniform_Worker1",
				"rds_uniform_Worker2",
				"rds_uniform_Worker3",
				"rds_uniform_Worker4",
				"rds_uniform_Woodlander1",
				"rds_uniform_Woodlander2",
				"rds_uniform_Woodlander3",
				"rds_uniform_Woodlander4",
				"rds_uniform_Villager1",
				"rds_uniform_Villager2",
				"rds_uniform_Villager3",
				"rds_uniform_Villager4",
				"rds_uniform_Profiteer1",
				"rds_uniform_Profiteer2",
				"rds_uniform_Profiteer3",
				"rds_uniform_Profiteer4",
				"rds_uniform_citizen1",
				"rds_uniform_citizen2",
				"rds_uniform_citizen3",
				"rds_uniform_citizen4"
		];	
        };
        _value
    },
    "uniform"
] call GRAD_Loadout_fnc_addReviver;
