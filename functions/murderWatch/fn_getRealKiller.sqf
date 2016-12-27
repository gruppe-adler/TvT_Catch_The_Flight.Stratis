#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"

// get the guy who's responsible for a death OR objNull on suicidal behaviour

_deceased = param [0, objNull];
_officialKiller = param [1, objNull];

_killer = _officialKiller;
if (_deceased == _officialKiller) then  { // probably no suicide but...
    _killer = _deceased getVariable ["ace_medical_lastDamageSource", objNull];
};

if (isNull _killer) then {
    TRACE_2("ACE killer not set. Assuming suicide for %1, official killer was %2", _deceased, _officialKiller);
};

_killer
