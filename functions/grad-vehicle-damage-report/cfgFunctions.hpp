class GRAD_vehicleDamageReport {
    class API {
        file = "functions\grad-vehicle-damage-report\api";
        class addDamageTrackingGroup {};
        class addServerSideDamageHandler {};
        class init {};
        class registerVehicle {};
    };

    class client {
        file = "functions\grad-vehicle-damage-report\client";
        class handleDamage {};
        class petzenLoop {};
    };
    class server {
        file = "functions\grad-vehicle-damage-report\server";
        class serverEventLoop {};
    };
};
