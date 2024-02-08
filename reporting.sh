createReport() {
    echo "HIGH PRIORITY CHANGES"
    echo " "
    grep_report() {
        flag="$1"
        description="$2"
        echo "$description Detected"
        grep "Flag $flag " ./Reports/temp_Report.txt | cut -d " " -f 7
        echo " "
    }

    grep_report 1 "Index Number Change"
    grep_report 2 "Privilege Change"
    grep_report 4 "Owner Change"
    grep_report 5 "Group Change"

    echo "MEDIUM PRIORITY CHANGES"
    echo " "
    grep_report 3 "Number of Links Change"
    grep_report 6 "Change in File Size"

    echo "LOW PRIORITY CHANGES"
    echo " "
    grep_report 10 "Last Access Time Change"
    grep_report 11 "Change in Real Path"
}
