# Technical Debt Register - CodePilot v2.0

**Tier**: Core+
**Phase**: 3 (Implementation)
**Feature #**: 20

## Purpose

Document shortcuts, deferred work, and technical compromises made during Phase 3 implementation so they can be tracked, prioritized, and addressed systematically rather than forgotten.

## When to Use

Whenever taking a shortcut or deferring work during Phase 3, immediately document it in the technical debt register. Review and prioritize before Phase 4.

## Configuration Check

```javascript
config = read(".codepilot.config.json");
if (config.feature_tier >= "core_plus") {
  enable_technical_debt_tracking();
} else {
  skip_this_feature();
}
```

## Create Artifact

**File**: `docs/artifacts/phase3-implementation/technical-debt-register.md`

## What Counts as Technical Debt

### Include These:
- [ ] Commented-out code (temporary workarounds)
- [ ] TODO comments with rationale
- [ ] Hardcoded values (should be config)
- [ ] Missing unit tests for edge cases
- [ ] Performance optimizations deferred
- [ ] Refactoring work identified but skipped
- [ ] Error handling simplified for time
- [ ] Documentation incomplete
- [ ] Temporary workarounds for bugs
- [ ] Scalability limits (hardcoded limits, N+1 queries)
- [ ] Security enhancements deferred
- [ ] Accessibility features not implemented

### Exclude These:
- [ ] Normal requirements not yet implemented (future features)
- [ ] Known limitations by design
- [ ] Dependencies on other teams
- [ ] YAGNI (You Aren't Gonna Need It) choices
- [ ] Features explicitly deprioritized

---

## Debt Register Template

```markdown
# Technical Debt Register

**Phase**: 3 (Implementation)
**Period**: 2026-01-03 to YYYY-MM-DD
**Total Items**: [N]
**Total Effort**: [X] person-days

---

## Summary by Category

| Category | Count | Effort | Priority | Status |
|----------|-------|--------|----------|--------|
| Performance | 3 | 5 days | High | Pending |
| Testing | 5 | 8 days | Medium | Pending |
| Refactoring | 2 | 3 days | Low | Pending |
| Documentation | 4 | 2 days | Medium | Pending |
| Error Handling | 2 | 1 day | Low | Pending |
| Accessibility | 1 | 2 days | Medium | Pending |

**Total**: 17 items, 21 person-days

---

## Debt Items

### DEBT-001: N+1 Query in Task List

**Component**: `src/api/tasks.ts:GET /api/tasks`

**Type**: Performance
**Severity**: High
**Estimated Effort**: 2 days
**Priority**: High

**Description**:
Current implementation fetches all tasks, then for each task fetches assigned users:

```javascript
// PROBLEM: N+1 query
const tasks = await Task.find();
const enriched = await Promise.all(
  tasks.map(async (task) => {
    task.assignees = await User.findByIds(task.assignee_ids);
    return task;
  })
);
```

This causes N+1 queries (1 for tasks + N for users).

**Workaround**:
Acceptable for now with <1000 tasks. Cache results with 5-minute TTL.

**Root Cause**:
ORMs don't support eager loading of arrays. Need to manually join or batch fetch.

**Solution**:
Implement batch loader or rewrite query with SQL JOIN:

```javascript
// SOLUTION: Single query with JOIN
const tasks = await sequelize.query(`
  SELECT t.*, json_agg(u.*) as assignees
  FROM tasks t
  LEFT JOIN task_assignments ta ON t.id = ta.task_id
  LEFT JOIN users u ON ta.user_id = u.id
  GROUP BY t.id
`);
```

**Acceptance Criteria**:
- [ ] Single SQL query for task list
- [ ] Response time <500ms for 1000 tasks
- [ ] No N+1 queries in logs

**Blocking**: No - has cache workaround
**Depends On**: None
**Owner**: Backend team
**Target Phase**: 4 or 5 (when data grows)

---

### DEBT-002: Hardcoded Rate Limits

**Component**: `src/middleware/rateLimit.ts`

**Type**: Configuration
**Severity**: Medium
**Estimated Effort**: 0.5 days
**Priority**: Medium

**Description**:
Rate limits are hardcoded in code:

```javascript
const RATE_LIMITS = {
  login: 5,        // 5 attempts per minute
  api: 100,        // 100 requests per minute
  upload: 10,      // 10 uploads per minute
};
```

Should be in configuration file or environment variables for easy tuning without redeployment.

**Workaround**:
Acceptable temporarily. Can patch by redeploying if needed.

**Solution**:
Move to `.env` file or admin dashboard:

```javascript
// Load from config
const RATE_LIMITS = {
  login: process.env.RATE_LIMIT_LOGIN || 5,
  api: process.env.RATE_LIMIT_API || 100,
  upload: process.env.RATE_LIMIT_UPLOAD || 10,
};
```

**Acceptance Criteria**:
- [ ] All limits in environment variables
- [ ] No hardcoded values in code
- [ ] Can update limits without redeploy (if dashboard)

**Blocking**: No
**Depends On**: Environment setup
**Owner**: DevOps + Backend
**Target Phase**: 4

---

### DEBT-003: Missing Error Context in Logs

**Component**: `src/middleware/errorHandler.ts`

**Type**: Debugging/Observability
**Severity**: Medium
**Estimated Effort**: 1 day
**Priority**: Medium

**Description**:
Error logs missing context (user ID, request ID, operation). Makes debugging production issues difficult:

```javascript
// CURRENT: Minimal info
logger.error('Database query failed', error);

// NEEDED: Full context
logger.error('Database query failed', {
  error,
  user_id: req.user?.id,
  request_id: req.id,
  operation: req.method + ' ' + req.path,
  timestamp: new Date().toISOString(),
});
```

**Workaround**:
Acceptable for now. Errors still logged, just harder to debug.

**Solution**:
Add request ID middleware and include in all logs:

```javascript
// Middleware to add request ID
app.use((req, res, next) => {
  req.id = uuidv4();
  res.setHeader('X-Request-ID', req.id);
  next();
});

// Updated error logging
logger.error('Database query failed', {
  error,
  request_id: req.id,
  user_id: req.user?.id,
  endpoint: `${req.method} ${req.path}`,
});
```

**Acceptance Criteria**:
- [ ] All errors include request ID
- [ ] User ID logged for auth errors
- [ ] Correlation ID available for tracing

**Blocking**: No
**Depends On**: Logger upgrade (if needed)
**Owner**: Backend team
**Target Phase**: 4

---

### DEBT-004: Missing Unit Tests for Edge Cases

**Component**: `src/services/taskService.ts`

**Type**: Testing
**Severity**: Medium
**Estimated Effort**: 3 days
**Priority**: High

**Description**:
Happy path tested well, but missing edge case coverage:
- What if parent task is deleted while subtask exists?
- What if assignment permissions change during bulk update?
- What if database connection drops mid-transaction?

**Current Coverage**: 85% (missing edge cases)
**Target Coverage**: 95%

**Workaround**:
Acceptable with manual testing. Integration tests cover some scenarios.

**Test Cases Needed**:
1. Delete parent task with active subtasks
2. Concurrent updates to same task
3. Permission changes during operation
4. Database transaction rollback
5. Invalid state transitions
6. Boundary conditions (empty lists, max sizes)

**Acceptance Criteria**:
- [ ] Add 15+ edge case tests
- [ ] Coverage increases to 95%+
- [ ] All edge case scenarios documented

**Blocking**: No - covered by integration tests
**Depends On**: Test infrastructure
**Owner**: QA + Backend
**Target Phase**: 4

---

### DEBT-005: Missing Documentation

**Component**: Architecture & API
**Type**: Documentation
**Severity**: Low
**Estimated Effort**: 2 days
**Priority**: Medium

**Description**:
Missing documentation for:
- [ ] Authentication flow (JWT, refresh tokens, expiry)
- [ ] API error codes and meanings
- [ ] Database schema evolution strategy
- [ ] Performance tuning guide
- [ ] Deployment procedure (manual steps)
- [ ] Recovery procedure (if things break)

**Current State**: Code exists, behavior undocumented.

**Workaround**:
Acceptable if team is stable. New team members struggle.

**Solution**:
Create markdown docs in `/docs`:
- `docs/architecture/authentication.md`
- `docs/api/error-codes.md`
- `docs/database/evolution.md`
- `docs/operations/deployment.md`
- `docs/operations/recovery.md`

**Acceptance Criteria**:
- [ ] All major flows documented
- [ ] New developer can onboard in <1 day
- [ ] Operations team has runbooks

**Blocking**: No
**Depends On**: Team availability
**Owner**: Tech Lead + team
**Target Phase**: 4 or 5

---

### DEBT-006: Accessibility Issues

**Component**: `src/components/` (all UI)

**Type**: Accessibility
**Severity**: Low
**Estimated Effort**: 2 days
**Priority**: Medium

**Description**:
UI missing WCAG 2.1 Level A compliance:
- Missing alt text on images
- Keyboard navigation incomplete
- Focus indicators missing
- Color contrast insufficient in some areas
- Form labels not associated with inputs

**Workaround**:
Acceptable for MVP. Can add accessibility in Phase 4.

**Solution**:
Audit and fix accessibility issues:

```javascript
// Example: Add alt text
- <img src="task.png" />
+ <img src="task.png" alt="Task icon" />

// Example: Add labels
- <input type="text" placeholder="Email" />
+ <label htmlFor="email">Email</label>
+ <input id="email" type="text" />

// Example: Add focus
+ button:focus { outline: 2px solid #0066cc; }
```

**Acceptance Criteria**:
- [ ] All images have alt text
- [ ] Full keyboard navigation working
- [ ] Focus indicators visible
- [ ] Color contrast ≥4.5:1
- [ ] WAVE audit: 0 errors
- [ ] Screen reader compatible

**Blocking**: No
**Depends On**: Design guidance
**Owner**: Frontend team
**Target Phase**: 4

---

### DEBT-007: Commented-Out Code

**Component**: Multiple files
**Type**: Code Cleanup
**Severity**: Low
**Estimated Effort**: 0.5 days
**Priority**: Low

**Description**:
Commented-out code left from development:

```javascript
// const oldLoginFlow = async (email, password) => { ... }
// const legacyTokenGeneration = (payload) => { ... }
```

Should be removed. If needed, retrieve from git history.

**Workaround**:
Acceptable to leave for now, doesn't affect functionality.

**Solution**:
Delete all commented-out code:

```bash
# Find commented code
grep -rn "^\s*//" src/ | grep -v "eslint" | grep -v "type" > commented.txt

# Review and delete
# Verify with git history if needed
```

**Acceptance Criteria**:
- [ ] No commented-out code
- [ ] No dead code branches

**Blocking**: No
**Depends On**: Code review
**Owner**: Frontend/Backend teams
**Target Phase**: 4

---

### DEBT-008: Environment Setup Manual

**Component**: DevOps / Setup
**Type**: Operations
**Severity**: Medium
**Estimated Effort**: 1 day
**Priority**: Low

**Description**:
Local development setup requires manual steps:
1. Copy `.env.example` to `.env`
2. Generate JWT secret: `openssl rand -base64 32`
3. Start Postgres: `docker run -d postgres`
4. Run migrations: `npm run migrate`
5. Seed database: `npm run seed`

Should be automated with `npm run setup` or Docker Compose.

**Workaround**:
Acceptable for small team. Onboarding takes 30 minutes.

**Solution**:
Create `setup.sh` script or Docker Compose file:

```bash
#!/bin/bash
cp .env.example .env
docker-compose up -d
npm install
npm run migrate
npm run seed
npm run dev
```

**Acceptance Criteria**:
- [ ] Single command setup: `./setup.sh`
- [ ] Or: `docker-compose up`
- [ ] New dev ready in <10 minutes

**Blocking**: No
**Depends On**: DevOps review
**Owner**: DevOps + Backend
**Target Phase**: 4 or 5

---

### DEBT-009: Performance Optimization Deferred

**Component**: Database queries, API responses
**Type**: Performance
**Severity**: Low
**Estimated Effort**: 3 days
**Priority**: Low

**Description**:
Several performance optimizations identified but deferred:
- [ ] Add database indexes on frequently queried columns
- [ ] Implement response pagination (currently returns all)
- [ ] Add caching layer (Redis)
- [ ] Compress API responses
- [ ] Lazy load UI components

**Current Performance**: Acceptable for <10k users
**Future Bottleneck**: Performance degradation at >50k users

**Workaround**:
Acceptable now. Monitor metrics as user base grows.

**Solution**:
Implement when metrics show need:

```javascript
// Example: Add database index
CREATE INDEX idx_tasks_user_id ON tasks(user_id);
CREATE INDEX idx_tasks_created_at ON tasks(created_at DESC);

// Example: Pagination
GET /api/tasks?page=1&limit=50

// Example: Caching
redis.set(`tasks:user:${userId}`, tasks, 'EX', 300);
```

**Acceptance Criteria**:
- [ ] Response time <500ms for normal queries
- [ ] Database queries use indexes
- [ ] Pagination implemented
- [ ] Cache hits >70%

**Blocking**: No - acceptable performance now
**Depends On**: Monitoring infrastructure
**Owner**: Backend + DevOps
**Target Phase**: 5 (when growth requires)

---

### DEBT-010: Security Enhancements Deferred

**Component**: Authentication, API
**Type**: Security
**Severity**: Low
**Estimated Effort**: 3 days
**Priority**: High (for production)

**Description**:
Security enhancements identified but deferred due to time:
- [ ] Add CSRF tokens to forms
- [ ] Implement rate limiting per user (currently global)
- [ ] Add security headers (CSP, HSTS, etc.)
- [ ] Implement API key rotation
- [ ] Add audit logging for sensitive operations

**Current Security**: Acceptable for MVP. Not production-grade.

**Workaround**:
Acceptable for staging. Must fix before production deployment.

**Solution**:
Before Phase 4 verification, implement:

```javascript
// Add CSRF protection
app.use(csrf());

// Security headers
app.use(helmet());

// Rate limiting per user
const limiter = rateLimit({
  store: new RedisStore({ client: redis }),
  keyGenerator: (req) => req.user?.id || req.ip,
});

// Audit logging
logger.audit({
  event: 'user_updated',
  user_id: req.user.id,
  target_user_id: updateData.id,
  changes: diff(oldData, newData),
});
```

**Acceptance Criteria**:
- [ ] CSRF tokens on all forms
- [ ] Per-user rate limiting working
- [ ] Security headers present
- [ ] Audit logs for sensitive operations
- [ ] Security review passed

**Blocking**: YES - for production
**Depends On**: Security team review
**Owner**: Security + Backend
**Target Phase**: 4 (required before production)

---

## Debt Register Summary

```markdown
# Summary Statistics

**Total Items**: 10
**Total Estimated Effort**: 23.5 person-days
**Average Effort**: 2.35 days

## By Priority

| Priority | Count | Effort | Days |
|----------|-------|--------|------|
| Critical | 1 | Security | 3 |
| High | 2 | N+1 + Tests | 5 |
| Medium | 5 | Config + Docs + Logs + Error Handling + Accessibility | 10 |
| Low | 2 | Cleanup + Performance | 5.5 |

## By Category

| Category | Count | Effort |
|----------|-------|--------|
| Performance | 2 | 5 days |
| Testing | 1 | 3 days |
| Documentation | 1 | 2 days |
| Configuration | 1 | 0.5 days |
| Observability | 1 | 1 day |
| Accessibility | 1 | 2 days |
| Code Quality | 1 | 0.5 days |
| Operations | 1 | 1 day |
| Security | 1 | 3 days |

## Remediation Timeline

**Must Do Before Production**:
- DEBT-010: Security enhancements (3 days)

**High Priority (do in Phase 4)**:
- DEBT-001: N+1 queries (2 days)
- DEBT-004: Missing tests (3 days)

**Medium Priority (do in Phase 4-5)**:
- DEBT-002: Hardcoded config (0.5 days)
- DEBT-003: Error context (1 day)
- DEBT-005: Documentation (2 days)
- DEBT-006: Accessibility (2 days)

**Low Priority (do in Phase 5)**:
- DEBT-007: Commented code (0.5 days)
- DEBT-008: Setup automation (1 day)
- DEBT-009: Performance (3 days)

**Total Effort**:
- Phase 4: ~11.5 days
- Phase 5: ~4.5 days
- Before Production: 3 days (DEBT-010)
```

---

## Management Workflow

### 1. During Implementation (Phase 3)

**When encountering shortcut**:
```
1. Pause work
2. Open debt register
3. Add debt item:
   - Name: Clear, searchable
   - Type: Performance, Testing, etc.
   - Severity: High, Medium, Low
   - Effort: Estimated days
   - Description: What & why deferred
   - Workaround: How it works now
   - Solution: How to fix it
4. Continue work
```

**Time to document**: <5 minutes per item

### 2. Before Phase 4 (Debt Review)

```
1. Print debt register
2. Team reviews all items
3. Prioritize for Phase 4/5
4. Estimate total effort
5. Allocate resources
6. Create Phase 4 tasks for high-priority items
```

**Time**: 1 hour team meeting

### 3. During Phase 4-5 (Remediation)

```
1. Take high-priority items first
2. Create task per debt item
3. Implement fix
4. Update debt register: Mark RESOLVED
5. Remove from register
```

### 4. Quarterly Review

**Every quarter**:
- [ ] Review all outstanding debt
- [ ] Prioritize again based on impact
- [ ] Plan remediation sprint if needed
- [ ] Celebrate items resolved

---

## Metrics to Track

**Debt Accumulation**:
- Items added per phase
- Average effort per item
- Total outstanding effort

**Debt Resolution**:
- Items fixed per quarter
- Time to resolution
- Impact of fixes

**Debt Health**:
- High-priority debt: should be <3 items
- Total debt: should be <30 days effort
- Resolution rate: should be >50% per quarter

---

## Best Practices

1. **Document Immediately**: Don't wait to batch document debt
2. **Be Honest**: Don't minimize effort or severity
3. **Include Workaround**: Explain how it works now
4. **Link to Code**: Include file:line references
5. **Prioritize Ruthlessly**: High priority debt must be resolved in Phase 4
6. **Don't Accumulate**: Keep total debt <1 month effort
7. **Review Regularly**: Weekly team sync on critical items

---

## Token Cost

**Creation**: ~200 tokens per debt item
**Review**: ~100 tokens per item
**Total Per Phase**: ~2,000-3,000 tokens

---

## Related Features

- [Code Quality Gates](code-quality-gates.md) - Block Phase 4 if critical debt
- [Progressive Checkpoints](progressive-checkpoints.md) - Save work before tackling debt
- [Task-Level Tracking](task-level-tracking.md) - Track debt remediation tasks

## Integration with Implementation Phase

Technical debt tracked **throughout Phase 3**:

```
During Phase 3
  ↓
Encounter shortcut
  ↓
Document in register
  ↓
Continue development
  ↓
Phase 3 Complete
  ↓
Review & Prioritize Debt
  ↓
Phase 4: Tackle High-Priority Items
  ↓
Phase 5: Address Remaining Debt
```

## Why This Matters

Prevents:
- ❌ Forgotten shortcuts becoming permanent bugs
- ❌ Surprise workload for Phase 4
- ❌ Accumulation of hidden complexity
- ❌ Team frustration with "technical debt"

Enables:
- ✅ Conscious trade-off decisions
- ✅ Systematic debt remediation
- ✅ Clear product roadmap
- ✅ Team alignment on priorities
- ✅ Data-driven decisions
