#define PREFIX grad
#define COMPONENT vehicle-damage-report
#include "\x\cba\addons\main\script_macros_mission.hpp"

if (!isDedicated) then {
    ISNILS(GVAR(clientDamage), [] call CBA_fnc_hashCreate);
    ISNILS(GVAR(vehicles), []);
    ISNILS(GVAR(groupBy), [[], {""}] call CBA_fnc_hashCreate);

    [] call grad_fnc_vehicleDamageReport_client_petzen;

};
if (isServer) then {
    ISNILS(GVAR(serverSideHandlers), [] call CBA_fnc_hashCreate);

    [] call grad_fnc_vehicleDamageReport_server_handler;
};
