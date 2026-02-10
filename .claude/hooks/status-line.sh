#!/bin/bash
# Status line: Display remaining context percentage with color and checkpoint prompt
# Input: JSON from stdin containing context_window information
# Output: Colored status line with checkpoint prompts when context is low

read -r json

# Parse remaining percentage (handle missing/invalid JSON gracefully)
remaining=$(echo "$json" | jq -r '.context_window.remaining_percentage // empty' 2>/dev/null)
extended=$(echo "$json" | jq -r '.exceeds_200k_tokens // false' 2>/dev/null)

# Fallback if remaining is empty, null, or non-numeric
if [ -z "$remaining" ] || [ "$remaining" = "null" ]; then
    echo "Context: --%"
    exit 0
fi

# Round to integer (handle decimals)
remaining_int=${remaining%.*}

# Handle edge case where remaining_int might be empty after truncation
if [ -z "$remaining_int" ]; then
    remaining_int=0
fi

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

# Extended context indicator
ext_label=""
if [ "$extended" = "true" ]; then
    ext_label=" [1M]"
fi

# Determine color and message based on remaining percentage
if [ "$remaining_int" -ge 70 ]; then
    # Normal: green, no prompt
    echo -e "${GREEN}Context: ${remaining_int}%${ext_label}${NC}"
elif [ "$remaining_int" -ge 30 ]; then
    # Warning: yellow, prompt for checkpoint
    echo -e "${YELLOW}Context: ${remaining_int}%${ext_label} - Consider /checkpoint${NC}"
else
    # Critical: red, urgent checkpoint prompt
    echo -e "${RED}Context: ${remaining_int}%${ext_label} - Run /checkpoint now!${NC}"
fi
