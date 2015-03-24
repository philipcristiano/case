
all: final_case.svg case.dxf

case.eps: case.svg
	/Applications/Inkscape.app/Contents/Resources/bin/inkscape -D -f ~/Documents/3d/night-light/case.svg -E case.eps -P case.ps -e case.png

case.dxf: case.scad
	/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -m make --projection=o  case.scad -o case.dxf

case.svg: case.scad
	/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -m make --projection=o  case.scad -o case.svg

final_case.svg: case.svg
	sed 's/black/#0000FF/' case.svg | sed  's/lightgray/#FFFFFF/' | sed  's/stroke-width="0.5"/stroke-width="0.01"/'> final_case.svg
