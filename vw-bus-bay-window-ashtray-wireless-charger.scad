// Volkswagen Bus (Type 2) Bay Window Bus wireless charger for the ashtray
// Cedric Priscal
// https://github.com/cepr/vw-bus-bay-window-ashtray-wireless-charger
// Licensed under Creative Commons Legal Code, CC0 1.0 Universal

// Used additional parts:
// https://www.amazon.com/dp/B0DGTCSYLJ
// https://www.amazon.com/dp/B0D4HCT8FR

$fn=128;
clearance = 0.5;
opening_angle = 30;
depth = 135;
h=54.5;
l=101.5;
wall=4;

module section(offset) {
    r=5;
    minkowski() {
        square([l-r*2+offset*2, h-r*2+offset*2], center=true);
        circle(r=r);
    }
}

difference() {
    union() {
        linear_extrude(wall, convexity = 4, scale=[l/(l+2*wall), h/(h+2*wall)]) {
            difference() {
                section(offset=+wall);
                section(offset=0);
            }
        }
        translate([0,50,0])
            rotate([90,0,0])
                rotate([0,-90,0])
                    rotate_extrude(angle=30, convexity = 4)
                        translate([50, 0, 0])
                            rotate([0,0,90])
                                difference() {
                                    section(offset=0);
                                    section(offset=-wall);
                                }
        translate([0,50,0])
            rotate([-30,0,0])
                translate([0,-50,-0.1])
                    linear_extrude(depth+0.1, convexity = 4) {
                        difference() {
                            section(offset=0);
                            section(offset=-wall);
                        }
                    }
        bottom();
        translate([0,50,0])
        rotate([-30,0,0])
        translate([0,-50,h/2+depth])
        rotate([0,0,180])
        rotate([0,-90,0]) {
            usb_support();
            %usb();
        }
    }
    translate([0,45,-20])
        rotate([-30,0,0])
            translate([0,-.8,0])
                charger();
    //translate([-10.25,0,7+12.1-1.9+1])
        //rotate([90,0,0])
            //cylinder(h=50, d=5.5);
}

module charger() {
    translate([0, -26.5-1, 75])
        rotate([90,0,0])
            union() {
                minkowski() {
                    cylinder(h=6.35/3, d=99.5 - 6.35/3*2 + clearance, center=true);
                    sphere(r=6.35/3);
                }
                translate([0,500,0])
                    cube([13, 1000, 6.35], center=true);
            }
}

module opening(offset) {
    r=5;
    linear_extrude(depth) {
        minkowski() {
            square([l-r*2+offset*2, h-r-2+offset*2], center=true);
            circle(r=5);
        }
    }
}

module usb() {
    translate([0,0,wall/2])
    union() {
        translate([0,0,-1.2*25.4])
            cylinder(h=1.2*25.4, d=7/8*25.4);
        cylinder(h=3, d=120/86*7/8*25.4);
    }
}

module phone() {
    r = 3;
    rotate([-30, 0, 0])
    translate([0,10,80])
        minkowski() {
            cube([70-r*2, 8-r*2, 150-r*2], center=true);
            sphere(r=3);
        }
}

module inside() {
    translate([0,0,wall])
        opening(offset=-wall);
}

module front() {
    difference() {
        opening(offset=wall);
        translate([0,0,depth-21])
        rotate([opening_angle, 0, 0])
            translate([0,0,-500-wall])
                cube([1000, 1000, 1000], center=true);
    }
}

module usb_support() {
    linear_extrude(wall, center=true)
        difference() {
            hull() {
                circle(d=32);
                translate([-h/2, 0, 0])
                    square([1,h], center=true);
            }
            circle(d=7/8*25.4+clearance);
        }
}

%phone();

module bottom() {
    r = 5;
    translate([0,50,0])
    rotate([-30,0,0])
    translate([0,-50,depth])
        minkowski() {
            linear_extrude(0.000001)
                square([l-r*2, h-r*2], center=true);
            sphere(r=r);
    }
}
