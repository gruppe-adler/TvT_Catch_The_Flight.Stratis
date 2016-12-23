/**
 *
 * Add a groupBy to the damage tracking.
 * That is, the answer to the question "how should we differentiate the damage?"
 *
 * parameters:
 *      _groupBy ... function(_selectionName: string, _source: Object, _projectile: string, _instigator: Object): Array<string>
 *                   return arbitrary number of group-by terms
 *
 */

 #define PREFIX grad
 #define COMPONENT vehicleDamageReport
 #include "\x\cba\addons\main\script_macros_mission.hpp"

_groupBy = param [0, {[]}];

GVAR(groupBy) pushBack _groupBy;
