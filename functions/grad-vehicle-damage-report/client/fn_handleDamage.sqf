#define PREFIX grad
#define COMPONENT vehicleDamageReport
#define DEBUG_MODE_FULL
#include "\x\cba\addons\main\script_macros_mission.hpp"

 /*
  * Damage handler
  */


params ["_unit", "_selectionName", "_totalDamage", "_source", "_projectile", "_hitPartIndex", "_instigator"];

if (_totalDamage == 0) exitWith {nil};

_unitVarNameStart = "mission_damage_total_by_";

_newDamage = [_unit, _selectionName, _totalDamage] call  {
	params ["_unit", "_selectionName", "_totalDamage"];

	_varName = ("mission_damage_total_" + _selectionName);
	_oldVal = _unit getVariable [_varName, 0];
	_unit setVariable [_varName, _totalDamage];
	(_totalDamage - _oldVal)
};

// often, we get very small quantities here that shouldnt be counted
if (_newDamage < 0.001 && _newDamage > -0.001) exitWith {nil};

_newDamage = _newDamage min 1; // no use to log larger numbers - 1 is dead

_addNewDamageGrouped = {
	params ["_unit", "_varName", "_increment"];
	_damage = ((_unit getVariable [_varName, 0]) + _increment);

	_unit setVariable [_varName, _damage]; // we do NOT want to broadcast here, else we'd probably flood the net badly
};

// cooking off leads to collateral damage which cannot be traced back to the shooter. lets try to change this.
if (!isNull _instigator && _selectionName == "" && _totalDamage > 0.5 && _newDamage > 0.2) then {
	[
		{
			params ["_unit", "_instigator"];
			TRACE_2("setting cookoff instigator for %1 to %2", _unit, _instigator);
			if (_unit getVariable ["ace_cookoff_iscookingoff", false]) then {
				_unit setVariable ["grad_vehicleDamageReport_cookoff_instigator", _instigator];
			};
		},
		[_unit, _instigator],
		0.2
	] call CBA_fnc_waitAndExecute;
};

{
	TRACE_2("instigator %1, source %2", _source, _instigator);
	if (isNull _instigator && !isNull _source) then {
		_instigator = _source getVariable ["grad_vehicleDamageReport_cookoff_instigator", objNull];
		TRACE_1("got probable instigator %1 from object var", _instigator);
	};
	_groups = ([_selectionName, _source, _projectile, _instigator] call _x) joinString "_";
	_unitVarName = (_unitVarNameStart + _groups);
	TRACE_2("new damage %2 on %1", _unitVarName , _newDamage);
	[_unit, _unitVarName, _newDamage] call _addNewDamageGrouped;
} forEach GVAR(groupBy);
