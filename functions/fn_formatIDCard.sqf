private _name = param [0, ""];
private _allegiances = param [0, []]; // optional HASH: {independent: {independent: -1|0|1, opfor: -1|0|1, isPublic: Boolean}, opfor: {independent: -1|0|1, opfor: -1|0|1, isPublic: Boolean}}




// _allegiances = [] call CBA_fnc_hashCreate;
//[_allegiances, independent,
_name = "Jason Miles";
private _allegianceText = "<t align='left'>
......| IND| OPF| public <br />
---------------<br />
INDEP | :) | :| | yes <br />
OPFOR | :| | :( |  no<br />
</t><br />

";

hint parseText format ["
<t font='EtelkaMonospacePro'>
<t underline='true'>Občanský průkaz</t><br />
Příjmení: %1 <br/>
<br />
------------ <br />
%2
    </t>",
    _name,
    _allegianceText
];
