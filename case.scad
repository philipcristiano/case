
WIDTH = 100;
HEIGHT = 50;
LENGTH = 100;
THICKNESS = 3.175;

TAB_LENGTH = 6 * THICKNESS;

module TabbedPanel(length, width, height, tab_x_filled=true, tab_y_filled=true)
{

    difference() {
        cube(size = [length, width, height]);
        tab_x_multiplier = tab_x_filled ? 1: -1;
        tab_y_multiplier = tab_y_filled ? 1: -1;
        x_center_offset = length/2 % TAB_LENGTH + .5 * TAB_LENGTH * tab_x_multiplier ;
        y_center_offset = width/2 % TAB_LENGTH + .5 * TAB_LENGTH * tab_y_multiplier;

        for ( i = [0 - (4*TAB_LENGTH): TAB_LENGTH * 2: LENGTH + WIDTH])
        {
            translate([i + x_center_offset, 0, 0]) cube([TAB_LENGTH , THICKNESS, THICKNESS]);
            translate([i + x_center_offset, width - THICKNESS, 0]) cube([TAB_LENGTH , THICKNESS, THICKNESS]);
        }
        for ( i = [0 - (4*TAB_LENGTH): TAB_LENGTH * 2: LENGTH + WIDTH] )
        {
            translate([0, i + y_center_offset, 0]) cube([THICKNESS , TAB_LENGTH, THICKNESS]);
            translate([length - THICKNESS, i + y_center_offset, 0]) cube([THICKNESS , TAB_LENGTH, THICKNESS]);
        }
    }
}

module Case()
{
    // Bottom
    TabbedPanel(LENGTH, WIDTH, THICKNESS);

    // Front
    translate([0, -2* THICKNESS, 0]) rotate([90, 0, 0]) TabbedPanel(LENGTH, HEIGHT, THICKNESS, tab_x_filled=false);

    // Back
    translate([0, WIDTH + 3* THICKNESS, 0]) rotate([90, 0, 0]) TabbedPanel(LENGTH, HEIGHT, THICKNESS, tab_x_filled=false);

    // Left
    translate([-2* THICKNESS, 0, 0]) rotate([0, 270, 0]) TabbedPanel(HEIGHT, WIDTH, THICKNESS, tab_x_filled=false, tab_y_filled=false);

    // Right
    translate([LENGTH + 3 * THICKNESS, 0, 0]) rotate([0, 270, 0]) TabbedPanel(HEIGHT, WIDTH, THICKNESS, tab_x_filled=false, tab_y_filled=false);

    // Top
    translate([0, 0, HEIGHT - THICKNESS]) TabbedPanel(LENGTH, WIDTH, THICKNESS);

}

module FlatCase()
{
    // Bottom
    TabbedPanel(LENGTH, WIDTH, THICKNESS);

    // Front
    translate([LENGTH + THICKNESS, 0, 0]) TabbedPanel(LENGTH, HEIGHT, THICKNESS, tab_x_filled=false);

    // Back
    translate([-LENGTH - THICKNESS, 0, 0]) TabbedPanel(LENGTH, HEIGHT, THICKNESS, tab_x_filled=false);

    // Left
    translate([0, LENGTH + THICKNESS, 0])  TabbedPanel(HEIGHT, WIDTH, THICKNESS, tab_x_filled=false, tab_y_filled=false);

    // Right
    translate([0, -LENGTH - THICKNESS, 0])  TabbedPanel(HEIGHT, WIDTH, THICKNESS, tab_x_filled=false, tab_y_filled=false);

    // Top
    translate([-LENGTH - THICKNESS, HEIGHT + THICKNESS, 0]) TabbedPanel(LENGTH, WIDTH, THICKNESS);
}

//Case();

translate([150, 150, 0]) color("red") projection() FlatCase();

translate([0, 0, -1]) {
    difference() {
        square([384, 384]);
        translate([0.5, 0.5, 0]) square([383, 383]);
    }

}
