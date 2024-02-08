File System Integrity Checker

The File System Integrity Checker program allows users to create baselines of given directory trees and run checks against them to monitor changes to files. This program is written in BASH scripting and provides a user-friendly interface for creating baselines, running checks, and generating reports.

How to Run:
To run this program, download or clone it from this repository and execute the main.sh script using:

bash:
Copy code
./main.sh

If administrative privileges are required to access certain files or directories, 
Run:

bash
Copy code
sudo ./main.sh

How It Works

Baseline Creation
The program utilizes a for loop to traverse through directories and sub-directories, identifying files and directories. If a directory is encountered, the function calls itself recursively to continue traversing the directory tree.

Checking Changes
When checking changes, the program reads a previously taken baseline and a newly taken temporary file line by line, and field by field, checking for changes. These changes are flagged based on their priority, and the flags are used to generate a comprehensive report.

Reporting
The program generates an easy-to-read report displaying high priority changes first and low priority changes last. Each bullet point in the report is generated using separate scripts, enhancing readability and understanding.

Scripts Overview
main.sh: Main script providing a user-friendly interface to create baselines, run checks, and generate reports.

baseline_creator.sh: Script for creating baselines of specified directory trees.

run_check.sh: Script for running checks against baseline files to monitor changes.

reporting.sh: Script for generating reports based on the detected changes.

Example Usage
Run ./main.sh.
Select the desired action:
Create Baseline
Run Check
Generate Report
Quit
Note
Ensure that the appropriate permissions are granted to execute the scripts, especially if administrative privileges are required to access certain files or directories.

By following these instructions, users can effectively monitor changes to their file system and maintain its integrity.
