#include "..\script_component.hpp"

_this setVariable ["mission_side", side _this];
_this setVariable ["mission_faction", faction _this];

if (isNil "Mission_fnc_setupMurderWatch_var_unit_indep_c_radius") then {
	Mission_fnc_setupMurderWatch_var_unit_indep_c_radius = 500;
};

_this addMPEventHandler ["MPKilled", {
	if (isServer) then {
		_this call Mission_fnc_killedHandler;
	};
}];

_this addMPEventHandler ["MPHit", {
	params ["_unit", "_causedBy", "_damage", "_instigator"];	
	if (_unit getVariable ["mission_lasthit", 0] > CBA_missiontime - 1) exitWith {};
	_unit setVariable ["mission_lasthit", CBA_missiontime];
	if (isServer) then {
		if (isNull _instigator) exitWith {};
		switch (_instigator call Mission_fnc_getAllegiance) do {
			case independent: { [opfor, _unit, 1] call Mission_fnc_giveUpgradeToSide; };
			case opfor: { [independent, _unit, 1] call Mission_fnc_giveUpgradeToSide; };		
		};
	};
}];
