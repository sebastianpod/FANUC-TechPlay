import cv2
import numpy as np
import json # To store and load calibration data

# --- Helper Functions ---
def sort_points_clockwise(pts):
    """Sorts detected points (rectangle vertices) in a clockwise manner."""
    pts = np.array(pts)
    center = np.mean(pts, axis=0)
    # Calculate angles relative to the center. arctan2(y, x) gives angle in range (-pi, pi].
    # Angles increase counter-clockwise. Sorting them and then reversing or
    # using a specific order (e.g., top-left, top-right, bottom-right, bottom-left)
    # is crucial. For this simple case, direct sorting of angles usually works for convex shapes.
    angles = np.arctan2(pts[:, 1] - center[1], pts[:, 0] - center[0])
    sorted_indices = np.argsort(angles)
    sorted_pts = pts[sorted_indices]
    return sorted_pts.tolist()

def calculate_scales(sorted_pixels, object_width_mm_robot_X, object_height_mm_robot_Y):
    """
    Calculates mm/pixel scales for Robot X and Y axes based on detected rectangle vertices
    and its real-world dimensions. Accounts for axis swapping between camera and robot.

    Args:
        sorted_pixels (list): List of (x, y) pixel coordinates of the 4 detected rectangle vertices, sorted.
        object_width_mm_robot_X (float): The real width of the calibration object along the Robot X-axis (e.g., 300.0).
        object_height_mm_robot_Y (float): The real height of the calibration object along the Robot Y-axis (e.g., 250.0).

    Returns:
        tuple: (mm_per_pixel_for_robot_X, mm_per_pixel_for_robot_Y)
    """
    # Find extreme pixel values for the rectangle's extent
    min_pixel_x = min(p[0] for p in sorted_pixels)
    max_pixel_x = max(p[0] for p in sorted_pixels)
    
    min_pixel_y = min(p[1] for p in sorted_pixels)
    max_pixel_y = max(p[1] for p in sorted_pixels)

    # Calculate the rectangle's extent in pixels
    pixel_range_x = max_pixel_x - min_pixel_x  # Pixel width of the detected rectangle
    pixel_range_y = max_pixel_y - min_pixel_y  # Pixel height of the detected rectangle

    # Calculate scales with axis swapping and negative sign (as determined previously)
    # Robot X-axis scale is derived from pixel Y-axis range
    mm_per_pixel_for_robot_X = -(object_width_mm_robot_X / pixel_range_y)
    
    # Robot Y-axis scale is derived from pixel X-axis range
    mm_per_pixel_for_robot_Y = -(object_height_mm_robot_Y / pixel_range_x)

    return mm_per_pixel_for_robot_X, mm_per_pixel_for_robot_Y

# --- Main Calibration Program ---
if __name__ == "__main__":
    print("--- Vision System Calibration ---")
    print("Please provide the following information for calibration.")
    print("Note: This program assumes you are using a rectangular calibration object.")
    print("It also assumes the camera is perpendicular to the object plane and has no lens distortion.")
    print("---------------------------------")

    # --- User Input for Calibration ---
    image_file_path = input("Enter the path to the calibration image: ")
    robot_calibration_object_width_mm = float(input("Enter the real width of the calibration object (in mm, along Robot X-axis): "))
    robot_calibration_object_height_mm = float(input("Enter the real length of the calibration object (in mm, along Robot Y-axis): "))
    origin_uframe_pixel_x = float(input("Enter the pixel X coordinate of Robot User Frame (0,0,0) origin (Hz from Fanuc): "))
    origin_uframe_pixel_y = float(input("Enter the pixel Y coordinate of Robot User Frame (0,0,0) origin (Vt from Fanuc): "))

    # --- Load Image ---
    # Simplified error handling for presentation purposes
    image = cv2.imread(image_file_path, cv2.IMREAD_GRAYSCALE)
    # In a real application, you'd add: if image is None: print("Error loading image") and exit

    # --- Image Processing: Detect Rectangle Vertices ---
    _, threshold = cv2.threshold(image, 127, 255, cv2.THRESH_BINARY_INV)
    contours, _ = cv2.findContours(threshold, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

    # Simplified error handling for presentation purposes
    contour = max(contours, key=cv2.contourArea) # Assumes at least one contour
    epsilon = 0.01 * cv2.arcLength(contour, True)
    approx = cv2.approxPolyDP(contour, epsilon, True)
    points = [tuple(pt[0]) for pt in approx]

    # Sort points for consistent order (e.g., clockwise starting from top-left)
    sorted_points_pixel = sort_points_clockwise(points)

    print("\n--- Detected Rectangle Vertices in Pixels (Sorted) ---")
    for i, pt_pixel in enumerate(sorted_points_pixel):
        print(f"Vertex {i}: {pt_pixel}")

    # --- Calculate Calibration Parameters ---
    calculated_mm_per_pixel_robot_x, calculated_mm_per_pixel_robot_y = \
        calculate_scales(sorted_points_pixel, robot_calibration_object_width_mm, robot_calibration_object_height_mm)

    print("\n--- Calculated Calibration Parameters ---")
    print(f"Scale for Robot X (depends on pixel Y): {calculated_mm_per_pixel_robot_x:.6f} mm/pix")
    print(f"Scale for Robot Y (depends on pixel X): {calculated_mm_per_pixel_robot_y:.6f} mm/pix")
    print(f"Pixel origin of Robot User Frame (0,0,0): X={origin_uframe_pixel_x}, Y={origin_uframe_pixel_y}")

    # --- Save Calibration Data to a JSON file ---
    calibration_data = {
        "mm_per_pixel_robot_x": calculated_mm_per_pixel_robot_x,
        "mm_per_pixel_robot_y": calculated_mm_per_pixel_robot_y,
        "origin_uframe_pixel_x": origin_uframe_pixel_x,
        "origin_uframe_pixel_y": origin_uframe_pixel_y,
        "origin_uframe_robot_x": 0.0, # Always 0.0 for the origin of the User Frame
        "origin_uframe_robot_y": 0.0, # Always 0.0 for the origin of the User Frame
        "origin_uframe_robot_z_plane": 0.0 # Assuming Z=0.0 on the measurement plane
    }

    calibration_file_name = "calibration_data.json"
    with open(calibration_file_name, 'w') as f:
        json.dump(calibration_data, f, indent=4)
    print(f"\nCalibration data saved to '{calibration_file_name}'")

    # --- Optional: Verify with Calculated Points for Presentation ---
    print("\n--- Verification: Transformed Calibration Points to Robot User Frame ---")
    print(f"Robot User Frame (0,0,0) corresponds to pixel ({origin_uframe_pixel_x}, {origin_uframe_pixel_y})\n")

    # Re-using the pixel_to_robot_coords logic for verification output
    # (defined directly here for self-contained verification)
    def verify_pixel_to_robot_coords(px, py, scale_rx, scale_ry, origin_px, origin_py, origin_rx, origin_ry, origin_rz):
        delta_px = px - origin_px
        delta_py = py - origin_py
        robot_x = origin_rx + (delta_py * scale_rx) # Swapped
        robot_y = origin_ry + (delta_px * scale_ry) # Swapped
        return robot_x, robot_y, origin_rz

    for pt_pixel in sorted_points_pixel:
        robot_x_ver, robot_y_ver, robot_z_ver = verify_pixel_to_robot_coords(
            pt_pixel[0], pt_pixel[1],
            calculated_mm_per_pixel_robot_x, calculated_mm_per_pixel_robot_y,
            origin_uframe_pixel_x, origin_uframe_pixel_y,
            0.0, 0.0, 0.0 # Robot origin is 0,0,0
        )
        print(f"Pixel ({pt_pixel[0]}, {pt_pixel[1]}) -> Robot ({robot_x_ver:.3f}, {robot_y_ver:.3f}, {robot_z_ver:.3f})")

    print("\nCalibration complete.")