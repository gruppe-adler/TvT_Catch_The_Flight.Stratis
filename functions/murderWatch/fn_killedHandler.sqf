#include "..\..\script_component.hpp"


_triggerIndepCMarkerForOpfor = {
    params ["_deceased", "_killer"];
    if (Mission_fnc_setupMurderWatch_var_unit_indep_c_radius > 60) then {
        Mission_fnc_setupMurderWatch_var_unit_indep_c_radius = Mission_fnc_setupMurderWatch_var_unit_indep_c_radius - 50;
    };
    INFO_3("Setting spotted-trigger %1 => %2 with radius %3 ...", _killer, _deceased, Mission_fnc_setupMurderWatch_var_unit_indep_c_radius);

    [{ [unit_indep_c, Mission_fnc_setupMurderWatch_var_unit_indep_c_radius, opfor] call Mission_fnc_createSpottedMarker; }, [], (random [15, 35, 90])]  call CBA_fnc_waitAndExecute;
};

params [
    ["_deceased", objNull, [objNull, sideUnknown]], 
    ["_killer", objNull, [objNull]]
];

private _deceasedAllegiance = sideUnknown;
if (_deceased isEqualType sideUnknown) then {
    _deceasedAllegiance = _deceased;
    _deceased = objNull;
} else {
    _killer = [_deceased, _killer] call Mission_fnc_getRealKiller;
    _deceasedAllegiance = _deceased call Mission_fnc_getAllegiance;
};
private _killerAllegiance = _killer call Mission_fnc_getAllegiance;

TRACE_3("killer for %1 (side %2) is %3", _deceased, _deceasedAllegiance, _killer);

switch (_killerAllegiance) do {
    case independent: {
        switch (_deceasedAllegiance) do {
            case independent: {
                INFO_2("Teamkill %1 => %2", _killer, _deceased);
            };
            case opfor: {
                INFO_2("Kill: %1 => %2", _killer, _deceased);

                if ((_deceased getVariable ["mission_faction", ""]) == "OPF_F") then {
                    _this call _triggerIndepCMarkerForOpfor;
                };
                [opfor, _deceased, 3] call Mission_fnc_giveUpgradeToSide;
            };
            default {
                INFO_2("Unbeteiligtenkill %1 => %2", _killer, _deceased);

                [opfor, _deceased, 2] call Mission_fnc_giveUpgradeToSide;
            };
        };
    };
    case opfor: {
        switch (_deceasedAllegiance) do {
            case independent: {
                INFO_2("Kill: %1 => %2", _killer, _deceased);

                [independent, _deceased, 3] call Mission_fnc_giveUpgradeToSide;
            };
            case opfor: {
                INFO_2("Teamkill %1 => %2", _killer, _deceased);
            };
            default {
                INFO_2("Unbeteiligtenkill %1 => %2", _killer, _deceased);
                [independent, _deceased, 2] call Mission_fnc_giveUpgradeToSide;
            };
        };
    };
    default {
        INFO_3("Kill by neutral: %1 => %2 (side %3)", _killer, _deceased, _deceasedAllegiance);
    };
};

if ((!isNull _deceased) && (_deceasedAllegiance in [independent, opfor])) then {
    [_deceased, _deceasedAllegiance] call Mission_fnc_triggerKIAMarker;
};
