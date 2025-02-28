#!/bin/sh

cd 00_simpleFoam

rm -rf 0

rm log.*

cp -rf 0_orig 0

decomposePar > log.decomposePar 2>&1

mpirun -np 8 simpleFoam -parallel > log.simpleFoam 2>&1

reconstructPar > log.reconstructPar 2>&1

pyFoamCopyLastToFirst.py . . > log.pyFoamCopyLastToFirst

pyFoamClearCase.py . --processors-remove --keep-postprocessing > log.pyFoamClearCase

postProcess -func "add(C1, C2, C3, C4)" > log.add 2>&1

postProcess -func sampleDictConcentration > log.sampleConcentration 2>&1
