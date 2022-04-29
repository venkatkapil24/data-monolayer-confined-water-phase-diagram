#!/usr/bin/env python3

import os
import re
import math

equil_time_au = 10.
#pickunits = 'au'
#pickunits = 'kcal/mol'
pickunits = 'eV'

debug = False
#debug = True

units = { 'au':1, 'eV':2, 'kcal/mol':3, 
        'au/atom':4, 'eV/atom':5, 'kcal/mol/atom':6 }

conv2au = { 
        'au':1.0, 
        'eV':27.21138505,
        'kcal/mol':627.503,
        'kJ/mol':2625.5,
        'cm^-1':219474.63,
        'K': 315777.,
        'J': 43.60E-19,
        'Hz':6.57966E+15,
        }

results = {}

config = '0GPa_z10'
tau = '0.02'

ftau = float(tau)
dmcdir = f'DMC_{tau}'
equil = int(math.ceil( equil_time_au / ftau ))
command = """~/CASINO/bin_qmc/reblock << EOF > _reblock
{eq}
{u}
{b}
EOF
""".format( eq=equil, u=units[pickunits], b='-1' )



basedir = os.getcwd()
l = os.listdir( basedir )
confdirs = [ s for s in l if s.startswith( f'{config}_k' ) ]
for conf in sorted( confdirs ):
    if (debug): print( f'{conf}' )
    geo, zdist, kgrid = conf.split('_')
    results[conf] = { 
            'kgrid' : kgrid,
            'geo'   : geo,
            'zdist' : zdist,
            'tau'   : ftau,
            }

if (debug): print(results)


for conf in confdirs:
        dmcpath = os.path.join( basedir, conf, dmcdir )
        os.chdir( dmcpath )
        os.system( 'pwd' )
        if (os.path.isfile( 'dmc.hist' )):
            try:
                # run reblocking
                os.system( command )
                # read output
                flag_poperr = False
                flag_taueff = False
                for line in open( 'input', 'r' ):
                    if re.search( 'neu', line ):
                        lsplit = line.split()
                        neu = int(lsplit[2])
                        nwat = neu/4
                for line in open( '_reblock', 'r' ):
                    if re.search( 'Total energy \(using Ewald\)', line ):
                        lsplit = line.split()
                        ene = lsplit[-2]
                        err = lsplit[-1]
                        if (debug): print(lsplit)
                    if re.search( 'Mean population :', line ):
                        pop = float(line.split()[-1])
                        flag_poperr = True
                    if re.search( 'Std error :', line ) and flag_poperr:
                        poperr = float(line.split()[-1])
                        flag_poperr = False
                    if re.search( 'Mean time step', line ):
                        taueff = float(line.split()[-1])
                        flag_taueff = True
                    if re.search( 'Std error', line ) and flag_taueff:
                        tauefferr = float(line.split()[-1])
                        flag_taueff = False
                        if (debug): print(f'Effective tau = {taueff} +/- {tauefferr}')
                    if re.search( '   Variance ', line ):
                        var = float(line.split()[-1])
                    if re.search( 'Correlation time', line ):
                        autocorrtime = float(line.split()[-1])
                    if re.search( 'lines of data in total', line ):
                        Nsteps = int(line.split()[2])
                    if re.search( 'Effective population size :', line ):
                        lsplit = line.split()
                        popeff = float(lsplit[-2])
                        popefferr = float(lsplit[-1])
                print( f'{conf:<6} {nwat}: {ene} {err} {pickunits} Tsim {Nsteps*ftau:3.1f} Pop {pop:7.1f} {poperr:3.1f} Var {var*pop*conv2au[pickunits]**-2:5.3f} tau_eff {taueff:5.4f} corr-time {autocorrtime*ftau:3.2f}' )
                results[conf].update({ 
                        'ene' : ene, 
                        'err' : err,
                        'units' : pickunits,
                        'TotTimeSim[au]' : Nsteps*ftau,
                        'Pop' : pop,
                        'Pop-err' : poperr,
                        'Var[au]' : var*pop*conv2au[pickunits]**-2,
                        'tau_eff[au]' : taueff,
                        'corr-time[au]' : autocorrtime*ftau,
                        'nwat' : nwat,
                        })
            except Exception as e:
                print(f'Exception reading {dmcdir}: {e}')

#def gettau(r):
#    return r['tau']
#results.sort( key=gettau )

if (debug): print(results)

os.chdir( basedir )

print('\nBinding Energy [m{}]'.format(pickunits))
with open('data_0GPa.txt','w') as f:
  for k in sorted(results.keys()):
    try:  
        r = results[k]
        ec, erc = [ float( r[i] ) for i in ['ene','err'] ]
        e1, er1 = [ -4.68366702238636E+02, 1.28991774599235E-03 ]
        Eb = ec/2.0 - e1
        Eberr = math.sqrt( (erc/2.0)**2 + er1**2 )
        results['Eb'] = [ Eb, Eberr ]
        kgrid = r['kgrid']
        nwat = r['nwat']
        print( f'{kgrid:<7} {Eb*1e3:5.2f} {Eberr*1e3:5.2f} {nwat}' )
        f.write( f'{kgrid:<7} {Eb*1e3:5.2f} {Eberr*1e3:5.2f} {nwat}\n' )
        r['Eb'] = { 'ene':Eb, 'err':Eberr }
    except Exception as e:
        if debug: print(f'Exception writing results for {k}: {e}')

import pickle
with open( 'results_dmc.pkl', 'wb' ) as f:
    pickle.dump( results, f, pickle.HIGHEST_PROTOCOL )
#with open( 'results_dmc.pkl', 'rb' ) as f:
#    Edmc = pickle.load( f )
#print(Edmc)

print()
#print(results)
