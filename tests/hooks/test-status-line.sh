#!/bin/bash
# Test script for status-line.sh
# Verifies all acceptance criteria from the implementation plan

# Do not use set -e because arithmetic operations like ((PASSED++))
# can return non-zero when incrementing from 0

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
STATUS_LINE_SCRIPT="$REPO_ROOT/.claude/hooks/status-line.sh"

# Colors for test output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

PASSED=0
FAILED=0

# Test helper function
run_test() {
    local test_name="$1"
    local input="$2"
    local expected_pattern="$3"

    if [ ! -x "$STATUS_LINE_SCRIPT" ]; then
        echo -e "${RED}FAIL${NC}: $test_name - status-line.sh not found or not executable"
        ((FAILED++))
        return
    fi

    local output
    output=$(echo "$input" | "$STATUS_LINE_SCRIPT" 2>&1) || true

    if echo "$output" | grep -qE "$expected_pattern"; then
        echo -e "${GREEN}PASS${NC}: $test_name"
        ((PASSED++))
    else
        echo -e "${RED}FAIL${NC}: $test_name"
        echo "  Input: $input"
        echo "  Expected pattern: $expected_pattern"
        echo "  Actual output: $output"
        ((FAILED++))
    fi
}

# Test helper for negative assertions (pattern should NOT match)
run_test_not() {
    local test_name="$1"
    local input="$2"
    local unexpected_pattern="$3"

    if [ ! -x "$STATUS_LINE_SCRIPT" ]; then
        echo -e "${RED}FAIL${NC}: $test_name - status-line.sh not found or not executable"
        ((FAILED++))
        return
    fi

    local output
    output=$(echo "$input" | "$STATUS_LINE_SCRIPT" 2>&1) || true

    if echo "$output" | grep -qE "$unexpected_pattern"; then
        echo -e "${RED}FAIL${NC}: $test_name"
        echo "  Input: $input"
        echo "  Pattern should NOT match: $unexpected_pattern"
        echo "  Actual output: $output"
        ((FAILED++))
    else
        echo -e "${GREEN}PASS${NC}: $test_name"
        ((PASSED++))
    fi
}

echo "=========================================="
echo "Status Line Script Tests"
echo "=========================================="
echo ""

# AC-1.2: WHEN remaining context is 70% or more THE SYSTEM SHALL display the percentage in green (normal)
echo "--- AC-1.2: Green display (70%+ remaining) ---"
run_test "70% shows green, no prompt" \
    '{"context_window":{"remaining_percentage":70}}' \
    "Context: 70%"

run_test "85% shows green, no prompt" \
    '{"context_window":{"remaining_percentage":85}}' \
    "Context: 85%"

run_test "100% shows green, no prompt" \
    '{"context_window":{"remaining_percentage":100}}' \
    "Context: 100%"

run_test_not "70% should NOT contain checkpoint prompt" \
    '{"context_window":{"remaining_percentage":70}}' \
    "checkpoint"

echo ""

# AC-1.3: WHEN remaining context is between 30% and 69% THE SYSTEM SHALL display the percentage in yellow with a prompt to run /checkpoint
echo "--- AC-1.3: Yellow display (30-69% remaining) ---"
run_test "69% shows yellow with Consider /checkpoint" \
    '{"context_window":{"remaining_percentage":69}}' \
    "Context: 69%.*Consider /checkpoint"

run_test "50% shows yellow with Consider /checkpoint" \
    '{"context_window":{"remaining_percentage":50}}' \
    "Context: 50%.*Consider /checkpoint"

run_test "30% shows yellow with Consider /checkpoint" \
    '{"context_window":{"remaining_percentage":30}}' \
    "Context: 30%.*Consider /checkpoint"

echo ""

# AC-1.4: WHEN remaining context is below 30% THE SYSTEM SHALL display the percentage in red with an urgent prompt to run /checkpoint
echo "--- AC-1.4: Red display (<30% remaining) ---"
run_test "29% shows red with urgent checkpoint prompt" \
    '{"context_window":{"remaining_percentage":29}}' \
    "Context: 29%.*Run /checkpoint now"

run_test "10% shows red with urgent checkpoint prompt" \
    '{"context_window":{"remaining_percentage":10}}' \
    "Context: 10%.*Run /checkpoint now"

run_test "1% shows red with urgent checkpoint prompt" \
    '{"context_window":{"remaining_percentage":1}}' \
    "Context: 1%.*Run /checkpoint now"

echo ""

# AC-1.5: WHEN context exceeds 200K tokens THE SYSTEM SHALL indicate extended context mode with [1M] label
echo "--- AC-1.5: Extended context indicator ---"
run_test "Extended context shows [1M] label" \
    '{"context_window":{"remaining_percentage":80},"exceeds_200k_tokens":true}' \
    "Context: 80%.*\[1M\]"

run_test "Normal context does not show [1M] label" \
    '{"context_window":{"remaining_percentage":80},"exceeds_200k_tokens":false}' \
    "Context: 80%"

run_test "Extended context with yellow also shows [1M]" \
    '{"context_window":{"remaining_percentage":50},"exceeds_200k_tokens":true}' \
    "Context: 50%.*\[1M\].*Consider /checkpoint"

run_test "Extended context with red also shows [1M]" \
    '{"context_window":{"remaining_percentage":15},"exceeds_200k_tokens":true}' \
    "Context: 15%.*\[1M\].*Run /checkpoint now"

echo ""

# EC-1: WHEN status line JSON is malformed THE SYSTEM SHALL display "Context: --%" fallback
echo "--- EC-1: Malformed JSON handling ---"
run_test "Malformed JSON shows fallback" \
    '{invalid json' \
    "Context: --%"

run_test "Empty input shows fallback" \
    '' \
    "Context: --%"

echo ""

# EC-2: WHEN context_window fields are missing THE SYSTEM SHALL display fallback without crashing
echo "--- EC-2: Missing fields handling ---"
run_test "Missing context_window shows fallback" \
    '{"other_field":"value"}' \
    "Context: --%"

run_test "Missing remaining_percentage shows fallback" \
    '{"context_window":{}}' \
    "Context: --%"

run_test "Null remaining_percentage shows fallback" \
    '{"context_window":{"remaining_percentage":null}}' \
    "Context: --%"

echo ""

# Additional edge cases
echo "--- Edge Cases ---"
run_test "Decimal percentage is rounded" \
    '{"context_window":{"remaining_percentage":75.7}}' \
    "Context: 75%"

run_test "Zero percentage shows red" \
    '{"context_window":{"remaining_percentage":0}}' \
    "Context: 0%.*Run /checkpoint now"

echo ""
echo "=========================================="
echo "Test Summary"
echo "=========================================="
echo -e "Passed: ${GREEN}$PASSED${NC}"
echo -e "Failed: ${RED}$FAILED${NC}"
echo ""

if [ "$FAILED" -gt 0 ]; then
    echo -e "${RED}Some tests failed!${NC}"
    exit 1
else
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
fi
