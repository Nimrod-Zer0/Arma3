enableSaving [ false, false ];

missionFinished=false; 
publicVariable "missionFinished";

missionTask_01_Completed_success=false; 
publicVariable "missionTask_01_Completed_success";

missionTask_02_Completed_success=false; 
publicVariable "missionTask_02_Completed_success";

missionTask_03_Completed_success=false; 
publicVariable "missionTask_03_Completed_success";

missionTask_01_Completed_fail=false; 
publicVariable "missionTask_01_Completed_fail";

missionTask_02_Completed_fail=false; 
publicVariable "missionTask_02_Completed_fail";

missionTask_03_Completed_fail=false; 
publicVariable "missionTask_03_Completed_fail";

//var for task that succeeds after confirmation both twins are dead
cartelTwins_confirmed=false;
[missionNamespace,"SMG_cartelTwins_Dead",1] call BIS_fnc_setServerVariable;

//notification popUp text 
hostageUpdate_Text = {["hostageUpdate",[_this select 0]] call BIS_fnc_showNotification};
publicVariable "hostageUpdate_Text";

_captives=[hostage_1,hostage_2];
[missionNamespace,"SMG_captivesFree",(count _captives)-1] call BIS_fnc_setServerVariable;

// setup the all hostages stuff (hostage animation and "free hostage" action)
{[_x] remoteExec ["SMG_fnc_setupCaptives",2];} forEach _captives;