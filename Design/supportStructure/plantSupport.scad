//reference
//import("/Users/cqx931/Downloads/Post.stl");

// total need two spikes
// two A, two B of each kind

$fn= 64;
distance = 77; // distance between the two sticks 77mm
d_stick = 5.7; // 5mm or 6mm diameters
screw_r = 1.8; // M3
screw_h = 8+1;
nut_d=6.7; // 6.7 for nozzle 0.25 multimaker
nut_h=2.5; // 2.5 for nozzle 0.25 multimaker
d_v = 10;
h = 80;
plate_h = 4;
//spike();
//plantSupportA();
//tester();
//translate([0,200,0]) plantSupportB();
//translate([0,-200,0]) plantSupportC();
//translate([400,0,0]) pizza();
//translate([400,100,0]) modularPizza("B");
pizzaLeg("support");
module plate() {
 color("black") cube([77,50,4]);
}

module tester() {
  difference() {
    cube([10,40,2], center=true);
    translate([0,-16,-1.1]) cylinder(h=6,r=1.6);
    translate([0,-8,-1.1]) cylinder(h=6,r=1.5);
    translate([0,0,-1.1]) cylinder(h=6,r=3.1);
    translate([0,10,-1.1]) cylinder(h=6,r=3);
    
  }
}
module pizza(type="A") {
d = distance + d_stick;
y = d / 2 / 1.73;
w = 12;
 difference() {
  union() {
    cylinder(h=plate_h,r=10);
    if(type!="C") translate([-w/2-2,0,0]) cube([w+4,2*y+10,plate_h]);
    translate([0,type=="C" ? 0 : 2*y ,plate_h]) support();
    if(type=="B") rotate([0,0,-120]) translate([0,2*y,plate_h]) support();
    rotate([0,0,120]) translate([-w/2,0,0]) cube([w,2*y+10,plate_h]);
    if(type=="A") rotate([0,0,-120])  translate([-w/2,0,0]) cube([w,2*y+10,plate_h]);
    else rotate([0,0,-120])  translate([-w/2-2,0,0]) cube([w+4,2*y+10,plate_h]);
  }
  translate([0,type=="C" ? 0 : 2*y, -0.1]) cylinder(h = h+0.2, r = d_stick/2); 
  translate([-d/2,-y,-0.1]) cylinder(h = h+0.2, r = screw_r);
  if(type=="A" || "C") translate([d/2,-y,-0.1]) cylinder(h = h+0.2, r = screw_r);
  else translate([d/2,-y,-0.1]) cylinder(h = h+0.2, r = d_stick/2); 
 }
};

module modularPizza(type="A") {
d = distance + d_stick;
y = d / 2 / 1.73;
w = 12;
 difference() {
  union() {
    cylinder(h=plate_h,r=10);
    if(type!="C") translate([-w/2-2,0,0]) cube([w+4,2*y+10,plate_h]);
    translate([0,type=="C" ? 0 : 2*y ,plate_h]) support();
    if(type=="B") rotate([0,0,-120]) translate([0,2*y,plate_h]) support();
    //rotate([0,0,120]) translate([-w/2,0,0]) cube([w,2*y+10,plate_h]);
    if(type=="A") rotate([0,0,-120])  translate([-w/2,0,0]) cube([w,2*y+10,plate_h]);
    else rotate([0,0,-120])  translate([-w/2-2,0,0]) cube([w+4,2*y+10,plate_h]);
  }
  translate([0,type=="C" ? 0 : 2*y, -0.1]) cylinder(h = h+0.2, r = d_stick/2); 
  translate([-d/2,-y,-0.1]) cylinder(h = h+0.2, r = screw_r);
  translate([0,0,-0.1]) cylinder(h = h+0.2, r = screw_r); // center screw
  if(type=="A" || type == "C") translate([d/2,-y,-0.1]) cylinder(h = h+0.2, r = screw_r);
  else translate([d/2,-y,-0.1]) cylinder(h = h+0.2, r = d_stick/2); 
 }
};

module pizzaLeg(type="default") {
w = 12;
//d = distance + d_stick;
//y = d / 2 / 1.73;
y=15;
 difference() {
  union() {
    cylinder(h=plate_h,r=10);
    translate([-w/2-2,0,0]) cube([w+4,type=="support" ? 20+10 : 2*y+10,plate_h]);
    if(type=="support") translate([0,20,plate_h]) support();
  }
  translate([0, 0, -0.1]) cylinder(h = h+0.2, r = screw_r);
  if(type=="default") translate([0, 2*y, -0.1]) cylinder(h = h+0.2, r = screw_r); 
  else translate([0, 20, -0.1]) cylinder(h = h+0.2, r = d_stick/2); 
 }
}

module plantSupportB(outer_d = 200, inner_d = 150) {
  m = (outer_d + inner_d)/4;
  p = (inner_d-d_stick)/2;
  translate([0,0,-5]) bottomPlateB(outer_d,inner_d);
  translate([m,0,0]) spike(d_v,h);
  translate([0,m,0]) spike(d_v,h);
  translate([p,p,0]) support(od=d_v, id=d_stick);
}

module plantSupportC(outer_d = 250, inner_d = 200) {
  
  t = (distance+d_stick) / 1.414;
  d = ((outer_d/2 +d_stick)- t) / 2;
  m = (outer_d + inner_d)/4;
  p = (inner_d-d_stick)/4;
  // for reference plate
  t1 = distance / 1.414;
  d1 = ((2*outer_d-inner_d)/2 - t1) / 2 -2;
  
  translate([0,0,-5]) bottomPlate(outer_d, inner_d, 5, t, d);
  translate([p,p,0]) spike(d_v,h);

  translate([d,t+d,0]) support(od=d_v, id=d_stick);
  translate([t+d,d,0]) support(od=d_v, id=d_stick);
  
  //translate([d, t1+d1,70]) rotate([0,0,-45]) plate();
}

module plantSupportA(outer_d = 250, inner_d = 200) {
  
  t = (distance+d_stick) / 1.414;
  d = ((outer_d/2 +d_stick)- t) / 2;

  // for reference plate
  t1 = distance / 1.414;
  d1 = ((2*outer_d-inner_d)/2 - t1) / 2 -2;
  
  translate([0,0,-5]) bottomPlate(outer_d, inner_d, 5, t, d);
  translate([d,t+d,0]) support(od=d_v, id=d_stick);
  translate([t+d,d,0]) support(od=d_v, id=d_stick);
  
  //translate([d, t1+d1,70]) rotate([0,0,-45]) plate();
}

module bottomPlate(od, id, h=5, t, d) {
m = (od+id)/4;
color("grey") difference() {
  union() {
    intersection() {
      ring(h,od,id);
      cube([od,id,h], center=false);
    }
    translate([m,0,0]) cylinder(h = h, r = (od-id)/4);
    translate([0,m,0]) cylinder(h = h, r = (od-id)/4);
    translate([d,t+d,0]) cylinder(h = h, r = d_stick*1.5);
    translate([t+d,d,0]) cylinder(h = h, r = d_stick*1.5);
   }
  // holes
  translate([d,t+d,-0.1]) cylinder(h = h+0.2, r = d_stick/2);
  translate([t+d,d,-0.1]) cylinder(h = h+0.2, r = d_stick/2);
  translate([m,0,-0.1]) cylinder(h = h+0.2, r = screw_r);
  translate([0,m,-0.1]) cylinder(h = h+0.2, r = screw_r);
}
}

module bottomPlateB(od, id, h=5) {
m = (od+id)/4;
p = (id-d_stick)/2;
color("grey") difference() {
  union() {
    intersection() {
      ring(h,od,id);
      translate([]) cube([od,id,h], center=false);
    }
    translate([m,0,0]) cylinder(h = h, r = (od-id)/4);
    translate([0,m,0]) cylinder(h = h, r = (od-id)/4);
    translate([p,p,0]) cylinder(h = h, r = d_stick*1.5);
   }
  // hole
  translate([p,p,-0.1]) cylinder(h = h+0.2, r = d_stick/2);
  translate([m,0,-0.1]) cylinder(h = h+0.2, r = screw_r);
  translate([0,m,-0.1]) cylinder(h = h+0.2, r = screw_r);
}
}

module support(id=d_stick,h=15) {
  wall = 2;
  color("grey")  translate([0,0,0]) difference() {
   klam_fillet_cylinder(cylinder_height = h, cylinder_radius = d_stick/2 + wall, fillet_radius_top=0,fillet_radius_bottom=3);
   translate([0,0,-0.1]) cylinder(h = h+0.2, r = id/2);
  }
}

module spike(d=6,h=80) {
  l_before = 1.5;
  screw_space = 6;
  top_h = 7;
  color("white") difference() {
  union() {
   cylinder(h=top_h,r=6);
   translate([0,0,top_h]) klam_fillet_cylinder(cylinder_height = h-10-top_h, cylinder_radius = d/2, fillet_radius_top=0,fillet_radius_bottom=3);
   translate([0,0,h-10]) cylinder(h = 10, r1 = d/2, r2 = 0);
   
  }
  //screws
  translate([0,0,-0.1]) union() {
    cylinder(r=screw_r, h=screw_space);
    translate([0,0,l_before]) {
    cylinder(r=nut_d/2, h=nut_h, $fn=6);
    //translate([0,0,nut_h-0.01]) cylinder(r1=nut_d/2,r2=0, h=nut_d/2);
    }
    //translate([0,0,screw_h-0.01]) cylinder(h=3, r1=screw_r, r2=0);
  }
  }
}

module ring(
        h=1,
        od = 10,
        id = 5,
        de = 0.1
        ) 
{
    difference() {
        cylinder(h=h, r=od/2);
        translate([0, 0, -de])
            cylinder(h=h+2*de, r=id/2);
    }
}

module klam_fillet_cylinder(
    cylinder_height=2,
    cylinder_radius=1,
    fillet_radius_bottom=1,
    fillet_radius_top=0,
    nfaces=50
) {
    /* created by Kevin Lam on Dec 3, 2016 */
    union() {      
        cylinder(cylinder_height, r=cylinder_radius, $fn=nfaces, false);
        
        if (fillet_radius_bottom > 0) {
            difference() {
                cylinder(fillet_radius_bottom, r=cylinder_radius+fillet_radius_bottom, $fn=nfaces, false);
                translate([0, 0, fillet_radius_bottom])
                rotate_extrude($fn=nfaces)
                translate([cylinder_radius+fillet_radius_bottom, 0, 0])
                circle(fillet_radius_bottom, $fn=nfaces);
            }
        }
        
        if (fillet_radius_top>0) {
            difference() {
                translate([0,0,cylinder_height-fillet_radius_top])
                cylinder(fillet_radius_top, r=cylinder_radius+fillet_radius_top, $fn=nfaces, false);
                
                translate([0, 0, cylinder_height-fillet_radius_top])
                rotate_extrude($fn=nfaces)
                translate([cylinder_radius+fillet_radius_top, 0, 0])
                circle(fillet_radius_top, $fn=nfaces);
            }
        }
    }
}