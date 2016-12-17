_this setVariable ["Mission_side", side _this];
_this setVariable ["Mission_faction", faction _this];

_this addMPEventHandler ["MPKilled", {
    params ["_deceased", "_killer"];

diag_log "official killer:";
diag_log _killer;

    _sideKiller = side _killer;
    if (!(_sideKiller in [east, resistance])) then {
        _daRealKiller = _deceased getVariable ["ace_medical_lastDamageSource", objNull];

diag_log "ace last damage from:";
diag_log _daRealKiller;

        if (_daRealKiller != objNull) then {
            _killer = _daRealKiller;
            _sideKiller = side _killer;
        };
    };
    _sideDeceased = _deceased getVariable "Mission_side";

    if (_sideDeceased != _sideKiller) then {

        switch (side _killer) do {
            case independent: {[opfor, _deceased, _killer] call Mission_fnc_giveUpgradeToSide};
            case east:  {[independent, _deceased, _killer] call Mission_fnc_giveUpgradeToSide};
            default { diag_log format ["murder where killer was not indep or east. murderer was %1 / %2", str _killer, name _killer]; };
        };

        if (_sideDeceased == civilian) then {
            {
                ["Der war unbeteiligt. Das macht uns nicht beliebter."] call Mission_fnc_showHint;
            } remoteExec ["BIS_fnc_call", [_sideKiller], true];
        } else {
            {
                ["Wir haben einen unserer Gegner erwischt. Das ist nicht weiter traurig, aber freundlicher werden die dadurch bestimmt nicht..."] call Mission_fnc_showHint;
            } remoteExec ["BIS_fnc_call", [_sideKiller], true];

            {
                ["Einer unserer Leute wurde ermordet! Dies wird Konsequenzen haben."] call Mission_fnc_showHint;
            } remoteExec ["BIS_fnc_call", _sideDeceased, true];
        };
    } else {
        ["teamkill"] call Mission_fnc_showHint;
    };

    [
        [(name _deceased), (getPos _deceased)],
        {
            params ["_name", "_pos"];
            [
                "marker_death_" + _name,
                _pos,
                "ICON", [1, 1], "COLOR:", "ColorBlack", "TYPE:", "kia", "TEXT:", _name
            ] call CBA_fnc_createMarker;
        }
    ] remoteExec ["BIS_fnc_call", [west, east, independent, civilian], true];

}];
