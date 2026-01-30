---
name: security-patterns
description: Security vulnerability patterns and prevention. Use when writing code that handles user input, authentication, API endpoints, or sensitive data.
---

# Security Patterns

## Vulnerability Patterns (OWASP Top 10)

### Hardcoded Secrets (CRITICAL)
Never hardcode secrets (API keys, passwords, tokens). Always use environment variables or secret management systems.

### SQL Injection (CRITICAL)
Always use parameterized queries. Never use string concatenation with user input in database queries.

### Command Injection (CRITICAL)
Avoid shell execution with user input. Use safe APIs that don't invoke shell. If unavoidable, strictly validate and sanitize input.

### Path Traversal (HIGH)
Never use user input directly in file paths. Always validate and sanitize, use basename, and restrict to allowed directories.

### XSS - Cross-Site Scripting (HIGH)
Always escape/sanitize output. Use framework's built-in escaping. Never insert raw user input into HTML.

### Insecure Password Storage (CRITICAL)
Never use MD5/SHA1 for passwords. Use bcrypt, argon2, or scrypt with appropriate cost factors.

### SSRF - Server-Side Request Forgery (HIGH)
Validate and whitelist URLs before making server-side requests. Never fetch arbitrary user-provided URLs.

### Insecure Deserialization (HIGH)
Never deserialize untrusted data without validation. Use safe serialization formats (JSON) over unsafe ones (pickle, Marshal).

### Race Conditions (CRITICAL for financial operations)
Use database transactions with proper locking for operations that check-then-act on shared resources.

### Missing Rate Limiting (HIGH)
Apply rate limiting to all public endpoints, especially authentication and financial operations.

## Security Tools by Language

### General (All Languages)
```bash
trufflehog filesystem . --json   # Secrets detection
gitleaks detect --source .       # Secrets in git history
semgrep --config auto .          # Pattern-based scanning
```

### TypeScript/JavaScript
```bash
npm audit
npx eslint . --plugin security
```

### Python
```bash
bandit -r .
pip-audit
safety check
```

### Ruby
```bash
brakeman -A
bundle audit check --update
```

### Go
```bash
gosec ./...
govulncheck ./...
```

### ShellScript
```bash
shellcheck *.sh
```

## OWASP Top 10 Checklist

1. **Injection** - Queries parameterized? Input sanitized?
2. **Broken Authentication** - Passwords hashed? Sessions secure?
3. **Sensitive Data Exposure** - HTTPS enforced? Secrets in env vars?
4. **XXE** - XML parsers configured securely?
5. **Broken Access Control** - Authorization checked on every route?
6. **Security Misconfiguration** - Defaults changed? Debug disabled?
7. **XSS** - Output escaped/sanitized?
8. **Insecure Deserialization** - User input deserialized safely?
9. **Vulnerable Components** - Dependencies up to date?
10. **Insufficient Logging** - Security events logged?

## When to Review

**ALWAYS review when:**
- New API endpoints added
- Authentication/authorization code changed
- User input handling added
- Database queries modified
- File operations with user input
- Dependencies updated
