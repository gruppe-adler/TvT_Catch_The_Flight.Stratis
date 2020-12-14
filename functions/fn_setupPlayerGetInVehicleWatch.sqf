#include "..\script_component.hpp"

_this addEventHandler [
    "GetInMan",
    {
        params ["_player", "_role", "_vehicle", "_turret"];
        private _driver = driver _vehicle;
        if (_driver isEqualTo _player) then {
            [_vehicle, _driver] call Mission_fnc_vehicleTheftHandler;
        };        
    }
];


_this addEventHandler [
    "SeatSwitchedMan",
    {
        params ["_player", "_unit2", "_vehicle"];
        private _driver = driver _vehicle;
        if (_driver isEqualTo _player) then {
            [_vehicle, _driver] call Mission_fnc_vehicleTheftHandler;
        };        
    }
];
