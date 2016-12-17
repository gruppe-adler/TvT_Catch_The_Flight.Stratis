params ["_targetSide", "_deceased", "_killer"];

_minDistance = 200;
_radioClass = "tf_fadak";
_getPistolclasses = {
    ["rhs_weap_makarov_pm"]
};
_getRifleClasses1 = {
    [
        "rhs_weap_kar98k", // Halbautomatik
        "rhs_weap_m38", // Halbautomatik
        "rhs_weap_m24sws_blk", // Halbautomatik
        "rhs_weap_M590_5RD" // Schrotflinte
    ]
};

_getRifleClasses2 = {
    [
        "arifle_AKS_F",
        "srifle_DMR_06_olive_F" // M14
    ]
};

_unitGiveMagazines = {
    params ["_player", "_amount"];

    _giveMagazin = {
        params ["_weapon"];
    	_magazines = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
    	_mag = selectRandom _magazines;

        _oldInventoryCount = count (items _player);
		_player addMagazines [_mag, _amount];
        // inventory mightve been full. in that case, put mags in front of player or in vehicle trunk
        _missingMagazines = _oldInventoryCount + _amount - (count (items _player)) ;
        if (_missingMagazines > 0) then {
            _weaponHolder = vehicle _player;
            if (_weaponHolder == _player) then {
                _weaponHolder = "GroundWeaponHolder" createVehicle (getPos _player);
            };
            _weaponHolder addMagazineCargoGlobal [_mag, _missingMagazines];
        };
    };

    _weapon = primaryWeapon _player;
    if (_weapon == "") then {
        _weapon = handgunWeapon _player;
    };
    if (_weapon != "") then {
        [_weapon] call _giveMagazin;
    };
};

_isRadioInItems = {
    params ["_items", "_radioClass"];

    _result = false;
    {
        if (_x find _radioClass == 0 ) exitWith {_result = true}
    } forEach _items;

    _result
};

_unitGetNextUpgradeLevel = {
    _unitHasUpgradeLevel = [
        {
            ((handgunWeapon _this) isKindOf ["Pistol", configFile >> "CfgWeapons"])
        },
        {
            (primaryWeapon _this) in (_this call _getRifleClasses1)
        },
        {
            (([assignedItems _this, _radioClass] call _isRadioInItems) || ([items _this, _radioClass] call _isRadioInItems))
        },
        {
            ((primaryWeapon _this) in (_this call _getRifleClasses2))
        }
        // { ("ACE_Banana" in items _this) } // we dont need to check this, b/c we dont progress past the 5th level
    ];

    reverse _unitHasUpgradeLevel;
    _reverseLevel = (count _unitHasUpgradeLevel);

    {
        if (_this call _x) exitWith { _reverseLevel = _forEachIndex };
    } forEach _unitHasUpgradeLevel;

    _nextLevel = ((count _unitHasUpgradeLevel) - _reverseLevel);
    _this setVariable ["Mission_nextLevel", _nextLevel];

    _nextLevel
};

_unitApplyUpgradeLevel = [ // to be applied to units
	{
        _this addWeaponGlobal (selectRandom (_this call _getPistolclasses));
		[_this, 2] call _unitGiveMagazines;
	},
	{
        _this addWeaponGlobal (selectRandom (_this call _getRifleClasses1));
        [_this, 2] call _unitGiveMagazines;
	},
	{
		_this addItem _radioClass;
        [_this, 1] call _unitGiveMagazines;
	},
	{
        _this addWeaponGlobal (selectRandom (_this call _getRifleClasses2));
		[_this, 2] call _unitGiveMagazines;
    },
    {
		_this addItem "ACE_Banana";
		_this addItem "SmokeShell";
        // _this addBackpack "";
        [_this, 1] call _unitGiveMagazines;
	}
];


_isNotArmy = { faction _this != "OPF_F" };
_isAlive = {alive _this};
_isTargetSide = { side _this == _targetSide };
_isNotTooClose = { (_this distance2D _deceased) >= _minDistance };
_isNotTheIndependentBoss =  {(vehicleVarName _this) != "unit_indep_c"};

_eligibleUnits = allUnits;
{
    _eligibleUnits = [_eligibleUnits, _x] call CBA_fnc_select;
} forEach [_isTargetSide, _isAlive, _isNotArmy, _isNotTooClose,_isNotTheIndependentBoss];

_eligibleUnits = [
    _eligibleUnits,
    [],
    {_x distance2D _deceased},
    "DESCEND"
] call BIS_fnc_sortBy;

_eligibleUnits = [
    _eligibleUnits,
    [],
    {_x call _unitGetNextUpgradeLevel}
] call BIS_fnc_sortBy;

// now we've got eligible units sorted by their next upgrade level. splendid!
// pick the first ones and apply:

diag_log _eligibleUnits;
diag_log ("units found that may be upgraded: " + (str count _eligibleUnits));

{
    _level = _x getVariable ["Mission_nextLevel", 0];
    _x call (_unitApplyUpgradeLevel select _level);
    diag_log format ["applying upgrade # %1 to unit %2 / %3", _level, _x, name _x];
    { hint "Waffenupgrade für mich!"; } remoteExec ["BIS_fnc_call", _x, true];

} forEach (_eligibleUnits select [0, 2]);
