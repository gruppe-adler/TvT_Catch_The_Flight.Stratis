#include "..\..\script_component.hpp"

// get the guy who's responsible for a death OR objNull on suicidal behaviour

params [
    ["_deceased", objNull, [objNull, sideUnknown]], 
    ["_officialKiller", objNull, [objNull]]
];

private _killer = _officialKiller;
if (_deceased == _officialKiller) then  { // probably no suicide but...
    _killer = _deceased getVariable ["ace_medical_lastDamageSource", objNull];
} else {
    _cookoffInstigator = _officialKiller getVariable ["grad_vehicleDamageReport_cookoff_instigator", objNull];
    if (!(isNull _cookoffInstigator)) then {
        _killer = _cookoffInstigator;
    };
};

if (isNull _killer) then {
    TRACE_2("ACE killer not set. Assuming suicide for %1, official killer was %2", _deceased, _officialKiller);
};

_killer
