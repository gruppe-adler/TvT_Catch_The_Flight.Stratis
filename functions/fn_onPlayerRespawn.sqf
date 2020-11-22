params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];
if (isNull _oldUnit) exitWith {}; // ignore first spawn

/*
if !(isNull getAssignedCuratorLogic _newUnit) then {
	_this call BIS_fnc_respawnSeagull;
};
*/
