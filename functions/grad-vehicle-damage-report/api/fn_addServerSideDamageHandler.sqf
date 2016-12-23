/**
 * register server damage handler.
 * parameters:
 *     _groups .... Array<string>  ...................... for selecting the damage group registered with add-tracking-group-by
 *     _callback .. `function(_damage: number): void` ... gets the damage value
 **/

#define PREFIX grad
#define COMPONENT vehicleDamageReport
#include "\x\cba\addons\main\script_macros_mission.hpp"

_groups = param [0, []];
_callback = param [1, {nil}];


GVAR(serverSideHandlers) pushBack [_groups, _callback];
