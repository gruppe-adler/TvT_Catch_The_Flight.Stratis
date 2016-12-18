class CfgFunctions {
    #include "node_modules\grad-loadout\cfgFunctions.hpp"

    class Mission {
        class Setup {
            class setAllSidesFriendly { file = "fnc_setAllSidesFriendly.sqf";};
            class limitOffroadSpeed { file = "fnc_limitOffroadSpeed.sqf";};
            class disableMarkerChannels { file = "fnc_disableMarkerChannels.sqf";};
            class preventOtherSidesFromStealing { file = "fnc_preventOtherSidesFromStealing.sqf";};
            class setup_tasks { file = "fnc_setup_tasks.sqf";};
            class setupMurderWatch { file = "fnc_setupMurderWatch.sqf";};
            class limitSwimmingAbility { file = "fnc_limitSwimmingAbility.sqf";};
            class setupIDCard { file = "fnc_setupIDCard.sqf";};
        };
        class Triggers {
            class alert_opfor_katzenwache { file = "fnc_alert_opfor_katzenwache.sqf";};
            class win_opfor_elim { file = "fnc_win_opfor_elim.sqf";};
            class win_indep_elim { file = "fnc_win_indep_elim.sqf";};
            class win_indep_escape { file = "fnc_win_indep_escape.sqf";};
            class update_task_survive { file = "fnc_update_task_survive.sqf";};
            class spawn_boat { file = "fnc_spawn_boat.sqf";};
        };
        class Upgrades {
            class giveUpgradeToSide { file = "fnc_giveUpgradeToSide.sqf";};
        };
        class Misc {
            class showHint { file = "fnc_showHint.sqf";};
        };
    };
};
