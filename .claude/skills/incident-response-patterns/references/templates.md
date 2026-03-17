# Incident Response Templates and Reference Data

## Runbook Template Structure

| Section | Contents |
|---------|----------|
| Quick Reference | Service name, owner team, on-call link, dashboard links, last tested date |
| Detection | Alert name, user-visible symptoms, false positive check |
| Diagnosis | Step-by-step health checks, error rate review, recent deployment check, dependency health |
| Remediation | Options ordered by preference: rollback, restart, scale up, failover, feature flag |
| Verification | Error rate at baseline, latency within SLO, no new alerts for 10 min, manual functionality check |
| Communication | Internal channel update, external status page update, post-mortem creation deadline |

### Runbook Maintenance

- Test runbooks quarterly -- an untested runbook is a false sense of security
- Document tribal knowledge into runbooks -- never rely on a single person's knowledge
- Track which runbook steps actually resolve issues vs which are outdated ceremony

## Post-Mortem Template

### Required Sections

1. **Executive Summary**: 2-3 sentences covering what happened, who was affected, how resolved
2. **Impact Assessment**: Users affected, revenue impact, SLO budget consumed, support tickets
3. **Timeline (UTC)**: Timestamped sequence from detection to all-clear
4. **Root Cause Analysis**:
   - Immediate cause (direct trigger)
   - Underlying cause (why the trigger was possible)
   - Systemic cause (organizational/process gap)
   - 5 Whys drill-down to root systemic issue
5. **What Went Well**: Processes and tools that helped during response
6. **What Went Poorly**: Gaps that slowed detection or resolution
7. **Action Items**: Each with ID, description, owner, priority (P1-P4), due date, status
8. **Lessons Learned**: Key takeaways for future architecture and process decisions

### Post-Mortem Deadlines

- Schedule within 48 hours while memory is fresh
- All SEV1/SEV2 incidents must produce a post-mortem
- Track action items to completion -- a post-mortem without follow-through is just a meeting

## Burn Rate Alert Thresholds

| Alert Severity | Short Window | Long Window | Burn Rate | Budget Exhaustion |
|---------------|-------------|-------------|-----------|-------------------|
| Page (immediate) | 5 min | 1 hour | 14.4x | ~2 hours |
| Ticket (next shift) | 30 min | 6 hours | 6x | ~5 days |

Multi-window burn rate alerts reduce false positives: the short window catches fast burns, the long window confirms sustained impact.

## Stakeholder Communication Cadence

| Severity | Initial Notification | Update Frequency | Audiences |
|----------|---------------------|------------------|-----------|
| SEV1 | Immediate | Every 15 min | Engineering, executives, affected customers |
| SEV2 | Within minutes | Every 30 min | Engineering, eng management |
| SEV3 | Within hours | Every 2 hours | Owning team |
| SEV4 | Next business day | Daily | Backlog triage |

### Communication Principles

- Communicate status updates at fixed intervals, even if the update is "no change, still investigating"
- Be specific about impact: quantify affected users, failing transactions, degraded metrics
- Be honest about uncertainty: state what has been ruled out and what is being investigated next
