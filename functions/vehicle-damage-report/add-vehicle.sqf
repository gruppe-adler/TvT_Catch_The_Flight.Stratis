/*
 * parameters:
 *     _vehicle ..... object - the vehicle to be tracked
 *
 *
 *
 */

 #define PREFIX grad
 #define COMPONENT vehicle-damage-report
 #include "\x\cba\addons\main\script_macros_mission.hpp"

_vehicle = param [0, objNull];

if !(GVAR(vehicles) find _vehicle) then {
    _vehicle addEventHandler ["HandleDamage", {
        _unit = param [0];
        _unregister = {
            _unit removeEventHandler _thisEventHandler;
            _idx = GVAR(vehicles) find _unit;
            if (_idx != -1) then {
                GVAR(vehicles) deleteAt _idx;
            };
        };

        _this call grad_fnc_vehicleDamageReport_client_handleDamage;

        if !(alive _unit) then { [] call _unregister; };
    }];
};
