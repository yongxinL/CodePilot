#!/bin/bash

# Automated Development System v2.0 - Initialization Script
# Run this script to set up the project documentation structure

set -e

echo "🚀 Initializing Automated Development System v2.0..."
echo ""

# Create directory structure
echo "📁 Creating directory structure..."

mkdir -p docs/{config/roles,prompts,specifications,analysis,architecture/tasks,architecture/api-contracts,implementation/context-packages,verification/evidence-packages,verification/performance-baselines,release/runbooks,team}

# Create placeholder files
echo "📄 Creating placeholder files..."

# Config files
cat > docs/config/roles/custom-roles.md << 'EOF'
# Custom Roles

> Define custom roles here to override or extend the default role system.
> See `./docs/prompts/00-core.md#custom-role-template` for the template.

## Custom Roles

<!-- Add your custom role definitions below -->

EOF

cat > docs/config/thresholds.md << 'EOF'
# Quality Thresholds

> Override default thresholds here if needed.
> Default values are defined in `./docs/prompts/00-core.md`.

## Project-Specific Overrides

<!-- Uncomment and modify to override defaults

## Blocking Thresholds
| Metric | Minimum |
|--------|---------|
| Test Coverage | 70% |
| Critical Security Issues | 0 |
| High Security Issues | 0 |
| AC Pass Rate | 100% |

## Target Thresholds
| Metric | Target |
|--------|--------|
| Test Coverage | 85% |
| Cyclomatic Complexity | <10 |
| Code Duplication | <5% |

-->
EOF

cat > docs/config/team.md << 'EOF'
# Team Configuration

## Mode
enabled: false

## Team Members
<!-- Uncomment and fill in when enabling team mode

| Name | GitHub | Role | Modules |
|------|--------|------|---------|
| [Name] | @handle | Lead | M1, M2 |
| [Name] | @handle | Developer | M3 |

-->

## Branch Protection
<!-- Uncomment when enabling team mode

- Require PR for: develop, main
- Required approvals: 1
- Required checks: lint, test

-->

## Code Review Policy
<!-- Uncomment when enabling team mode

- Self-review: Allowed for Ninja tier
- Cross-review: Required for Beginner tier

-->
EOF

# Architecture files
cat > docs/architecture/tasks/_index.md << 'EOF'
# Task Index

## Summary
| Metric | Value |
|--------|-------|
| Total Tasks | 0 |
| Completed | 0 |
| In Progress | 0 |
| Pending | 0 |

## By Milestone

<!-- Tasks will be added here during Phase 2 -->

EOF

cat > docs/architecture/tasks/_task-template.md << 'EOF'
# T-[X.X.X]: [Task Name]

## Meta
| Field | Value |
|-------|-------|
| Status | ⏳ Pending |
| Milestone | M[X]: [Name] |
| Module | M[X]-MOD[Y]: [Name] |
| Created | [Date] |
| Started | — |
| Completed | — |
| Assignee | Unassigned |

---

## Objective
[Clear, concise statement of what this task accomplishes]

---

## Acceptance Criteria Mapping

| AC ID | Criterion | Verification |
|-------|-----------|--------------|
| AC-XXX | [Criterion text] | [Test/Review] |

---

## Dependencies

### Requires (must complete first)
| Task | Status | Reason |
|------|--------|--------|
| — | — | — |

### Blocks (waiting on this)
| Task | Reason |
|------|--------|
| — | — |

---

## Parallelization

| Field | Value |
|-------|-------|
| Parallel Group | — |
| Can Run With | — |
| Sequential After | — |
| Blocks | — |

---

## Effort Tracking

| Type | Value |
|------|-------|
| Estimated | [X] hours |
| Actual | — |
| Variance | — |
| Variance % | — |

### Estimation Rationale
- Complexity: [Low/Medium/High]
- Risk factors: [List]

### Time Log
| Date | Duration | Notes |
|------|----------|-------|
| | | |

---

## Technical Notes

### Approach
[How this should be implemented]

### Files to Create/Modify
- [ ] `src/path/to/file` - [Purpose]
- [ ] `tests/path/to/test` - [Tests]

---

## Implementation Log

<!-- Populated during Phase 3 -->

---

## Verification

### Tests Required
- [ ] Unit tests for [component]
- [ ] Integration test for [flow]

### Manual Verification
- [ ] [Verification step]
EOF

cat > docs/architecture/tasks/_parallel-groups.md << 'EOF'
# Parallel Task Groups

## Overview

Parallel groups identify tasks that can execute concurrently.

## Groups

<!-- Parallel groups will be defined during Phase 2 -->

EOF

# Implementation files
cat > docs/implementation/decision-log.md << 'EOF'
# Decision Log

## Overview

This log captures significant decisions made during implementation.

---

## Decisions

<!-- Decisions will be logged here during Phase 3 -->

EOF

cat > docs/implementation/task-checklist.md << 'EOF'
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

## Summary
| Metric | Count |
|--------|-------|
| Total | 0 |
| Completed | 0 |
| In Progress | 0 |
| Pending | 0 |

---

## Tasks

<!-- Tasks will be added here during Phase 2 -->

EOF

cat > docs/implementation/estimation-tracking.md << 'EOF'
# Estimation Tracking

## Summary
| Metric | Value |
|--------|-------|
| Total Estimated | — |
| Total Actual | — |
| Variance | — |

---

## By Task

| Task | Name | Est | Actual | Variance |
|------|------|-----|--------|----------|
| — | — | — | — | — |

---

## Lessons

<!-- Estimation lessons will be captured here -->

EOF

cat > docs/implementation/.recovery-checkpoint.md << 'EOF'
# Recovery Checkpoint

| Field | Value |
|-------|-------|
| Last Updated | [Not started] |
| Phase | — |
| Active Role | — |
| Current Task | — |
| Git Commit | — |
| Git Branch | — |

## Context Summary
Project not yet started.

## Next Action
Run Phase 1 initialization.
EOF

# Verification files
cat > docs/verification/test-plan.md << 'EOF'
# Test Plan

## Overview
<!-- Test strategy will be defined during Phase 2 -->

## Quality Thresholds

| Metric | Minimum | Target | Blocking |
|--------|---------|--------|----------|
| Test Coverage | 70% | 85% | Yes |
| Critical Security Issues | 0 | 0 | Yes |
| High Security Issues | 0 | 0 | Yes |

---

## Test Cases

<!-- Test cases will be added during Phase 2 -->

EOF

# Release files
cat > docs/release/rollback-sop.md << 'EOF'
# Rollback Standard Operating Procedure

## Overview
This document defines rollback procedures for emergency recovery.

## Git Rollback Commands

### By Phase Tag
| Target | Command |
|--------|---------|
| Specification | `git checkout v0.1.x-spec` |
| Planning | `git checkout v0.2.x-plan` |
| Implementation | `git checkout v0.3.x-impl` |
| Last Verified | `git checkout v0.4.x-verify` |

### Create Hotfix
```bash
git checkout v[X.Y.Z]
git checkout -b hotfix/description
# Apply fixes
git commit -m "fix: Description"
```

### Emergency Reset
```bash
# Reset to last known good state
git checkout develop
git reset --hard v[X.Y.Z]
```

---

## Procedures

<!-- Detailed rollback procedures will be added during Phase 2 -->

EOF

cat > docs/release/monitoring-plan.md << 'EOF'
# Monitoring Plan

## Overview
<!-- Monitoring strategy will be defined during Phase 2 -->

## Key Metrics

| Metric | Source | Alert Threshold |
|--------|--------|-----------------|
| P95 Latency | — | — |
| Error Rate | — | — |
| Throughput | — | — |

---

## Alerts

<!-- Alert definitions will be added during Phase 2 -->

EOF

# Team files (for team mode)
cat > docs/team/CODEOWNERS << 'EOF'
# Code Owners
# This file will be populated when team mode is enabled

# Default owner
# * @team-lead

EOF

cat > docs/team/pr-template.md << 'EOF'
## Description
[What does this PR do?]

## Tasks
- [ ] T-X.X.X: [Task name]

## Checklist
- [ ] Tests pass
- [ ] Linter clean
- [ ] Documentation updated
- [ ] Estimation tracking updated

## Acceptance Criteria
- [ ] AC-XXX verified
EOF

cat > docs/team/review-checklist.md << 'EOF'
# Code Review Checklist

## Functionality
- [ ] Meets acceptance criteria
- [ ] Edge cases handled
- [ ] Error handling appropriate

## Code Quality
- [ ] Follows coding standards
- [ ] No code smells
- [ ] Appropriate abstraction level

## Testing
- [ ] Adequate test coverage
- [ ] Tests are meaningful
- [ ] No test anti-patterns

## Documentation
- [ ] Code is self-documenting
- [ ] Complex logic explained
- [ ] Public APIs documented

## Security
- [ ] No hardcoded secrets
- [ ] Input validation present
- [ ] Authentication/authorization correct
EOF

# Root documentation files
cat > docs/CHANGELOG.md << 'EOF'
# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- Initial project setup
- Automated Development System v2.0 structure

EOF

cat > docs/PROJECT-SUMMARY.md << 'EOF'
# Project Summary

## Overview
| Field | Value |
|-------|-------|
| Project | [Project Name] |
| Status | Not Started |
| Created | [Date] |

---

## Quick Links
- [CHANGELOG](./CHANGELOG.md)
- [Specifications](./specifications/)
- [Architecture](./architecture/)
- [Verification](./verification/)

---

## Current Phase
Phase 1: Not Started

EOF

echo ""
echo "✅ Directory structure created!"
echo ""
echo "📋 Structure:"
echo "docs/"
echo "├── config/"
echo "│   ├── roles/"
echo "│   │   └── custom-roles.md"
echo "│   ├── thresholds.md"
echo "│   └── team.md"
echo "├── prompts/              (copy prompt files here)"
echo "├── specifications/"
echo "├── analysis/"
echo "├── architecture/"
echo "│   ├── tasks/"
echo "│   │   ├── _index.md"
echo "│   │   ├── _task-template.md"
echo "│   │   └── _parallel-groups.md"
echo "│   └── api-contracts/"
echo "├── implementation/"
echo "│   ├── context-packages/"
echo "│   ├── decision-log.md"
echo "│   ├── task-checklist.md"
echo "│   ├── estimation-tracking.md"
echo "│   └── .recovery-checkpoint.md"
echo "├── verification/"
echo "│   ├── evidence-packages/"
echo "│   ├── performance-baselines/"
echo "│   └── test-plan.md"
echo "├── release/"
echo "│   ├── runbooks/"
echo "│   ├── rollback-sop.md"
echo "│   └── monitoring-plan.md"
echo "├── team/"
echo "│   ├── CODEOWNERS"
echo "│   ├── pr-template.md"
echo "│   └── review-checklist.md"
echo "├── CHANGELOG.md"
echo "└── PROJECT-SUMMARY.md"
echo ""
echo "🎯 Next Steps:"
echo "1. Copy prompt files to docs/prompts/"
echo "2. Copy CLAUDE.md to project root"
echo "3. Initialize git: git init && git checkout -b develop"
echo "4. Start Claude Code to begin Phase 1"
echo ""
echo "🚀 Ready for Automated Development System v2.0!"
