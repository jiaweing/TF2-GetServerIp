#include <steamtools>

public void OnPluginStart() {
	RegConsoleCmd("sm_getip", Command_GetIP);
}

public Action Command_GetIP(int iClient, int iArgs) {
	ReplyToCommand(iClient, "Server IP: %s", GetServerIp());
}

stock char[] GetServerIp()
{
	char
		sOutput[128];
	int
		iHostIP;
		
	// iHostIP = GetConVarInt(FindConVar("hostip"));
	
	int sOctets[4];
	Steam_GetPublicIP(sOctets);
	
	iHostIP = 
		sOctets[0] << 24	|
		sOctets[1] << 16	|
		sOctets[2] << 8	|
		sOctets[3];
		
	char sHostPort[16];
	GetConVarString(FindConVar("hostport"), sHostPort, sizeof(sHostPort));
	
	Format(sOutput, sizeof(sOutput), "%d.%d.%d.%d:%s",
		(iHostIP >> 24 & 0xFF),
		(iHostIP >> 16 & 0xFF),
		(iHostIP >> 8 & 0xFF),
		(iHostIP & 0xFF),
		sHostPort
	);
	
	return sOutput;
}