# Test Coverage Matrix - CodePilot v2.0

**Tier**: Core+
**Phase**: 4 (Verification)
**Feature #**: 21

## Purpose

Create visual matrix showing test coverage by feature and test type, enabling quick identification of coverage gaps before release.

## When to Use

During Phase 4 verification, use this matrix to verify all features have adequate test coverage and to visualize coverage across the codebase.

## Configuration Check

```javascript
config = read(".codepilot.config.json");
if (config.feature_tier >= "core_plus") {
  enable_test_coverage_matrix();
} else {
  skip_this_feature();
}
```

## Create Artifact

**File**: `docs/artifacts/phase4-verification/test-coverage-matrix.md`

## Coverage Matrix Format

```markdown
# Test Coverage Matrix

**Phase**: 4 (Verification)
**Date**: YYYY-MM-DD
**Overall Coverage**: 89%
**Target Coverage**: 80%+
**Status**: ✅ PASS

---

## Summary by Feature

| Feature | Unit | Integration | E2E | Total | Status | Gap |
|---------|------|-------------|-----|-------|--------|-----|
| Authentication | 95% | 92% | 88% | 92% | ✅ | - |
| User Profile | 88% | 85% | 80% | 84% | ✅ | - |
| Tasks | 90% | 88% | 92% | 90% | ✅ | - |
| Teams | 85% | 82% | 78% | 82% | ✅ | - |
| Real-time | 92% | 89% | 85% | 89% | ✅ | - |
| Dashboard | 78% | 75% | 82% | 78% | ✅ | - |
| Search | 85% | 83% | 80% | 83% | ✅ | - |
| API | 91% | 90% | 88% | 90% | ✅ | - |

**Legend**:
- ✅ = Meets target (≥80%)
- ⚠️ = Below target, needs review (70-79%)
- ❌ = Critical gap (< 70%)

---

## Detailed Coverage by Component

### Authentication Module

| Component | File | Unit | Integration | E2E | Total | Note |
|-----------|------|------|-------------|-----|-------|------|
| Register | auth.controller.ts | 96% | 94% | 90% | 93% | ✅ |
| Login | auth.controller.ts | 95% | 90% | 88% | 91% | ✅ |
| Token Refresh | auth.service.ts | 94% | 92% | 85% | 90% | ✅ |
| Password Reset | auth.service.ts | 92% | 88% | 85% | 88% | ✅ |
| JWT Validation | jwt.middleware.ts | 98% | 95% | N/A | 96% | ✅ |
| Permission Check | rbac.middleware.ts | 90% | 85% | 82% | 86% | ✅ |

**Summary**: 92% overall (target: 90%) ✅

---

### User Profile Module

| Component | File | Unit | Integration | E2E | Total | Note |
|-----------|------|------|-------------|-----|-------|------|
| Get Profile | user.controller.ts | 85% | 80% | 75% | 80% | ⚠️ |
| Update Profile | user.controller.ts | 88% | 85% | 82% | 85% | ✅ |
| Upload Avatar | file.service.ts | 92% | 88% | 85% | 88% | ✅ |
| Change Password | auth.service.ts | 90% | 87% | 85% | 87% | ✅ |
| Preferences | user.service.ts | 80% | 78% | 72% | 77% | ⚠️ |

**Summary**: 84% overall (target: 85%) ⚠️

**Gaps**:
- Get Profile: Missing tests for invalid user IDs
- Preferences: Missing tests for permission edge cases

**Action**: Add 5-10 tests to reach 85%

---

### Tasks Module

| Component | File | Unit | Integration | E2E | Total | Note |
|-----------|------|------|-------------|-----|-------|------|
| Create | task.controller.ts | 92% | 90% | 88% | 90% | ✅ |
| Read | task.controller.ts | 90% | 88% | 92% | 90% | ✅ |
| Update | task.controller.ts | 88% | 86% | 90% | 88% | ✅ |
| Delete | task.controller.ts | 90% | 88% | 90% | 89% | ✅ |
| Bulk Update | task.service.ts | 85% | 80% | 78% | 81% | ✅ |
| Search | search.service.ts | 88% | 85% | 82% | 85% | ✅ |
| Filters | filter.service.ts | 92% | 90% | 88% | 90% | ✅ |

**Summary**: 90% overall (target: 90%) ✅

---

### Teams Module

| Component | File | Unit | Integration | E2E | Total | Note |
|-----------|------|------|-------------|-----|-------|------|
| Create | team.controller.ts | 88% | 85% | 80% | 84% | ✅ |
| Members | team.service.ts | 82% | 78% | 75% | 78% | ⚠️ |
| Invite | invite.service.ts | 85% | 82% | 80% | 82% | ✅ |
| Roles | rbac.service.ts | 88% | 85% | 82% | 85% | ✅ |

**Summary**: 82% overall (target: 85%) ⚠️

**Gaps**:
- Members management missing concurrent update tests

---

## Coverage by Test Type

### Unit Tests (60% of total)

```
Target: ≥80% unit coverage for business logic

Authentication: 96% ✅
User Profile: 86% ✅
Tasks: 90% ✅
Teams: 85% ✅
Real-time: 92% ✅
Dashboard: 78% ⚠️
Search: 88% ✅
API: 91% ✅

Average: 89% ✅
```

**Unit Test Pyramid**:
- Fast: <10ms per test
- Isolated: No external dependencies
- Focused: One behavior per test

---

### Integration Tests (25% of total)

```
Target: ≥70% integration coverage for workflows

Authentication: 92% ✅
User Profile: 83% ✅
Tasks: 88% ✅
Teams: 80% ✅
Real-time: 89% ✅
Dashboard: 75% ⚠️
Search: 83% ✅
API: 90% ✅

Average: 85% ✅
```

**Integration Test Pyramid**:
- Medium speed: 100-500ms per test
- Partially isolated: Database + cache
- Workflow focused: Multiple components

---

### E2E Tests (15% of total)

```
Target: ≥75% E2E coverage for critical paths

Authentication: 88% ✅
User Profile: 79% ✅
Tasks: 91% ✅
Teams: 78% ✅
Real-time: 85% ✅
Dashboard: 82% ✅
Search: 80% ✅
API: 88% ✅

Average: 84% ✅
```

**E2E Test Pyramid**:
- Slow: 1-10 seconds per test
- Full isolation: Real browser/API
- User scenario focused: Feature workflows

---

## Coverage Heatmap

```
Feature        Unit  Integration  E2E   Overall
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Auth          ████████████ 96%  ████████░ 92%
Tasks         ███████████░ 90%  ████████░ 88%
API           ███████████░ 91%  ████████░ 90%
Real-time     ████████████ 92%  █████████░ 89%
Search        ███████████░ 88%  ████████░ 85%
User Profile  ██████████░░ 86%  ████████░ 83%
Teams         ███████████░ 85%  ████████░ 80%
Dashboard     ███████░░░░░ 78%  ███████░░ 75%
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Average       ███████████░ 89%  ████████░ 86%
```

---

## Coverage by Criticality

### Tier 1: Critical Features (≥95% coverage required)

| Feature | Coverage | Status | Risk |
|---------|----------|--------|------|
| Authentication | 92% | ⚠️ | Medium |
| Payment Processing | N/A | N/A | N/A |
| User Data | 88% | ⚠️ | High |

**Tier 1 Total**: 90% (target: 95%) - NEEDS WORK

### Tier 2: Core Features (≥85% coverage required)

| Feature | Coverage | Status | Risk |
|---------|----------|--------|------|
| Tasks | 90% | ✅ | Low |
| Teams | 82% | ⚠️ | Medium |
| Real-time | 89% | ✅ | Low |
| Search | 83% | ⚠️ | Medium |

**Tier 2 Total**: 86% (target: 85%) ✅

### Tier 3: UI Features (≥75% coverage required)

| Feature | Coverage | Status | Risk |
|---------|----------|--------|------|
| Dashboard | 78% | ✅ | Low |
| Components | 82% | ✅ | Low |

**Tier 3 Total**: 80% (target: 75%) ✅

---

## Coverage Gaps

### High Priority (Block Release)

**Authentication Coverage: 92% (target: 95%)**

```
Missing Coverage:
- JWT refresh token expiry edge cases
- Permission check under load
- Concurrent login attempts

Tests Needed:
- [ ] Test token refresh after clock skew
- [ ] Test permission check with 1000+ roles
- [ ] Test concurrent login from multiple IPs

Effort: 1 day
```

---

### Medium Priority (Fix Before Release)

**User Profile: 84% (target: 85%)**

```
Missing Coverage:
- Get profile with suspended account
- Update profile with concurrent changes
- Avatar upload size boundary

Tests Needed:
- [ ] Test get profile with suspended status
- [ ] Test concurrent profile updates
- [ ] Test avatar upload edge sizes

Effort: 0.5 days
```

**Teams: 82% (target: 85%)**

```
Missing Coverage:
- Member concurrent add/remove
- Role permission changes during operation
- Team deletion with tasks

Tests Needed:
- [ ] Test concurrent member changes
- [ ] Test role changes mid-update
- [ ] Test team deletion cascades

Effort: 1 day
```

---

### Low Priority (Fix After Release)

**Dashboard: 78% (target: 75%)**

```
Already meets target, can optimize later.
```

---

## Action Items

| Item | Priority | Effort | Estimated |
|------|----------|--------|-----------|
| Add Auth JWT edge cases | High | 1 day | Jan 10 |
| Add User Profile tests | Medium | 0.5 days | Jan 10 |
| Add Teams concurrency tests | Medium | 1 day | Jan 11 |
| Review Dashboard coverage | Low | 0.5 days | Jan 15 |

**Total**: 3 days to reach all targets

---

## Coverage Trend

```
Phase 2 (Planning):
- Target: N/A
- Actual: N/A

Phase 3 (Implementation):
- Target: ≥80%
- Actual: 89% ✅

Phase 4 (Verification):
- Target: ≥85%
- Actual: 89% (current) → 92% (after fixes)
- Trend: ⬆️ Improving

Phase 5 (Master):
- Target: ≥90%
- Expected: 94%
```

---

## Coverage Dashboard Commands

```bash
# Generate coverage report
npm run test:coverage

# Generate HTML coverage report
npm run test:coverage -- --report=html

# View coverage dashboard
open coverage/index.html

# Track coverage over time
npm run test:coverage -- --benchmark

# Coverage by file
npm run test:coverage -- --per-file

# Coverage change from last version
npm run test:coverage -- --compare
```

---

## Integration with CI/CD

**Pre-commit Hook**:
```bash
# Fail if coverage drops
npm run test:coverage && \
  node scripts/check-coverage-threshold.js
```

**Pull Request Check**:
```bash
# Require coverage for changed files
# Block merge if coverage < 80%
scripts/check-pr-coverage.js PR-123
```

**Release Gate**:
```bash
# Must pass before release
scripts/verify-release-coverage.js v1.0.0
```

---

## Best Practices

1. **Focus on Critical Paths**: 95% coverage for auth, 90% for core, 75% for UI
2. **Test Types Matter**: Mix unit (60%), integration (25%), E2E (15%)
3. **Fast Tests**: Unit tests should be <10ms each
4. **Real Data**: Integration and E2E with realistic scenarios
5. **Update Regularly**: Coverage matrix updated with each build
6. **Celebrate Progress**: Track trending toward targets

---

## Token Cost

**Generate Matrix**: ~200 tokens
**Analyze Gaps**: ~150 tokens
**Update Per Phase**: ~100 tokens

**Total Per Phase**: ~500 tokens

---

## Related Features

- [Code Quality Gates](../phase3-implementation/code-quality-gates.md) - Enforce coverage minimums
- [Release Readiness Checklist](release-readiness-checklist.md) - Coverage checked here
- [Performance Benchmarks](performance-benchmarks.md) - Track test performance

## Integration with Verification Phase

Coverage matrix created **early in Phase 4**:

```
Phase 4 Start
  ↓
Generate Coverage Matrix
  ↓
Identify Gaps
  ↓
Prioritize Work
  ↓
Fix High-Priority Gaps
  ↓
Verify Coverage Targets Met
  ↓
Phase 4 → Phase 5
```

## Why This Matters

Prevents:
- ❌ Releasing code with untested features
- ❌ Critical path failures in production
- ❌ Undiscovered bugs in integration
- ❌ False confidence from incomplete testing

Enables:
- ✅ Visual overview of test quality
- ✅ Quick gap identification
- ✅ Confident release decisions
- ✅ Data-driven testing strategy
