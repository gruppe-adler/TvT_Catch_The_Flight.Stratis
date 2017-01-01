[] spawn {
    0 setFog [0.7, 0.1, 10]; // initial fog. wait a bit, then transition to zero_fog

    [
    {
        10 setFog [0.0, 0.0, 0];
    },
    [],
    5
    ] call CBA_fnc_waitAndExecute;
};
