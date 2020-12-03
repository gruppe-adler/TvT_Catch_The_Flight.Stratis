#include "..\script_component.hpp"

params ["_position"];

["katzenwacheboat being spawned"] call Mission_fnc_showHint;

vehicle_indep_boat setPos _position;
