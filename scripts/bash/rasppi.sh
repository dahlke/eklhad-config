#!/bin/bash

# TODO: scp all the install files
HOSTS=("rpi1" "rpi2" "rpi3" "rpi4")
PRIMARY_HOST="rpi1"
SERVER_HOSTS=("rpi1" "rpi2" "rpi3")
CLIENT_HOSTS=("rpi4")

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
