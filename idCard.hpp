class IDCard
{
    idd = -1;
    duration = 30; //1 min
    fadeOut = 5;
    onLoad = "_this call onIDCardLoad;  onIDCardLoadEventHandler = (findDisplay 46) displayAddEventHandler [""KeyDown"", ""cutText ["""""""", """"PLAIN""""];""];";
    onUnload = "(findDisplay 46) displayRemoveEventHandler [""KeyDown"",  onIDCardLoadEventHandler];";
    class controls
    {
        class TheTitle
        {
            idc = 1; //control reference
            type = 0;
            style = ST_CENTER;
            x = 0;
            y = 0;
            w = 1;
            h = 0.2;
            font = "EtelkaMonospacePro";
            sizeEx = 0.1;
            colorBackground[] = {0.9, 0.9, 0.9, 0.9};
            colorText[] = {0.1, 0.1, 0.1,1};
            text = "Občanský průkaz";
        };
        class UnitNameLabel
        {
            idc = 10; //control reference
            type = 0;
            style = ST_LEFT;
            x = 0;
            y = 0.2;
            w = 0.5;
            h = 0.1;
            font = "EtelkaMonospacePro";
            sizeEx = 0.1;
            colorBackground[] = {0.9, 0.9, 0.9, 0.9};
            colorText[] = {0.1, 0.1, 0.1,1};
            text = "JMÉNO/PŘÍJMENÍ :";
        };
        class UnitNameValue
        {
            idc = 11; //control reference
            type = 0;
            style = ST_LEFT;
            x = 0.5;
            y = 0.2;
            w = 0.5;
            h = 0.1;
            font = "EtelkaMonospacePro";
            sizeEx = 0.1;
            colorBackground[] = {0.9, 0.9, 0.9, 0.9};
            colorText[] = {0.1, 0.1, 0.1,1};
            text = "<INSERT NAME HERE>";
        };

    };
};
