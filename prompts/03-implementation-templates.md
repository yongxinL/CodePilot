# Phase 3: Output Templates

> **Usage**: Load only when generating artifacts. Reduces context overhead.

---

## Context Package Template (Failure)

**File**: `./docs/implementation/context-packages/T-X.X.X-failure.md`

```markdown
# Context Package: T-X.X.X Failure

## Meta
| Field | Value |
|-------|-------|
| Created | [Timestamp] |
| Task | T-X.X.X: [Name] |
| Module | M[X]-MOD[Y] |
| Milestone | M[X] |
| Git Branch | [Branch] |
| Git Commit | [Last successful commit SHA] |
| Role | Senior Developer |

---

## Original Task Context

### Objective
[Task objective from task file]

### Acceptance Criteria
| AC ID | Criterion |
|-------|-----------|
| AC-XXX | [Criterion] |

### Technical Notes
[From task file]

---

## Failure Information

### Error Description
```
[Error message / stack trace]
```

### When Occurred
- During: [What step]
- Trigger: [What caused it]

### Symptoms
- [Symptom 1]
- [Symptom 2]

---

## Root Cause Analysis

### Primary Cause
[What fundamentally caused the failure]

### Contributing Factors
1. [Factor 1]
2. [Factor 2]

### Category
- [ ] Environment issue
- [ ] Dependency issue
- [ ] Logic error
- [ ] Design flaw
- [ ] External service failure
- [ ] Insufficient specification

---

## Attempts Made

### Attempt 1: [Description]
- **Action**: [What was tried]
- **Result**: [What happened]
- **Learning**: [What was learned]

### Attempt 2: [Description]
- **Action**: [What was tried]
- **Result**: [What happened]
- **Learning**: [What was learned]

---

## Environment State

### System Info
```bash
# Runtime version
[runtime] --version

# Dependency versions
npm list [relevant-deps]  # or equivalent
```

### Configuration
[Relevant config that might affect the issue]

### External Dependencies
| Service | Status | Notes |
|---------|--------|-------|
| [Service] | [Up/Down] | [Notes] |

---

## Impact Assessment

### Blocked Tasks
| Task | Reason Blocked |
|------|----------------|
| T-X.X.X | Depends on failed task |

### Milestone Impact
- Original Target: [Date]
- Revised Estimate: [Date]
- Delay: [Duration]

### Scope Impact
- [ ] No scope change needed
- [ ] Minor scope adjustment
- [ ] Significant scope change
- [ ] Requires specification update

---

## Suggested Corrective Actions

### Option 1: [Fix and Retry]
**Description**: [What to do]
**Effort**: [Estimate]
**Risk**: Low/Medium/High
**Confidence**: [X]%

**Steps**:
1. [Step 1]
2. [Step 2]

**Git Approach**:
```bash
# Commands to implement fix
```

---

### Option 2: [Alternative Approach]
**Description**: [What to do differently]
**Effort**: [Estimate]
**Risk**: Low/Medium/High
**Confidence**: [X]%

**Trade-offs**:
- Pro: [Pro]
- Con: [Con]

---

### Option 3: [Descope]
**Description**: [What to remove/defer]
**Impact on Specification**: [Changes needed]
**Risk**: Low/Medium/High

---

## Recovery Recommendation

**Recommended Option**: [Option X]

**Rationale**: [Why this option]

**Next Steps**:
1. [Step 1]
2. [Step 2]

---

## Lessons Learned

### For This Project
- [Learning 1]
- [Learning 2]

### For Future Projects
- [Learning 1]
- [Learning 2]

---

## References

- Task File: `./docs/architecture/tasks/[M]/[MOD]/T-X.X.X.md`
- Blueprint: `./docs/architecture/blueprint.md`
- Specification: `./docs/specifications/locked-specification.md#[section]`
- Decision Log: `./docs/implementation/decision-log.md#[entry]`
```

---

## Decision Log Entry Template

**File**: `./docs/implementation/decision-log.md` (append)

```markdown
### [YYYY-MM-DD] - [Decision Title]

**ID**: DEC-[NNN]
**Task**: T-X.X.X
**Commit**: [SHA]
**Role**: Senior Developer

#### Context
[Why this decision was needed - what problem or choice arose]

#### Options Considered

| # | Option | Description |
|---|--------|-------------|
| 1 | [Option A] | [Brief description] |
| 2 | [Option B] | [Brief description] |
| 3 | [Option C] | [Brief description] |

#### Analysis

| Option | Pros | Cons | Effort | Risk |
|--------|------|------|--------|------|
| 1 | [Pros] | [Cons] | [Low/Med/High] | [Low/Med/High] |
| 2 | [Pros] | [Cons] | [Low/Med/High] | [Low/Med/High] |
| 3 | [Pros] | [Cons] | [Low/Med/High] | [Low/Med/High] |

#### Decision
**Selected**: Option [X] - [Name]

#### Rationale
[Why this option was chosen]

#### Consequences
- [Consequence 1 - positive or negative]
- [Consequence 2]

#### Reversibility
- [ ] Easily reversible
- [ ] Reversible with effort
- [ ] Difficult to reverse
- [ ] Irreversible

#### Follow-up Actions
- [ ] [Action if any]

---
```

---

## Estimation Tracking Template

**File**: `./docs/implementation/estimation-tracking.md`

```markdown
# Estimation Tracking

## Meta
| Field | Value |
|-------|-------|
| Created | [Date] |
| Last Updated | [Date] |
| Phase | 3: Implementation |
| Role | Senior Developer |

---

## Summary

| Metric | Value |
|--------|-------|
| Total Estimated | [X] hours |
| Total Actual | [Y] hours |
| Overall Variance | [Z] hours |
| Variance % | [W]% |
| Estimation Accuracy | [A]% |

### Accuracy Calculation
```
Accuracy = 100 - |Variance %|
If Variance = +20%, Accuracy = 80%
If Variance = -10%, Accuracy = 90%
```

---

## By Milestone

| Milestone | Tasks | Est (h) | Actual (h) | Variance | Var % | Status |
|-----------|-------|---------|------------|----------|-------|--------|
| M1 | [X] | [Y] | [Z] | [+/-W] | [%] | ✅/🔄/⏳ |
| M2 | [X] | [Y] | [Z] | [+/-W] | [%] | ✅/🔄/⏳ |
| **Total** | **[X]** | **[Y]** | **[Z]** | **[+/-W]** | **[%]** | |

---

## By Module

| Module | Tasks | Est (h) | Actual (h) | Variance % |
|--------|-------|---------|------------|------------|
| M1-MOD1 | [X] | [Y] | [Z] | [%] |
| M1-MOD2 | [X] | [Y] | [Z] | [%] |

---

## By Task

| Task | Name | Est (h) | Actual (h) | Var (h) | Var % | Notes |
|------|------|---------|------------|---------|-------|-------|
| T-1.1.1 | [Name] | 4 | 5.5 | +1.5 | +37.5% | [Note] |
| T-1.1.2 | [Name] | 2 | 1.5 | -0.5 | -25% | |
| T-1.2.1 | [Name] | 8 | 12 | +4 | +50% | Underestimated complexity |

---

## By Complexity

| Complexity | Count | Avg Est | Avg Actual | Avg Variance |
|------------|-------|---------|------------|--------------|
| Low (<4h) | [X] | [Y]h | [Z]h | [%] |
| Medium (4-8h) | [X] | [Y]h | [Z]h | [%] |
| High (>8h) | [X] | [Y]h | [Z]h | [%] |

---

## Variance Analysis

### Most Underestimated
| Task | Est | Actual | Variance | Reason |
|------|-----|--------|----------|--------|
| T-X.X.X | 4h | 10h | +150% | [Reason] |

### Most Overestimated
| Task | Est | Actual | Variance | Reason |
|------|-----|--------|----------|--------|
| T-X.X.X | 8h | 3h | -62.5% | [Reason] |

### Patterns Observed
1. [Pattern 1 - e.g., "Integration tasks consistently underestimated by 30%"]
2. [Pattern 2]

---

## Calibration Recommendations

### For This Project (Remaining Tasks)
- [Recommendation 1]
- [Recommendation 2]

### For Future Projects
| Task Type | Current Factor | Recommended Factor |
|-----------|----------------|-------------------|
| Backend API | 1.0x | 1.3x |
| Frontend UI | 1.0x | 0.9x |
| Integration | 1.0x | 1.5x |
| Testing | 1.0x | 1.2x |

---

## Time Log Summary

### By Day
| Date | Hours | Tasks Worked |
|------|-------|--------------|
| [Date] | [X] | T-1.1.1, T-1.1.2 |

### By Week
| Week | Hours | Tasks Completed |
|------|-------|-----------------|
| Week 1 | [X] | [Y] |
```

---

## Task Checklist Template

**File**: `./docs/implementation/task-checklist.md`

```markdown
# Task Checklist

## Legend
| Marker | Meaning |
|--------|---------|
| ⏳ | Pending |
| 🔄 | In Progress |
| ✅ | Completed |
| ❌ | Failed |
| 🚫 | Blocked |
| 🔀 | Can Parallelize |

---

## Summary

| Metric | Count | % |
|--------|-------|---|
| Total | [X] | 100% |
| ✅ Completed | [Y] | [%] |
| 🔄 In Progress | [Z] | [%] |
| ⏳ Pending | [W] | [%] |
| ❌ Failed | [V] | [%] |
| 🚫 Blocked | [U] | [%] |

---

## Progress Visualization

```
[████████████░░░░░░░░] 60% Complete
```

---

## M1: [Milestone Name]

**Status**: 🔄 In Progress
**Progress**: [X]/[Y] tasks

### M1-MOD1: [Module Name]

| Task | Description | Status | Est | Actual | Started | Completed | Notes |
|------|-------------|--------|-----|--------|---------|-----------|-------|
| T-1.1.1 🔀 | [Desc] | ✅ | 4h | 5h | [Date] | [Date] | |
| T-1.1.2 🔀 | [Desc] | 🔄 | 2h | — | [Date] | — | In progress |
| T-1.1.3 | [Desc] | ⏳ | 3h | — | — | — | Blocked by T-1.1.2 |

### M1-MOD2: [Module Name]

| Task | Description | Status | Est | Actual | Started | Completed | Notes |
|------|-------------|--------|-----|--------|---------|-----------|-------|
| T-1.2.1 🔀 | [Desc] | ⏳ | 4h | — | — | — | PG-001 |

---

## M2: [Milestone Name]

**Status**: ⏳ Pending
**Progress**: 0/[Y] tasks
**Blocked By**: M1 completion

### M2-MOD1: [Module Name]

| Task | Description | Status | Est | Actual | Started | Completed | Notes |
|------|-------------|--------|-----|--------|---------|-----------|-------|
| T-2.1.1 | [Desc] | ⏳ | 6h | — | — | — | |

---

## Failed Tasks

| Task | Error Summary | Context Package | Recovery Status |
|------|---------------|-----------------|-----------------|
| T-X.X.X | [Brief error] | [Link] | Pending review |

---

## Blocked Tasks

| Task | Blocked By | Unblock Condition |
|------|------------|-------------------|
| T-X.X.X | T-Y.Y.Y | T-Y.Y.Y completion |

---

## Recent Activity

| Date | Task | Action | Duration |
|------|------|--------|----------|
| [Date] | T-1.1.1 | Completed | 5h |
| [Date] | T-1.1.2 | Started | — |
```

---

## Recovery Checkpoint Template (Phase 3)

**File**: `./docs/implementation/.recovery-checkpoint.md`

```markdown
# Recovery Checkpoint

## State
| Field | Value |
|-------|-------|
| Last Updated | [ISO Timestamp] |
| Phase | 3: Implementation |
| Active Role | Senior Developer |
| Skill Tier | [Tier] |

## Git State
| Field | Value |
|-------|-------|
| Branch | [Branch name] |
| Last Commit | [SHA] |
| Uncommitted | [Yes/No] |
| Tag | [Latest tag] |

## Task State
| Field | Value |
|-------|-------|
| Current Task | T-X.X.X |
| Task Status | 🔄 In Progress |
| Tasks Completed | [X]/[Y] |
| Tasks Failed | [Z] |

## Progress Summary
```
M1: [██████░░░░] 60% (3/5 tasks)
M2: [░░░░░░░░░░] 0% (0/4 tasks)
```

## Current Context
[2-3 sentences describing what was being worked on]

## Last Actions
1. [Most recent action]
2. [Previous action]
3. [Earlier action]

## Next Action
[What should happen next]

## Open Items
- [ ] [Open item 1]
- [ ] [Open item 2]

## Recovery Instructions
1. Check git status: `git status`
2. Check last commit: `git log --oneline -3`
3. Load Phase 3 prompt: `./docs/prompts/03-implementation.md`
4. Load current task: `./docs/architecture/tasks/[M]/[MOD]/T-X.X.X.md`
5. Resume from: [Specific step]

## Notes
[Any additional context needed for recovery]
```
