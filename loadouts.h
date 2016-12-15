class Loadouts {
    baseDelay = 2;
    perPlayerDelay = 1;
    handleRadios = 1;
    resetLoadout = 1;

    class AllUnits {
        addItemsToUniform[] = {
            "ACE_Flashlight_KSF1",
            LIST_5("ACE_fieldDressing")
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
                addItemsToVest[] = {
                    LIST_2("SmokeShell"),
                    LIST_2("Chemlight_green")
                };
            };
        };

        class OPF_G_F: CIV_F {
            class AllUnits: AllUnits {};
        };

        class IND_F: CIV_F {
            class AllUnits: AllUnits {};
        };
    };

    class Type {
        class O_Soldier_F {
            primaryWeapon = "arifle_AKS_F";
            primaryWeaponAttachments[] = {"acc_flashlight"};
            addItemsToVest[] = {
                LIST_5("30Rnd_545x39_Mag_F")
            };
        };
        class O_Soldier_TL: O_Soldier_F {
            binoculars = "Binocular";
            addItemsToVest[] = {
                LIST_5("UGL_FlareGreen_F")
            };
        };
        class O_Soldier_SL: O_Soldier_TL {
        };
        class O_Officer_F: O_Soldier_SL {
        };
        class O_Soldier_AR_F {
            primaryWeapon = "rhs_weap_pkm";
            addItemsToVest[] = {
                "rhs_100Rnd_762x54mmR_green"
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
                LIST_2("Chemlight_green"),
                LIST_2("rhs_mag_9x18_8_57N181S")
            };
            headgear = "H_Hat_checker";
        };

        class I_Survivor_F {
            addItemsToUniform[] = {
                "Chemlight_green"
            };
        };
    };
};
