#include "..\script_component.hpp"

/**
 * mark vehicle ownerships: 
 *  defaults to sideEmpty - vehicle not owned by anybody
 *  then set to first person to use it
 *  on allegaince changed to sideUnknown to mark as stolen
 */

params [
    ["_vehicle", objNull, [objNull]], 
    ["_newDriver", objNull, [objNull]]
];

private _oldDriversAllegiance = _vehicle getVariable ["mission_owner_side", sideEmpty];
private _newDriversAllegiance = _newDriver call Mission_fnc_getAllegiance;
if (_newDriversAllegiance isEqualTo _oldDriversAllegiance) exitWith {
    TRACE_1("no theft of vehicle %1, new owner has same allegiance as old one", _vehicle);
};
if (_vehicle getVariable ["grad_civs_knownStolen", false]) exitWith {
    // grad-civs are handled by separate handler
    INFO_1("vehicle %1 is known as stolen from civs", _vehicle);
};
if (_oldDriversAllegiance isEqualTo sideUnknown) exitWith {
    INFO_1("vehicle %1 is known as stolen from player ", _vehicle);
};

if (_oldDriversAllegiance isEqualTo sideEmpty) exitWith {
    _vehicle setVariable ["mission_owner_side", _newDriversAllegiance, true];
    INFO_1("empty vehicle ownership is being taken by %1", _newDriversAllegiance);
};

INFO_2("vehicle allegiance transfer %1 => %2 (theft)", _oldDriversAllegiance, _newDriversAllegiance);
_vehicle setVariable ["mission_owner_side", sideUnknown, true];

switch (_oldDriversAllegiance) do {
    case independent: { [independent, _vehicle, 1] call Mission_fnc_giveUpgradeToSide; };
    case opfor: { [opfor, _vehicle, 1] call Mission_fnc_giveUpgradeToSide; };
};
