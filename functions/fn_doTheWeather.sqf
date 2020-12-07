#include "..\script_component.hpp"

[] spawn {
    INFO("setting initial fog values...");

    private _fogSettings = "FogSettings" call BIS_fnc_getParamValue;
    if (_fogSettings == FOG_NOFOG) exitWith {
        INFO("clearing all fog.");
        0 setFog [0, 0, 0];
    };

    0 setFog [0.6, 0.2, 10];

    if (_fogSettings == FOG_PERMAFOG) exitWith {
        INFO("permafog it is.");
        true
    };

    [
    {
        private _fogLiftDelay = param [0];
        INFO_1("starting fog easing over %1 seconds...",  _fogLiftDelay);
        _fogLiftDelay setFog [0.0, 0.0, 0];
    },
    [_fogSettings],
    5
    ] call CBA_fnc_waitAndExecute;
};
