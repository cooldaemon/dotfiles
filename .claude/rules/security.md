# Security

## Response Protocol

If security issue found during any work:
1. STOP immediately
2. Use **security-reviewer** agent
3. Fix CRITICAL issues before continuing
4. Rotate any exposed secrets

## Quick Check (Before Commit)

- No hardcoded secrets (API keys, passwords, tokens)
- All user inputs validated
- Error messages don't leak sensitive data

For comprehensive security patterns, the `security-patterns` skill is loaded by reviewers automatically.
