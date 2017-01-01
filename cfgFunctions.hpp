class CfgFunctions {
	#include "node_modules\grad-loadout\cfgFunctions.hpp"
    #include "node_modules\grad-leaveNotes\cfgFunctions.hpp"
	#include "functions\grad-vehicle-damage-report\cfgFunctions.hpp"
	class Config {
		class General {
			class civilianUniforms { file = "config\fn_civilianUniforms.json"; };
		};
	};
	class Mission {
		file = functions;
		class Shit {
            class setupActionBackgroundCheck {};
            class alert_opfor_katzenwache {};
            class alert_plane_damaged {};
            class alert_indep_at_airport {};
            class createTaskCivKill {};
            class createTaskCivProtect {};
            class createTaskOpfor {};
            class createTaskOpforAvoidArea {};
            class createTaskIndepFlight {};
            class createTaskSurvival {};
            class disableMarkerChannels {};
            class doTheWeather {};
            class formatIDCard {};
            class getAllegiance {};
            class giveUpgradeToSide {};
            class limitOffroadSpeed {};
            class limitSwimmingAbility {};
            class preventOtherSidesFromStealing {};
            class setAllSidesFriendly {};
            class setupACEInteractVehicleRelease {};
            class setupIDCard {};
            class setupMurderWatch {};
            class setupVehicleTheftWatch {};
            class setupTasks {};
            class showHint {};
            class spawn_boat {};
            class update_task_survive {};
            class vehicleFlightPlaneDamageHandler {};
            class vehicleTheftHandler {};
            class win_indep_elim {};
            class win_indep_escape {};
            class win_opfor_elim {};
		};
		class Client {
			file = "functions\client";
			class getMyAllegianceCallback {};
		};
		class Server {
			file = "functions\server";
			class getMyAllegiance {};
		};
        class MurderWatch {
            file ="functions\murderWatch";
            class createSpottedMarker {};
            class killedHandler {};
            class getRealKiller {};
            class triggerKIAMarker {};
        };
	};
};
