#include "..\script_component.hpp"

/**
 * declare channels as illegal  for markers.
 *
 * example: [1] call Mission_fnc_disableMarkerChannels;
 *
 * periodically clears illegal markers
 */


_channels = _this;
_interval = 10;

missionNamespace setVariable ["Mission_fnc_disabledMarkerChannels", _channels];

_clearIllegalMarkers = {

	_channelsAsCharacters = [missionNamespace getVariable "Mission_fnc_disabledMarkerChannels", { _x + 48}] call CBA_fnc_filter;

	_isUserMarker = {
		  _a = toArray _this;
		  _a resize 15;

		  (toString _a == "_USER_DEFINED #");
	};

	_isInBadChannel = {
		_a = toArray _this;
		_lastChar = _a select ((count _a) - 1);

		_lastChar in _channelsAsCharacters;
	};

	_markers = allMapMarkers;
	{
		_markers = [_markers, _x] call CBA_fnc_select;
	} forEach [_isUserMarker, _isInBadChannel];

	{
		INFO_1("WARN deleting bad marker %1", _x);
		deleteMarker _x;
	} forEach _markers;
};

_handle = addMissionEventHandler ["Map", _clearIllegalMarkers];
[_clearIllegalMarkers, _interval] call CBA_fnc_addPerFrameHandler;
