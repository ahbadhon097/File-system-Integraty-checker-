# File-system-Integraty-checker-
#!/bin/bash

createBaseline() {
    local directory="$1"
    local baselines_dir="Baselines"

    # Check if the input is a valid directory
    if [ ! -d "$directory" ]; then
        echo "Error: '$directory' is not a valid directory."
        return 1
    fi

    # Create the Baselines directory if it doesn't exist
    mkdir -p "$baselines_dir"

    # Generate a unique filename for the baseline
    local baseline_file="${baselines_dir}/$(basename "${directory}")_baseline.txt"

    # Check if a baseline with the same name already exists
    if [ -e "$baseline_file" ]; then
        echo "Error: A baseline for '$directory' already exists."
        return 1
    fi

    # Write baseline information to the file
    echo "Baseline for directory: $directory" > "$baseline_file"
    echo "---------------------------------" >> "$baseline_file"
    ls -lR "$directory" >> "$baseline_file"

    echo "Baseline created: $baseline_file"
}

# Example usage:
createBaseline "$1"
