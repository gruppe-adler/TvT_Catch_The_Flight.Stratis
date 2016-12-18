_this setVariable ["Mission_side", side _this];
_this setVariable ["Mission_faction", faction _this];

if (isNil "Mission_fnc_setupMurderWatch_var_unit_indep_c_radius") then {
    Mission_fnc_setupMurderWatch_var_unit_indep_c_radius = 500;
};

if (isNil "Mission_fnc_setupMurderWatch_createSpottedMarker") then {
    Mission_fnc_setupMurderWatch_createSpottedMarker = {
        params ["_unit", "_radius", "_target"];
        _pos = getPos _unit;
        _name = name _unit;

        diag_log "creating 'spotted' marker: exec remote...";

        _x = (_pos select 0) - _radius + random _radius;
        _y = (_pos select 1) - _radius + random _radius;

        [
            [_name, [_x, _y], _radius * 2],
            {
                _formattedTime = {
                    _hour = floor daytime;
                    _minute = floor ((daytime - _hour) * 60);
                    _second = floor (((((daytime) - (_hour))*60) - _minute)*60);

                    format ["%1:%2:%3", _hour, _minute, _second];
                };
                params ["_name", "_pos", "_radius"];

                _markerName = ("marker_last_spotted_" + _name);
                diag_log ("creating 'spotted' marker local... " + _markerName);

                deleteMarker _markerName;
                [
                    _markerName,
                    _pos,
                    "ELLIPSE",
                    [_radius, _radius],
                    "COLOR:", "ColorRed",
                    "TEXT:", (format ["%1 %2", _name, ([] call _formattedTime)])
                ] call CBA_fnc_createMarker;
                _markerName setMarkerAlphaLocal 0.5;
                [(format ["%1 wurde gesichtet.", _name])] call Mission_fnc_showHint;
            }
        ] remoteExec ["BIS_fnc_call", _target, true];
    };
};

Mission_fnc_setupMurderWatch_killedHandler = {
    _getSide = {
        _side = sideUnknown;
        if (alive _this) then {
            _side = side _this;
        } else {
            _side = _this getVariable ["Mission_side", sideUnknown];
        };

        _side
    };

    params ["_deceased", "_killer"];

diag_log "official killer:";
diag_log _killer;

    _sideKiller = sideUnknown;
    if (alive _killer) then {
        _sideKiller = _killer call _getSide;
    } else {
        _daRealKiller = _deceased getVariable ["ace_medical_lastDamageSource", objNull];

diag_log "ace last damage from:";
diag_log _daRealKiller;

        if (_daRealKiller != objNull) then {
            _killer = _daRealKiller;
            _sideKiller = _killer call _getSide;
        };
    };

    _sideDeceased = _deceased getVariable "Mission_side";

    if (_sideKiller != civilian) then {
        if (_sideDeceased != _sideKiller) then {

            switch (side _killer) do {
                case independent: {[opfor, _deceased] call Mission_fnc_giveUpgradeToSide};
                case east:  {[independent, _deceased] call Mission_fnc_giveUpgradeToSide};
                default { diag_log format ["murder where killer was not indep or east. murderer was %1 / %2", str _killer, name _killer]; };
            };

            if ((_deceased getVariable "Mission_faction") == "OPF_F") then {
                if (Mission_fnc_setupMurderWatch_var_unit_indep_c_radius > 0) then {
                    Mission_fnc_setupMurderWatch_var_unit_indep_c_radius = Mission_fnc_setupMurderWatch_var_unit_indep_c_radius - 50;
                };
                diag_log format ["Setting spotted-trigger %1 => %2 with radius %3 ...", _killer, _deceased];

                [{ [unit_indep_c, Mission_fnc_setupMurderWatch_var_unit_indep_c_radius, opfor] call Mission_fnc_setupMurderWatch_createSpottedMarker; }, [], (random [15, 35, 90])]  call CBA_fnc_waitAndExecute;
            };

            if (_sideDeceased == civilian) then {
                diag_log format ["Unbeteiligtenkill %1 => %2", _killer, _deceased];
                // { ["Der war unbeteiligt. Das macht uns nicht beliebter."] call Mission_fnc_showHint; } remoteExec ["BIS_fnc_call", _killer, true];
            } else {
                diag_log format ["Kill: %1 => %2", _killer, _deceased];
                // { ["Ich habe einen unserer Gegner erwischt. Das ist nicht weiter traurig, aber freundlicher werden die dadurch bestimmt nicht..."] call Mission_fnc_showHint; } remoteExec ["BIS_fnc_call", _killer, true];
                //{ ["Einer unserer Leute wurde ermordet! Dies wird Konsequenzen haben."] call Mission_fnc_showHint; } remoteExec ["BIS_fnc_call", _sideDeceased, true];
            };
        } else {
            diag_log format ["Teamkill %1 => %2", _killer, _deceased];
        };

        [
            [(name _deceased), (getPos _deceased)],
            {
                params ["_name", "_pos"];
                [
                    "marker_death_" + _name,
                    _pos,
                    "ICON", [1, 1], "COLOR:", "ColorBlack", "TYPE:", "kia", "TEXT:", _name
                ] call CBA_fnc_createMarker;
            }
        ] remoteExec ["BIS_fnc_call", _sideDeceased, true];

    };
};


_this addMPEventHandler ["MPKilled", {
    if (isServer) then {
        _this call Mission_fnc_setupMurderWatch_killedHandler;
    };
}];
