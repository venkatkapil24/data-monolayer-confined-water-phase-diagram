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
H        0.14499255       0.51499312       5.68423442
H        1.30359728       4.41279494       4.99713936
H        2.82958131       2.87668543       4.31576558
H        1.67097658       2.05110264       5.00286064
O        0.91228855       0.60310969       5.09196169
O        2.06228531       2.96480200       4.90803831

K_POINTS automatic
3 2 1 0 0 0

CELL_PARAMETERS { angstrom }
  2.9745739000   0.0000000000   0.0000000000 
  0.0000000000   4.7233846000   0.0000000000 
  0.0000000000   0.0000000000  10.0000000000 

