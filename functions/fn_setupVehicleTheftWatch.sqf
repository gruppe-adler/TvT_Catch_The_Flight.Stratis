#include "..\script_component.hpp"

_vehicle =  param [0, objNull];

_vehicle addEventHandler [
    "GetIn",
    {
        params ["_vehicle", "_position", "_unit"];
        _driver = driver _vehicle;
        if (isNull _driver || (_driver != _unit)) exitWith {TRACE_2("person %1 got in vehicle %2, but not as driver", _unit, _vehicle); false};
        [_vehicle, _driver] call Mission_fnc_vehicleTheftHandler;
    }
];


_vehicle addEventHandler [
    "SeatSwitched",
    {
        params ["_vehicle", "_unit1", "_unit2"];
        _driver = driver _vehicle;
        if (isNull _driver) exitWith {TRACE_2("units %1, %2 switched seats in vehicle %3, but not to driver", _unit1, _unit2, _vehicle); false};
        [_vehicle, _driver] call Mission_fnc_vehicleTheftHandler;
    }
];
