
#define PREFIX mission
#define COMPONENT vehicleOwnership
#include "\x\cba\addons\main\script_macros_mission.hpp"


GRAD_VehicleReleaseOwnership = {
	_target setVariable ["mission_owner_side", sideUnknown, true];
};

_action = [
    "GRAD_VehicleReleaseOwnership",
    "Release ownership",
    "",
    GRAD_VehicleReleaseOwnership,
    {
        _allegiance = _player call Mission_fnc_getAllegiance;
        (_target getVariable ["mission_owner_side", sideUnknown]) == _allegiance;
    }
] call ace_interact_menu_fnc_createAction;
["Car", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
