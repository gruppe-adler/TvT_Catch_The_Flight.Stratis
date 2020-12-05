class Loadouts {
	baseDelay = 2;
	perPlayerDelay = 1;
	handleRadios = 1;
	resetLoadout = 1;
	customGear = 120;
	customGearAllowedCategories[] = {
		"uniform",
		"headgear",
		"goggles"
    };

	class AllUnits {
		addItemsToUniform[] = {
			"ACE_Flashlight_KSF1",
			LIST_6("ACE_fieldDressing")
		};
		map = "ItemMap";
		compass = "ItemCompass";
		watch = "ItemWatch";
		radio = "";
	};

	class Faction {

		class CIV_F {
			class AllUnits {
				uniform[] = {
					"rds_uniform_Woodlander1", "rds_uniform_Woodlander2", "rds_uniform_Woodlander3", "rds_uniform_Woodlander4",
					"rds_uniform_Worker1", "rds_uniform_Worker2", "rds_uniform_Worker3", "rds_uniform_Worker4"

				};
				headgear[] = {
					"rds_worker_cap1", "rds_worker_cap2", "rds_worker_cap3", "rds_worker_cap4",
					"rds_villager_cap1", "rds_villager_cap2", "rds_villager_cap3", "rds_villager_cap4"
					
				};
				addItemsToUniform[] = {
					LIST_1("ACE_SpraypaintRed"),
					"SmokeShell"
				};
				goggles[] = {
					"rds_long_hair_01", "rds_long_hair_02", "rds_long_hair_03",
					"tryk_beard", "tryk_beard2", "tryk_beard3", "tryk_beard4", 
					"tryk_beard_bw", "tryk_beard_bw2", "tryk_beard_bw3", "tryk_beard_bw4", 
					"tryk_beard_bk", "tryk_beard_bk2", "tryk_beard_bk3", "tryk_beard_bk4", 
					"tryk_beard_gr", "tryk_beard_gr2", "tryk_beard_gr3", "tryk_beard_gr4"
				};
			};
		};

		class OPF_F {
			class AllUnits {
				uniform = "rhsgref_uniform_ttsko_mountain";
				vest = "rhsgref_6b23_ttsko_mountain_rifleman";
				headgear = "rhsgref_ssh68_ttsko_mountain";
				radio = "tf_fadak";
				addItemsToUniform[] = {
					LIST_1("ACE_epinephrine"),
					LIST_1("ACE_morphine")
				};
				goggles[] = {
					"gm_headgear_foliage_summer_forest_01", "gm_headgear_foliage_summer_forest_02", "gm_headgear_foliage_summer_forest_03", "gm_headgear_foliage_summer_forest_04",
					"gm_headgear_foliage_summer_grass_01", "gm_headgear_foliage_summer_grass_02", "gm_headgear_foliage_summer_grass_03", "gm_headgear_foliage_summer_grass_04",
					"g_balaclava_blk", "g_balaclava_oli",
					"g_bandanna_khk", "g_bandanna_oli", "g_bandanna_tan"
				};
			};
			class Type {
				class Soldier_F {
					primaryWeapon = "arifle_AKS_F";
					addItemsToVest[] = {
						LIST_6("30Rnd_545x39_Mag_F")
					};

				};
				class Soldier_TL_F {
					binoculars = "Binocular";
					primaryWeapon = "arifle_AKS_F";
					addItemsToVest[] = {
						LIST_1("ACE_SpraypaintRed"),
						LIST_2("SmokeShell"),
						LIST_4("30Rnd_545x39_Mag_F")
					};
				};
				class Soldier_SL_F {
					binoculars = "Binocular";
					vest = "rhsgref_6b23_ttsko_mountain_nco";
					primaryWeapon = "arifle_AKS_F";
					addItemsToVest[] = {
						LIST_1("ACE_SpraypaintRed"),
						LIST_4("30Rnd_545x39_Mag_F"),
						LIST_2("SmokeShell"),
						LIST_2("SmokeShellGreen"),
						LIST_2("SmokeShellRed")
					};
				};
				class Officer_F: Soldier_SL_F {
					vest = "rhsgref_6b23_ttsko_mountain_officer";
					headgear = "rhsgref_fieldcap_ttsko_mountain";
					goggles[] = {
						"g_balaclava_blk", "g_balaclava_oli",
						"g_bandanna_khk", "g_bandanna_oli", "g_bandanna_tan"				
					};
					handgunWeapon = "rhs_weap_makarov_pm";
					addItemsToUniform[] = {
						LIST_3("rhs_mag_9x18_8_57N181S")
					};
				};
				class Soldier_AR_F {
					primaryWeapon = "rhs_weap_pkm";
					addItemsToVest[] = {
						LIST_1("rhs_100Rnd_762x54mmR_green")
					};
				};
				class Medic_F: Soldier_F {
					backpack = "rhs_assault_umbts";
					vest = "rhsgref_6b23_ttsko_mountain_medic";
					addItemsToBackpack[] = {
						LIST_10("ACE_fieldDressing"),
						LIST_10("ACE_fieldDressing"),
						LIST_4("ACE_fieldDressing"),
						LIST_5("ACE_epinephrine"),
						LIST_10("ACE_morphine")
					};
				};
				class Soldier_A_F: Soldier_F {
					backpack = "rhs_assault_umbts";
					addItemsToBackpack[] = {
						LIST_3("rhs_100Rnd_762x54mmR_green")
					};
				};
				class Soldier_AT_F: Soldier_F {
					secondaryWeapon = "launch_RPG7_F";
					backpack = "rhs_rpg_empty";
					addItemsToBackpack[] = {
						LIST_3("RPG7_F")
					};
				};
			};
		};
	};

	class Type {
		class I_Officer_F {
			uniform[] = {
				"rds_uniform_Functionary1", "rds_uniform_Functionary2", 
				"rds_uniform_Profiteer1", "rds_uniform_Profiteer2", "rds_uniform_Profiteer3", "rds_uniform_Profiteer4"
			};
			handgunWeapon = "rhs_weap_makarov_pm";
			binoculars = "Binocular";
			addItemsToUniform[] = {
				LIST_2("rhs_mag_9x18_8_57N181S")
			};
			headgear[] = {
				"H_Hat_checker",
				"h_hat_tinfoil_f",
				"rds_profiteer_cap1", "rds_profiteer_cap2", "rds_profiteer_cap3", "rds_profiteer_cap4", 
				"h_strawhat", "h_strawhat_dark"
			};
			goggles[] = {
				"g_shades_black", "g_shades_blue", "g_shades_green", "g_shades_red", 
				"g_aviator",
				"g_spectacles", "g_spectacles_tinted",
				"G_squares", "g_squares_tinted"
			};
		};
	};
};
