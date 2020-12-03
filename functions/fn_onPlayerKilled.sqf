#include "..\script_component.hpp"

params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];
if (isNull getAssignedCuratorLogic _newUnit) then {
	_this call ace_spectator_fnc_respawnTemplate;
} else {
	setPlayerRespawnTime 1;	
};
