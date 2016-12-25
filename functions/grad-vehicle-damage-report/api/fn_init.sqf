#define PREFIX grad
#define COMPONENT vehicleDamageReport
#include "\x\cba\addons\main\script_macros_mission.hpp"

if (!isDedicated) then {
	ISNILS(GVAR(clientDamage), ([] call CBA_fnc_hashCreate));
	ISNILS(GVAR(vehicles), []);
	ISNILS(GVAR(groupBy), []);

	[] call GRAD_vehicleDamageReport_fnc_petzenLoop;

};
if (isServer) then {
	ISNILS(GVAR(serverSideHandlers), []);
	_newHash = [[], 0] call CBA_fnc_hashCreate;
	ISNILS(GVAR(serverSideDamageList), _newHash);

	[] call GRAD_vehicleDamageReport_fnc_serverEventLoop;
};
