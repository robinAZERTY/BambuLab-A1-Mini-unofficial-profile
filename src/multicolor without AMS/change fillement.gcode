;===== machine: A1 mini edited 22/11/2025 =========================
G392 S0
M204 S9000

G1 Z{max_layer_z + 3.0} F1200

M400
M106 P1 S0
M106 P2 S0
{if old_filament_temp > 142 && next_extruder < 255}
    M104 S[old_filament_temp]
{endif}

G1 X180 F18000
G1 E-20 F1000
G1 X192 F500
G1 X197 E-3 F200
G1 X180 F500
G1 E23 F1000
G1 E-38 F1000

G1 X0 Y90 F18000
G1 X-13.5 F9000

; pause for user to load and press resume
M400 U1

;===== Instructions: =====
; when print has paused,
; unload the current filamant
; load the next filament by pushing into the PTFE tube until the endstop
; press resume

{if next_extruder < 255}
    M400

    G92 E0
    G1 E35 F500
    ;G1 E{retraction_distances_when_cut[previous_extruder]} F200

    {if flush_length_1 > 1}
        ; FLUSH_START
        ; always use highest temperature to flush
        M400
        M1002 set_filament_type:UNKNOWN
        M109 S[flush_temperatures[next_extruder]]
        M106 P1 S60
        {if flush_length_1 > 43.7}
            G1 E43.7 F{flush_volumetric_speeds[previous_extruder]/2.4053*60} ; do not need pulsatile flushing for start part
            G1 E{(flush_length_1 - 43.7) * 0.02} F50
            G1 E{(flush_length_1 - 43.7) * 0.23} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}
            G1 E{(flush_length_1 - 43.7) * 0.02} F50
            G1 E{(flush_length_1 - 43.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
            G1 E{(flush_length_1 - 43.7) * 0.02} F50
            G1 E{(flush_length_1 - 43.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
            G1 E{(flush_length_1 - 43.7) * 0.02} F50
            G1 E{(flush_length_1 - 43.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        {else}
            G1 E{flush_length_1} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}
        {endif}
        ; FLUSH_END
        G1 E-[old_retract_length_toolchange] F1800
        G1 E[old_retract_length_toolchange] F300
        M400
        M1002 set_filament_type:{filament_type[next_extruder]}
    {endif}

    {if flush_length_1 > 45 && flush_length_2 > 1}
        ; WIPE
        M400
        M106 P1 S178
        M400 S3
        G1 X-3.5 F18000
        G1 X-13.5 F3000
        G1 X-3.5 F18000
        G1 X-13.5 F3000
        G1 X-3.5 F18000
        G1 X-13.5 F3000
        M400
        M106 P1 S0
    {endif}

    {if flush_length_2 > 1}
    M106 P1 S60
        ; FLUSH_START
        G1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        G1 E{flush_length_2 * 0.02} F50
        G1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        G1 E{flush_length_2 * 0.02} F50
        G1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        G1 E{flush_length_2 * 0.02} F50
        G1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        G1 E{flush_length_2 * 0.02} F50
        G1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        G1 E{flush_length_2 * 0.02} F50
        ; FLUSH_END
        G1 E-[new_retract_length_toolchange] F1800
        G1 E[new_retract_length_toolchange] F300
    {endif}

    {if flush_length_2 > 45 && flush_length_3 > 1}
        ; WIPE
        M400
        M106 P1 S178
        M400 S3
        G1 X-3.5 F18000
        G1 X-13.5 F3000
        G1 X-3.5 F18000
        G1 X-13.5 F3000
        G1 X-3.5 F18000
        G1 X-13.5 F3000
        M400
        M106 P1 S0
    {endif}

    {if flush_length_3 > 1}
        M106 P1 S60
        ; FLUSH_START
        G1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        G1 E{flush_length_3 * 0.02} F50
        G1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        G1 E{flush_length_3 * 0.02} F50
        G1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        G1 E{flush_length_3 * 0.02} F50
        G1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        G1 E{flush_length_3 * 0.02} F50
        G1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        G1 E{flush_length_3 * 0.02} F50
        ; FLUSH_END
        G1 E-[new_retract_length_toolchange] F1800
        G1 E[new_retract_length_toolchange] F300
    {endif}

    {if flush_length_3 > 45 && flush_length_4 > 1}
        ; WIPE
        M400
        M106 P1 S178
        M400 S3
        G1 X-3.5 F18000
        G1 X-13.5 F3000
        G1 X-3.5 F18000
        G1 X-13.5 F3000
        G1 X-3.5 F18000
        G1 X-13.5 F3000
        M400
        M106 P1 S0
    {endif}

    {if flush_length_4 > 1}
        M106 P1 S60
        ; FLUSH_START
        G1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        G1 E{flush_length_4 * 0.02} F50
        G1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        G1 E{flush_length_4 * 0.02} F50
        G1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        G1 E{flush_length_4 * 0.02} F50
        G1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        G1 E{flush_length_4 * 0.02} F50
        G1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
        G1 E{flush_length_4 * 0.02} F50
        ; FLUSH_END
    {endif}

    M400
    M106 P1 S60
    M109 S[new_filament_temp]
    G1 E5 F{flush_volumetric_speeds[next_extruder]/2.4053*60} ;Compensate for filament spillage during waiting temperature
    M400
    G92 E0
    G1 E-[new_retract_length_toolchange] F1800
    M400
    M106 P1 S178
    M400 S3
    G1 X-3.5 F18000
    G1 X-13.5 F3000
    G1 X-3.5 F18000
    G1 X-13.5 F3000
    G1 X-3.5 F18000
    G1 X-13.5 F3000
    G1 X-3.5 F18000
    M400
    G1 Z{max_layer_z + 3.0} F3000
    M106 P1 S0
    {if layer_z <= (initial_layer_print_height + 0.001)}
        M204 S[initial_layer_acceleration]
    {else}
        M204 S[default_acceleration]
    {endif}
{else}
    G1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000
{endif}


M620 S[next_extruder]A
T[next_extruder]
M621 S[next_extruder]A
G392 S1