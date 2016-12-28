
#define PREFIX grad
#define COMPONENT vehicleDamageReport
#include "\x\cba\addons\main\script_macros_mission.hpp"

_interval = 15;

[
	{
		_count = count GVAR(vehicles);
		TRACE_1("petzloop...", _count);
		_varnameTrunk = "mission_damage_total_by_";
		_varnameTrunkCount = count _varnameTrunk;
		{
			_vehicle = _x;
			//TRACE_1("all  var for vehicle: ",_vehicle);
			_relevantVars = [allVariables _vehicle, {((_this find _varnameTrunk) == 0)}] call CBA_fnc_select;
			TRACE_2("relevant var for vehicle: ",_vehicle, _relevantVars);
			{
				_varName = _x;
				_dmg = _vehicle getVariable [_varName, 0];
				_vehicle setVariable [_varName, nil]; // clean up properly to avoid unnecessary loops the next time around
				if (_dmg > 0) then {
					_by = _varName select [_varnameTrunkCount];
					_by = _by splitString "_";
					TRACE_2("ich petze!", _by, _dmg);
					[[_by, _dmg], {
						_by = param [0, []];
						_dmg = param [1, 0];
						_existingDmg = [GVAR(serverSideDamageList), _by] call CBA_fnc_hashGet;
						TRACE_2("server: got damage %1", _by, _dmg);
						[GVAR(serverSideDamageList), _by, (_existingDmg + _dmg)] call CBA_fnc_hashSet;
					}] remoteExec ["BIS_fnc_call", 2 /*server*/];
				};
			} forEach _relevantVars;
		} forEach GVAR(vehicles);
	},
	_interval,
	[]
] call CBA_fnc_addPerFrameHandler;
