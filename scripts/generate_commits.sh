#!/bin/bash

# Calculate dates
END_DATE="2024-06-10"  # Your G2 start date
START_DATE=$(date -v-150d -j -f "%Y-%m-%d" "$END_DATE" "+%Y-%m-%d")

# Development phases
declare -a PHASES=(
    "Initial project setup"
    "Basic layout and navigation"
    "About page development"
    "Projects page creation"
    "Contact page implementation"
    "Dark mode implementation"
    "Responsive design improvements"
    "Animation additions"
    "QR code feature"
    "Performance optimizations"
    "Content updates"
    "Bug fixes and refinements"
)

# Function to make a change to a file
make_change() {
    echo "// Update for commit on $1" >> temp_changes.txt
    echo "console.log('Development update: $2');" >> app/javascript/application.js
}

# Function to commit with a specific date
make_commit() {
    local date=$1
    local message=$2
    
    # Make some changes
    make_change "$date" "$message"
    
    # Set commit date
    export GIT_AUTHOR_DATE="$date"
    export GIT_COMMITTER_DATE="$date"
    
    # Stage and commit
    git add .
    git commit -m "$message" --date="$date"
}

# Initialize repository if needed
if [ ! -d .git ]; then
    git init
    git config --local user.name "Deepan Kumar"
    git config --local user.email "deepan.ppgit@gmail.com"
fi

# Generate commits
current_date=$START_DATE
phase_index=0
commit_count=0

while [ "$current_date" != "$END_DATE" ]; do
    # Random number of commits per day (0-3)
    daily_commits=$((RANDOM % 4))
    
    for ((i=0; i<daily_commits; i++)); do
        phase=${PHASES[$((phase_index % ${#PHASES[@]}))]}
        
        # Generate commit message
        message="$phase: "
        case $((RANDOM % 5)) in
            0) message+="Add new features and improvements";;
            1) message+="Update styling and layout";;
            2) message+="Fix responsive design issues";;
            3) message+="Enhance user experience";;
            4) message+="Optimize performance";;
        esac
        
        # Make commit with changes
        make_commit "$current_date 12:00:00 +0530" "$message"
        
        commit_count=$((commit_count + 1))
        if [ $((commit_count % 10)) -eq 0 ]; then
            phase_index=$((phase_index + 1))
        fi
    done
    
    # Move to next day
    current_date=$(date -v+1d -j -f "%Y-%m-%d" "$current_date" "+%Y-%m-%d")
done

echo "Generated $commit_count commits from $START_DATE to $END_DATE" 