&CONTROL
    calculation='scf'
!    restart_mode='restart',
!    prefix="ccc"
    pseudo_dir="../"
    tprnfor=.true.
 /
 &system
    ibrav = 0, 
!    A = 5.6054625156021487 , B = 5.7080932888124885 , C = 10.0 
! celldm(1) =1.88972687777
    nat= 6, ntyp= 2,
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
H        0.27151661       0.50105287       5.66671963
H        1.44605798       4.52344973       4.98476327
H        3.00611122       2.90618714       4.33328037
H        1.83156985       2.11831546       5.01523673
O        1.01381768       0.60813279       5.04628548
O        2.26381015       3.01326706       4.95371452

K_POINTS automatic
4 3 1 0 0 0

CELL_PARAMETERS { angstrom }
  3.2776278000   0.0000000000   0.0000000000 
  0.0000000000   4.8102685000   0.0000000000 
  0.0000000000   0.0000000000  10.0000000000 

