#include "..\script_component.hpp"

params [
	["_trigger", objNull, [objNull]],
	["_brush", "", [""]],
	["_color", "", [""]]
];


(triggerArea _trigger) params ["_a", "_b", "_angle", "_isRectangle", "_c"];
private _shape = if (_isRectangle) then {"RECTANGLE"} else {"ELLIPSE"};

private _marker = createMarkerLocal [format ["marker_%1", _trigger], getPos _trigger];
_marker setMarkerSizeLocal [_a, _b];
_marker setMarkerShapeLocal _shape;
_marker setMarkerDirLocal _angle;
_marker setMarkerAlphaLocal 0.5;
_marker setMarkerBrushLocal _brush;
_marker setMarkerColorLocal _color;
_marker setMarkerTypeLocal "Empty";

_marker
