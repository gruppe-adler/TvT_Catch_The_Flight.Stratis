{
	["Flugzeug am Flughafen beschädigt. Alternative Fluchtmöglichkeit gefunden!"] call Mission_fnc_showHint;
	{ [_x] call Mission_fnc_createTaskIndepFlight; } forEach [getPos trigger_indep_spawn_boat_1, getPos trigger_indep_spawn_boat_2];

} remoteExec ["BIS_fnc_call", [RESISTANCE], true];

{
	["Am Flughafen ist ein Flugzeug beschädigt worden. Verdächtige Aktivität im Nordteil der Insel gemeldet. Wir fürchten, die Zielperson könnte von dort per Boot flüchten."] call Mission_fnc_showHint;
    {
        _x setTaskState "canceled";
    } forEach task_opfor_katzenwache;
} remoteExec ["BIS_fnc_call", [EAST], true];
