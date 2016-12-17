params [
    "_unit",
    "_drowningTimeout"
];

_interval = 30;
_unit setVariable ["Mission_fnc_limitSwimming_dangerStart", time];
_unit setVariable ["Mission_fnc_limitSwimming_swimming", false];

_drownLoop = {
    _isSwimmingInDeepWater = {
        _pos = getPosATL _this;
        (
            (surfaceIsWater _pos) &&
            (vehicle _this == _this) &&
            (
                (!isTouchingGround _this) ||
                (underwater _this)
            )
         );
    };

diag_log "checking swimming";
    params ["_params"];
    _unit = _params select 0;
    _drowningTimeout = _params select 1;

    _swimmingStartTime = _unit getVariable ["Mission_fnc_limitSwimming_dangerStart", time];

    _pos = getPos _unit;

    if (!(_unit call _isSwimmingInDeepWater)) then {
        _swimmingStartTime = time;
        if (_unit getVariable ["Mission_fnc_limitSwimming_swimming", false]) then {
                ["Du hast dich vom Schwimmen erholt."] call Mission_fnc_showHint;
                _unit setVariable ["Mission_fnc_limitSwimming_swimming", false];
            };
    } else {
        _unit setVariable ["Mission_fnc_limitSwimming_swimming", true];
    };

    if ((_swimmingStartTime + (_drowningTimeout/2)) < time) then {
        ["Das Schwimmen wird sehr anstrengend. Point of no return erreicht oder überschritten!"] call Mission_fnc_showHint;
    };

   if ((_swimmingStartTime + _drowningTimeout) < time) then {
       ["Du ersäufst. Dein letzter haßerfüllter Gedanke gilt dem Missionsbauer."] call Mission_fnc_showHint;
        _unit setUnconscious true;
        [{_this setDamage 1;}, _unit, 5] call CBA_fnc_waitAndExecute;

   };
   _unit setVariable ["Mission_fnc_limitSwimming_dangerStart", _swimmingStartTime];
};

[_drownLoop, _interval, [_unit, _drowningTimeout]] call CBA_fnc_addPerFrameHandler;
