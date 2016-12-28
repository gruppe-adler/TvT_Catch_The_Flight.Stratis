// this call Mission_fnc_addFlightPlaneDamageHandler;


_plane = _this;

_plane addEventHandler ["HandleDamage", {
    params ["_unit", "_selectionName", "_totalDamage", "_source", "_projectile", "_hitPartIndex", "_instigator"];

    if (_totalDamage > 0.1) then {
        _unit removeEventHandler ["HandleDamage", _thisEventHandler];
    };
    if ((_instigator call Mission_fnc_getAllegiance) != independent) then {
        mission_state_katzenwache = true;
        [] call Mission_fnc_alert_plane_damaged;
    };
}];
