---
name: ears-format
description: EARS (Easy Approach to Requirements Syntax) format for writing testable acceptance criteria. Used by planning and testing agents.
---

# EARS Format for Acceptance Criteria

EARS (Easy Approach to Requirements Syntax) provides patterns for writing clear, testable acceptance criteria.

## WHEN Pattern (Event-driven)

Use for user actions and triggered behaviors.

```
WHEN <trigger/condition>
THE SYSTEM SHALL <expected behavior>
```

**Example:**
```
WHEN user clicks the submit button
THE SYSTEM SHALL validate all form fields
```

## IF Pattern (Conditional)

Use for state-based conditions and logical branching.

```
IF <precondition/state>
THEN THE SYSTEM SHALL <response>
```

**Example:**
```
IF user is not authenticated
THEN THE SYSTEM SHALL redirect to login page
```

## WHILE Pattern (Continuous)

Use for ongoing behaviors and continuous conditions.

```
WHILE <ongoing condition>
THE SYSTEM SHALL <continuous behavior>
```

**Example:**
```
WHILE file upload is in progress
THE SYSTEM SHALL display progress indicator
```

## WHERE Pattern (Contextual)

Use for context-dependent and environmental conditions.

```
WHERE <context/environment>
THE SYSTEM SHALL <contextual behavior>
```

**Example:**
```
WHERE user has admin role
THE SYSTEM SHALL display admin controls
```

## Compound Pattern

Combine patterns for complex requirements.

```
WHEN <event> AND <additional condition>
THEN THE SYSTEM SHALL <response>
```

**Example:**
```
WHEN user submits form AND validation passes
THEN THE SYSTEM SHALL save data and show success message
```

## Pattern Selection Guide

| Pattern | Use When |
|---------|----------|
| **WHEN** | Event-driven behaviors, user actions |
| **IF** | State-based conditions, logical branching |
| **WHILE** | Continuous behaviors, ongoing conditions |
| **WHERE** | Context-dependent, environmental conditions |

## Converting EARS to Gherkin

EARS acceptance criteria map directly to Gherkin scenarios:

```
EARS:
  WHEN user submits form with invalid email
  THE SYSTEM SHALL display error message

Gherkin:
  Scenario: Form validation for invalid email
    Given I am on the registration page
    When I enter "invalid-email" as email
    And I submit the form
    Then I should see "Please enter a valid email" error
```
