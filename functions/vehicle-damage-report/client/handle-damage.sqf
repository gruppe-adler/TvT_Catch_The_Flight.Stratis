/*
 * parameters:
 *     _vehicle ..... object - the vehicle to be tracked
 *
 *
 *
 */

 #define PREFIX grad
 #define COMPONENT vehicle-damage-report
 #include "\x\cba\addons\main\script_macros_mission.hpp"

params ["_unit", "_selectionName", "_totalDamage", "_source", "_projectile", "_hitPartIndex", "_instigator"];

_unitVarNameStart = "Mission_damage_total_by_";

_registerDamageAndGetIncrement = {
    params ["_unit", "_selectionName", "_totalDamage"];

    _varName = "Mission_damage_total";
    _oldVal = _unit getVariable [_varName, 0];
    _unit setVariable [_varName, _totalDamage];

    _totalDamage - _oldVal
};

_addNewDamageGrouped = {
    params ["_unit", "_varName", "_increment"];
    _damage = (_unit getVariable [_varName, 0]) + _increment;
    _unit setVariable [_varName, _damage]; // we do NOT want to broadcast here, else we'd probably flood the net badly
};

_newDamage = [_unit, _unitVarName, _selectionName] call _registerDamageAndGetIncrement;

{
    _groups = ([_selectionName, _source, _projectile, _instigator] call _x) joinString "_";
    _unitVarName = (_unitVarNameStart + _groups);
    [_unit, _unitVarName, _newDamage] call _addNewDamageGrouped;
} forEach RETDEF([GVAR(groupBy), []);
