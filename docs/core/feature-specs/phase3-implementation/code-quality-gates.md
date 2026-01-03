# Code Quality Gates - CodePilot v2.0

**Tier**: Core+
**Phase**: 3 (Implementation)
**Feature #**: 19

## Purpose

Enforce code quality standards before Phase 4 verification, ensuring minimum thresholds for test coverage, linting, type checking, and architectural compliance are met before release.

## When to Use

Before marking Phase 3 complete, run quality gates to verify all code meets production standards. Block Phase 4 entry if any gate fails.

## Configuration Check

```javascript
config = read(".codepilot.config.json");
if (config.feature_tier >= "core_plus") {
  enable_quality_gates();
} else {
  skip_this_feature();
}
```

## Quality Gates Checklist

Create artifact: `docs/artifacts/phase3-implementation/quality-gates-report.md`

## Gate 1: Test Coverage

**Requirement**: ≥80% overall code coverage

```javascript
// Run coverage
npm run test:coverage

// Output format
Coverage Summary:
- Statements: 92% ✅
- Branches: 85% ✅
- Functions: 88% ✅
- Lines: 91% ✅

Overall: 89% (target: 80%+) ✅ PASS
```

**Critical Coverage Requirements**:
- Authentication code: ≥95%
- API endpoints: ≥90%
- Database models: ≥85%
- Utilities: ≥80%
- UI components: ≥75%

**Acceptable Exclusions**:
- [ ] Error handling for unreachable code (e.g., `/* istanbul ignore next */`)
- [ ] Mock data generation for tests
- [ ] Debugging helpers
- [ ] Configuration-only modules

**Blocked Exclusions** (must test):
- [ ] Business logic
- [ ] Conditional branches
- [ ] Security-sensitive functions
- [ ] Data validation

**If Gate Fails**:
```
Coverage: 72% (target: 80%) ❌ FAIL

Missing coverage in:
- src/auth/jwt.ts (64% → need 95%)
- src/api/tasks.ts (71% → need 90%)
- src/db/models/user.ts (78% → need 85%)

Action: Write additional tests in these files
Estimated: 4-6 hours
```

---

## Gate 2: All Tests Passing

**Requirement**: 100% test pass rate

```bash
# Run all tests
npm run test

# Output
Tests:     285 passed, 0 failed
Duration:  42.3s
Coverage:  89%

Status: ✅ PASS
```

**Test Pyramid Requirements**:
- Unit tests: ≥60% of total
- Integration tests: ≥25% of total
- E2E tests: ≥15% of total

**Required Test Categories**:
- [ ] Happy path (normal operation)
- [ ] Error cases (expected errors)
- [ ] Edge cases (boundary conditions)
- [ ] Security tests (auth, validation)
- [ ] Performance tests (slow operations)
- [ ] Data integrity tests (transactions)

**If Gate Fails**:
```
Tests Failed: 7 failures in integration suite

Failures:
1. ❌ POST /api/tasks - Invalid input validation
   Expected: 400 Bad Request
   Actual: 500 Internal Server Error

2. ❌ Authentication - Token refresh after expiry
   Expected: New token issued
   Actual: Null pointer exception

Action: Fix failing tests and re-run
Status: BLOCKING
```

---

## Gate 3: Linting & Code Style

**Requirement**: 0 warnings, 0 errors

```bash
# Run linter
npm run lint

# Output
Files linted: 247
Errors: 0
Warnings: 0

Status: ✅ PASS
```

**Linting Rules**:
- ESLint: Core rules enabled
- Prettier: Consistent formatting
- TypeScript: Strict mode on
- Security: No known vulnerabilities

**Common Violations**:
- `console.log()` left in code → remove or use logger
- Unused variables → delete or prefix with `_`
- `any` types → use proper types
- Missing semicolons → run prettier auto-fix
- Line length >100 chars → refactor

**If Gate Fails**:
```
Linting Failed: 12 issues found

Issues:
- src/auth.ts:45 - Unexpected console.log (remove)
- src/tasks.ts:23 - Unused variable 'tempCache' (delete)
- src/api.ts:12 - Variable typed as 'any' (use proper type)

Action: Fix linting issues
Command: npm run lint:fix
```

---

## Gate 4: Type Checking

**Requirement**: 0 type errors

```bash
# Run TypeScript check
npm run type-check

# Output
Type checking: 347 files
Errors: 0
Warnings: 0

Status: ✅ PASS
```

**TypeScript Strictness**:
```json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true
  }
}
```

**If Gate Fails**:
```
Type Checking Failed: 23 errors

Errors:
- src/db/models.ts:156 - Argument type 'string | undefined'
  not assignable to parameter type 'string'
- src/api/routes.ts:89 - Property 'title' does not exist
  on type 'TaskRequest'

Action: Add proper type annotations or fix logic
```

---

## Gate 5: Architecture Compliance

**Requirement**: No architectural violations

### Directory Structure
```
✅ src/
  ├── auth/          (authentication concerns)
  ├── api/           (HTTP endpoints)
  ├── db/            (database layer)
  ├── services/      (business logic)
  ├── middleware/    (HTTP middleware)
  └── utils/         (shared utilities)
```

### Layering Rules
- ✅ Controllers → Services → Repositories
- ✅ API Routes → Middleware → Handlers
- ❌ Direct model access from routes
- ❌ Business logic in controllers
- ❌ HTTP concerns in services

### Dependency Flow
```
Routes → Controllers → Services → Repositories → Models
  ↑                                                  ↓
  ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ←
(no circular dependencies)
```

**If Gate Fails**:
```
Architecture Violation: Circular dependency detected

Path: auth.service → user.repo → auth.service

Action: Refactor to break cycle
Options:
1. Extract common logic to shared module
2. Move responsibility up the chain
3. Create new service for shared concern
```

---

## Gate 6: Security Scan

**Requirement**: No known vulnerabilities

```bash
# Scan dependencies
npm audit

# Output
847 packages audited, 0 vulnerabilities
```

**Required Checks**:
- [ ] Dependency audit (npm audit, yarn audit, pip audit)
- [ ] Known CVEs (check security databases)
- [ ] Outdated packages (npm outdated)
- [ ] License compliance (check GPL, AGPL, etc.)

**Acceptable Vulnerabilities**:
- [ ] Low severity in dev dependencies only
- [ ] No active exploitation (theoretical risk OK)
- [ ] Mitigated in code (e.g., validated inputs)

**Blocked Vulnerabilities**:
- [ ] Any critical severity
- [ ] High severity in production code
- [ ] Active exploitation in the wild

**If Gate Fails**:
```
Vulnerability Found: express 4.18.0

CVE-2024-XXXXX: XSS vulnerability in express
Severity: HIGH
Fix: Update to 4.19.2+

Action: npm update express
Command: npm install express@4.19.2
```

---

## Gate 7: Build Success

**Requirement**: Production build succeeds without errors

```bash
# Build for production
npm run build

# Output
Build complete in 23.4s

Assets:
- main.js        245 KB (gzipped: 65 KB)
- styles.css     125 KB (gzipped: 23 KB)
- index.html     4.2 KB

Status: ✅ PASS
```

**Build Requirements**:
- [ ] All imports resolve
- [ ] No missing files
- [ ] Source maps generated
- [ ] Assets optimized
- [ ] Bundle size within limits

**Bundle Size Limits**:
- Main bundle: <250 KB gzipped
- CSS bundle: <100 KB gzipped
- Total: <500 KB gzipped

**If Gate Fails**:
```
Build Failed: Import resolution error

Error in src/components/TaskList.tsx:
Cannot find module 'src/services/taskService'

Action: Check import path
Expected: ../services/taskService
Found: src/services/taskService
```

---

## Quality Gates Report Template

Create: `docs/artifacts/phase3-implementation/quality-gates-report.md`

```markdown
# Code Quality Gates Report

**Date**: YYYY-MM-DD
**Phase**: 3 (Implementation)
**Status**: ✅ ALL GATES PASSED

---

## Executive Summary

- Test Coverage: 89% (target: 80%+) ✅
- Tests Passing: 285/285 (100%) ✅
- Linting: 0 issues ✅
- Type Checking: 0 errors ✅
- Architecture: Compliant ✅
- Security: 0 vulnerabilities ✅
- Build: Success ✅

**Overall Status**: 🟢 GREEN - Ready for Phase 4

---

## Gate Details

### Gate 1: Test Coverage (89%)
- Statements: 92%
- Branches: 85%
- Functions: 88%
- Lines: 91%

**Areas Above Target**:
- ✅ Authentication: 96% (target: 95%)
- ✅ API endpoints: 91% (target: 90%)
- ✅ Database models: 88% (target: 85%)

**Areas At Target**:
- ✅ Utilities: 81% (target: 80%)
- ✅ UI components: 76% (target: 75%)

### Gate 2: Tests (285/285 Passing)
- Unit tests: 172 (60%)
- Integration tests: 75 (26%)
- E2E tests: 38 (14%)

**Test Categories Covered**:
- ✅ Happy path scenarios: 85 tests
- ✅ Error handling: 68 tests
- ✅ Edge cases: 54 tests
- ✅ Security: 42 tests
- ✅ Performance: 21 tests
- ✅ Data integrity: 15 tests

### Gate 3: Linting (0 Issues)
- ESLint: 0 errors, 0 warnings
- Prettier: All files formatted
- Code style: Consistent

### Gate 4: Type Checking (0 Errors)
- TypeScript files: 347
- Type errors: 0
- Strict mode: Enabled

### Gate 5: Architecture (Compliant)
- Directory structure: ✅ Proper layers
- Dependency flow: ✅ No cycles
- Layering rules: ✅ Respected

### Gate 6: Security (0 Vulnerabilities)
- Dependencies audited: 847
- Vulnerabilities: 0
- Critical issues: 0
- High issues: 0

### Gate 7: Build (Success)
- Build time: 23.4 seconds
- Output size: 370 KB (total), 88 KB (gzipped)
- Within limits: ✅ Yes

---

## Detailed Metrics

| Gate | Target | Actual | Status | Timestamp |
|------|--------|--------|--------|-----------|
| Coverage | 80% | 89% | ✅ | 14:35 UTC |
| Tests | 100% | 100% (285/285) | ✅ | 14:38 UTC |
| Linting | 0 | 0 | ✅ | 14:40 UTC |
| Types | 0 | 0 | ✅ | 14:42 UTC |
| Architecture | Compliant | Compliant | ✅ | 14:44 UTC |
| Security | 0 | 0 | ✅ | 14:46 UTC |
| Build | Success | Success | ✅ | 14:50 UTC |

---

## Sign-Off

- [ ] Engineering Lead reviewed
- [ ] All gates passing
- [ ] Ready for Phase 4
- [ ] No exceptions or waivers

**Approved By**: [Name]
**Approved Date**: YYYY-MM-DD HH:MM UTC

**Next**: Proceed to Phase 4 Verification
```

---

## Workflow During Phase 3

```
Phase 3 Implementation
  ↓
Feature development complete
  ↓
Run Gate 1: Test Coverage
  ├─ If fail → Write tests, retry
  └─ If pass → Continue
  ↓
Run Gate 2: All Tests Passing
  ├─ If fail → Fix code, retry
  └─ If pass → Continue
  ↓
Run Gate 3: Linting
  ├─ If fail → Fix style, retry
  └─ If pass → Continue
  ↓
Run Gate 4: Type Checking
  ├─ If fail → Add types, retry
  └─ If pass → Continue
  ↓
Run Gate 5: Architecture
  ├─ If fail → Refactor, retry
  └─ If pass → Continue
  ↓
Run Gate 6: Security
  ├─ If fail → Update deps, retry
  └─ If pass → Continue
  ↓
Run Gate 7: Build
  ├─ If fail → Fix build, retry
  └─ If pass → Continue
  ↓
🟢 ALL GATES PASSED
  ↓
Phase 3 Complete → Phase 4 Verification
```

---

## Handling Gate Failures

### If Multiple Gates Fail

**Priority Order** (fix in this order):
1. **Critical**: Type checking, Build success (blocks everything)
2. **High**: Security, Tests (core quality)
3. **Medium**: Coverage, Linting (maintainability)
4. **Low**: Architecture (refactoring)

**Example Scenario** (2 gates failing):

```
❌ Gate 2 Failed: 7 test failures
❌ Gate 3 Failed: 12 linting issues

Actions:
1. Fix linting first (quick wins, 30 min)
   npm run lint:fix

2. Fix tests (address root issues, 2 hours)
   - Re-read failing test descriptions
   - Identify actual bugs vs test issues
   - Implement fixes

3. Re-run gates in order
4. Iterate until all pass
```

### Waiver Process

**When Waivers Allowed**:
- Architectural violations with explicit team approval
- Security issues with risk assessment and monitoring
- Coverage edge cases with documented rationale

**Waiver Template**:

```markdown
# Quality Gate Waiver

**Gate**: Code Quality Gates
**Item**: Test coverage at 78% (target: 80%)

**Rationale**:
The remaining 2% coverage is in error handling paths that
are difficult to test without mocking database. The logic
is proven by integration tests.

**Risk**: Low - logic tested indirectly
**Monitoring**: Alert if error rate >0.1%
**Duration**: Until next sprint (2 weeks max)
**Approval**: CTO + Tech Lead

**Approved**: 2026-01-10
**Expires**: 2026-01-24
```

---

## Token Cost

**First Run**: ~400 tokens
**Subsequent Runs**: ~200 tokens (cached results)
**Report Generation**: ~300 tokens

**Total Per Phase**: ~1,000 tokens

---

## Related Features

- [Technical Debt Register](technical-debt-register.md) - Document known quality compromises
- [Progressive Checkpoints](progressive-checkpoints.md) - Save state before gate runs
- [Code Quality Gates](code-quality-gates.md) - Enforce standards

## Integration with Implementation Phase

Quality gates run **at the end of Phase 3**:

```
Step 6: Final Review
  ↓
Step 7: Track Technical Debt
  ↓
Step 8: Quality Gates (THIS FEATURE)
  ├─ Run 7 gates
  ├─ All pass? YES → Phase 3 Complete
  └─ Any fail? NO → Fix and retry
  ↓
Phase 3 Complete → Phase 4 Verification
```

## Benefits

- ✅ Prevents broken code from reaching Phase 4
- ✅ Catches regressions early
- ✅ Ensures consistent code quality
- ✅ Documents quality metrics for release
- ✅ Enforces team standards

## Why This Matters

Prevents:
- ❌ Low-quality code reaching production
- ❌ Test suite degradation over time
- ❌ Security vulnerabilities in releases
- ❌ Build failures in CI/CD

Enables:
- ✅ Confidence in code quality
- ✅ Fast Phase 4 verification (gates done)
- ✅ Clear quality metrics
- ✅ Data-driven quality decisions
