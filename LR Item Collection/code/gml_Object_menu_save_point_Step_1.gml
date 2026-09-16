text = "[fa_center][fa_middle][fnt_Logbook][NES_Gray]\n";

if (selection == 0)
    text += "[c_white]";

if (!can_teleport)
    text += "[NES_Red]";

text += (txt("Teleportation System") + "[NES_Gray]\n");

if (selection == 1)
    text += "[c_white]";

if (!can_artifact)
    text += "[NES_Red]";

text += (txt("Toggle Aeon Abilities") + "[NES_Gray]\n");

// ----- LRedit : item toggle menu, also shifted return to game -----
if (selection == 2)
    text += "[c_white]";

text += (txt("Toggle Custom Items") + "[NES_Gray]\n");
// -------------------------------------------------------------------

if (selection == 3)
    text += "[c_white]";

text += (txt("Return to Game") + "[NES_Gray]\n");
