#include "script_component.hpp"

params ["_oldUnit", "_killer", "_respawn", "_respawnDelay"];

INFO_4("player %1 has been killed by %2, so survival task fails. respawn is %3, delay %4", _oldUnit, _killer, _respawn, _respawnDelay);

task_survive setTaskState "FAILED";
