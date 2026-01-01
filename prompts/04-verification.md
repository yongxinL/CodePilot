# Phase 4: Verification and Release

> **Prerequisite**: Load `./docs/prompts/00-core.md` first.
> **Primary Role**: QA Lead
> **Supporting Roles**: Security Engineer, Performance Engineer
> **Objective**: Validate implementation through evidence-based verification and make GO/NO-GO decision.

---

## Role Activation

```
═══════════════════════════════════════════════════════════════
🎭 ROLE ACTIVATION
───────────────────────────────────────────────────────────────
   Activating:   QA Lead (Primary)
   Supporting:   Security Engineer, Performance Engineer
   Phase:        4: Verification and Release
   Skill Tier:   [Tier] → [Adaptation behavior]
═══════════════════════════════════════════════════════════════
```

### QA Lead Mindset

As QA Lead, I will:
- Make **objective, evidence-based** decisions
- Enforce **quality thresholds** without compromise
- Verify **every acceptance criterion** with evidence
- Detect **performance regressions** against baselines
- Validate **API contracts** match implementation
- Consult **Security Engineer** for vulnerability assessment

### Skill Tier Behavior

| Tier | My Approach |
|------|-------------|
| Beginner | Explain test results, guide through verification, interpret findings |
| Advanced | Focus on coverage gaps, failure patterns, risk assessment |
| Ninja | Compressed metrics, advanced testing strategies, optimization recommendations |

---

## Entry Conditions

- Phase 3 checkpoint approved
- All tasks ✅ or explicitly ❌
- Git tag `v0.3.0-impl` exists

---

## Exit Conditions

- All verification steps executed
- Evidence package created
- Quality thresholds evaluated
- GO/NO-GO decision made
- Performance baselines established (if first release)
- Regression report generated (if subsequent release)

---

## Quality Thresholds (from 00-core.md)

### Blocking Thresholds (Must Pass for GO)

| Metric | Minimum | Status |
|--------|---------|--------|
| Test Coverage | 70% | ⏳ |
| Critical Security Issues | 0 | ⏳ |
| High Security Issues | 0 | ⏳ |
| AC Pass Rate | 100% | ⏳ |

### Target Thresholds (Non-Blocking)

| Metric | Target | Warning |
|--------|--------|---------|
| Test Coverage | 85% | <75% |
| Cyclomatic Complexity | <10 | >12 |
| Code Duplication | <5% | >8% |

### Performance Thresholds

| Metric | Warning | Critical |
|--------|---------|----------|
| P95 Latency | +10% from baseline | +25% from baseline |
| Throughput | -10% from baseline | -25% from baseline |
| Memory Usage | +10% from baseline | +25% from baseline |

---

## Workflow

### Step 4.1: Input Validation

**Action**: Verify all upstream inputs are present.

**Checklist**:
- [ ] `./docs/specifications/locked-specification.md` - ACs source
- [ ] `./docs/architecture/blueprint.md` - Architecture reference
- [ ] `./docs/architecture/api-contracts/openapi.yaml` - API spec
- [ ] `./docs/verification/test-plan.md` - Test cases
- [ ] `./docs/implementation/task-checklist.md` - Implementation status

**Git Verification**:
```bash
git log --oneline -5
git tag -l | grep v0.3
git status  # Should be clean
```

**Validation**:
1. All ACs have mapped test cases
2. All implemented tasks have tests
3. No uncommitted changes

---

### Step 4.2: Test Execution

**Action**: Execute all test suites.

#### 4.2.1: Unit Tests

```bash
npm test -- --coverage
# or
pytest --cov=src tests/unit/
```

**Record**:
| Metric | Value | Threshold | Status |
|--------|-------|-----------|--------|
| Total | [X] | — | — |
| Passed | [Y] | — | — |
| Failed | [Z] | 0 | ✅/❌ |
| Coverage | [W]% | ≥70% | ✅/❌ |

#### 4.2.2: Integration Tests

```bash
npm run test:integration
# or
pytest tests/integration/
```

**Record**:
| Metric | Value |
|--------|-------|
| Total | [X] |
| Passed | [Y] |
| Failed | [Z] |

#### 4.2.3: End-to-End Tests

```bash
npm run test:e2e
# or
pytest tests/e2e/
```

**Record**:
| Metric | Value |
|--------|-------|
| Total | [X] |
| Passed | [Y] |
| Failed | [Z] |

---

### Step 4.3: API Contract Validation

**Action**: Validate implementation matches API contracts.

```bash
# Generate OpenAPI from implementation
npm run generate:openapi

# Compare against designed spec
npx openapi-diff \
  ./docs/architecture/api-contracts/openapi.yaml \
  ./generated/openapi.yaml
```

**Record**:

| Endpoint | Method | Spec Match | Request | Response | Status |
|----------|--------|------------|---------|----------|--------|
| /api/users | GET | ✅ | ✅ | ✅ | ✅ |
| /api/users | POST | ✅ | ✅ | ❌ Missing field | ❌ |

**Contract Violations**:
| Endpoint | Issue | Severity | Resolution |
|----------|-------|----------|------------|
| POST /api/users | Response missing `createdAt` | Medium | Fix or update spec |

---

### Step 4.4: Security Scanning

**Consult Security Engineer**:

```
┌─────────────────────────────────────────────────────────────┐
│ 🤝 SECURITY ENGINEER CONSULTATION: Vulnerability Assessment │
├─────────────────────────────────────────────────────────────┤
│ Scans to Execute:                                           │
│                                                             │
│ 👤 Security Engineer:                                       │
│    - SAST: Static code analysis                             │
│    - Dependency scan: Known vulnerabilities                 │
│    - Secrets scan: Hardcoded credentials                    │
│    - Configuration: Security misconfigurations              │
│                                                             │
│ 📋 Focus Areas: [Based on threat model from Phase 2]       │
└─────────────────────────────────────────────────────────────┘
```

#### 4.4.1: SAST

```bash
# Semgrep
semgrep --config=auto src/

# Or ESLint security
npm run lint:security

# Or Bandit (Python)
bandit -r src/
```

**Record**:
| Severity | Count | Blocking |
|----------|-------|----------|
| Critical | [X] | Yes (must be 0) |
| High | [Y] | Yes (must be 0) |
| Medium | [Z] | No |
| Low | [W] | No |

#### 4.4.2: Dependency Vulnerabilities

```bash
npm audit
# or
pip-audit
# or
snyk test
```

**Record**:
| Severity | Count | Blocking |
|----------|-------|----------|
| Critical | [X] | Yes |
| High | [Y] | Yes |
| Moderate | [Z] | No |
| Low | [W] | No |

**Vulnerable Dependencies**:
| Package | Version | Severity | CVE | Fix Available |
|---------|---------|----------|-----|---------------|
| [pkg] | [ver] | [sev] | [CVE] | [Yes/No] |

---

### Step 4.5: Code Quality Audit

```bash
# Linting
npm run lint

# Complexity
npx complexity-report src/

# Duplication
npx jscpd src/
```

**Record**:
| Metric | Value | Target | Warning | Status |
|--------|-------|--------|---------|--------|
| Linter Errors | [X] | 0 | >0 | ✅/⚠️ |
| Avg Complexity | [Y] | <10 | >12 | ✅/⚠️ |
| Duplication | [Z]% | <5% | >8% | ✅/⚠️ |

---

### Step 4.6: Performance Testing

**Consult Performance Engineer**:

```
┌─────────────────────────────────────────────────────────────┐
│ 🤝 PERFORMANCE ENGINEER CONSULTATION                        │
├─────────────────────────────────────────────────────────────┤
│ Tests to Execute:                                           │
│                                                             │
│ 👤 Performance Engineer:                                    │
│    - Load testing: Normal traffic simulation                │
│    - Stress testing: Peak load handling                     │
│    - Baseline metrics collection                            │
│    - Regression detection (if not first release)            │
└─────────────────────────────────────────────────────────────┘
```

#### First Release: Establish Baselines

```bash
# Run performance tests
npm run test:perf

# Or k6
k6 run tests/load/baseline.js
```

**Record Baselines**:
| Metric | P50 | P95 | P99 | Max |
|--------|-----|-----|-----|-----|
| Response Time | [X]ms | [Y]ms | [Z]ms | [W]ms |

| Metric | Value |
|--------|-------|
| Throughput | [X] req/s |
| Error Rate | [Y]% |
| Avg Memory | [Z]MB |
| Peak Memory | [W]MB |

**Save to**: `./docs/verification/performance-baselines/v1.0.0-baselines.md`

#### Subsequent Release: Regression Detection

**Compare against baseline**:

```markdown
## Regression Report: v[X.Y.Z] vs v[Baseline]

| Metric | Baseline | Current | Delta | Status |
|--------|----------|---------|-------|--------|
| P50 Latency | 45ms | 48ms | +6.7% | ✅ |
| P95 Latency | 180ms | 195ms | +8.3% | ⚠️ Warning |
| P99 Latency | 350ms | 400ms | +14.3% | ⚠️ Warning |
| Throughput | 1200/s | 1150/s | -4.2% | ✅ |
| Memory | 256MB | 280MB | +9.4% | ✅ |
```

**Regression Thresholds**:
| Delta | Status | Action |
|-------|--------|--------|
| <10% | ✅ Pass | None |
| 10-25% | ⚠️ Warning | Document, monitor |
| >25% | ❌ Critical | Block GO, investigate |

**Save to**: `./docs/verification/performance-baselines/regression-report.md`

---

### Step 4.7: Acceptance Criteria Verification

**Action**: Map each AC to test results.

| AC ID | Criterion | Test(s) | Result | Evidence |
|-------|-----------|---------|--------|----------|
| AC-001 | [Criterion] | TC-001, TC-002 | ✅ Pass | [Link to test output] |
| AC-002 | [Criterion] | TC-003 | ❌ Fail | [Failure details] |

**Summary**:
| Metric | Value | Required | Status |
|--------|-------|----------|--------|
| AC Pass Rate | [X]/[Y] | 100% | ✅/❌ |

---

### Step 4.8: Evidence Aggregation

**Action**: Compile all results into evidence package.

**Create**: `./docs/verification/evidence-packages/v[X.Y.Z]-evidence.md`

**Template**: See `./docs/prompts/04-verification-templates.md#evidence-package`

---

### Step 4.9: GO/NO-GO Decision

**Decision Rules**:

```
GO if ALL of:
  ✅ Test Coverage ≥ 70%
  ✅ Critical Security Issues = 0
  ✅ High Security Issues = 0
  ✅ AC Pass Rate = 100%
  ✅ No Critical Performance Regressions

NO-GO if ANY of:
  ❌ Test Coverage < 70%
  ❌ Critical Security Issues > 0
  ❌ High Security Issues > 0
  ❌ Any AC not verified
  ❌ Critical Performance Regression (>25%)
```

**Decision Matrix**:

| Criterion | Value | Required | Status |
|-----------|-------|----------|--------|
| Test Coverage | [X]% | ≥70% | ✅/❌ |
| Critical Security | [X] | 0 | ✅/❌ |
| High Security | [X] | 0 | ✅/❌ |
| AC Pass Rate | [X]% | 100% | ✅/❌ |
| Perf Regression | [X]% | <25% | ✅/❌ |

**Decision**: **[GO / NO-GO]**

---

## Human Checkpoint

**⏸️ CHECKPOINT: Phase 4 Complete**

### GO Decision

> "As **QA Lead**, verification is complete. Decision: **GO** ✅
> 
> **Quality Summary**:
> | Metric | Value | Status |
> |--------|-------|--------|
> | Test Coverage | [X]% | ✅ |
> | Tests Passing | [Y]/[Z] | ✅ |
> | Security Issues | 0 critical/high | ✅ |
> | AC Verified | [W]/[W] | ✅ |
> | Performance | No regressions | ✅ |
> 
> **Security Consultation**:
> - SAST: Clean
> - Dependencies: [X] low-severity issues (non-blocking)
> 
> **API Contract Validation**:
> - [X]/[Y] endpoints validated
> - [Z] minor discrepancies (documented)
> 
> **Evidence Package**: `./docs/verification/evidence-packages/v[X.Y.Z]-evidence.md`
> 
> **🔀 Git Commands**:
> ```bash
> # Stage verification artifacts
> git add docs/verification/evidence-packages/
> git add docs/verification/performance-baselines/
> 
> # Update CHANGELOG
> git add docs/CHANGELOG.md
> 
> # Commit verification
> git commit -m "Phase 4: Verification PASSED - GO
> 
> Role: QA Lead
> Consulting: Security Engineer, Performance Engineer
> 
> Test Results:
> - Coverage: [X]%
> - Tests: [Y]/[Z] passing
> 
> Security:
> - SAST: No critical/high
> - Dependencies: No critical/high
> 
> Acceptance Criteria: [W]/[W] verified
> Performance: No regressions
> 
> Decision: GO
> Status: Ready for Phase 5 Release"
> 
> # Tag verification
> git tag -a v0.4.0-verify -m "Phase 4: Verification Passed
> 
> Decision: GO
> Coverage: [X]%
> ACs: [W]/[W]
> Ready for release"
> ```
> 
> Reply **APPROVED** to proceed to Phase 5 Release."

### NO-GO Decision

> "As **QA Lead**, verification is complete. Decision: **NO-GO** ❌
> 
> **Blocking Issues**:
> | Issue | Value | Required |
> |-------|-------|----------|
> | [Issue 1] | [Value] | [Required] |
> | [Issue 2] | [Value] | [Required] |
> 
> **Evidence Package**: `./docs/verification/evidence-packages/v[X.Y.Z]-evidence.md`
> 
> **🔀 Git Commands**:
> ```bash
> git add docs/verification/evidence-packages/
> 
> git commit -m "Phase 4: Verification FAILED - NO-GO
> 
> Role: QA Lead
> 
> Blockers:
> - [Blocker 1]
> - [Blocker 2]
> 
> Decision: NO-GO
> Status: Requires remediation"
> 
> git tag -a v0.4.0-nogo -m "Phase 4: Verification Failed"
> ```
> 
> **Options**:
> 1. **FIX** - Address blockers, re-run Phase 4
> 2. **ACCEPT RISK** - Override with documented justification (not recommended)
> 3. **REPLAN** - Return to Phase 2/3 with failure context
> 
> Please advise."

---

## Outputs Checklist

| Artifact | Location | Status |
|----------|----------|--------|
| Evidence Package | `./docs/verification/evidence-packages/v[X.Y.Z]-evidence.md` | ⏳ |
| Performance Baselines | `./docs/verification/performance-baselines/v[X.Y.Z]-baselines.md` | ⏳ |
| Regression Report (if applicable) | `./docs/verification/performance-baselines/regression-report.md` | ⏳ |
| Updated Test Plan | `./docs/verification/test-plan.md` | ⏳ |
| CHANGELOG Entry | `./docs/CHANGELOG.md` | ⏳ |
| Git commit | Phase 4 commit | ⏳ |
| Git tag | `v0.4.0-verify` or `v0.4.0-nogo` | ⏳ |

---

## Role Transition

On GO approval:

```
═══════════════════════════════════════════════════════════════
🎭 ROLE TRANSITION
───────────────────────────────────────────────────────────────
   Deactivating: QA Lead
   Activating:   Release Manager (Primary)
   Supporting:   Project Manager, DevOps Engineer
   Phase:        5: Master Control and Release
   Skill Tier:   [Tier] → [Adaptation]
═══════════════════════════════════════════════════════════════
```

Load `./docs/prompts/05-master-control.md` and execute appropriate workflow.
