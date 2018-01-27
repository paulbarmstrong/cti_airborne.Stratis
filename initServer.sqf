// Function Definitions:
//=========================================

FNC_EntityKilled = compileFinal preprocessFile "Server\EntityKilled.sqf";
FNC_AIRespawn = compileFinal preprocessFile "Server\AIRespawn.sqf";
FNC_ServerLoop = compileFinal preprocessFile "Server\ServerLoop.sqf";
FNC_PayIncome = compileFinal preprocessFile "Server\PayIncome.sqf";
FNC_CalculateIncome = compileFinal preprocessFile "Server\CalculateIncome.sqf";
FNC_TrackOnMap = compileFinal preprocessFile "Server\TrackOnMap.sqf";
FNC_InitializeVars = compileFinal preprocessFile "Server\InitializeVars.sqf";
FNC_SetUpTowns = compileFinal preprocessFile "Server\SetUpTowns.sqf";
FNC_DetectTownLoss = compileFinal preprocessFile "Server\DetectTownLoss.sqf";
FNC_ManEnteredTurret = compileFinal preprocessFile "Server\ManEnteredTurret.sqf";

// Quickly Initialize some global variables:
[] call FNC_InitializeVars;

// Initialize town stuff
//=========================================

[] spawn FNC_SetUpTowns;

// Initialize playable AI stuff
//=========================================

{	
	// Create markers for all playable units
	_side = side _x;
	_groupID = groupID (group _x);
	_newMarkerName = format["%1_%2_marker",_side,_groupID];
	_newMarker = createMarker[_newMarkerName,position _x];
	_newMarker setMarkerType "mil_dot";
	if (isPlayer _x) then {
		_newMarker setMarkerText (name player);
	} else {
		_newMarker setMarkerText _groupID;
	};
	if (_side == west) then { _newMarker setMarkerColor "colorBLUFOR"; } else { _newMarker setMarkerColor "colorOPFOR"; };
	//_newMarker setMarkerColor "colorUNKNOWN";
} forEach playableUnits;


// Initialize income/economy stuff
//=========================================

BluforIncome = 0;
OpforIncome = 0;

// Create the trucks
//=========================================

// Run scripts
//=========================================

[] spawn FNC_ServerLoop;
[] spawn FNC_PayIncome;

{
	if (!(isPlayer _x)) then
	{
		_x call FNC_AIRespawn;
	};
} forEach playableUnits;



// Plans
//=========================================

// Infantry Transport Truck spawns at bases and drives to nearest town to drop off guys






