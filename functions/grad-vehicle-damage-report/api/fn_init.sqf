#define PREFIX grad
#define COMPONENT vehicleDamageReport
#include "\x\cba\addons\main\script_macros_mission.hpp"

ISNILS(GVAR(clientDamage), ([] call CBA_fnc_hashCreate));
ISNILS(GVAR(vehicles), []);
ISNILS(GVAR(groupBy), []);

[] call GRAD_vehicleDamageReport_fnc_petzenLoop;

if (isServer) then {
	GVAR(serverSideHandlers) = [];
	GVAR(serverSideDamageList) = [[], 0] call CBA_fnc_hashCreate;

	[] call GRAD_vehicleDamageReport_fnc_serverEventLoop;
};
