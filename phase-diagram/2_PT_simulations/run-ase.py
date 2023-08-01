import os
import sys
import numpy as np

from ase.io import read
from confining_potential_calculator import ConfiningPotentialMorseCalculator
from ase.calculators.calculator import Calculator, all_changes
from ase.calculators.socketio import SocketClient

# Define atoms object
print ("Reading atoms object.")
atoms = read("init-ase.xyz", 0)
#atoms = read("debug.xyz", 0)

# Set CP2K calculator #################
calcs = []
n_committee = 0

atom_types = {'O' : 2, 'H' : 1}

print ("Setting up potential.")
atoms.set_calculator(ConfiningPotentialMorseCalculator(57.8 * 1e-3, 3.85, 0.92, 5))

# Create Client
# inet
port = 11111
host = "xxxTxxx_cp"
print ("Setting up socket.")
client = SocketClient(unixsocket=host)
print ("Running socket.")
client.run(atoms)
print ("setting up calculator")
