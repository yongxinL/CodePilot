# Phase 5: Output Templates

> **Usage**: Load only when generating artifacts. Reduces context overhead.

---

## PROJECT-SUMMARY Template

**File**: `./docs/PROJECT-SUMMARY.md`

```markdown
# Project Summary

## Overview
| Field | Value |
|-------|-------|
| Project | [Project Name] |
| Description | [One-line description] |
| Created | [Date] |
| Latest Release | v[X.Y.Z] |

---

## Latest Release

| Field | Value |
|-------|-------|
| Version | v[X.Y.Z] |
| Released | [Date] |
| Branch | main |
| Tag | v[X.Y.Z] |

### Release Highlights
- [Highlight 1]
- [Highlight 2]

---

## Artifacts

### Specifications
| Version | Status | Link |
|---------|--------|------|
| v1.0 | Active | [locked-specification-v1.0.md](./specifications/locked-specification-v1.0.md) |

### Architecture
| Version | Status | Link |
|---------|--------|------|
| v1.0 | Active | [blueprint-v1.0.md](./architecture/blueprint-v1.0.md) |

### Verification
| Version | Decision | Link |
|---------|----------|------|
| v[X.Y.Z] | GO | [evidence](./verification/evidence-packages/v[X.Y.Z]-evidence.md) |

---

## Quick Links

| Document | Description |
|----------|-------------|
| [CHANGELOG](./CHANGELOG.md) | Version history |
| [Specification](./specifications/locked-specification.md) | Current requirements |
| [Blueprint](./architecture/blueprint.md) | Current architecture |
| [Task Index](./architecture/tasks/_index.md) | All tasks |
| [Decision Log](./implementation/decision-log.md) | Design decisions |
| [Rollback SOP](./release/rollback-sop.md) | Emergency procedures |

---

## Statistics

### Effort
| Metric | Value |
|--------|-------|
| Total Estimated | [X] hours |
| Total Actual | [Y] hours |
| Variance | [Z]% |
| Estimation Accuracy | [W]% |

### Tasks
| Status | Count |
|--------|-------|
| ✅ Completed | [X] |
| ❌ Failed | [Y] |
| Total | [Z] |

### Quality
| Metric | Value |
|--------|-------|
| Test Coverage | [X]% |
| Tests Passing | [Y]/[Z] |
| Security Issues | [W] |

---

## Release History

| Version | Date | Highlights |
|---------|------|------------|
| v[X.Y.Z] | [Date] | [Summary] |

---

## Team (if Team Mode)

| Role | Member |
|------|--------|
| Product Manager | [Name] |
| Software Architect | [Name] |
| Senior Developer | [Name] |
| QA Lead | [Name] |
| Release Manager | [Name] |

---

## Lessons Learned Summary

### What Worked Well
- [Item 1]
- [Item 2]

### Areas for Improvement
- [Item 1]
- [Item 2]

### Key Insights
- [Insight 1]
- [Insight 2]
```

---

## Lessons Learned Template

**File**: `./docs/release/lessons-learned.md`

```markdown
# Lessons Learned

## Release: v[X.Y.Z]
**Date**: [Date]
**Role**: Release Manager + Project Manager

---

## Executive Summary

[2-3 sentences summarizing the release and key learnings]

---

## What Went Well

### Process
- [Process success 1]
- [Process success 2]

### Technical
- [Technical success 1]
- [Technical success 2]

### Team (if applicable)
- [Team success 1]
- [Team success 2]

---

## What Could Improve

### Process
| Issue | Impact | Recommendation |
|-------|--------|----------------|
| [Issue] | [Impact] | [Recommendation] |

### Technical
| Issue | Impact | Recommendation |
|-------|--------|----------------|
| [Issue] | [Impact] | [Recommendation] |

### Estimation
| Pattern | Occurrence | Adjustment |
|---------|------------|------------|
| [Pattern] | [X] times | [Adjustment] |

---

## Estimation Analysis

### Summary
| Metric | Value |
|--------|-------|
| Overall Accuracy | [X]% |
| Most Accurate Category | [Category] |
| Least Accurate Category | [Category] |

### Key Findings
1. [Finding 1]
2. [Finding 2]

### Calibration Recommendations
| Task Type | Current Factor | Recommended Factor |
|-----------|----------------|-------------------|
| [Type] | 1.0x | [X]x |

---

## Role Effectiveness

### Phase 1: Product Manager
| Aspect | Rating | Notes |
|--------|--------|-------|
| Requirements clarity | [1-5] | [Notes] |
| Stakeholder management | [1-5] | [Notes] |

### Phase 2: Software Architect
| Aspect | Rating | Notes |
|--------|--------|-------|
| Design quality | [1-5] | [Notes] |
| Technology choices | [1-5] | [Notes] |

### Phase 3: Senior Developer
| Aspect | Rating | Notes |
|--------|--------|-------|
| Code quality | [1-5] | [Notes] |
| Estimation accuracy | [1-5] | [Notes] |

### Phase 4: QA Lead
| Aspect | Rating | Notes |
|--------|--------|-------|
| Test coverage | [1-5] | [Notes] |
| Risk identification | [1-5] | [Notes] |

### Phase 5: Release Manager
| Aspect | Rating | Notes |
|--------|--------|-------|
| Coordination | [1-5] | [Notes] |
| Documentation | [1-5] | [Notes] |

---

## Action Items for Next Iteration

### High Priority
- [ ] [Action 1]
- [ ] [Action 2]

### Medium Priority
- [ ] [Action 1]
- [ ] [Action 2]

### Low Priority
- [ ] [Action 1]

---

## Knowledge to Preserve

### Technical Decisions
| Decision | Rationale | Reference |
|----------|-----------|-----------|
| [Decision] | [Why] | [Link to decision log] |

### Patterns Discovered
- [Pattern 1]
- [Pattern 2]

### Anti-Patterns Identified
- [Anti-pattern 1]: [What to do instead]
- [Anti-pattern 2]: [What to do instead]

---

## Metrics Comparison (if not first release)

| Metric | Previous | Current | Trend |
|--------|----------|---------|-------|
| Estimation Accuracy | [X]% | [Y]% | ↑/↓ |
| Test Coverage | [X]% | [Y]% | ↑/↓ |
| Defect Rate | [X] | [Y] | ↑/↓ |
| Cycle Time | [X] days | [Y] days | ↑/↓ |

---

## Sign-off

| Role | Name | Date |
|------|------|------|
| Release Manager | | |
| Project Manager | | |
| Technical Lead | | |
```

---

## CHANGELOG Template

**File**: `./docs/CHANGELOG.md`

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- [Feature being developed]

### Changed
- [Change in progress]

---

## [X.Y.Z] - YYYY-MM-DD

### Summary
[One paragraph summary of the release]

### Added
- [Feature 1] ([FR-XXX](./specifications/locked-specification.md#FR-XXX))
- [Feature 2] ([FR-XXX](./specifications/locked-specification.md#FR-XXX))

### Changed
- [Change 1]
- [Change 2]

### Fixed
- [Bug fix 1] (#issue)
- [Bug fix 2] (#issue)

### Security
- [Security improvement 1]

### Performance
- [Performance improvement 1]

### Deprecated
- [Deprecated feature]

### Removed
- [Removed feature]

### Documentation
- [Doc update 1]

---

### Verification
- **Evidence**: [v[X.Y.Z]-evidence.md](./verification/evidence-packages/v[X.Y.Z]-evidence.md)
- **Coverage**: [X]%
- **Tests**: [Y] passing

### Artifacts
- **Specification**: v[A.B]
- **Blueprint**: v[C.D]
- **Git Tag**: v[X.Y.Z]

---

## [Previous Version] - YYYY-MM-DD

[Previous release notes]
```

---

## Replan Context Package Template

**File**: `./docs/implementation/context-packages/replan-v[X.Y.Z].md`

```markdown
# Replan Context Package

## Meta
| Field | Value |
|-------|-------|
| Created | [Timestamp] |
| From Version | v[X.Y.Z] |
| Decision | Replan (v0.5.0-replan) |
| Role | Release Manager |
| Target Phase | Phase 2: Planning |

---

## Failure Summary

### What Failed
[Clear description of what verification or implementation failed]

### Verification Results
| Check | Result | Issue |
|-------|--------|-------|
| [Check 1] | ❌ | [Issue] |
| [Check 2] | ✅ | — |

### Error Evidence
```
[Error messages, stack traces, or test failures]
```

---

## Root Cause Analysis

### Primary Cause
[Detailed description of the architectural or design issue]

### Category
- [ ] Architectural flaw
- [ ] Technology mismatch
- [ ] Integration issue
- [ ] Performance design issue
- [ ] Security design issue
- [ ] Scalability issue

### Contributing Factors
1. [Factor 1]
2. [Factor 2]

---

## Impact Assessment

### Affected Components
| Component | Impact | Rework Required |
|-----------|--------|-----------------|
| [Component 1] | High | Yes |
| [Component 2] | Medium | Partial |
| [Component 3] | Low | No |

### Affected Tasks
| Task | Status | Disposition |
|------|--------|-------------|
| T-X.X.X | ✅ | Keep |
| T-X.X.X | ✅ | Revise |
| T-X.X.X | 🔄 | Discard |

### Estimated Rework
| Category | Hours |
|----------|-------|
| Architecture revision | [X] |
| Task regeneration | [Y] |
| Reimplementation | [Z] |
| **Total** | **[W]** |

---

## Recommended Changes

### Architecture Changes
1. **[Change 1]**
   - Current: [Current approach]
   - Proposed: [New approach]
   - Rationale: [Why]

2. **[Change 2]**
   - Current: [Current approach]
   - Proposed: [New approach]
   - Rationale: [Why]

### Technology Changes
| Current | Proposed | Reason |
|---------|----------|--------|
| [Tech 1] | [Tech 2] | [Reason] |

### Blueprint Sections to Revise
- [ ] Section X: [Name]
- [ ] Section Y: [Name]

---

## Preserved Progress

### Reusable Components
| Component | Location | Notes |
|-----------|----------|-------|
| [Component] | [Path] | [Can reuse as-is] |

### Valid Specifications
- Specification sections [X, Y, Z] remain valid
- No specification changes required

### Valid Tasks
| Task | Status | Notes |
|------|--------|-------|
| T-X.X.X | Keep | Implementation valid |

---

## Recovery Instructions

### Before Starting Phase 2
1. Read this context package completely
2. Review failed evidence package: `./docs/verification/evidence-packages/v[X.Y.Z]-evidence.md`
3. Load current blueprint: `./docs/architecture/blueprint.md`

### Phase 2 Focus Areas
1. [Focus area 1]
2. [Focus area 2]

### Constraints from Failure
- Must address: [Constraint 1]
- Must not repeat: [Anti-pattern]

### Git Recovery
```bash
# Current state
git log --oneline -5

# If need to rollback implementation
git checkout v0.2.0-plan -- src/

# Start fresh implementation branch
git checkout -b feature/replan-v[X.Y.Z]
```

---

## Success Criteria for Replan

### Architecture Revision Must
- [ ] Address [root cause]
- [ ] Include [missing aspect]
- [ ] Consider [overlooked factor]

### Before Returning to Phase 3
- [ ] Blueprint reviewed and approved
- [ ] Affected tasks regenerated
- [ ] Dependency versions validated
- [ ] Test plan updated

---

## Notes

[Any additional context that would be helpful]
```

---

## Team Release Checklist Template

**File**: `./docs/team/release-checklist.md` (Team Mode only)

```markdown
# Release Checklist: v[X.Y.Z]

## Pre-Release

### Code
- [ ] All PRs merged to develop
- [ ] No outstanding code reviews
- [ ] All CI checks passing
- [ ] Code freeze in effect

### Testing
- [ ] All tests passing
- [ ] Coverage meets threshold (≥70%)
- [ ] Performance tests complete
- [ ] Security scans clear

### Documentation
- [ ] CHANGELOG updated
- [ ] API documentation current
- [ ] README updated
- [ ] Release notes drafted

### Verification
- [ ] Evidence package complete
- [ ] GO decision documented
- [ ] Sign-offs obtained

---

## Release

### Git Operations
- [ ] Develop merged to main
- [ ] Release tag created
- [ ] Tag pushed to origin

### Deployment
- [ ] Deployment triggered
- [ ] Deployment successful
- [ ] Smoke tests passing
- [ ] Monitoring confirmed

### Communication
- [ ] Team notified
- [ ] Stakeholders informed
- [ ] Release announcement sent

---

## Post-Release

### Verification
- [ ] Production smoke tests pass
- [ ] Metrics nominal
- [ ] No error spikes

### Cleanup
- [ ] Feature branches deleted
- [ ] Develop updated from main
- [ ] Next iteration planned

### Documentation
- [ ] Lessons learned captured
- [ ] Metrics recorded
- [ ] Archive complete

---

## Sign-off

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Release Manager | | | |
| QA Lead | | | |
| Tech Lead | | | |
| Product Owner | | | |
```
