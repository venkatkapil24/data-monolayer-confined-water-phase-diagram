&CONTROL
    calculation='scf'
!    restart_mode='restart',
!    prefix="ccc"
    pseudo_dir="../"
    tprnfor=.true.
 /
 &system
    ibrav = 1, A = 11,
    nat= 3, ntyp= 2,
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
H 4.9632997435  4.3764078726 5.6207419294
H 4.0237365300  4.9566144148 4.5506480580
O 4.8453090000  4.4476770000 4.6581920000

K_POINTS gamma
