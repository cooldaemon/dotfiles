# Workflow Patterns

Five common patterns for skill design, based on Anthropic's official guide.

## Pattern 1: Sequential Workflow Orchestration

**Use when**: Multi-step processes requiring specific order.

```markdown
## Workflow: Customer Onboarding

### Step 1: Create Account
Call MCP tool: `create_customer`
Parameters: name, email, company

### Step 2: Setup Payment
Call MCP tool: `setup_payment_method`
Wait for: payment verification

### Step 3: Create Subscription
Call MCP tool: `create_subscription`
Parameters: plan_id, customer_id (from Step 1)
```

**Key techniques**:
- Explicit step ordering
- Dependencies between steps
- Validation at each stage
- Rollback instructions for failures

## Pattern 2: Multi-MCP Coordination

**Use when**: Workflows span multiple services.

```markdown
# Design-to-Development Handoff

## Phase 1: Design Export (Figma MCP)
1. Export design assets
2. Generate specifications
3. Create asset manifest

## Phase 2: Asset Storage (Drive MCP)
1. Create project folder
2. Upload assets
3. Generate shareable links

## Phase 3: Task Creation (Linear MCP)
1. Create development tasks
2. Attach asset links
3. Assign to team
```

**Key techniques**:
- Clear phase separation
- Data passing between MCPs
- Validation before next phase

## Pattern 3: Iterative Refinement

**Use when**: Output quality improves with iteration.

```markdown
## Report Generation

### Initial Draft
1. Fetch data via MCP
2. Generate first draft
3. Save to temporary file

### Quality Check
Run validation: `scripts/check_report.py`
Identify issues:
- Missing sections
- Inconsistent formatting
- Data validation errors

### Refinement Loop
1. Address each issue
2. Regenerate affected sections
3. Re-validate
4. Repeat until quality threshold met
```

**Key techniques**:
- Explicit quality criteria
- Iterative improvement
- Validation scripts
- Know when to stop

## Pattern 4: Context-Aware Tool Selection

**Use when**: Same outcome, different tools based on context.

```markdown
## Smart File Storage

### Decision Tree
1. Check file type and size
2. Determine best storage:
   - Large files (>10MB): Cloud storage MCP
   - Collaborative docs: Notion/Docs MCP
   - Code files: GitHub MCP
   - Temporary files: Local storage

### Execute
- Call appropriate MCP tool
- Apply service-specific metadata
- Generate access link
```

**Key techniques**:
- Clear decision criteria
- Fallback options
- Transparency about choices

## Pattern 5: Domain-Specific Intelligence

**Use when**: Skill adds specialized knowledge beyond tool access.

```markdown
## Payment Processing with Compliance

### Before Processing (Compliance Check)
1. Fetch transaction details
2. Apply compliance rules:
   - Check sanctions lists
   - Verify jurisdiction
   - Assess risk level
3. Document decision

### Processing
IF compliance passed:
  - Process transaction
  - Apply fraud checks
ELSE:
  - Flag for review
  - Create compliance case

### Audit Trail
- Log all compliance checks
- Record decisions
- Generate audit report
```

**Key techniques**:
- Domain expertise in logic
- Compliance before action
- Comprehensive documentation
