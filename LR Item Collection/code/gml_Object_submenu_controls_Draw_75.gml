var _string, _string2;

if (room != rm_Title)
{
    _string = "[fnt_Big][NES_Cyan][fa_left][fa_top]";
    _string += "-CONTROL OPTIONS-[fnt_Logbook]\n";
    _string2 = "[fnt_Big][NES_Cyan][fa_left][fa_top] ";
    _string2 += "[fnt_Logbook]\n\n";
}
else
{
    _string = "[fnt_Big][NES_Cyan][fa_left][fa_top]";
    _string += "-CONTROL OPTIONS-[fnt_Logbook]\n";
    _string2 = "[fnt_Big][NES_Cyan][fa_left][fa_top] ";
    _string2 += "[fnt_Logbook]\n\n";
}

if (pause)
{
    if (!rebinding_active)
    {
        _string += (butt(UnknownEnum.Value_8) + txt(" New Button | "));
        _string += (butt(UnknownEnum.Value_9) + txt(" Save + Exit | "));
        _string += (butt(UnknownEnum.Value_27) + txt(" Restore Defaults\n"));
        
        if (menu_selection == 0)
            _string += cursor_helmet();
        
        _string += (butt(UnknownEnum.Value_2) + " : Left\n");
        
        if (menu_selection == 1)
            _string += cursor_helmet();
        
        _string += (butt(UnknownEnum.Value_3) + " : Right\n");
        
        if (menu_selection == 2)
            _string += cursor_helmet();
        
        _string += (butt(UnknownEnum.Value_0) + " : Up\n");
        
        if (menu_selection == 3)
            _string += cursor_helmet();
        
        _string += (butt(UnknownEnum.Value_1) + " : Down\n");
        
        if (menu_selection == 4)
            _string += cursor_helmet();
        
        _string += (butt(UnknownEnum.Value_14) + " : Jump\n");
        
        if (menu_selection == 5)
            _string += cursor_helmet();
        
        _string += (butt(UnknownEnum.Value_15) + " : Shoot\n");
        
        if (menu_selection == 6)
            _string += cursor_helmet();
        
        _string += (butt(UnknownEnum.Value_16) + " : Missile\n");
        
        if (menu_selection == 7)
            _string += cursor_helmet();
        
        _string += (butt(UnknownEnum.Value_17) + " : Morph Ball\n");
        
        if (menu_selection == 8)
            _string += cursor_helmet();
        
        _string += (butt(UnknownEnum.Value_18) + " : Aim-Lock/Spider Ball\n");
        
        if (menu_selection == 9)
            _string += cursor_helmet();
        
        _string += (butt(UnknownEnum.Value_19) + " : Free-Aim/Boost Ball\n");
        
        if (menu_selection == 10)
            _string += cursor_helmet();
        
        _string += (butt(UnknownEnum.Value_26) + " : Scan Visor\n");
        
        if (menu_selection == 11)
            _string2 += cursor_helmet();
        
        _string2 += (butt(UnknownEnum.Value_25) + " : Grapple Beam\n");
        
        if (menu_selection == 12)
            _string2 += cursor_helmet();
        
        _string2 += (butt(UnknownEnum.Value_20) + " : Beam (Up)/Aim Up\n");
        
        if (menu_selection == 13)
            _string2 += cursor_helmet();
        
        _string2 += (butt(UnknownEnum.Value_21) + " : Beam (Right)/Aim Right\n");
        
        if (menu_selection == 14)
            _string2 += cursor_helmet();
        
        _string2 += (butt(UnknownEnum.Value_22) + " : Beam (Down)/Aim Down\n");
        
        if (menu_selection == 15)
            _string2 += cursor_helmet();
        
        _string2 += (butt(UnknownEnum.Value_23) + " : Beam (Left)/Aim Left\n");
        
        if (menu_selection == 16)
            _string2 += cursor_helmet();
        
        _string2 += (butt(UnknownEnum.Value_27) + " : Menu\n");
        
        if (menu_selection == 17)
            _string2 += cursor_helmet();
        
        _string2 += (butt(UnknownEnum.Value_8) + " : Confirm (Menu)\n");
        
        if (menu_selection == 18)
            _string2 += cursor_helmet();
        
        _string2 += (butt(UnknownEnum.Value_9) + " : Cancel (Menu)\n");
        
        if (menu_selection == 19)
            _string2 += cursor_helmet();
        
        _string2 += (butt(UnknownEnum.Value_10) + " : Scroll Left (Menu)\n");
        
        if (menu_selection == 20)
            _string2 += cursor_helmet();
        
        _string2 += (butt(UnknownEnum.Value_11) + " : Scroll Right (Menu)\n");
        
        if (menu_selection == 21)
            _string2 += cursor_helmet();
        
        _string2 += (butt(UnknownEnum.Value_28) + " : Map\n");
        
        if (menu_selection == 22)
            _string2 += cursor_helmet();
        
        _string2 += (butt(UnknownEnum.Value_24) + " : Toggle Beams\n");
        // ----- LRedit : Display extra buttons -----
        if (menu_selection == 23)
            _string2 += cursor_helmet();
        
        _string2 += (butt(UnknownEnum.Value_29) + " : Dash\n");
        // ------------------------------------------
    }
    else
    {
        _string2 = "";
        _string += "Press a new button for -";
        
        if (menu_selection == 0)
            _string += "Left";
        
        if (menu_selection == 1)
            _string += "Right";
        
        if (menu_selection == 2)
            _string += "Up";
        
        if (menu_selection == 3)
            _string += "Down";
        
        if (menu_selection == 4)
            _string += "Jump";
        
        if (menu_selection == 5)
            _string += "Shoot";
        
        if (menu_selection == 6)
            _string += "Missile";
        
        if (menu_selection == 7)
            _string += "Morph Ball";
        
        if (menu_selection == 8)
            _string += "Aim-Lock";
        
        if (menu_selection == 9)
            _string += "Free-Aim";
        
        if (menu_selection == 11)
            _string += "Grapple Beam";
        
        if (menu_selection == 10)
            _string += "Scan Visor";
        
        if (menu_selection == 12)
            _string += "Beam (Up)/Aim Up";
        
        if (menu_selection == 13)
            _string += "Beam (Right)/Aim Right";
        
        if (menu_selection == 14)
            _string += "Beam (Down)/Aim Down";
        
        if (menu_selection == 15)
            _string += "Beam (Left)/Aim Left";
        
        if (menu_selection == 16)
            _string += "Menu";
        
        if (menu_selection == 17)
            _string += "Confirm";
        
        if (menu_selection == 18)
            _string += "Cancel";
        
        if (menu_selection == 19)
            _string += "Scroll Left";
        
        if (menu_selection == 20)
            _string += "Scroll Right";
        
        if (menu_selection == 21)
            _string += "Map";
        
        if (menu_selection == 22)
            _string += "Toggle Beams";
        
        // ----- LRedit : Display extra buttons -----
        if (menu_selection == 23)
            _string2 += "Dash";
        // ------------------------------------------
        
        _string += "\n(Menu cancels)";
    }
}

scribble(_string).draw(4, (8 - menu_offset) + 12);
scribble(_string2).draw((global._screen_width / 2) - 4, (8 - menu_offset) + 12);

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_8 = 8,
    Value_9,
    Value_10,
    Value_11,
    Value_14 = 14,
    Value_15,
    Value_16,
    Value_17,
    Value_18,
    Value_19,
    Value_20,
    Value_21,
    Value_22,
    Value_23,
    Value_24,
    Value_25,
    Value_26,
    Value_27,
    Value_28,
    Value_29 // ---- LRedit : enum increase -----
}
