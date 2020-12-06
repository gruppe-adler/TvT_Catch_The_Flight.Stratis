#include "..\script_component.hpp"

params ["_unit"];

_interval = 2;
_unit setVariable ["Mission_fnc_limitSwimming_dangerStart", time];
_unit setVariable ["Mission_fnc_limitSwimming_swimming", false];

_drownLoop = {
	params ["_params"];
	private _unit = _params select 0;
	private _drowningTimeout = GVAR(drowningTimeout);

	private _hasBeenSwimmingSince = _unit getVariable ["mission_swimstart", -1];
	private _isSwimming = _unit call mission_fnc_isSwimming;

	if (_hasBeenSwimmingSince == -1) exitWith { 
		if _isSwimming then {
			_unit setVariable ["mission_swimstart", CBA_missiontime, true];
		};
	};
	
	if (!_isSwimming) exitWith {
		["Du hast dich vom Schwimmen erholt."] call Mission_fnc_showHint;		
		_unit setVariable ["mission_swimstart", nil, true];
	};


	if ((_hasBeenSwimmingSince + (_drowningTimeout/2)) < CBA_missiontime) then {
		["Das Schwimmen wird sehr anstrengend. Point of no return erreicht oder überschritten!"] call Mission_fnc_showHint;
	};

   if ((_hasBeenSwimmingSince + _drowningTimeout) < CBA_missiontime) then {
	   ["Du ersäufst. Dein letzter haßerfüllter Gedanke gilt dem Missionsbauer."] call Mission_fnc_showHint;
       INFO_1("Spieler %1 ertrinkt", _unit);
		_unit setUnconscious true;
		[{_this setDamage 1;}, _unit, 5] call CBA_fnc_waitAndExecute;

   };
};

[_drownLoop, _interval, [_unit]] call CBA_fnc_addPerFrameHandler;
