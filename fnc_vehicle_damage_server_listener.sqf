params ["_side", "_damage"];

diag_log format ["client reports %1 damage from %2", _damage, _side];

_varName = format ["Mission_vehicle_damage_total_%1", str _side];

_value = missionNamespace getVariable [_varName, 0];

_threshold = 10;


if (_value > _threshold) then {
  diag_log format ["side damage exceeded %1, calling punishment for %2", _threshold, str _side];
  _value = _value - _threshold;
};

missionNamespace setVariable [_varName, _value];
