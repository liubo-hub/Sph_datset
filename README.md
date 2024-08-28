# SPH Taichi Dataset

A high-performance implementation of Smooth Particle Hydrodynamics (SPH) simulator in [Taichi](https://github.com/taichi-dev/taichi). (working in progress)

## Examples

- Water floods the Dragon King's Temple

<p align="center">
  <img src="gif/Temple.gif" width="80%" height="80%" />
</p>

- Water floods the Pearl Tower

<p align="center">
  <img src="gif/Pearl_Tower.gif"  width="80%" height="80%" />
</p>

Here, Blender is used for rendering

## Features

Currently, the following features have been implemented:
- Cross-platform: Windows, Linux
- Support massively parallel GPU computing
- Weakly Compressible SPH (WCSPH)
- One-way/two-way fluid-solid coupling
- Shape-matching based rigid-body simulator
- Neighborhood search accelerated by GPU parallel prefix sum + counting sort

### Note
The GPU parallel prefix sum is only supported by cuda/vulkan backend currently. 

## Install

```
python -m pip install -r requirements.txt
```

Run the example:

> Run with geometric structure
```
python run_simulation.py --scene_file ./scenes/dragon_bath.json
```

> Visual run
```
python visualization.py --scene_file ./scenes/water.json
```
> Batch processing
```
bash batch_taichi_bak.sh
```

### Inspiration
SPH_Taichi Source Project Address:[SPH_Taichi](https://github.com/erizmr/SPH_Taichi)
### Acknowledgement
Implementation is largely inspired by [SPlisHSPlasH](https://github.com/InteractiveComputerGraphics/SPlisHSPlasH).
