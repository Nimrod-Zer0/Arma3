/*
	Author: Nimrod_Z
	
	Description: 
		Simple mission status structure.

		
	
	Parameter(s):
		0: target    (the person player is looking at)
		1: string    (type of function execution)	
	Returns:
		NOTHING

	NOTE:

hintsilent format ["%1",_total];
missionFinished=true;
*/
params
[
	["_target",objNull,[objNull]],
	["_mode","",[""]]
];

switch _mode do {
	//cartel truck destroyed
	case "SMG_cartelTruck_Pass": {
		missionTask_01_Completed_success=true;
	};

	//cartel truck still alive at mission end
	case "SMG_cartelTruck_Fail": {
		missionTask_01_Completed_fail=true;
	};

	//cartel twins are dead
	case "SMG_cartelTwins_Pass": {
		missionTask_02_Completed_success=true;
	};

	//cartel twins are not dead at end of mission
	case "SMG_cartelTwins_Fail": {
		missionTask_02_Completed_fail=true;
	};

	//keep track of captives free'ed
	case "SMG_captives": {
		//get total number of hostages from variable that was set in initserver.sqf - (_captives)
		_total=[missionNamespace,"SMG_captivesFree"] call BIS_fnc_getServerVariable;

		//reduce the captive count by 1 every time this function is called  (_total - 1)
		[missionNamespace,"SMG_captivesFree",(_total - 1)] call BIS_fnc_setServerVariable;

		_target setVariable ["isFree",true,true];

		//play animation of hostage being free'ed  (playmove command has global effect so it can be executed on server)
		_target playmove "Acts_AidlPsitMstpSsurWnonDnon_out";
		
		//execute hostages remaining text for all players
		if (_total > 0) then {[_total] remoteExecCall ["hostageUpdate_Text"]};

		//trigger task succeed when total count is zero and there are no more hostages to free.
		if (_total isEqualTo 0) then {missionTask_03_Completed_success=true};
	};

	case "SMG_endMission": {
		if !(missionTask_02_Completed_success) then {missionTask_02_Completed_fail=true};
		"EveryoneWon" call BIS_fnc_endMissionServer;
	};
};

//if truck is destroyed and hostages are free then show end task to complete the mission.
if (missionTask_01_Completed_success && missionTask_03_Completed_success) then {missionFinished=true};