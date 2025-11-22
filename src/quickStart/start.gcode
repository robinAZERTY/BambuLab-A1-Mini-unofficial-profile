;PART 6/6
;===== extrude cali test ===============================
M1002 gcode_claim_action : 2
M1002 set_filament_type:{filament_type[initial_no_support_extruder]}
M104 S170;begin nozzle preheat
M140 S[bed_temperature_initial_layer_single];set bed temp
M1002 gcode_claim_action : 13
M982.2 S1 ; turn on cog noise reduction
M975 S1 ; turn on vibration supression
G28 T300;home

M620 M ;enable remap
M620 S[initial_no_support_extruder]A   ; switch material if AMS exist
    G392 S0 ;turn on clog detect
    M1002 gcode_claim_action : 4
    M400
    M1002 set_filament_type:UNKNOWN
    M109 S[nozzle_temperature_initial_layer]
    M104 S250
    M400
    T[initial_no_support_extruder]
    G1 X-13.5 F3000
    M400
    M620.1 E F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60} T{flush_temperatures[initial_no_support_extruder]}
    M109 S250 ;set nozzle to common flush temp
    M106 P1 S0
    G92 E0
    G1 E50 F200
    M400
    M1002 set_filament_type:{filament_type[initial_no_support_extruder]}
    M104 S{flush_temperatures[initial_no_support_extruder]}
    G92 E0
    G1 E50 F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60}
    M400
    M106 P1 S178
    G92 E0
    G1 E5 F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60}
    M109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-20} ; drop nozzle temp, make filament shink a bit
    M104 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-40}
    G92 E0
    G1 E-0.5 F300

    G1 X0 F30000
    G1 X-13.5 F3000
    G1 X0 F30000 ;wipe and shake
    G1 X-13.5 F3000
    G1 X0 F12000 ;wipe and shake
    G1 X0 F30000
    G1 X-13.5 F3000
    M109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-40}
    G392 S0 ;turn off clog detect
M621 S[initial_no_support_extruder]A

M400
M106 P1 S0

;===== wipe nozzle ===============================
M1002 gcode_claim_action : 14
M975 S1

M211 S; push soft endstop status
M211 X0 Y0 Z0 ;turn off Z axis endstop

M83
G1 E-1 F500
G90
M83

G0 X90 Y-4 F10000
G380 S3 Z-5 F400
G1 Z2 F400
G1 X91 F3000
G380 S3 Z-5 F400
G1 Z2 F400
G1 X92 F3000
G380 S3 Z-5 F400
G1 Z2 F400
G1 X93 F3000
G380 S3 Z-5 F400
G1 Z2 F400
G1 X94 F3000
G380 S3 Z-5 F400
G1 Z2 F400
G1 X95 F3000
G380 S3 Z-5 F400
G1 Z2 F400
G1 X96 F3000
G380 S3 Z-5 F400
G1 Z2 F400
G1 X97 F3000
G380 S3 Z-5 F400
G1 Z2 F400
G1 X98 F3000
G380 S3 Z-5 F400
G1 Z2 F400
G1 X99 F3000
G380 S3 Z-5 F400
G1 Z2 F400
G1 X99 F3000
G380 S3 Z-5 F400
G1 Z2 F400
G1 X99 F3000
G380 S3 Z-5 F400
G1 Z2 F400
G1 X99 F3000
G380 S3 Z-5 F400
G1 Z2 F400
G1 X99 F3000
G380 S3 Z-5 F400

G1 Z5 F10000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

G1 X0 Y175 F18000
G1 X-13.5 F9000
M1002 gcode_claim_action : 2
M190 S[bed_temperature_initial_layer_single];wait for bed temp
M1002 gcode_claim_action : 0
M109 S[nozzle_temperature_initial_layer];wait for nozzle temp

G1 X25 Y175 F3000.1 ;Brush material

G1 Z0.2 F3000.1
G1 Y185
G91
G1 X-30 F3000
G1 Y-2
G1 X27
G1 Y1.5
G1 X-28
G1 Y-2
G1 X30
G1 Y1.5
G1 X-30
G90
M83

M211 R; pop softend status




G0 X90 Y90 F3000
G28 Z P0 T300; home z
;G1 E2 F500 ; Undo retraction

;===== extrude cali test ===============================
M104 S{nozzle_temperature_initial_layer[initial_extruder]}
G90
M83
G0 X68 Y-2.5 F30000
G0 Z0.2 F18000 ;Move to start position
G1 E1 F500
G0 X88 E10  F{outer_wall_volumetric_speed/(24/20)    * 60}
G0 X93 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}
G0 X98 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}
G0 X103 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}
G0 X108 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}
G0 X113 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}
G0 X115 Z0 F20000
G0 Z5
M400




;========turn off light and wait extrude temperature =============
M1002 gcode_claim_action : 0
M400 ; wait all motion done before implement the emprical L parameters
;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
;curr_bed_type={curr_bed_type}
{if curr_bed_type=="Textured PEI Plate"}
G29.1 Z{-0.02} ; for Textured PEI Plate
{endif}
M960 S1 P0 ; turn off laser
M960 S2 P0 ; turn off laser
M106 S0 ; turn off fan
M106 P2 S0 ; turn off big fan
M106 P3 S0 ; turn off chamber fan
M975 S1 ; turn on mech mode supression
G90
M83
T1000
M211 X0 Y0 Z0 ;turn off soft endstop
M1007 S1