# Agent Orchestration

## Immediate Agent Usage

No user prompt needed - use proactively:

| Trigger | Agent |
|---------|-------|
| Complex feature requests | **planner** |
| Code just written/modified | **code-reviewer** |
| Bug fix or new feature | **tdd-guide** |
| Architectural decision | **architect** |
| Build fails | **build-error-resolver** |
| Security concerns | **security-reviewer** |
| Database changes | **database-reviewer** |

## Build Troubleshooting

If build fails:
1. Use **build-error-resolver** agent
2. Analyze error messages
3. Fix incrementally
4. Verify after each fix

## Parallel Task Execution

ALWAYS use parallel Task execution for independent operations:

```markdown
# GOOD: Parallel execution
Launch 3 agents in parallel:
1. Agent 1: Security analysis
2. Agent 2: Code review
3. Agent 3: Type checking

# BAD: Sequential when unnecessary
First agent 1, then agent 2, then agent 3
```

## Multi-Perspective Analysis

For complex problems, use split role sub-agents:
- Security expert
- Senior engineer
- Consistency reviewer
