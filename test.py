import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# inital parameter
a, b = 1, 1
m, n = 1, 2
v = 0.02
min_walk = 0.002
num_particles = 1000

# set plot
fig, ax = plt.subplots()
ax.set_xlim(0, 1)
ax.set_ylim(0, 1)
particles, = ax.plot([], [], 'bo', ms=1)

# inital Particles
particle_positions = np.random.rand(num_particles, 2)

def chladni(x, y, a, b, m, n):
    return a * np.sin(np.pi * n * x) * np.sin(np.pi * m * y) + b * np.sin(np.pi * m * x) * np.sin(np.pi * n * y)

def move_particles():
    global particle_positions
    stochastic_amplitude = v * np.abs(chladni(particle_positions[:, 0], particle_positions[:, 1], a, b, m, n))
    stochastic_amplitude[stochastic_amplitude <= min_walk] = min_walk
    particle_positions[:, 0] += np.random.uniform(-stochastic_amplitude, stochastic_amplitude, num_particles)
    particle_positions[:, 1] += np.random.uniform(-stochastic_amplitude, stochastic_amplitude, num_particles)
    particle_positions = np.clip(particle_positions, 0, 1)

def update(frame):
    move_particles()
    particles.set_data(particle_positions[:, 0], particle_positions[:, 1])
    return particles,

# setting animation
ani = FuncAnimation(fig, update, frames=800, interval=50, blit=True)
plt.show()
