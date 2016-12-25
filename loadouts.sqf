[
	{
		params ["_value", "_unit"];
		if (_value == "rds_uniform_Woodlander1") then {
			_value = selectRandom ([] call Mission_fnc_civilianUniforms);
		};
		_value
	},
	"uniform"
] call GRAD_Loadout_fnc_addReviver;

_lessSprayPaint = {
	params ["_value", "_unit"];

	([_value, {
		_reject = false;
		if (_this == "ACE_SpraypaintRed") then {
			if (side _unit == civilian) then {
				_reject = (random 1) >= 0.4;
			};
		};

		_reject
	}] call CBA_fnc_reject);
};

[_lessSprayPaint, "addItemsToUniform"] call GRAD_Loadout_fnc_addReviver;
[_lessSprayPaint, "addItemsToVest"] call GRAD_Loadout_fnc_addReviver;
[_lessSprayPaint, "addItemsToBackpack"] call GRAD_Loadout_fnc_addReviver;
