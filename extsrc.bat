@echo off
echo Ready to Extract only useful stuff of sources ? Press Ctr-C if not and anything else if Yes.
pause

del debugging.txt
del *.exe
del *.~*

cd Dialogs
del *.~*
del *.dcu
cd ..

cd Editor
del *.~*
del *.dcu
cd ..

cd Logics
del *.~*
del *.dcu
cd ..

cd Utils
del *.~*
del *.dcu
cd ..

cd SerialMaker
del *.~*
del *.exe
del *.dcu
cd ..

cd PackageMaker
del *.~*
del *.exe
del *.dcu
cd ..

cd InstallScript
del *.~*
cd Output
del *.exe
cd .. 
rmdir Output

