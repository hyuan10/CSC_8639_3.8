import tobii_research as tr
import csv
import time


## Finds the Eye tracker
found_eyetrackers = tr.find_all_eyetrackers()

## Prints out Information of the eye tracker
my_eyetracker = found_eyetrackers[0]
print("Address: " + my_eyetracker.address)
print("Model: " + my_eyetracker.model)
print("Name (It's OK if this is empty): " + my_eyetracker.device_name)
print("Serial number: " + my_eyetracker.serial_number)

## Callback function for data
def gaze_data_callback(gaze_data):
    ## Print gaze points of left and right eye
    print("Left eye: ({gaze_left_eye}) \t Right eye: ({gaze_right_eye})".format(
        gaze_left_eye=gaze_data['left_gaze_point_on_display_area'],
        gaze_right_eye=gaze_data['right_gaze_point_on_display_area']))

    ## Save gaze data to CSV
    save_gaze_data_to_csv(gaze_data)


## Save data function
def save_gaze_data_to_csv(gaze_data):
    timestamp = time.strftime("%Y%m%d_%H%M%S")  ## Generate timestamp
    folder_path = "/Users/harvey/IdeaProjects/CSC_8639_3.8/Gaze Data" ## Specify folder path for data
    filename = f"{folder_path}/gaze_data_{timestamp}.csv" ## File name with the folderpath and timestamp

    ## Extract gaze points
    gaze_left_eye = gaze_data['left_gaze_point_on_display_area']
    gaze_right_eye = gaze_data['right_gaze_point_on_display_area']

    ## Save gaze data to CSV
    with open(filename, mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(['Left Eye X', 'Left Eye Y', 'Right Eye X', 'Right Eye Y'])
        writer.writerow([gaze_left_eye[0], gaze_left_eye[1], gaze_right_eye[0], gaze_right_eye[1]])

## Subscribe to data
my_eyetracker.subscribe_to(tr.EYETRACKER_GAZE_DATA, gaze_data_callback, as_dictionary=True)

## Time interval
time.sleep(10)

## Unsubscribe from data
my_eyetracker.unsubscribe_from(tr.EYETRACKER_GAZE_DATA, gaze_data_callback)
