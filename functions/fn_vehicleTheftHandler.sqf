
#define PREFIX grad
#define COMPONENT vehicleOwnership
#include "\x\cba\addons\main\script_macros_mission.hpp"

_vehicle = param [0, objNull];
_newDriver = param [1, objNull];

_ownerSide = _vehicle getVariable ["mission_owner_side", sideUnknown];
_newDriversAllegiance = _newDriver call Mission_fnc_getAllegiance;
_vehicle setVariable ["mission_owner_side", _newDriversAllegiance];

if (_ownerSide == sideUnknown) exitWith {
    INFO_2("vehicle ownership transfer %1 => %2 (empty vehicle)", _ownerSide, _newDriversAllegiance);
};
if (_newDriversAllegiance == _ownerSide) exitWith {
    TRACE_1("no theft, new owner has same allegiance as old one");
};

INFO_2("vehicle ownership transfer %1 => %2 (theft)", _ownerSide, _newDriversAllegiance);

switch (_ownerSide) do {
    case independent: { [independent, _vehicle, 1] call Mission_fnc_giveUpgradeToSide; };
    case opfor: { [opfor, _vehicle, 1] call Mission_fnc_giveUpgradeToSide; };
    // case civilian: { [_ownerSide, _vehicle, 0] call Mission_fnc_giveUpgradeToSide; }; // dont upgrade when civilian fled car, stupid AI fucks
};
