_this setVariable ["Mission_side", side _this];
_this setVariable ["Mission_faction", faction _this];

_this addMPEventHandler ["MPKilled", {
    params ["_deceased", "_killer"];

    _sideKiller = side _killer;
    _sideDeceased = _deceased getVariable "Mission_side";

    if (_sideDeceased != _sideKiller) then {
        _sideDeceased call Mission_fnc_giveUpgradeToSide;
    };


    {
        hint "Wir haben einen unserer Gegner erwischt. Das ist nicht weiter traurig, aber freundlicher werden die dadurch bestimmt nicht...";
    } remoteExec ["BIS_fnc_call", [_sideKiller], true];

    {
        hint "Einer unserer Leute wurde ermordet! Dies wird Konsequenzen haben.";
    } remoteExec ["BIS_fnc_call", [west, east, resistance, civilian] - _sideKiller, true];

}];
