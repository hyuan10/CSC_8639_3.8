import tobii_research as tr
import csv
import time


def run_eye_tracking():
    # Finds the Eye tracker
    found_eyetrackers = tr.find_all_eyetrackers()
    my_eyetracker = found_eyetrackers[0]

    # Create CSV file and writer for main CSV
    #folder_path = "/Users/harvey/IdeaProjects/CSC_8639_3.8/Plot Data/data/PNL"
    #folder_path = "/Users/harvey/IdeaProjects/CSC_8639_3.8/Plot Data/data/Sankey"
    folder_path = "/Users/harvey/IdeaProjects/CSC_8639_3.8/Plot Data/data/Waterfall"
    main_filename = f"{folder_path}/gaze_data.csv"
    main_csv_file = open(main_filename, mode='a', newline='')
    main_writer = csv.writer(main_csv_file)

    # Read counter from the file or initialize to 0
    counter_file = f"{folder_path}/counter.txt"
    try:
        with open(counter_file, 'r') as f:
            counter = int(f.read())
    except FileNotFoundError:
        counter = 0

    # Create standalone CSV file and writer
    timestamp = time.strftime("%Y%m%d_%H%M%S")
    standalone_filename = f"{folder_path}/gaze_data_{counter:03}_{timestamp}.csv"
    standalone_csv_file = open(standalone_filename, mode='w', newline='')
    standalone_writer = csv.writer(standalone_csv_file)
    standalone_writer.writerow(['Left Eye X', 'Left Eye Y', 'Right Eye X', 'Right Eye Y'])

    # Callback function for data
    def gaze_data_callback(gaze_data):
        # Print gaze points of left and right eye
        print("Left eye: ({gaze_left_eye}) \t Right eye: ({gaze_right_eye})".format(
            gaze_left_eye=gaze_data['left_gaze_point_on_display_area'],
            gaze_right_eye=gaze_data['right_gaze_point_on_display_area']))

        # Save gaze data to main CSV
        save_gaze_data_to_csv(gaze_data, main_writer)

        # Save gaze data to standalone CSV
        save_gaze_data_to_csv(gaze_data, standalone_writer)

    # Save data function
    def save_gaze_data_to_csv(gaze_data, writer):
        # Extract gaze points
        gaze_left_eye = gaze_data['left_gaze_point_on_display_area']
        gaze_right_eye = gaze_data['right_gaze_point_on_display_area']

        # Save gaze data to CSV
        writer.writerow([gaze_left_eye[0], gaze_left_eye[1], gaze_right_eye[0], gaze_right_eye[1]])

    # Subscribe to data
    my_eyetracker.subscribe_to(tr.EYETRACKER_GAZE_DATA, gaze_data_callback, as_dictionary=True)

    # Time interval
    time.sleep(20)

    # Unsubscribe from data
    my_eyetracker.unsubscribe_from(tr.EYETRACKER_GAZE_DATA, gaze_data_callback)

    # Increment the counter
    counter += 1

    # Write the counter value to the file
    with open(counter_file, 'w') as f:
        f.write(str(counter))

    # Close the main CSV file
    main_csv_file.close()

    # Close the standalone CSV file
    standalone_csv_file.close()


# Wait for Enter key press
input("Press Enter to start eye tracking...")

# Run the eye tracking code
run_eye_tracking()
