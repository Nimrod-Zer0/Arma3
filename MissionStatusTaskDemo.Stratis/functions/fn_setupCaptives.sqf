/*
	Author: Nimrod_Z
	
	Description: 
		
	
	Parameter(s):
		
			
	Returns:
		NOTHING

	NOTE:

hintsilent format ["%1",_total];
*/

_unit = param [0,objNull];
_unit disableAI "MOVE";
_unit setcaptive true;
_unit allowFleeing 0;
_unit enableFatigue false;
_unit setVariable ["isCaptive",true,true]; 
_unit setVariable ["isFree",false,true];
_unit playMove "Acts_AidlPsitMstpSsurWnonDnon_loop"; 
_unit setVariable ["BIS_noCoreConversations", true, true]; 

[ 
	_unit,																// Object the action is attached to
	"Free hostage",															// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",									// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",									// Progress icon shown on screen
	"!(_target getVariable 'isFree') && _target getVariable 'isCaptive' && alive _target && _this distance _target < 2.5 && cursorObject isEqualTo _target",		// Condition for the action to be shown
	"_caller distance _target < 2.5",												// Condition for the action to progress
	{},																// Code executed when action starts
	{},																// Code executed on every progress tick
	{[_target,"SMG_captives"] remoteExecCall ["SMG_fnc_missionStatus",2]},								// Code executed on completion
	{},																// Code executed on interrupted
	[],																// Arguments passed to the scripts as _this select 3
	5,																// Action duration [s]
	nil,																// Priority
	true,																// Remove on completion
	false																// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,_unit];