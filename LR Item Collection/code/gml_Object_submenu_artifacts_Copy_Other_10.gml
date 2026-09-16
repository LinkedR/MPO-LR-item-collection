arr = dz("Aeon");
arr_status = dz("Aeon Status");
top_string = "[fnt_Big][NES_Peach][fa_left][fa_bottom]";
name_string = "[fnt_Big][NES_Peach][fa_left][fa_bottom]";
list_string = "[fnt_Logbook][c_white][fa_left][fa_top]";
description_string = "[fnt_Logbook][NES_Peach][fa_left][fa_bottom]";
remaining_string = "[fnt_Logbook][NES_Peach][fa_left][fa_top]";
control_string_0 = "[fnt_Logbook][NES_Peach][fa_center][fa_bottom]";
control_string_1 = "[fnt_Logbook][NES_Peach][fa_center][fa_bottom]";
top_string += txt("- Aeon Powers -");
name_string += txt(arr[selection]);
pos = 0;

repeat (array_length(arr))
{
    if (selection == pos)
        list_string += "[blink][spr_cursor_right_1]";
    else
        list_string += "[spr_cursor_down_4]";
    
    if (arr_status[pos] == 0)
        list_string += "[spr_checkbox_0]";
    else
        list_string += "[spr_checkbox_1]";
    
    list_string += txt(arr[pos]);
    list_string += "\n[/blink]";
    pos += 1;
}

description_string += txt(aeon_descriptions(arr[selection]));
remaining_string += (txt("Active Powers") + ": ");
remaining_string += (string(aeon) + "/" + string(aeon_max));
control_string_0 += (butt("accept") + "\n");
control_string_0 += txt("Toggle");
control_string_1 += (butt("menu") + "\n");
control_string_1 += txt("Exit");
