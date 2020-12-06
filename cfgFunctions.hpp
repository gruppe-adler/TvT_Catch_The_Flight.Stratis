class CfgFunctions {
    #include "node_modules\@gruppe-adler\replay\cfgFunctions.hpp"
	#include "node_modules\grad-loadout\cfgFunctions.hpp"
    #include "node_modules\grad-leaveNotes\cfgFunctions.hpp"
    #include "node_modules\grad-makeFire\cfgFunctions.hpp"
    #include "node_modules\grad-passport\cfgFunctions.hpp"
	#include "functions\grad-vehicle-damage-report\cfgFunctions.hpp"
    
	class Config {
		class General {
			class civilianUniforms { file = "config\fn_civilianUniforms.json"; };
		};
	};
	class Mission {
		file = functions;
		class Shit {
            class alert_opfor_katzenwache {};
            class alert_plane_damaged {};
            class alert_indep_at_airport {};
            class alert_indep_at_beach {};
            class createTaskCivKill {};
            class createTaskCivProtect {};
            class createTaskOpfor {};
            class createTaskOpforAvoidArea {};
            class createTaskIndepFlight {};
            class createTaskSurvival {};
            class disableMarkerChannels {};
            class doTheWeather {};
            class getAllegiance {};
            class giveUpgradeToSide {};
            class handleWinConditionFulfilled {};
            class limitOffroadSpeed {};
            class limitSwimmingAbility {};
            class onPlayerKilled {};
            class onPlayerRespawn {};
            class preventOtherSidesFromStealing {};
            class setAllSidesFriendly {};
            class setupACEInteractVehicleRelease {};
            class setupMurderWatch {};
            class setupVehicleTheftWatch {};
            class setupTasks {};
            class showHint {};
            class spawn_boat {};
            class vehicleFlightPlaneDamageHandler {};
            class vehicleTheftHandler {};   
		};
		class Client {
			file = "functions\client";
			class getMyAllegianceCallback {};
            class isSwimming {};
		};
		class Server {
			file = "functions\server";
			class getMyAllegiance {};
            class winConditionTriggered {};
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
