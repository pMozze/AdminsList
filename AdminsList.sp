public Plugin myinfo = {
	name = "Admins List",
	author = "Mozze",
	description = "",
	version = "1.0",
	url = "t.me/pMozze"
}

public void OnPluginStart() {
	LoadTranslations("adminslist.phrases");
	RegConsoleCmd("sm_admins", onCommandPerform);
}

public Action onCommandPerform(int Client, int Args) {
	Menu hMenu = CreateMenu(menuHandler);
	hMenu.SetTitle("%t", "Title");
	hMenu.ExitButton = true;

	int Index = 1;

	for (Index = 1; Index < MaxClients; Index++) {
		if (IsClientInGame(Index) && GetUserFlagBits(Index)) {
			char Name[MAX_NAME_LENGTH];
			GetClientName(Index, Name, sizeof(Name));

			hMenu.AddItem(Name, Name);
			Index++;
		}
	}
	
	if (Index == 1) {
		char Buffer[128];
		Format(Buffer, sizeof(Buffer), "%t", "Admins are missing");
		hMenu.AddItem(Buffer, Buffer, ITEMDRAW_DISABLED);
	}

	hMenu.Display(Client, 15);
}

public int menuHandler(Menu hMenu, MenuAction iAction, int Client, int Item) {
	if (iAction == MenuAction_End)
		delete hMenu;
}