
#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"

_this setVariable ["mission_side", side _this];
_this setVariable ["mission_faction", faction _this];

if (isNil "Mission_fnc_setupMurderWatch_var_unit_indep_c_radius") then {
	Mission_fnc_setupMurderWatch_var_unit_indep_c_radius = 500;
};

_this addMPEventHandler ["MPKilled", {
	if (isServer) then {
		_this call Mission_fnc_killedHandler;
	};
}];
