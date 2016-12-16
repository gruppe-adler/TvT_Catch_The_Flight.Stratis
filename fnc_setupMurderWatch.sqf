_this setVariable ["Mission_side", side _this];
_this setVariable ["Mission_faction", faction _this];

_this addMPEventHandler ["MPKilled", {
    params ["_deceased", "_killer"];

    _sideKiller = side _killer;
    _sideDeceased = _deceased getVariable "Mission_side";

    if (_sideDeceased != _sideKiller) then {
        _sideDeceased call Mission_fnc_giveUpgradeToSide;

        if (_sideDeceased == civilian) then {
            {
                hint "Der war unbeteiligt. Das macht uns nicht beliebter.";
            } remoteExec ["BIS_fnc_call", [_sideKiller], true];
        } else {
            {
                hint "Wir haben einen unserer Gegner erwischt. Das ist nicht weiter traurig, aber freundlicher werden die dadurch bestimmt nicht...";
            } remoteExec ["BIS_fnc_call", [_sideKiller], true];

            {
                hint "Einer unserer Leute wurde ermordet! Dies wird Konsequenzen haben.";
            } remoteExec ["BIS_fnc_call", _sideDeceased, true];
        };
    } else {
        hint "teamkill";
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
