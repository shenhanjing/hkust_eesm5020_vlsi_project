################################################################################
# Filename: divider.constraints.tcl
# Author: ZHU Jingyang
# Email: jzhuak@connect.ust.hk
# Affiliation: Hong Kong University of Science and Technology
# -------------------------------------------------------------------------------
# This is the template constraint script for ELEC5160/EESM5020.
################################################################################

################################################################################
# Timing constraint
################################################################################
# # Critical path constraint: set the desired clock frequency
create_clock -period 5.000 -name VCLK

################################################################################
# Enviornement attribute constraint
################################################################################
# # Load on the output ports
# set_load 1 [all_outputs]

# # Input transition time on all inputs except clock
set_input_delay -max 0.5 -clock VCLK [all_inputs]
set_input_delay -min 0.25 -clock VCLK [all_inputs]

set_output_delay -max 0.5 -clock VCLK [all_outputs]
set_output_delay -min 0.25 -clock VCLK [all_outputs]


set_load [expr 0.01] [all_outputs]
set_input_transition 0.1 [all_inputs]