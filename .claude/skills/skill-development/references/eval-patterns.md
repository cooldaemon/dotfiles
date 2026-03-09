# Skill Eval Patterns

Manual process for systematically testing skill quality. No automated tooling required.

## Eval Structure

A skill eval consists of test prompts paired with expected outcomes:

| Component | Description |
|-----------|-------------|
| Test prompt | A realistic user request that should trigger the skill |
| Supporting files | Any files the prompt references (create minimal stubs) |
| Expected outcome | Specific, verifiable criteria for the output |

## Example Eval

### Prompt
"Refactor this function to be more readable"

### Supporting File: src/example.py
```python
def f(x,y,z):
    if x:
        if y:
            if z:
                return True
    return False
```

### Expected Outcome
- Uses guard clauses (early returns)
- Single level of nesting
- Descriptive variable names

## Measurement

Observe these qualities across eval runs:

| Quality | What It Tells You |
|---------|-------------------|
| Pass rate | How often output meets all expected criteria |
| False trigger rate | How often unrelated prompts incorrectly load the skill |
| Consistency | Whether repeated runs produce equivalent quality |

## Comparative Testing

To test whether a skill change is an improvement:

1. Run eval prompts with the **current** skill version
2. Run the same prompts with the **modified** version
3. Compare outputs side-by-side on expected criteria
4. A change is positive only if pass rate improves without regression on other evals

## When to Run Evals

- After modifying SKILL.md content or description
- After a new model release (especially for Capability Uplift skills)
- When adding/removing skills that may overlap
