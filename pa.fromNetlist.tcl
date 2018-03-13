
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name Tower_Defense-Invasion -dir "D:/Desktop/Nicolas/ECE/ING 4/VHDL/Project/Tower_Defense-Invasion/planAhead_run_1" -part xc3s500efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/Desktop/Nicolas/ECE/ING 4/VHDL/Project/Tower_Defense-Invasion/Top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/Desktop/Nicolas/ECE/ING 4/VHDL/Project/Tower_Defense-Invasion} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "Top.ucf" [current_fileset -constrset]
add_files [list {Top.ucf}] -fileset [get_property constrset [current_run]]
link_design
