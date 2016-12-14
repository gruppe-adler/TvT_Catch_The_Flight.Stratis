// player
_this setVariable ["Mission_side", side _this];
_this addMPEventHandler ["MPKilled", {
    params ["_deceased", "_killer"];

    _sideKiller = side _killer;
    _sideDeceased = _deceased getVariable "Mission_side";

    if (_sideDeceased != _sideKiller) then {
        _sideDeceased call Mission_fnc_giveUpgradeToSide;
    };

}];
