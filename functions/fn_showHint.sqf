#include "..\script_component.hpp"

params ["_message", "_type"];

if (isNil "_type") then {
	_type = "";
};

systemChat format ["mission: %1", _message];
hint _message;
diag_log format ["mission: %1: %2", _type, _message];
