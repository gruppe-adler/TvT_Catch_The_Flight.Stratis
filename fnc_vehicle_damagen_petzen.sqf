[] call grad_fnc_vehicleDamageReport_init;

[{
    _instigator = param [4, objNull];
    str side _instigator
}] call grad_fnc_vehicleDamageReport_addGroupBy;

{
    [_x] call grad_fnc_vehicleDamageReport_addVehicle;
 } forEach ([vehicles, {_this isKindOf "Car" }] call CBA_fnc_select);

if (isServer) then {
    _getSidePunisher = {
        _side = param [0];
        {
            // do the punishing for _side // TODO
        }
    };

    {
        [[_x], ([_x] call _getSidePunisher)] call grad_fnc_vehicleDamageReport_addHandler;
    } forEach ["EAST", "GUER"];
};
