#define PREFIX mission
#define COMPONENT fn
#include "\x\cba\addons\main\script_macros_mission.hpp"
#include "missionDefines.hpp"

mission_state_katzenwache = false;
mission_state_boat_spawned = false;

["Initialize"] call BIS_fnc_dynamicGroups;

GVAR(civPlayerAllegiances) = [] call CBA_fnc_HashCreate;
[] call Mission_fnc_setAllSidesFriendly;
[] spawn Mission_fnc_doTheWeather;


GVAR(NumberOfLrRadiosForOpfor) = "NumberOfLrRadiosForOpfor" call BIS_fnc_getParamValue;
opfor_crate addBackpackCargoGlobal ["TFAR_anprc155_coyote", GVAR(NumberOfLrRadiosForOpfor)];


GVAR(civSpawnPositions) = (allUnits select { typeOf _x == "C_Soldier_VR_F"}) apply {
	private _pos = getPos _x;
	deleteVehicle _x;
	_pos
};



addMissionEventHandler [QGVAR(playerConnected), {
	if (count GVAR(randomCivSpawnPositions) == 0) then {
		GVAR(randomCivSpawnPositions) = GVAR(civSpawnPositions) call BIS_fnc_arrayShuffle;	
	};
	private _pos = GVAR(randomCivSpawnPositions) deleteAt 0;
	private _player = _this;
	
	[QGVAR(spawnPosition), _pos, _player] call CBA_fnc_targetEvent;
}];
