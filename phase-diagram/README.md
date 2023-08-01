# List of sub directories with explanation

## 0. The snapshot of the i-PI code used for the study. 

This snapshot inplements constrained NPT allowing isotropic NPT in the xy plane. If you are interested in using this feature it is advisable to get in touch with (Venkat Kapil)[venkat.kapil@gmail.com]. We hope to have this implemented in the main branch of the (i-PI)[https://ipi-code.org/] code.

## 1. The crystal structures of the monolayer ice phases investigated in this work.

The structures correspond to supercells containing 144 molecules, the lowest number of molecules across supercells with the closest shape. 

## 2. Scripts and simulation setup to perform simulations at a set of lateral pressures and temperatures. 

Run `setup.sh` to create a folder structure. The top level directories correspond to pressures from the `PRESSURES` file. The inner ones correspond to temperatures from the `TEMPERATURES` file. The confining potentail in implemented in a simple python (ASE calculator)[], while the MLP is run using LAMMPS (see `in.lmp` and `data.lmp` files). The two potentials are combined within i-PI which takes care of running the simulations in the $NP_{lateral} T$ ensemble. The provided scripts work for the hexagonal phase of monolayer ice. To probe a different phase, you can substitue the `init-ase.xyz` and the `init.xyz` files with an appropriate LAMMPS `data.lmp` file. 

To calculate dynamical properties, replace `input.xml` with `input_classical_dynamics.xml`. To perform simulations with quantum nuclear effects, replace `input.xml` with `input_quantum_dynamics.xml`.

## 4. Scripts and simulation setup to perform coexistence simulations at a set of lateral pressures and temperatures.

We perform co-existence simulations in five steps. The first four steps create a half solid / half liquid supercell. The final step performs an $NP_{lateral}T$ simulation. In the `1_unit_cell_equilibration` directory, we perform a short low temperature simulation of a solid. In the `super_cell_melting` directory, we use an initial structure that is a 2x1x1 supercell of the final structure from the previous directory. To create a half solid half liquid structure, we fix atoms in one half of the box and perform a high temperature NVT simulation. In the directories `3_super_cell_cooling` and `4_super_cell_equilibration`, we perform short NVT simulations with and without constrains on the solid atoms. In the `5_production` directory, we perform $NP_{lateral}T$ simulations on the structures from steps 1-4. 

## 5. Random Structure Search Code

Please contact (Venkat Kapil)[venkat.kapil@gmail.com] and (Chris Pickard)[cjp20@cam.ac.uk].  
