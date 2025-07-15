import cv2
import numpy as np
import json
import csv
import os

# --- Global Calibration Parameters (will be loaded from file) ---
CALIBRATION_PARAMS = {}

# --- Fixed Paths and File Names ---
# USER INPUT REQUIRED: Set the path to the image captured by the robot.
# Example: IMAGE_PATH_TOP_XY = "C:/Users/YourUser/Documents/RobotImages/IM000001.PNG"
IMAGE_PATH_TOP_XY = "YOUR_IMAGE_FILE_PATH_HERE.PNG" # <<<--- USER MUST SET THIS PATH

FIXED_CSV_FILE_NAME = "coords.csv"

# --- Function to load calibration data ---
def load_calibration_data(file_name="calibration_data.json"):
    global CALIBRATION_PARAMS
    try:
        with open(file_name, 'r') as f:
            CALIBRATION_PARAMS = json.load(f)
        print(f"Calibration data loaded successfully from '{file_name}'.")
        # Remove Z key from calibration parameters as it's manually input
        if "origin_uframe_robot_z_plane" in CALIBRATION_PARAMS:
            del CALIBRATION_PARAMS["origin_uframe_robot_z_plane"]
    except FileNotFoundError:
        print(f"Error: Calibration file '{file_name}' not found. Please run 'calibration_program.py' first.")
        exit()
    except json.JSONDecodeError:
        print(f"Error: Could not decode JSON from '{file_name}'. Check file integrity.")
        exit()

# --- Main Transformation Function ---
def pixel_to_robot_coords(pixel_x, pixel_y, robot_z_input):
    mm_per_pixel_robot_x = CALIBRATION_PARAMS["mm_per_pixel_robot_x"]
    mm_per_pixel_robot_y = CALIBRATION_PARAMS["mm_per_pixel_robot_y"]
    origin_uframe_pixel_x = CALIBRATION_PARAMS["origin_uframe_pixel_x"]
    origin_uframe_pixel_y = CALIBRATION_PARAMS["origin_uframe_pixel_y"]
    origin_uframe_robot_x = CALIBRATION_PARAMS["origin_uframe_robot_x"]
    origin_uframe_robot_y = CALIBRATION_PARAMS["origin_uframe_robot_y"]

    delta_pixel_x = pixel_x - origin_uframe_pixel_x
    delta_pixel_y = pixel_y - origin_uframe_pixel_y

    # Transformation logic remains the same (swapped axes for Fanuc)
    robot_x = origin_uframe_robot_x + (delta_pixel_y * mm_per_pixel_robot_x)
    robot_y = origin_uframe_robot_y + (delta_pixel_x * mm_per_pixel_robot_y)
    robot_z = robot_z_input

    return robot_x, robot_y, robot_z

# --- Main Readout Program ---
if __name__ == "__main__":
    print("--- Vision System Readout (Panopticon) ---")
    print("This program uses previously calibrated data to transform pixel coordinates to robot coordinates.")
    print("Z-height is manually entered for this virtual project.")
    print("W-component of orientation is fixed at -180.0 degrees.")
    print("------------------------------------------\n")

    load_calibration_data()

    manual_z_height = float(input("Enter the FIXED Z-height of the object plane relative to Robot User Frame (in mm). "
                                  "NOTE: In a real application, this Z-height would be dynamically measured by a 3D vision system or other sensor: "))

    if not os.path.exists(IMAGE_PATH_TOP_XY):
        print(f"Error: Image file '{IMAGE_PATH_TOP_XY}' not found. Please ensure the file exists at this path and you have set it correctly in the script.")
        exit()

    image = cv2.imread(IMAGE_PATH_TOP_XY, cv2.IMREAD_GRAYSCALE)

    if image is None:
        print(f"Error: Could not load image from '{IMAGE_PATH_TOP_XY}'. Check file permissions or if it's a valid image.")
        exit()

    # Image Processing: Detect Contours and Vertices
    _, threshold = cv2.threshold(image, 127, 255, cv2.THRESH_BINARY_INV)
    contours, _ = cv2.findContours(threshold, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

    all_transformed_robot_xy_values = []

    if not contours:
        print("No contours found on the image.")
    else:
        print(f"\n--- Detected Objects/Points on '{IMAGE_PATH_TOP_XY}' ---")

        for i, contour in enumerate(contours):
            epsilon = 0.005 * cv2.arcLength(contour, True)
            approx = cv2.approxPolyDP(contour, epsilon, True)
            points = [tuple(pt[0]) for pt in approx]

            print(f"    Contour {i} detected with {len(points)} vertices.")

            for pt_pixel in points:
                robot_x, robot_y, robot_z = pixel_to_robot_coords(pt_pixel[0], pt_pixel[1], manual_z_height)

                all_transformed_robot_xy_values.append(robot_x)
                all_transformed_robot_xy_values.append(robot_y)
                all_transformed_robot_xy_values.append(robot_z)
                all_transformed_robot_xy_values.append(-180.0)      # W (Rotation around X)
                all_transformed_robot_xy_values.append(0.0)         # P (Rotation around Y)
                all_transformed_robot_xy_values.append(0.0)         # R (Rotation around Z)

                # Printing W,P,R for consistency with output format
                print(f"Pixel ({pt_pixel[0]}, {pt_pixel[1]}) -> Robot ({robot_x:.3f}, {robot_y:.3f}, {robot_z:.3f}, -180.0, 0.0, 0.0)")

        if not all_transformed_robot_xy_values:
            print("No significant points detected from contours for transformation.")

        script_dir = os.path.dirname(os.path.abspath(__file__))
        csv_full_path = os.path.join(script_dir, FIXED_CSV_FILE_NAME)

        try:
            with open(csv_full_path, 'w', newline='') as csvfile:
                writer = csv.writer(csvfile)

                for i in range(0, len(all_transformed_robot_xy_values), 6):
                    x_val = all_transformed_robot_xy_values[i]
                    y_val = all_transformed_robot_xy_values[i+1]
                    z_val = all_transformed_robot_xy_values[i+2]
                    w_val = all_transformed_robot_xy_values[i+3]
                    p_val = all_transformed_robot_xy_values[i+4]
                    r_val = all_transformed_robot_xy_values[i+5]

                    writer.writerow([f"{x_val:.3f}"])
                    writer.writerow([f"{y_val:.3f}"])
                    writer.writerow([f"{z_val:.3f}"])
                    writer.writerow([f"{w_val:.3f}"])
                    writer.writerow([f"{p_val:.3f}"])
                    writer.writerow([f"{r_val:.3f}"])

            print(f"\nSuccessfully exported robot coordinates (X,Y,Z,W,P,R) to '{csv_full_path}'.")
        except IOError as e:
            print(f"\nError writing CSV file '{csv_full_path}': {e}")
        except Exception as e:
            print(f"\nAn unexpected error occurred during CSV export: {e}")

    print("\nReadout complete.")