#define PREFIX grad
#define COMPONENT vehicle-damage-report
#include "\x\cba\addons\main\script_macros_mission.hpp"

_interval = 5;

[
    {
        {
            _vehicle = _x;
             _relevantVars = [allVariables _vehicle, {_this find "Mission_damage_total_by_" != -1}] call CBA_fnc_select
             {
                 _varName = _x;
                 _dmg = _vehicle getVariable _varName;
                _vehicle setVariable [_varName, nil]; // clean up properly to avoid unnecessary loops the next time around

                 // [_varName, _dmg] call tellTheServer // TODO
                 //[[_instigatorSide, _totalSideDamage], {
                //     _this call Mission_fnc_vehicle_damage_server_listener;
                 // }] remoteExec ["BIS_fnc_call", 2 /*server*/, true];

             } forEach _relevantVars;
        } forEach GVAR(vehicles);
    },
    _interval,
    []
] call CBA_fnc_addPerFrameHandler;
