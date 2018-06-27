cd ..
lua Examples\cmdLineBatchJob.lua
cd Examples

@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp2inches.stl -o stl\moonLamp2inches.stl
@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp3inches.stl -o stl\moonLamp3inches.stl
@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp4inches.stl -o stl\moonLamp4inches.stl
@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp5inches.stl -o stl\moonLamp5inches.stl

@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp2inches.stl -o stl\moonLamp2inchesY30.stl -s rotatey30.mlx
@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp2inchesOuterOnly.stl -o stl\moonLamp2inchesY30OuterOnly.stl -s rotatey30.mlx
@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp5inches.stl -o stl\moonLamp5inchesY45.stl -s rotatey45.mlx
@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp5inchesOuterOnly.stl -o stl\moonLamp5inchesY45OuterOnly.stl -s rotatey45.mlx

pause
