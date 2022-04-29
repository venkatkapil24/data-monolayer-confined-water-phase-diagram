&CONTROL
    calculation='scf'
!    restart_mode='restart',
!    prefix="ccc"
    pseudo_dir="/work/e202/e202/zen/2d-ice/"
    tprnfor=.true.
 /
 &system
    ibrav = 0, 
!    A = 5.6054625156021487 , B = 5.7080932888124885 , C = 10.0 
! celldm(1) =1.88972687777
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
H  2.4191197364   1.1824017030   5.6300041599    
H  1.2801759125   0.1647019143   5.2490039290    
H  5.0614529316   1.1819995825   4.3697672760    
H  3.9224887630   0.1644979351   4.7509159067    
H  0.2232711666   3.7952036296   4.3695775185    
H  1.3622659164   2.7778351983   4.7507775457    
H  4.0046906353   2.7778120158   5.2492444466    
H  2.8657318452   3.7953014986   5.6302057644    
O  2.2577512989   0.2820269340   5.2653361189    
O  4.9000713681   0.2818049634   4.7347465346    
O  0.3846972698   2.8950515037   4.7346640214    
O  3.0271215349   2.8950591189   5.2652765327    

K_POINTS automatic
4 4 1 0 0 0

CELL_PARAMETERS { angstrom }
  5.2849163109  -0.0002373917   0.0000000000 
  0.0002735401   5.2261765741   0.0000000000 
  0.0000000000   0.0000000000  10.0000000000 

