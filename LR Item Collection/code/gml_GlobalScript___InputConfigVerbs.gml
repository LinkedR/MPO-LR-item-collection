function __InputConfigVerbs()
{
    InputDefineVerb(UnknownEnum.Value_0, "up", [38, "W"], [-32786, 32781]);
    InputDefineVerb(UnknownEnum.Value_1, "down", [40, "S"], [32786, 32782]);
    InputDefineVerb(UnknownEnum.Value_2, "left", [37, "A"], [-32785, 32783]);
    InputDefineVerb(UnknownEnum.Value_3, "right", [39, "D"], [32785, 32784]);
    InputDefineVerb(UnknownEnum.Value_4, "d_up", "0", 32781);
    InputDefineVerb(UnknownEnum.Value_5, "d_down", "0", 32782);
    InputDefineVerb(UnknownEnum.Value_6, "d_left", "0", 32783);
    InputDefineVerb(UnknownEnum.Value_7, "d_right", "0", 32784);
    InputDefineVerb(UnknownEnum.Value_8, "accept", [13, 32], 32769);
    InputDefineVerb(UnknownEnum.Value_9, "cancel", 8, 32770);
    InputDefineVerb(UnknownEnum.Value_10, "option_l", "Q", 32773);
    InputDefineVerb(UnknownEnum.Value_11, "option_r", "E", 32774);
    InputDefineVerb(UnknownEnum.Value_12, "option_x", "Z", 32771);
    InputDefineVerb(UnknownEnum.Value_13, "option_y", "X", 32772);
    InputDefineVerb(UnknownEnum.Value_14, "jump", 32, 32769);
    InputDefineVerb(UnknownEnum.Value_15, "shoot", 1, 32771);
    InputDefineVerb(UnknownEnum.Value_16, "missile", 2, 32772);
    InputDefineVerb(UnknownEnum.Value_17, "ball", 17, 32770);
    InputDefineVerb(UnknownEnum.Value_18, "aimlock", 16, 32774);
    InputDefineVerb(UnknownEnum.Value_19, "freeaim", 18, 32773);
    InputDefineVerb(UnknownEnum.Value_20, "beam_0", "1", -32788);
    InputDefineVerb(UnknownEnum.Value_21, "beam_1", "2", 32787);
    InputDefineVerb(UnknownEnum.Value_22, "beam_2", "3", 32788);
    InputDefineVerb(UnknownEnum.Value_23, "beam_3", "4", -32787);
    InputDefineVerb(UnknownEnum.Value_24, "beam", "Q", 32780);
    InputDefineVerb(UnknownEnum.Value_25, "grapple", "F", 32776);
    InputDefineVerb(UnknownEnum.Value_26, "scan", 3, 32775);
    InputDefineVerb(UnknownEnum.Value_27, "menu", 27, 32778);
    InputDefineVerb(UnknownEnum.Value_28, "map", 9, 32777);
    // ----- LRedit : extra button -----
    InputDefineVerb(UnknownEnum.Value_29, "dash", "G", gp_stickl);
    // ---------------------------------
    InputDefineVerb(UnknownEnum.Value_30, "fullscreen", 115, undefined);
    InputDefineCluster(UnknownEnum.Value_0, UnknownEnum.Value_20, UnknownEnum.Value_21, UnknownEnum.Value_22, UnknownEnum.Value_23, 0.23809523809523808, true);
    InputDefineCluster(UnknownEnum.Value_1, UnknownEnum.Value_22, UnknownEnum.Value_23, UnknownEnum.Value_20, UnknownEnum.Value_21, 0.23809523809523808, true);
    InputDefineCluster(UnknownEnum.Value_2, UnknownEnum.Value_0, UnknownEnum.Value_3, UnknownEnum.Value_1, UnknownEnum.Value_2, 0.23809523809523808, true);
    InputDefineCluster(UnknownEnum.Value_3, UnknownEnum.Value_1, UnknownEnum.Value_2, UnknownEnum.Value_0, UnknownEnum.Value_3, 0.23809523809523808, true);
    InputDefineCluster(UnknownEnum.Value_4, UnknownEnum.Value_0, UnknownEnum.Value_3, UnknownEnum.Value_1, UnknownEnum.Value_2, 0, true);
    InputDefineCluster(UnknownEnum.Value_5, UnknownEnum.Value_4, UnknownEnum.Value_7, UnknownEnum.Value_5, UnknownEnum.Value_6, 0, false);
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
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
    Value_29,
    Value_30 // ----- LRedit : extra input -----
}
