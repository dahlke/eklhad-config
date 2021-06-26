#!/bin/bash

# TODO: scp all the install files

##################
# COMMON INSTALL #
##################
./install.sh

##########
# CONSUL #
##########
./consul.sh

#########
# VAULT #
#########
./vault.sh

#########
# NOMAD #
#########
./nomad.sh

############
# BOUNDARY #
############
./boundary.sh

############
# WAYPOINT #
############
./waypoint.sh
