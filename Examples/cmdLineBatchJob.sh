#!/bin/sh
cd ..
lua Examples/cmdLineBatchJob.lua
cd Examples

# meshlabserver -i moonLamp2inches.stl -o stl/moonLamp2inches.stl
# meshlabserver -i moonLamp3inches.stl -o stl/moonLamp3inches.stl
# meshlabserver -i moonLamp4inches.stl -o stl/moonLamp4inches.stl
# meshlabserver -i moonLamp5inches.stl -o stl/moonLamp5inches.stl

# meshlabserver -i moonLamp2inches.stl -o stl/moonLamp2inchesY30.stl -s MeshLabRotateY30.mlx
# meshlabserver -i moonLamp2inchesOuterOnly.stl -o stl/moonLamp2inchesY30OuterOnly.stl -s MeshLabRotateY30.mlx
# meshlabserver -i moonLamp5inches.stl -o stl/moonLamp5inchesY45.stl -s MeshLabRotateY45.mlx
# meshlabserver -i moonLamp5inchesOuterOnly.stl -o stl/moonLamp5inchesY45OuterOnly.stl -s MeshLabRotateY45.mlx
