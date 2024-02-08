change_check() {
    local baseline_file="./Baselines/${1}_baseline.txt"
    
    # Check if baseline file exists
    if [ ! -f "$baseline_file" ]; then
        echo "Error: Baseline not found for $1."
        return 1
    fi

    echo "Running Check... This may take a moment."

    # Create temp.txt file for comparison
    tempCreate "$1" || return 1

    # Initialize temp_Report.txt or clear existing contents
    > ./Reports/temp_Report.txt

    # Compare baseline with temp.txt
    for (( i = 1; i <= 11; i++ )); do
        spotDiff "$baseline_file" temp.txt $i >> ./Reports/temp_Report.txt
    done

    # Remove temp.txt
    rm temp.txt

    echo "Finished Check! Results are stored in temp_Report.txt."
}

tempCreate() {
    local directory_path=$(find / -name "$1" 2> /dev/null)
    
    # Check if directory exists and baseline exists
    if [ -d "$directory_path" ] && [ -f "./Baselines/${1}_baseline.txt" ]; then
        dirLoop "$directory_path" > temp.txt
    else
        echo "Error: Baseline not found or invalid directory."
        return 1
    fi
}

dirLoop() {
    find "$1" -exec ls -lid {} \;
}

spotDiff() {
    local baseline_file="$1"
    local temp_file="$2"
    local field_num="$3"

    # Compare baseline and temp files line by line
    while read -r baseline_record && read -r temp_record <&3; do
        local baseline_field=$(echo "$baseline_record" | cut -d " " -f "$field_num")
        local temp_field=$(echo "$temp_record" | cut -d " " -f "$field_num")
        local next_temp_field=$(head -n1 <&3 | cut -d " " -f "$field_num")

        # Check for differences
        if [ "$baseline_field" != "$temp_field" ]; then
            # Check if difference is due to deletion
            if [ "$next_temp_field" == "$baseline_field" ]; then
                read -r temp_record <&3  # Skip to next line in temp file
            else
                echo "Change detected in Flag $field_num at: $(echo "$baseline_record" | cut -d " " -f 10)"
            fi
        fi
    done < "$baseline_file" 3< "$temp_file"
}
