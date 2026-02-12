# Troubleshooting Guide

Common issues and solutions for skill development.

## Skill Won't Upload

### Error: "Could not find SKILL.md"
**Cause**: File not named exactly `SKILL.md`

**Solution**:
- Rename to `SKILL.md` (case-sensitive)
- Verify: `ls -la` should show `SKILL.md`

### Error: "Invalid frontmatter"
**Cause**: YAML formatting issue

```yaml
# Wrong - missing delimiters
name: my-skill
description: Does things

# Wrong - unclosed quotes
name: my-skill
description: "Does things

# Correct
---
name: my-skill
description: Does things
---
```

### Error: "Invalid skill name"
**Cause**: Name has spaces or capitals

```yaml
# Wrong
name: My Cool Skill

# Correct
name: my-cool-skill
```

## Skill Doesn't Trigger

**Symptom**: Skill never loads automatically

**Quick checklist**:
- Is description too generic? ("Helps with projects" won't work)
- Does it include trigger phrases users would actually say?
- Does it mention relevant file types?

**Debugging**: Ask Claude "When would you use the [skill-name] skill?" - it will quote the description back. Adjust based on what's missing.

## Skill Triggers Too Often

**Symptom**: Skill loads for unrelated queries

**Solutions**:

1. **Add negative triggers**:
```yaml
description: Advanced data analysis for CSV files. Use for statistical modeling, regression, clustering. Do NOT use for simple data exploration.
```

2. **Be more specific**:
```yaml
# Too broad
description: Processes documents

# Better
description: Processes PDF legal documents for contract review
```

3. **Clarify scope**:
```yaml
description: PayFlow payment processing for e-commerce. Use specifically for online payment workflows, not general financial queries.
```

## Instructions Not Followed

**Symptom**: Skill loads but Claude doesn't follow instructions

**Causes and fixes**:

1. **Instructions too verbose**
   - Keep concise, use bullet points
   - Move details to references/

2. **Instructions buried**
   - Put critical rules at TOP
   - Use `## Critical` or `## Important` headers

3. **Ambiguous language**
```markdown
# Bad
Make sure to validate things properly

# Good
CRITICAL: Before calling create_project, verify:
- Project name is non-empty
- At least one team member assigned
- Start date is not in the past
```

4. **Consider validation scripts**
   - For critical validations, code is deterministic
   - Language interpretation varies

## Large Context Issues

**Symptom**: Skill seems slow or responses degraded

**Causes**:
- SKILL.md content too large
- Too many skills enabled (>20-50)
- All content loaded instead of progressive disclosure

**Solutions**:

1. **Optimize SKILL.md size**
   - Move detailed docs to references/
   - Link to references instead of inline
   - Keep SKILL.md under 5,000 words

2. **Reduce enabled skills**
   - Evaluate if you have >20-50 skills enabled
   - Consider skill "packs" for related capabilities
