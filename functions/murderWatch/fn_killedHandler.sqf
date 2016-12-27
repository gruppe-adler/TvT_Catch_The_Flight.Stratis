#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"

_triggerIndepCMarkerForOpfor = {
    params ["_deceased", "_killer"];
    if (Mission_fnc_setupMurderWatch_var_unit_indep_c_radius > 60) then {
        Mission_fnc_setupMurderWatch_var_unit_indep_c_radius = Mission_fnc_setupMurderWatch_var_unit_indep_c_radius - 50;
    };
    INFO_3("Setting spotted-trigger %1 => %2 with radius %3 ...", _killer, _deceased, Mission_fnc_setupMurderWatch_var_unit_indep_c_radius);

    [{ [unit_indep_c, Mission_fnc_setupMurderWatch_var_unit_indep_c_radius, opfor] call Mission_fnc_createSpottedMarker; }, [], (random [15, 35, 90])]  call CBA_fnc_waitAndExecute;
};

params ["_deceased", "_killer"];

_killer = _this call Mission_fnc_getRealKiller;

TRACE_1("killer for %1 is %2", _deceased, _killer);

_killerAllegiance = _killer call Mission_fnc_getAllegiance;
_deceasedAllegiance = _deceased call Mission_fnc_getAllegiance;

switch (_killerAllegiance) do {
    case independent: {
        switch (_deceasedAllegiance) do {
            case independent: {
                INFO_2("Teamkill %1 => %2", _killer, _deceased);
            };
            case opfor: {
                INFO_2("Kill: %1 => %2", _killer, _deceased);

                if ((_deceased getVariable "mission_faction") == "OPF_F") then {
                    _this call _triggerIndepCMarkerForOpfor;
                };
                [opfor, _deceased] call Mission_fnc_giveUpgradeToSide;
            };
            default {
                INFO_2("Unbeteiligtenkill %1 => %2", _killer, _deceased);

                [opfor, _deceased] call Mission_fnc_giveUpgradeToSide;
            };
        };
    };
    case opfor: {
        switch (_deceasedAllegiance) do {
            case independent: {
                INFO_2("Kill: %1 => %2", _killer, _deceased);

                [independent, _deceased] call Mission_fnc_giveUpgradeToSide;
            };
            case opfor: {
                INFO_2("Teamkill %1 => %2", _killer, _deceased);
            };
            default {
                INFO_2("Unbeteiligtenkill %1 => %2", _killer, _deceased);
                [independent, _deceased] call Mission_fnc_giveUpgradeToSide;
            };
        };
    };
    default {
        INFO_2("Kill by neutral: %1 => %2", _killer, _deceased);
    };
};

if (_deceasedAllegiance in [independent, opfor]) then {
    [_deceased, _deceasedAllegiance] call Mission_fnc_triggerKIAMarker;
};
