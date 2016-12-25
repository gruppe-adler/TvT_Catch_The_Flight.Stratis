{
	["Möglicherweise Katzenwache am Flugfeld. INDEP C bekommt alternative Fluchtmöglichkeit! Siehe Map."] call Mission_fnc_showHint;
	{
		[
			"marker_indep_spawn_boat_" + (str _forEachIndex),
			_x,
			"ICON", [1, 1], "COLOR:", "ColorGreen", "TYPE:", "hd_pickup", "TEXT:", "verstecktes Boot"
		] call CBA_fnc_createMarker;
	} forEach [getPos trigger_indep_spawn_boat_1, getPos trigger_indep_spawn_boat_2];

} remoteExec ["BIS_fnc_call", [CIVILIAN, RESISTANCE], true];

{
	["Unsere Leute am Flughafen wurden entdeckt. Verdächtige Aktivität im Nordteil der Insel gemeldet. Wir fürchten, die Zielperson könnte von dort per Boot flüchten."] call Mission_fnc_showHint;
} remoteExec ["BIS_fnc_call", [EAST], true];
