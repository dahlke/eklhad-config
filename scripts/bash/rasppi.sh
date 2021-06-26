#!/bin/bash

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
