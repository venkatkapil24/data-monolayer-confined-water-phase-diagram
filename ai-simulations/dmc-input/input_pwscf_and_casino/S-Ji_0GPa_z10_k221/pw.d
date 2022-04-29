&CONTROL
    calculation='scf'
!    restart_mode='restart',
!    prefix="ccc"
    pseudo_dir="../"
    tprnfor=.true.
 /
 &system
    ibrav = 8, 
    A = 5.6474896423 , B = 5.6474577703 , C = 10.0 ,
    nat= 12, ntyp= 2,
    ecutwfc = 600,
    nosym=.t.
!    nspin=1,nbnd=580
!    occupations='smearing'
!    degauss=0.001
!    smearing='fd'    
!input_dft='kzk'
 /
 &electrons
    conv_thr = 1.0e-7
    mixing_beta = 0.7
    mixing_mode = 'local-TF'
!    diago_david_ndim=2
 /

ATOMIC_SPECIES
H 1.0  H.hf
O 16.0 O.hf

ATOMIC_POSITIONS { angstrom }
H   3.1763611983   4.3182010792   5.3550914468
H   4.1530093801   5.2948451664   4.6449029889
H   2.4711284440   1.3292566911   5.3550914468
H   1.4944802622   0.3526156375   4.6449029889
H   0.3526163772   4.1529855762   5.3550914468
H   1.3292645589   3.1763414891   4.6449029889
H   5.2948732651   1.4944721941   5.3550914468
H   4.3182250834   2.4711162812   4.6449029889
O   4.0902046808   4.3810037401   4.9999995643
O   1.5572849615   1.2664540302   4.9999995643
O   1.2664598597   4.0901829153   4.9999995643
O   4.3810297826   1.5572748550   4.9999995643

K_POINTS automatic
2 2 1 0 0 0

