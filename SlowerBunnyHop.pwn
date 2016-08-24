#include <a_samp>

forward KillTimerSprung();
forward FunktionInSprung(playerid);
forward FunktionSprungVerlangsamen(playerid);

#define PRESSING(%0,%1) (%0 & (%1)) (%0 & (%1))
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define HOLDING(%0) ((newkeys & (%0)) == (%0))
#define RELEASED(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

new InSprung[MAX_PLAYERS] = 0;
new Float:VektorBlickrichtung[4];
new TimerIDSprung;

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_JUMP) && IsPlayerInAnyVehicle(playerid) == 0 && InSprung[playerid] == 0)
	{
		InSprung[playerid] = 1;
		new Float:FacingAngle;
		GetPlayerFacingAngle(playerid,FacingAngle);
		VektorBlickrichtung[1] = floatsin(180+FacingAngle,degrees);
		VektorBlickrichtung[2] = floatcos(FacingAngle,degrees);
		VektorBlickrichtung[3] = 0;
		TimerIDSprung = SetTimerEx("FunktionSprungVerlangsamen",10,true,"i",playerid);
		SetTimer("KillTimerSprung",200,false);
		SetTimerEx("FunktionInSprung",1000,false,"i",playerid);
	}
	return 1;
}

public FunktionSprungVerlangsamen(playerid)
{
	SetPlayerVelocity(playerid,0.1*VektorBlickrichtung[1],0.1*VektorBlickrichtung[2],0.03);
	return 1;
}

public KillTimerSprung()
{
	KillTimer(TimerIDSprung);
	return 1;
}

public FunktionInSprung(playerid)
{
	InSprung[playerid] = 0;
	return 1;
}
