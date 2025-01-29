import matplotlib.pyplot as plt
import numpy as np

# Load the data from the CSV file
file_path = 'iRobot_Zoomba\GRID_DATA.CSV'
data = np.loadtxt(file_path, dtype=int)

# Remove duplicate entries
unique_data = np.unique(data, axis=0)

# Create a 20x20x20 grid
grid_size = 20
grid = np.zeros((grid_size, grid_size, grid_size))

# Update the grid based on the robot's data
for xIndex, yIndex, zIndex in unique_data:
    grid[xIndex-1, yIndex-1, zIndex-1] = 1

# Create a figure and a 3D axis
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# Plot the entire grid with transparent blocks
ax.voxels(np.ones((grid_size, grid_size, grid_size), dtype=bool), facecolors=(0,0,0,0), edgecolor='k')

# Plot the occupied spaces with red blocks
ax.voxels(grid.astype(bool), facecolors='red', edgecolor='k')

# Set labels
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')

# Set aspect ratio to be equal
ax.set_box_aspect([1,1,1])

# Show the plot
plt.show()