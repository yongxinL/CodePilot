# Phase 1: Output Templates

> **Usage**: Load only when generating artifacts. Reduces context overhead.

---

## Competitive Analysis Template

**File**: `./docs/analysis/competitive-analysis.md`

```markdown
# Competitive Analysis

## Meta
| Field | Value |
|-------|-------|
| Created | [Date] |
| Specification | locked-specification-v1.0 |
| Analyst Role | Product Manager + Business Analyst |

## Market Overview
[Brief description of the market space, size, trends]

## Competitors

### [Competitor 1 Name]
| Field | Details |
|-------|---------|
| URL | [Website] |
| Founded | [Year] |
| Funding/Size | [Details] |
| Target Market | [Who they serve] |

**Strengths**:
- [Strength 1]
- [Strength 2]

**Weaknesses**:
- [Weakness 1]
- [Weakness 2]

**Key Features**:
- [Feature 1]
- [Feature 2]

**Pricing**: [Model and pricing]

---

### [Competitor 2 Name]
[Repeat structure]

---

### [Competitor 3 Name]
[Repeat structure]

---

## Competitive Matrix

| Feature | Our Project | Competitor 1 | Competitor 2 | Competitor 3 |
|---------|-------------|--------------|--------------|--------------|
| [Feature A] | ✅ Planned | ✅ | ❌ | ⚠️ Partial |
| [Feature B] | ✅ Planned | ❌ | ✅ | ✅ |
| [Feature C] | ✅ Planned | ⚠️ Partial | ⚠️ Partial | ❌ |

Legend: ✅ Full support | ⚠️ Partial | ❌ Not available

## Differentiation Opportunities

### Gap Analysis
| Gap | Description | Our Approach |
|-----|-------------|--------------|
| [Gap 1] | [What's missing in market] | [How we address it] |
| [Gap 2] | [What's missing in market] | [How we address it] |

### Unique Value Proposition
[One paragraph describing our unique position]

## Threats

| Threat | Likelihood | Impact | Mitigation |
|--------|------------|--------|------------|
| [Threat 1] | High/Med/Low | High/Med/Low | [Strategy] |
| [Threat 2] | High/Med/Low | High/Med/Low | [Strategy] |

## Strategic Recommendations

### Recommended Positioning
[How to position in market]

### Go-to-Market Considerations
1. [Consideration 1]
2. [Consideration 2]

### Features to Prioritize
1. [Feature] - [Rationale]
2. [Feature] - [Rationale]

### Features to Defer
1. [Feature] - [Rationale]
```

---

## Locked Specification Template

**File**: `./docs/specifications/locked-specification-v[X.Y].md`

```markdown
# Locked Specification

## Meta
| Field | Value |
|-------|-------|
| Version | [X.Y] |
| Status | ✅ Locked |
| Created | [Date] |
| Locked Date | [Date] |
| Skill Tier | [Beginner/Advanced/Ninja] |
| Author Role | Product Manager |

## Change Log
| Version | Date | Changes |
|---------|------|---------|
| 1.0 | [Date] | Initial specification |

---

## One-Line Requirement

> [The one-line requirement statement]

---

## Functional Requirements

| ID | Requirement | Priority | Complexity | Notes |
|----|-------------|----------|------------|-------|
| FR-001 | [Description] | High | Medium | |
| FR-002 | [Description] | High | Low | |
| FR-003 | [Description] | Medium | High | |
| FR-004 | [Description] | Medium | Medium | |
| FR-005 | [Description] | Low | Low | |

### Priority Definitions
- **High**: Must have for MVP
- **Medium**: Should have, significant value
- **Low**: Nice to have, can defer

### Complexity Definitions
- **High**: >8 hours estimated, architectural impact
- **Medium**: 4-8 hours estimated
- **Low**: <4 hours estimated

---

## Non-Functional Requirements

| ID | Category | Requirement | Metric | Target | Threshold |
|----|----------|-------------|--------|--------|-----------|
| NFR-001 | Performance | [Description] | Response time | <200ms | <500ms |
| NFR-002 | Performance | [Description] | Throughput | 1000 req/s | 500 req/s |
| NFR-003 | Scalability | [Description] | Concurrent users | 10,000 | 1,000 |
| NFR-004 | Security | [Description] | [Metric] | [Target] | [Threshold] |
| NFR-005 | Reliability | [Description] | Uptime | 99.9% | 99% |
| NFR-006 | Maintainability | [Description] | [Metric] | [Target] | [Threshold] |

---

## Acceptance Criteria

| AC ID | Criterion | Linked Req | Verification | Priority |
|-------|-----------|------------|--------------|----------|
| AC-001 | [Given/When/Then or measurable statement] | FR-001 | Automated Test | High |
| AC-002 | [Given/When/Then or measurable statement] | FR-001, FR-002 | Integration Test | High |
| AC-003 | [Given/When/Then or measurable statement] | NFR-001 | Load Test | High |
| AC-004 | [Given/When/Then or measurable statement] | FR-003 | Manual Review | Medium |

### Verification Methods
- **Automated Test**: Unit or integration test
- **Load Test**: Performance testing
- **Security Scan**: SAST/DAST tools
- **Manual Review**: Human verification
- **Demo**: Stakeholder demonstration

---

## Constraints

### Technical Constraints
| ID | Constraint | Rationale | Impact |
|----|------------|-----------|--------|
| TC-001 | [Constraint] | [Why] | [Effect on design] |
| TC-002 | [Constraint] | [Why] | [Effect on design] |

### Business Constraints
| ID | Constraint | Rationale | Impact |
|----|------------|-----------|--------|
| BC-001 | [Constraint] | [Why] | [Effect on scope] |
| BC-002 | [Constraint] | [Why] | [Effect on timeline] |

### Regulatory Constraints
| ID | Regulation | Requirement | Verification |
|----|------------|-------------|--------------|
| RC-001 | [Regulation] | [What's required] | [How to verify] |

---

## Assumptions

| ID | Assumption | Risk if Invalid | Mitigation |
|----|------------|-----------------|------------|
| A-001 | [Assumption] | [Risk] | [Mitigation] |
| A-002 | [Assumption] | [Risk] | [Mitigation] |

---

## Out of Scope

| Item | Rationale | Future Phase? |
|------|-----------|---------------|
| [Feature/capability] | [Why excluded] | Yes/No |
| [Feature/capability] | [Why excluded] | Yes/No |

---

## Dependencies

### External Dependencies
| Dependency | Type | Risk | Mitigation |
|------------|------|------|------------|
| [Dependency] | API/Service/Library | High/Med/Low | [Strategy] |

### Internal Dependencies
| Dependency | Owner | Status |
|------------|-------|--------|
| [Dependency] | [Team/Person] | Available/Pending |

---

## Glossary

| Term | Definition |
|------|------------|
| [Term] | [Definition] |
| [Term] | [Definition] |

---

## Appendix A: Selected Interpretation Draft

### Draft Selected: [Title]

**Focus**: [Primary emphasis]

**Rationale for Selection**:
[Why this draft was chosen over alternatives]

**Trade-offs Accepted**:
- [Trade-off 1]
- [Trade-off 2]

### Rejected Alternatives

| Draft | Reason for Rejection |
|-------|---------------------|
| [Draft title] | [Reason] |
| [Draft title] | [Reason] |

---

## Appendix B: Stakeholder Sign-off

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Product Owner | | | |
| Technical Lead | | | |
| [Other] | | | |

---

## Document Control

| Action | Allowed | Process |
|--------|---------|---------|
| View | All team members | — |
| Edit | Product Manager only | Create new version |
| Unlock | Requires Phase 5 replan | Document rationale |
```

---

## One-Line Requirements Template

**File**: `./docs/specifications/one-line-requirements.md`

```markdown
# One-Line Requirements

## Current Requirement

> [The finalized one-line requirement]

**Version**: 1.0
**Locked**: [Date]

---

## Evolution History

| Version | Date | Requirement | Reason for Change |
|---------|------|-------------|-------------------|
| 1.0 | [Date] | [Current requirement] | Initial |

---

## Deconstruction

### Solution Type
[What kind of solution is this?]

### Primary Capability
[What is the core function?]

### Target Users
[Who will use this?]

### Key Differentiator
[What makes this unique?]

### Implied Constraints
[What constraints are embedded in this statement?]
```

---

## Recovery Checkpoint Template

**File**: `./docs/implementation/.recovery-checkpoint.md`

```markdown
# Recovery Checkpoint

| Field | Value |
|-------|-------|
| Last Updated | [ISO timestamp] |
| Phase | [1-5] |
| Active Role | [Role name] |
| Current Task | [T-X.X.X or N/A] |
| Git Commit | [SHA or Pending] |
| Git Branch | [Branch name] |
| Skill Tier | [Tier] |

## Context Summary
[2-3 sentences describing current state]

## Recent Actions
1. [Action 1]
2. [Action 2]
3. [Action 3]

## Next Action
[What should happen next]

## Open Decisions
- [Decision 1 if any]
- [Decision 2 if any]

## Blockers
- [Blocker if any]

## Recovery Instructions
1. Read this file
2. Check git status: `git log --oneline -3`
3. Load phase prompt: `./docs/prompts/0[N]-*.md`
4. Resume from [specific step or task]
```
