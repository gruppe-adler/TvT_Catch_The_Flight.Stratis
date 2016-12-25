switch (side player) do {
	case east: {
		_title = localize "str_GRAD_OPFOR_A_title";
		_content = localize "str_GRAD_OPFOR_A_story";
		_condition = localize "str_GRAD_OPFOR_A_condition";

		{
			[

				"marker_opfor_katzenwache_" + (str _forEachIndex),
				_x,
				"ICON", [1, 1], "COLOR:", "ColorBrown", "TYPE:", "mil_warning", "TEXT:", "überwacht"
			] call CBA_fnc_createMarker;
		} forEach [getPos trigger_opfor_katzenwache_1, getPos trigger_opfor_katzenwache_2, getPos trigger_opfor_katzenwache_3];

		[_title, _content, _condition] call Mission_fnc_create_tasks;

	};
	case resistance: {

		_title = localize "str_GRAD_INDEP_C_title";
		_content = localize "str_GRAD_INDEP_C_story";
		_condition = localize "str_GRAD_INDEP_C_condition";

		[
			"marker_indep_spawn_plane",
			(getPos vehicle_flight_plane),
			"ICON", [1, 1], "COLOR:", "ColorGreen", "TYPE:", "hd_pickup"
		] call CBA_fnc_createMarker;

		[_title, _content, _condition] call Mission_fnc_create_tasks;
	};
	case civilian: {
		[player] remoteExecCall ["Mission_fnc_getMyAllegiance", 2];
	};
};

