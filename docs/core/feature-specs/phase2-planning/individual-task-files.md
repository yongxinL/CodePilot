# Individual Task Files - CodePilot v2.0

**Tier**: Core+
**Phase**: 2 (Planning)
**Feature #**: 4

## Purpose

Replace single monolithic implementation-plan.md with individual task files to enable token-efficient loading of specific tasks during Phase 3 implementation.

## When to Use

During task breakdown phase (Step 4), decide whether to create one large plan or individual task files based on configuration.

## Configuration Check

```javascript
config = read(".codepilot.config.json");
if (config.individual_task_files) {
  create_individual_task_files();
} else {
  create_monolithic_plan();
}
```

## Workflow

1. Break down implementation into 15-25 discrete tasks
2. Create directory: `docs/artifacts/phase2-planning/tasks/`
3. For each task, create: `task-{NNN}-{short-description}.md`
4. Create index file: `tasks/INDEX.md`
5. Link tasks via dependencies
6. Cross-reference in Gantt chart

## Create Artifacts

**Directory**: `docs/artifacts/phase2-planning/tasks/`

**Files Created**: 15-25 individual task files (one per implementation task)

**Index File**: `docs/artifacts/phase2-planning/tasks/INDEX.md`

## Task File Format

### Template Structure

```markdown
# Task 003: Implement User Authentication

**ID**: TASK-003
**Status**: Not Started
**Priority**: High
**Complexity**: Medium
**Estimated Effort**: 3 days
**Assigned To**: TBD (in Phase 3)

## Description

Implement JWT-based authentication system including:
- User registration with email/password
- Login with JWT token generation
- Password reset flow
- Token refresh mechanism
- Logout with token revocation

## Dependencies

**Blocks** (must complete before):
- TASK-001: Database setup ✅ Required
- TASK-002: User model ✅ Required

**Blocked By** (must complete first):
- None (can start after dependencies done)

**Related** (can work in parallel):
- TASK-004: User profile (uses authentication)
- TASK-005: Task assignment (needs user context)

## Deliverables

- [ ] POST /auth/register endpoint
- [ ] POST /auth/login endpoint
- [ ] POST /auth/refresh endpoint
- [ ] POST /auth/logout endpoint
- [ ] POST /auth/reset-password endpoint
- [ ] Auth middleware for protected routes
- [ ] Unit tests (90%+ coverage)
- [ ] Integration tests (all auth flows)
- [ ] API documentation for auth endpoints

## Acceptance Criteria

From User Story US-001:
- [ ] Users can register with email and password
- [ ] Passwords hashed with bcrypt (12+ rounds)
- [ ] Users can log in and receive JWT token
- [ ] Tokens expire after 15 minutes
- [ ] Refresh tokens valid for 7 days
- [ ] Users can log out (token revoked)
- [ ] Failed logins rate-limited (5 attempts/minute)

## Technical Approach

### Authentication Method
JWT (JSON Web Tokens):
- Access token: 15-minute expiry
- Refresh token: 7-day expiry
- Store refresh tokens in Redis for revocation

### Libraries
- jsonwebtoken: Token generation
- bcrypt: Password hashing
- express-rate-limit: Rate limiting

### Security Considerations
- Validate password strength (min 8 chars, mix of types)
- Rate limit login attempts
- Secure token storage (httpOnly cookies or localStorage with XSS protection)
- Refresh token rotation

## Resources

- OWASP Authentication Cheat Sheet
- JWT Best Practices (RFC 8725)
- Knowledge Base: patterns/jwt-auth-pattern.md (if exists)
- Consult @security for security review

## Implementation Notes

[Added during Phase 3 - document decisions, blockers, lessons learned]

## Completion

**Status**: [Not Started | In Progress | Complete]
**Date Started**: [Date]
**Date Completed**: [Date]
**Actual Effort**: [Hours/days vs estimated]
**Issues Encountered**: [Any challenges, blockers, workarounds]
**Test Results**: [Coverage %, test count, any failures]
**Git Commit**: [Commit hash if automatic git enabled]
**Code Review**: [Who reviewed, feedback addressed]
**Notes**: [Lessons learned, patterns for reuse, performance notes]
```

### Example Task Files

```
docs/artifacts/phase2-planning/tasks/
├── task-001-database-setup.md
├── task-002-user-model.md
├── task-003-user-authentication.md
├── task-004-user-profile.md
├── task-005-task-model.md
├── task-006-task-crud-api.md
├── task-007-task-assignment.md
├── task-008-team-management.md
├── task-009-real-time-websockets.md
├── task-010-task-updates-broadcast.md
├── task-011-comments-activity.md
├── task-012-notifications.md
├── task-013-search-filtering.md
├── task-014-dashboard-ui.md
├── task-015-task-list-ui.md
├── task-016-task-detail-ui.md
├── task-017-team-ui.md
├── task-018-integration-tests.md
├── task-019-e2e-tests.md
├── task-020-documentation.md
└── INDEX.md
```

## Index File Format

```markdown
# Implementation Tasks - Index

**Total Tasks**: 20
**Estimated Duration**: 8 weeks
**Team**: 3 developers

## Task Overview

### Foundation (Tasks 001-004) - 2 weeks
Database and user management infrastructure
- Task 001: Database Setup
- Task 002: User Model
- Task 003: User Authentication
- Task 004: User Profile
**Dependencies**: Sequential
**Parallel**: None (all dependent on prior)

### Core Features (Tasks 005-008) - 2 weeks
Task and team management
- Task 005: Task Model
- Task 006: Task CRUD API
- Task 007: Task Assignment
- Task 008: Team Management
**Dependencies**: 005 → 006 → 007; 008 parallel
**Parallel**: Task 008 (team) can run with 006-007

### Collaboration (Tasks 009-012) - 2.5 weeks
Real-time and notification infrastructure
- Task 009: Real-time WebSockets
- Task 010: Task Updates Broadcast
- Task 011: Comments & Activity
- Task 012: Notifications
**Dependencies**: 009 → 010 → (011, 012)
**Parallel**: 011 and 012 can run together

### Polish (Tasks 013-020) - 1.5 weeks
UI, testing, and documentation
- Task 013: Search & Filtering
- Task 014: Dashboard UI
- Task 015: Task List UI
- Task 016: Task Detail UI
- Task 017: Team UI
- Task 018: Integration Tests
- Task 019: E2E Tests
- Task 020: Documentation
**Dependencies**: 014-017 parallel, then 018-020
**Parallel**: All UI tasks can run together

## Critical Path

```
001 → 002 → 003 → 004 → 005 → 006 → 009 → 010
      23 days (critical - cannot slip)
```

## Task Files

| ID | Task | Status | Duration | Dependencies |
|----|------|--------|----------|--------------|
| 001 | Database Setup | — | 3d | None |
| 002 | User Model | — | 2d | 001 |
| 003 | Authentication | — | 3d | 001, 002 |
| ... | ... | ... | ... | ... |

See individual task files for details.

## Quick Start

**For Phase 3 Engineer**:
1. Load this INDEX.md
2. Find next task based on dependencies
3. Load specific task file (e.g., task-003-user-authentication.md)
4. Implement following task spec
5. Update task file status when complete
6. Move to next task

**Token Savings**: Load only current task (~250 tokens) vs full plan (5,000 tokens)
```

## Usage in Phase 3

During implementation, the engineer:

1. **Loads** `docs/artifacts/phase2-planning/tasks/INDEX.md`
2. **Identifies** next task (based on dependencies)
3. **Loads** specific task file (e.g., `task-006-task-crud-api.md`)
4. **Implements** following spec in task file
5. **Updates** task file with progress:
   ```markdown
   **Status**: In Progress
   **Progress**: 60% (endpoints working, tests pending)
   **Started**: 2026-01-03 14:30 UTC
   ```
6. **Marks complete** when done:
   ```markdown
   **Status**: ✅ Complete
   **Date Completed**: 2026-01-03 17:45 UTC
   **Actual Effort**: 6.5 hours (vs 2 days estimated)
   ```
7. **Moves** to next task

## Token Savings

| Approach | Phase 3 Loading | Phase 4 Loading | Total Tokens Saved |
|----------|-----------------|-----------------|-------------------|
| Monolithic | 5,000 tokens (full plan) | 5,000 tokens (full plan) | 0 tokens |
| Individual Files | 300 tokens (INDEX) + 250 tokens (current task) | 300 + 250 | ~9,400 tokens |

**Net Savings**: ~4,000 tokens per phase = ~8,000 total

## Best Practices

1. **Task Size**: 1-3 days effort each (not too granular)
2. **Dependencies**: Clear blocking relationships
3. **Deliverables**: Specific, testable outputs
4. **Acceptance Criteria**: Measurable success
5. **Resources**: Link to knowledge base patterns
6. **Regular Updates**: Update status during work

## Token Cost

**Creation**: ~800 tokens (all files)
**Update**: ~50-100 tokens per task (during Phase 3)

## Related Features

- [Gantt Chart](gantt-chart.md) - Visual timeline of tasks
- [Progressive Checkpoints](../phase3-implementation/progressive-checkpoints.md) - Save progress after each task
- [Technical Debt Register](../phase3-implementation/technical-debt-register.md) - Track task-level shortcuts

## Integration with Planning Phase

This step occurs **at Step 4.5 (Task Breakdown)** in the planning workflow:

```
Step 4: Create Technical Design
  ↓
Step 4.5: Create Individual Task Files (THIS FEATURE)
  ↓
Step 5: Develop Implementation Plan
```

## Why Individual Files Better Than Monolithic

| Aspect | Monolithic | Individual Files |
|--------|-----------|------------------|
| Load Time | Full plan always | Only current task |
| Token Cost | ~5,000 per load | ~250 per load |
| Maintenance | Hard to find changes | Clear per-task history |
| Reusability | Mixed with others | Standalone specs |
| Progress Tracking | Centralized | Task-level granularity |
| Discoverability | Search overwhelmed | Organized by number |
