class CfgFunctions {
	#include "node_modules\grad-loadout\cfgFunctions.hpp"
	#include "functions\grad-vehicle-damage-report\cfgFunctions.hpp"
	class Config {
		file = config
		class General {
			class civilianUniforms { file = "config\fn_civilianUniforms.json"; };
		};
	};
	class Mission {
		file = functions;
		class Setup {
			class setAllSidesFriendly {};
			class limitOffroadSpeed {};
			class disableMarkerChannels {};
			class preventOtherSidesFromStealing {};
			class setup_tasks {};
			class setupMurderWatch {};
			class limitSwimmingAbility {};
			class setupIDCard {};
		};
		class Triggers {
			class alert_opfor_katzenwache {};
			class win_opfor_elim {};
			class win_indep_elim {};
			class win_indep_escape {};
			class update_task_survive {};
			class spawn_boat {};
		};
		class Upgrades {
			class giveUpgradeToSide {};
		};
		class Misc {
			class showHint {};
		};
	};
};
