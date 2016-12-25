/*
 * parameters:
 *     _vehicle ..... object - the vehicle to be tracked
 *
 */

 #define PREFIX grad
 #define COMPONENT vehicleDamageReport
 #include "\x\cba\addons\main\script_macros_mission.hpp"

_vehicle = param [0, objNull];

if (GVAR(vehicles) find _vehicle == -1) then {
	GVAR(vehicles) pushBack _vehicle;

	_vehicle addEventHandler ["HandleDamage", {
		_unit = param [0];
		_removeFromList = {
			_unit = param [0];
			_idx = GVAR(vehicles) find _unit;
			if (_idx != -1) then {
				GVAR(vehicles) deleteAt _idx;
			};
		};

		_this call GRAD_vehicleDamageReport_fnc_handleDamage;

		if !(alive _unit) then {
			_unit removeEventHandler ["HandleDamage", _thisEventHandler];
			[_unit] call _removeFromList;
		};
	}];
};
