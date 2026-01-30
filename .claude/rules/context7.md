# context7 Usage

Use context7 to verify documentation when:
- Writing code with library-specific APIs that may have changed
- Uncertain about correct usage patterns or configuration
- User explicitly requests documentation verification

Do NOT use for:
- Well-established, stable APIs (basic JavaScript, SQL, HTTP)
- Simple operations Claude confidently knows
- Internal/project-specific code

## Workflow

1. `resolve-library-id` - Find the library ID first
2. `query-docs` - Query with specific question
3. If no results, use WebFetch for official documentation
