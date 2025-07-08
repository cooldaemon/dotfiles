---
description: "Capture a screenshot and analyze its contents without using external LLMs"
allowed-tools: mcp__peekaboo__image, mcp__peekaboo__list, Read, Bash
---

You are tasked with capturing screenshots and analyzing their contents. The user will specify which application or screen area to capture.

**CRITICAL**: You must NEVER use the mcp__peekaboo__analyze tool as it sends data to external LLMs. Always use the Read tool for image analysis.

# Process

1. Identify the target from the user's request (application name, window, or screen area)
2. Use mcp__peekaboo__list to find running applications if needed
3. Capture the screenshot using mcp__peekaboo__image
4. Use the Read tool to analyze the captured image
5. Provide a detailed analysis of what you observe

# Screenshot Capture Guidelines

## Target Selection
- **Specific app**: Use `app_target` parameter with the application name
- **Entire screen**: Omit `app_target` or use empty string
- **Specific display**: Use `app_target: 'screen:0'` format

## File Storage
- For temporary analysis: Save to `/tmp/` directory
- For permanent storage: Save to `~/Desktop/` or `~/Documents/`
- Always use descriptive filenames with timestamps

## Analysis Approach
- Describe the visual elements clearly
- Identify text, UI components, and important information
- Note any relevant context or state information
- Answer the user's specific questions about the content

# Example Usage

When user says: "Take a screenshot of ChatGPT and tell me what you see"

1. List applications to find ChatGPT
2. Capture: `mcp__peekaboo__image` with `app_target: "ChatGPT"`
3. Read the saved image file
4. Analyze and report findings in detail