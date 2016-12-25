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
		class Shit {
			class alert_opfor_katzenwache {};
			class createTasks {};
			class disableMarkerChannels {};
			class giveUpgradeToSide {};
			class limitOffroadSpeed {};
			class limitSwimmingAbility {};
			class preventOtherSidesFromStealing {};
			class setAllSidesFriendly {};
			class setupIDCard {};
			class setupMurderWatch {};
			class setup_tasks {};
			class showHint {};
			class spawn_boat {};
			class update_task_survive {};
			class win_indep_elim {};
			class win_indep_escape {};
			class win_opfor_elim {};
		};
		class Client {
			file = "functions\client"
			class getMyAllegianceCallback {};
		};
		class Server {
			file = "functions\server";
			class getMyAllegiance {};
		};
	};
};
