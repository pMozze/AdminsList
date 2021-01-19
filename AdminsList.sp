public Plugin myinfo = {
	name = "Admins List",
	author = "Mozze",
	description = "",
	version = "1.1",
	url = "t.me/pMozze"
}

Menu g_hMenu;

public void OnPluginStart() {
	LoadTranslations("adminslist.phrases");

	g_hMenu = new Menu(adminsMenuHandler);
	g_hMenu.SetTitle("%t", "Title");

	RegConsoleCmd("sm_admins", adminsCommand);
}

public void OnPluginEnd() {
	delete g_hMenu;
}

public Action adminsCommand(int iClient, int iArgs) {
	char szBuffer[MAX_NAME_LENGTH];
	int iAdmins;

	g_hMenu.RemoveAllItems();

	for (int iClientIndex = 1; iClientIndex <= MaxClients; iClientIndex++) {
		if (IsClientInGame(iClientIndex) && GetUserFlagBits(iClientIndex)) {
			GetClientName(iClientIndex, szBuffer, sizeof(szBuffer));
			g_hMenu.AddItem("", szBuffer);
			iAdmins++;
		}
	}
	
	if (iAdmins == 0) {
		Format(szBuffer, sizeof(szBuffer), "%t", "Admins are missing");
		g_hMenu.AddItem(szBuffer, szBuffer, ITEMDRAW_DISABLED);
	}

	g_hMenu.Display(iClient, 15);
}

public int adminsMenuHandler(Menu hMenu, MenuAction iAction, int iClient, int iItem) {
	return 0;
}
