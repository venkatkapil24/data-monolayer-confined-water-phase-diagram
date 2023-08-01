while read P
do
    mkdir ${P}
    while read T;
    do
        mkdir ${P}/${T}/
        mkdir ${P}/${T}/NPT

        sed "s/xxxTxxx/${T}/g" input.xml > ${P}/${T}/NPT/input.xml
        sed -i "s/xxxPxxx/${P}/g" ${P}/${T}/NPT/input.xml
        sed "s/xxxTxxx/${T}/g" run-ase.py > ${P}/${T}/NPT/run-ase.py
        sed "s/xxxTxxx/${T}/g" in1.lmp > ${P}/${T}/NPT/in1.lmp
        sed "s/xxxTxxx/${T}/g" submit.sh > ${P}/${T}/NPT/submit.sh
        sed -i "s/xxxPxxx/${P}/g" ${P}/${T}/NPT/submit.sh

        cd ${P}/${T}/NPT
        ln -s ../../../init.xyz .
        ln -s ../../../init-ase.xyz .
        ln -s ../../../data.lmp .
        ln -s ../../../confin* .
        cd ../../../

    done < TEMPERATURES
done < PRESSURES
