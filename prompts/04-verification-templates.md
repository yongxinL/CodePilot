# Phase 4: Output Templates

> **Usage**: Load only when generating artifacts. Reduces context overhead.

---

## Evidence Package Template

**File**: `./docs/verification/evidence-packages/v[X.Y.Z]-evidence.md`

```markdown
# Evidence Package: v[X.Y.Z]

## Meta
| Field | Value |
|-------|-------|
| Version | [X.Y.Z] |
| Created | [Date] |
| Role | QA Lead |
| Consulting | Security Engineer, Performance Engineer |
| Decision | [GO / NO-GO] |

## Linked Artifacts
| Artifact | Version | Location |
|----------|---------|----------|
| Specification | v[X.Y] | `./docs/specifications/locked-specification.md` |
| Blueprint | v[X.Y] | `./docs/architecture/blueprint.md` |
| API Contract | v[X.Y] | `./docs/architecture/api-contracts/openapi.yaml` |
| Test Plan | v[X.Y] | `./docs/verification/test-plan.md` |

---

## Executive Summary

**Decision**: [GO / NO-GO]

**Overall Quality Score**: [X]/100

| Category | Score | Weight | Weighted |
|----------|-------|--------|----------|
| Test Coverage | [X]/100 | 25% | [Y] |
| Test Pass Rate | [X]/100 | 25% | [Y] |
| Security | [X]/100 | 25% | [Y] |
| AC Verification | [X]/100 | 25% | [Y] |

---

## 1. Test Results

### 1.1 Unit Tests
| Metric | Value |
|--------|-------|
| Total | [X] |
| Passed | [Y] |
| Failed | [Z] |
| Skipped | [W] |
| Pass Rate | [V]% |

**Failed Tests**:
| Test | Error | Severity |
|------|-------|----------|
| [test name] | [error] | [Critical/High/Medium] |

### 1.2 Integration Tests
| Metric | Value |
|--------|-------|
| Total | [X] |
| Passed | [Y] |
| Failed | [Z] |
| Pass Rate | [W]% |

### 1.3 End-to-End Tests
| Metric | Value |
|--------|-------|
| Total | [X] |
| Passed | [Y] |
| Failed | [Z] |
| Pass Rate | [W]% |

### 1.4 Coverage Report
| Scope | Lines | Branches | Functions | Statements |
|-------|-------|----------|-----------|------------|
| Overall | [X]% | [Y]% | [Z]% | [W]% |
| src/module1 | [X]% | [Y]% | [Z]% | [W]% |
| src/module2 | [X]% | [Y]% | [Z]% | [W]% |

**Threshold Compliance**:
| Metric | Value | Minimum | Target | Status |
|--------|-------|---------|--------|--------|
| Line Coverage | [X]% | 70% | 85% | ✅/❌ |

---

## 2. Security Assessment

### 2.1 SAST Results
| Severity | Count | Status |
|----------|-------|--------|
| Critical | [X] | ✅/❌ (must be 0) |
| High | [Y] | ✅/❌ (must be 0) |
| Medium | [Z] | ⚠️ |
| Low | [W] | ℹ️ |

**Findings**:
| ID | Severity | Location | Description | Status |
|----|----------|----------|-------------|--------|
| [ID] | [Sev] | [File:Line] | [Desc] | [Fixed/Accepted/Deferred] |

### 2.2 Dependency Vulnerabilities
| Severity | Count | Status |
|----------|-------|--------|
| Critical | [X] | ✅/❌ |
| High | [Y] | ✅/❌ |
| Moderate | [Z] | ⚠️ |
| Low | [W] | ℹ️ |

**Vulnerable Dependencies**:
| Package | Version | Severity | CVE | Fix | Status |
|---------|---------|----------|-----|-----|--------|
| [pkg] | [ver] | [sev] | [CVE] | [fix ver] | [Fixed/Accepted] |

### 2.3 Security Engineer Assessment
```
Consulted: [Date]
Risk Level: [Low/Medium/High]

Summary:
[Security Engineer's overall assessment]

Recommendations:
1. [Recommendation 1]
2. [Recommendation 2]
```

---

## 3. API Contract Validation

### 3.1 Endpoint Coverage
| Endpoint | Method | Specified | Implemented | Match |
|----------|--------|-----------|-------------|-------|
| /api/users | GET | ✅ | ✅ | ✅ |
| /api/users | POST | ✅ | ✅ | ✅ |
| /api/users/{id} | GET | ✅ | ✅ | ✅ |

### 3.2 Schema Validation
| Schema | Fields Specified | Fields Implemented | Match |
|--------|------------------|-------------------|-------|
| User | [X] | [Y] | ✅/❌ |
| Error | [X] | [Y] | ✅/❌ |

### 3.3 Discrepancies
| Endpoint | Type | Spec | Implementation | Resolution |
|----------|------|------|----------------|------------|
| [endpoint] | [Request/Response] | [Spec value] | [Impl value] | [Fix code/Update spec] |

---

## 4. Code Quality

### 4.1 Linting
| Metric | Value | Status |
|--------|-------|--------|
| Errors | [X] | ✅/❌ |
| Warnings | [Y] | ⚠️ |

### 4.2 Complexity
| Metric | Value | Target | Warning | Status |
|--------|-------|--------|---------|--------|
| Average Cyclomatic | [X] | <10 | >12 | ✅/⚠️/❌ |
| Max Cyclomatic | [Y] | <20 | >25 | ✅/⚠️/❌ |

**High Complexity Functions**:
| Function | Location | Complexity | Action |
|----------|----------|------------|--------|
| [func] | [file:line] | [X] | [Refactor/Accept] |

### 4.3 Duplication
| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| Duplication % | [X]% | <5% | ✅/⚠️ |
| Duplicate Blocks | [Y] | — | — |

---

## 5. Performance

### 5.1 Baseline Metrics (First Release)
| Metric | P50 | P95 | P99 | Max |
|--------|-----|-----|-----|-----|
| Response Time | [X]ms | [Y]ms | [Z]ms | [W]ms |

| Metric | Value |
|--------|-------|
| Throughput | [X] req/s |
| Error Rate | [Y]% |
| Memory (avg) | [Z]MB |
| Memory (peak) | [W]MB |

### 5.2 Regression Analysis (Subsequent Release)
| Metric | Baseline | Current | Delta | Status |
|--------|----------|---------|-------|--------|
| P50 Latency | [X]ms | [Y]ms | [Z]% | ✅/⚠️/❌ |
| P95 Latency | [X]ms | [Y]ms | [Z]% | ✅/⚠️/❌ |
| P99 Latency | [X]ms | [Y]ms | [Z]% | ✅/⚠️/❌ |
| Throughput | [X]/s | [Y]/s | [Z]% | ✅/⚠️/❌ |
| Memory | [X]MB | [Y]MB | [Z]% | ✅/⚠️/❌ |

### 5.3 Performance Engineer Assessment
```
Consulted: [Date]

Summary:
[Performance Engineer's assessment]

Concerns:
- [Concern 1]

Recommendations:
- [Recommendation 1]
```

---

## 6. Acceptance Criteria Verification

### 6.1 AC Matrix
| AC ID | Criterion | Test(s) | Result | Evidence |
|-------|-----------|---------|--------|----------|
| AC-001 | [Criterion text] | TC-001, TC-002 | ✅ | Test output |
| AC-002 | [Criterion text] | TC-003 | ✅ | Test output |
| AC-003 | [Criterion text] | Manual | ✅ | Screenshot |

### 6.2 Summary
| Metric | Value | Required | Status |
|--------|-------|----------|--------|
| Total ACs | [X] | — | — |
| Verified | [Y] | [X] | ✅/❌ |
| Pass Rate | [Z]% | 100% | ✅/❌ |

---

## 7. Decision Summary

### 7.1 Blocking Criteria
| Criterion | Required | Actual | Status |
|-----------|----------|--------|--------|
| Test Coverage | ≥70% | [X]% | ✅/❌ |
| Critical Security | 0 | [X] | ✅/❌ |
| High Security | 0 | [X] | ✅/❌ |
| AC Pass Rate | 100% | [X]% | ✅/❌ |
| Critical Perf Regression | <25% | [X]% | ✅/❌ |

### 7.2 Decision
**Result**: [GO / NO-GO]

**Rationale**:
[Explanation of decision]

### 7.3 Conditions (if applicable)
- [Condition 1]
- [Condition 2]

### 7.4 Risk Acceptance (if NO-GO overridden)
| Risk | Impact | Mitigation | Approver |
|------|--------|------------|----------|
| [Risk] | [Impact] | [Mitigation] | [Name] |

---

## 8. Appendix

### 8.1 Test Execution Log
```
[Test runner output summary]
```

### 8.2 Security Scan Output
```
[Scan tool output summary]
```

### 8.3 Performance Test Output
```
[Load test output summary]
```
```

---

## Performance Baseline Template

**File**: `./docs/verification/performance-baselines/v[X.Y.Z]-baselines.md`

```markdown
# Performance Baseline: v[X.Y.Z]

## Meta
| Field | Value |
|-------|-------|
| Version | [X.Y.Z] |
| Established | [Date] |
| Test Environment | [Description] |
| Load Profile | [Description] |
| Duration | [X] minutes |

---

## Test Configuration

### Environment
| Component | Specification |
|-----------|---------------|
| CPU | [X] cores |
| Memory | [X] GB |
| Storage | [Type, IOPS] |
| Network | [Bandwidth] |

### Load Profile
| Parameter | Value |
|-----------|-------|
| Virtual Users | [X] |
| Ramp Up | [X] seconds |
| Steady State | [X] minutes |
| Ramp Down | [X] seconds |

### Endpoints Tested
| Endpoint | Method | Weight |
|----------|--------|--------|
| /api/users | GET | 40% |
| /api/users | POST | 20% |
| /api/users/{id} | GET | 30% |
| /api/users/{id} | PUT | 10% |

---

## Response Time Metrics

### Overall
| Percentile | Value |
|------------|-------|
| P50 | [X]ms |
| P75 | [Y]ms |
| P90 | [Z]ms |
| P95 | [W]ms |
| P99 | [V]ms |
| Max | [U]ms |

### By Endpoint
| Endpoint | P50 | P95 | P99 |
|----------|-----|-----|-----|
| GET /api/users | [X]ms | [Y]ms | [Z]ms |
| POST /api/users | [X]ms | [Y]ms | [Z]ms |
| GET /api/users/{id} | [X]ms | [Y]ms | [Z]ms |

---

## Throughput Metrics

| Metric | Value |
|--------|-------|
| Requests/second | [X] |
| Successful | [Y] |
| Failed | [Z] |
| Error Rate | [W]% |

---

## Resource Utilization

### Application
| Metric | Average | Peak |
|--------|---------|------|
| CPU | [X]% | [Y]% |
| Memory | [X]MB | [Y]MB |
| Threads | [X] | [Y] |
| Connections | [X] | [Y] |

### Database (if applicable)
| Metric | Average | Peak |
|--------|---------|------|
| CPU | [X]% | [Y]% |
| Connections | [X] | [Y] |
| Query Time (avg) | [X]ms | [Y]ms |

---

## Thresholds for Regression Detection

| Metric | Baseline | Warning (+10%) | Critical (+25%) |
|--------|----------|----------------|-----------------|
| P95 Latency | [X]ms | [Y]ms | [Z]ms |
| P99 Latency | [X]ms | [Y]ms | [Z]ms |
| Throughput | [X]/s | [Y]/s (−10%) | [Z]/s (−25%) |
| Error Rate | [X]% | [Y]% | [Z]% |
| Memory | [X]MB | [Y]MB | [Z]MB |

---

## Notes

### Observations
- [Observation 1]
- [Observation 2]

### Known Limitations
- [Limitation 1]

### Recommendations for Future Tests
- [Recommendation 1]
```

---

## Regression Report Template

**File**: `./docs/verification/performance-baselines/regression-report.md`

```markdown
# Performance Regression Report

## Meta
| Field | Value |
|-------|-------|
| Current Version | v[X.Y.Z] |
| Baseline Version | v[A.B.C] |
| Comparison Date | [Date] |
| Role | QA Lead + Performance Engineer |

---

## Executive Summary

**Regression Status**: [No Regressions / Warnings / Critical]

| Status | Count |
|--------|-------|
| ✅ Pass | [X] |
| ⚠️ Warning | [Y] |
| ❌ Critical | [Z] |

---

## Detailed Comparison

### Response Time
| Metric | Baseline | Current | Delta | Status |
|--------|----------|---------|-------|--------|
| P50 | [X]ms | [Y]ms | [+/-Z]% | ✅/⚠️/❌ |
| P75 | [X]ms | [Y]ms | [+/-Z]% | ✅/⚠️/❌ |
| P90 | [X]ms | [Y]ms | [+/-Z]% | ✅/⚠️/❌ |
| P95 | [X]ms | [Y]ms | [+/-Z]% | ✅/⚠️/❌ |
| P99 | [X]ms | [Y]ms | [+/-Z]% | ✅/⚠️/❌ |

### Throughput
| Metric | Baseline | Current | Delta | Status |
|--------|----------|---------|-------|--------|
| Requests/s | [X] | [Y] | [+/-Z]% | ✅/⚠️/❌ |
| Error Rate | [X]% | [Y]% | [+/-Z]% | ✅/⚠️/❌ |

### Resource Usage
| Metric | Baseline | Current | Delta | Status |
|--------|----------|---------|-------|--------|
| CPU (avg) | [X]% | [Y]% | [+/-Z]% | ✅/⚠️/❌ |
| Memory (avg) | [X]MB | [Y]MB | [+/-Z]% | ✅/⚠️/❌ |
| Memory (peak) | [X]MB | [Y]MB | [+/-Z]% | ✅/⚠️/❌ |

---

## Regressions Detected

### Critical (Blocking)
| Metric | Delta | Impact | Investigation |
|--------|-------|--------|---------------|
| [Metric] | +[X]% | [Impact] | [Investigation notes] |

### Warnings (Non-Blocking)
| Metric | Delta | Recommendation |
|--------|-------|----------------|
| [Metric] | +[X]% | [Monitor / Investigate] |

---

## Root Cause Analysis (for Critical)

### Regression 1: [Metric]

**Symptom**: [What was observed]

**Investigation**:
1. [Step 1]
2. [Step 2]

**Root Cause**: [Identified cause]

**Recommendations**:
- [Fix recommendation]

---

## Decision

**Can Proceed**: [Yes / No]

**Conditions**:
- [Condition if any]

**Sign-off**:
| Role | Name | Date |
|------|------|------|
| QA Lead | | |
| Performance Engineer | | |
```

---

## CHANGELOG Entry Template

**File**: `./docs/CHANGELOG.md` (append)

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- [Feature 1] (FR-XXX, AC-XXX)
- [Feature 2] (FR-XXX, AC-XXX)

### Changed
- [Change 1]
- [Change 2]

### Fixed
- [Fix 1] (Issue #XXX)

### Security
- [Security improvement]

### Performance
- [Performance improvement]

### Deprecated
- [Deprecated feature]

### Removed
- [Removed feature]

---

**Verification**: v0.4.0-verify
**Evidence**: `./docs/verification/evidence-packages/v[X.Y.Z]-evidence.md`
```
