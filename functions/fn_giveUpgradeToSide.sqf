#include "..\script_component.hpp"

_this params [
	["_targetSide", sideUnknown, [sideUnknown]],
	["_deceased", objNull, [objNull]],
	["_upgradeCount", 1,[0]]
];

TRACE_1("starting upgrade for side %1", _targetSide);

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

_getVestClasses = {
	[
		"rhs_vest_commander",
		"rhs_6sh46"
	]
};

/*
lvl2: V_BandollierB_rgr
*/

Mission_fnc_giveUpgradToSide_unitGiveMagazines = {
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
			_hasRadioUpgrade = true;
			if (isPlayer _this) then {
				_hasRadioUpgrade = ([assignedItems _this, _radioClass] call _isRadioInItems) || ([items _this, _radioClass] call _isRadioInItems);
			};

			_hasRadioUpgrade
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

_addWeaponGlobal = {
	params ["_unit", "_weapon"];
	[
		[_unit, _weapon],
		{
			params ["_unit", "_weapon"];
			_unit addWeapon _weapon;
		}
	] remoteExec ["BIS_fnc_call", _unit, true];
};

_addRadioDelayed = {
	{
		_msg = format ["%1: Gegebenenfalls Platz in der Jacke freimachen, gleich gibts ein Funkgerät!", name player];
		[_msg] call Mission_fnc_showHint;
		[{player addItem "tf_fadak";}, [], 30] call CBA_fnc_waitAndExecute;
	} remoteExec ["BIS_fnc_call", _this, true];
};

_unitApplyUpgradeLevel = [ // to be applied to units
	{
		[_this, (selectRandom (_this call _getPistolclasses))] call _addWeaponGlobal;
		[Mission_fnc_giveUpgradToSide_unitGiveMagazines, [_this, 2], 5] call CBA_fnc_waitAndExecute;
	},
	{
		_this addVest (selectRandom (_this call _getVestClasses));
		[_this, (selectRandom (_this call _getRifleClasses1))] call _addWeaponGlobal;
		[Mission_fnc_giveUpgradToSide_unitGiveMagazines, [_this, 2], 5] call CBA_fnc_waitAndExecute;
	},
	{
		_this call _addRadioDelayed;
		[Mission_fnc_giveUpgradToSide_unitGiveMagazines, [_this, 1], 5] call CBA_fnc_waitAndExecute;
	},
	{
		[_this, (selectRandom (_this call _getRifleClasses2))] call _addWeaponGlobal;
		[Mission_fnc_giveUpgradToSide_unitGiveMagazines, [_this, 1], 5] call CBA_fnc_waitAndExecute;
	},
	{
		// _this addVest "V_BandollierB_rgr";
		_this addItem "ACE_Banana";
		// _this addItem "SmokeShell";
		// _this addBackpack "";
		[Mission_fnc_giveUpgradToSide_unitGiveMagazines, [_this, 2], 5] call CBA_fnc_waitAndExecute;
	}
];

_isAlive = {alive _this};
_isTargetAllegiance = { (_this call Mission_fnc_getAllegiance) == _targetSide; };
_isNotTheIndependentBoss =  {(vehicleVarName _this) != "unit_indep_c"};


_deceasedPos = [0, 0, 0];
if (!(isNull _deceased)) then {
	_deceasedPos = getPos _deceased;
};

_eligibleUnits = allUnits;
{
	_eligibleUnits = [_eligibleUnits, _x] call CBA_fnc_select;
} forEach [_isTargetAllegiance, _isAlive, _isNotTheIndependentBoss];

_eligibleUnits = [
	_eligibleUnits,
	[],
	{_x distance2D _deceasedPos},
	"DESCEND"
] call BIS_fnc_sortBy;

_eligibleUnits = [
	_eligibleUnits,
	[],
	{_x call _unitGetNextUpgradeLevel}
] call BIS_fnc_sortBy;

// now we've got eligible units sorted by their next upgrade level. splendid!
// pick the first ones and apply:

TRACE_1("%1 units may be upgraded", count _eligibleUnits);

{
	_level = _x getVariable ["Mission_nextLevel", 0];
	_x call (_unitApplyUpgradeLevel select _level);
	INFO_3("applying upgrade # %1 to unit %2 / %3", _level, _x, name _x);
	{ ["Waffenupgrade für mich!"] call Mission_fnc_showHint; } remoteExec ["BIS_fnc_call", _x, true];

} forEach (_eligibleUnits select [0, _upgradeCount]);
