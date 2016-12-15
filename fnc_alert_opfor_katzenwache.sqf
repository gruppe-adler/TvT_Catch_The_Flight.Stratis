hint "Möglicherweise Katzenwache am Flugfeld. INDEP C bekommt alternative Fluchtmöglichkeit! Siehe Map";

{
    {
        [
            "marker_indep_spawn_boat_" + (str _forEachIndex),
            _x,
            "ICON", [1, 1], "COLOR:", "ColorGreen", "TYPE:", "hd_pickup", "TEXT:", "verstecktes Boot"
        ] call CBA_fnc_createMarker;
    } forEach [getPos trigger_indep_spawn_boat_1, getPos trigger_indep_spawn_boat_2];

} remoteExec ["BIS_fnc_call", [CIVILIAN, RESISTANCE], true];
