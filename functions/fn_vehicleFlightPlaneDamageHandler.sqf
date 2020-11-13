_plane = _this;

_plane addEventHandler ["HandleDamage", {
    params ["_unit", "_selectionName", "_totalDamage", "_source", "_projectile", "_hitPartIndex", "_instigator"];

    // if a driver exists, disregard damage except the driver is opfor-aligned
    private _driver = driver _unit;
    private _effectiveManipulator = if (isNull _driver) then {_instigator} else {_driver};
    
    if ((_effectiveManipulator call Mission_fnc_getAllegiance) != independent) then {
        _unit removeEventHandler ["HandleDamage", _thisEventHandler];
        mission_state_katzenwache = true;
        [] call Mission_fnc_alert_plane_damaged;
    };
}];
