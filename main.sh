#!/bin/bash

welcome_message() {
    echo "Welcome to your at-home File Integrity Checker!"
}

print_menu() {
    echo "What would you like to do today?"
    echo "1. Create Baseline"
    echo "2. Run Check"
    echo "3. Generate Report"
    echo "q. Quit"
}

create_baseline() {
    echo "Please enter the directory to create a baseline of: "
    read -r dir
    source ./baseline_creator.sh "$dir"
}

run_check() {
    echo "WARNING: Running a check will destroy any data stored in the temp_Reports file."
    echo "Do you wish to continue? (y/n)"
    read -r ans
    if [[ "$ans" == "y" ]]; then
        echo "Please enter the directory you want to check: "
        read -r dir
        source ./run_check.sh "$dir"
    fi
}

generate_report() {
    echo "Would you like to create a report from your temp_Reports file? (y/n)"
    read -r ans
    if [[ "$ans" == "y" ]]; then
        echo "Please name your report: "
        read -r name
        source ./reporting.sh "./Reports/temp_Report.txt" > "./Reports/$name"
    fi
}

main() {
    welcome_message

    while true; do
        print_menu

        read -r opt

        case $opt in
            1) create_baseline ;;
            2) run_check ;;
            3) generate_report ;;
            q) echo "Exiting..."; exit ;;
            *) echo "Invalid option. Please choose again." ;;
        esac
    done
}

main
