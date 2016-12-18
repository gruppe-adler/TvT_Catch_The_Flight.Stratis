class Loadouts {
    baseDelay = 2;
    perPlayerDelay = 1;
    handleRadios = 1;
    resetLoadout = 1;

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
                uniform = "rds_uniform_Woodlander1";
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
            };
        };

        class OPF_G_F {
            class AllUnits  {
                uniform = "rds_uniform_Woodlander1";
                addItemsToUniform[] = {
                    LIST_1("ACE_SpraypaintRed"),
                    "SmokeShell"
                };
            };
        };

        class IND_F {
            class AllUnits {
                uniform = "rds_uniform_Woodlander1";
            };
        };

        class IND_G_F {
            class AllUnits  {
                uniform = "rds_uniform_Woodlander1";
                addItemsToUniform[] = {
                    LIST_1("ACE_SpraypaintRed"),
                    "SmokeShell"
                };
            };
        };
    };

    class Type {
        class O_Soldier_F {
            primaryWeapon = "arifle_AKS_F";
            addItemsToVest[] = {
                LIST_6("30Rnd_545x39_Mag_F")
            };
        };
        class O_Soldier_TL_F {
            binoculars = "Binocular";
            primaryWeapon = "arifle_AKS_F";
            addItemsToVest[] = {
                LIST_1("ACE_SpraypaintRed"),
                LIST_2("SmokeShell"),
                LIST_4("30Rnd_545x39_Mag_F")
            };
        };
        class O_Soldier_SL_F {
            binoculars = "Binocular";
            primaryWeapon = "arifle_AKS_F";
            addItemsToVest[] = {
                LIST_1("ACE_SpraypaintRed"),
                LIST_4("30Rnd_545x39_Mag_F"),
                LIST_2("SmokeShell"),
                LIST_2("SmokeShellGreen"),
                LIST_2("SmokeShellRed")
            };
        };
        class O_Officer_F: O_Soldier_SL_F {};
        class O_Soldier_AR_F {
            primaryWeapon = "rhs_weap_pkm";
            addItemsToVest[] = {
                LIST_1("rhs_100Rnd_762x54mmR_green")
            };
        };
        class O_medic_F: O_Soldier_F {
            backpack = "rhs_assault_umbts";
            addItemsToBackpack[] = {
                LIST_10("ACE_fieldDressing"),
                LIST_10("ACE_fieldDressing"),
                LIST_4("ACE_fieldDressing"),
                LIST_5("ACE_epinephrine"),
                LIST_10("ACE_morphine")
            };
        };
        class O_Soldier_AAR_F: O_Soldier_F {
            backpack = "rhs_assault_umbts";
            addItemsToBackpack[] = {
                LIST_3("rhs_100Rnd_762x54mmR_green")
            };
        };
        class O_Soldier_LAT_F: O_Soldier_F {
            secondaryWeapon = "launch_RPG7_F";
            backpack = "rhs_rpg_empty";
            addItemsToBackpack[] = {
                LIST_3("RPG7_F")
            };
        };

        class I_Officer_F {
            handgunWeapon = "rhs_weap_makarov_pm";
            binoculars = "Binocular";
            addItemsToUniform[] = {
                LIST_2("rhs_mag_9x18_8_57N181S")
            };
            headgear = "H_Hat_checker";
        };
    };
};
