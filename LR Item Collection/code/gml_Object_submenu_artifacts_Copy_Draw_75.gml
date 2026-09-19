top_string = "[fnt_Big][NES_Peach][fa_left][fa_bottom]";
name_string = "[fnt_Big][NES_Peach][fa_left][fa_bottom]";
list_string = "[fnt_Logbook][c_white][fa_left][fa_top]";
description_string = "[fnt_Logbook][NES_Peach][fa_left][fa_bottom]";
remaining_string = "[fnt_Logbook][NES_Peach][fa_left][fa_top]";
control_string_0 = "[fnt_Logbook][NES_Peach][fa_center][fa_bottom]";
control_string_1 = "[fnt_Logbook][NES_Peach][fa_center][fa_bottom]";
top_string += txt("- Custom Items -");
var t_thisItem = item_list[selection];
if t_thisItem != "g"
{
    if dz(t_thisItem) == 0
    {
        name_string += txt("???");
        description_string += txt("Yet to discover.");
    }
    else
    {
        name_string += txt(LRscr_helper_filterName(item_list[selection]));
        description_string += txt(item_descriptions(t_thisItem));
    }
}
pos = 0;

repeat (item_quantity)
{
    var t_itemIndex = item_list[pos];
    if (selection == pos)
        list_string += "[blink][spr_cursor_right_1]";
    else
        list_string += "[spr_cursor_down_4]";
    
    if (dz(t_itemIndex) == 1)
        list_string += "[spr_checkbox_1]";
    else
        list_string += "[spr_checkbox_2]";
    
    if t_itemIndex != "g"
    {
        if dz(t_itemIndex) == 0
            list_string += txt("???");
        else
            list_string += txt(LRscr_helper_filterName(t_itemIndex));
    }
    list_string += "\n[/blink]";
    pos++;
}

control_string_0 += (butt("accept") + "\n");
control_string_0 += txt("Toggle");
control_string_1 += (butt("menu") + "\n");
control_string_1 += txt("Exit");


if (shaky)
    off_x = -5 + irandom(10);
else
    off_x = 0;

if (selection >= 0)
    off_y = 0;

var t_scroll = (floor(selection / 12));
off_y = t_scroll * 132;

draw_text_scribble(off_x + 3, 49 - menu_offset - off_y, list_string);
draw_rectangle_colour(0, 0, global._screen_width, global._screen_height / 5, c_black, c_black, c_black, c_black, 0);
draw_rectangle_colour(0, ((global._screen_height * 4) / 5) - 6, global._screen_width, global._screen_height, c_black, c_black, c_black, c_black, 0);
draw_text_scribble(7, 36 - menu_offset, "[sprMenuArtifacts,0]" + top_string);
draw_text_scribble(off_x + 12, 29 - menu_offset, " ");
draw_text_scribble_ext(128, global._screen_height - 60 - menu_offset, name_string + "\n" + description_string, global._screen_width - 119 - 20);
draw_text_scribble((global._screen_width / 2) - 32, (global._screen_height - 5) + menu_offset, control_string_0);
draw_text_scribble((global._screen_width / 2) + 32, (global._screen_height - 5) + menu_offset, control_string_1);
