# Test Coverage Matrix

**Project**: [Project Name]  
**Date**: [YYYY-MM-DD]  
**Tested By**: Verifier Agent  
**Overall Coverage**: [X]%  
**Target**: [Y]% (typically 80%)

---

## Coverage Grid

| Feature/Module | Unit | Integration | E2E | API Docs | Security | Overall |
|----------------|------|-------------|-----|----------|----------|---------|
| [Feature 1] | [X]% | [Y]% | [Z]% | [Yes/No] | [Yes/No] | **[Overall]%** |
| [Feature 2] | [X]% | [Y]% | [Z]% | [Yes/No] | [Yes/No] | **[Overall]%** |
| [Feature 3] | [X]% | [Y]% | [Z]% | [Yes/No] | [Yes/No] | **[Overall]%** |
| [Feature 4] | [X]% | [Y]% | [Z]% | [Yes/No] | [Yes/No] | **[Overall]%** |
| [Feature 5] | [X]% | [Y]% | [Z]% | [Yes/No] | [Yes/No] | **[Overall]%** |
| **AVERAGE** | **[X]%** | **[Y]%** | **[Z]%** | **[X/N]** | **[X/N]** | **[Overall]%** |

**Legend**:
- ✅ = >90% coverage
- ⚠️ = 70-90% coverage  
- ❌ = <70% coverage
- Yes/No = Documentation or security testing present

---

## Summary Statistics

### Overall Metrics

**Total Test Coverage**: [X]% (Target: [Y]%)  
**Status**: ✅ Exceeds target | ⚠️ Below target | ❌ Significantly below

**Test Type Distribution**:
- Unit Tests: [X]% average ([N] tests)
- Integration Tests: [Y]% average ([N] tests)
- E2E Tests: [Z]% average ([N] tests)
- Total Tests: [N] tests

**Test Execution**:
- Tests Passing: [N] / [Total] ([X]%)
- Tests Failing: [N]
- Tests Skipped: [N]
- Execution Time: [X] seconds

---

## Coverage by Priority

**High Priority Features** ([N] features):
- Average coverage: [X]%
- Minimum coverage: [Y]%
- All above target: [Yes/No]
- Status: [Assessment]

**Medium Priority Features** ([N] features):
- Average coverage: [X]%
- Minimum coverage: [Y]%
- Status: [Assessment]

**Low Priority Features** ([N] features):
- Average coverage: [X]%
- Status: [Assessment]

---

## Coverage Gaps Identified

### Critical Gaps (Must Address Before Release)

**Gap 1**: [Feature/Module with insufficient coverage]
- **Current Coverage**: [X]%
- **Target**: [Y]%
- **Gap**: [Z]%
- **Missing Tests**: [What's not tested]
- **Risk**: [Impact if not tested]
- **Action**: [What tests to add]
- **Effort**: [Estimated time]

**Gap 2**: [Another critical gap]
[Same structure]

### High Priority Gaps (Recommended Before Release)

**Gap 1**: [Feature/Module]
- Current: [X]%, Target: [Y]%, Gap: [Z]%
- Missing: [What's not tested]
- Action: [Required tests]

### Medium Priority Gaps (Post-Release Acceptable)

**Gap 1**: [Feature/Module]
- Current: [X]%, Gap: [Z]%
- Acceptable because: [Reason - e.g., "Low-risk feature, can add tests post-launch"]

---

## Coverage by Test Type

### Unit Test Coverage

**Overall**: [X]%  
**Status**: [Assessment]

**Well-Covered Modules** (>90%):
- [Module 1]: [X]%
- [Module 2]: [Y]%

**Under-Covered Modules** (<80%):
- [Module 1]: [X]% - ⚠️ Needs attention
- [Module 2]: [Y]% - ⚠️ Needs attention

---

### Integration Test Coverage

**Overall**: [X]%  
**Status**: [Assessment]

**Well-Covered Integrations** (100%):
- [Integration 1]: All flows tested
- [Integration 2]: All flows tested

**Gaps**:
- [Integration 1]: [What's missing]
- [Integration 2]: [What's missing]

---

### E2E Test Coverage

**Overall**: [X]%  
**Critical User Flows**: [N] flows, [M] tested ([X]%)

**Covered Flows**:
1. [Flow 1]: ✅ Fully tested
2. [Flow 2]: ✅ Fully tested

**Uncovered Flows**:
1. [Flow 1]: ⚠️ Partially tested - [What's missing]
2. [Flow 2]: ❌ Not tested - [Why and risk]

---

### API Documentation Coverage

**Endpoints Documented**: [N] / [Total] ([X]%)

**Well-Documented**:
- [Endpoint 1]: Complete with examples
- [Endpoint 2]: Complete with examples

**Missing Documentation**:
- [Endpoint 1]: [What's missing]
- [Endpoint 2]: [What's missing]

---

### Security Testing Coverage

**Features Security Tested**: [N] / [Total] ([X]%)

**Tested**:
- [Feature 1]: ✅ Auth bypass, XSS, SQL injection tested
- [Feature 2]: ✅ Security tests complete

**Not Tested**:
- [Feature 1]: ❌ No security tests - ⚠️ HIGH RISK
- [Feature 2]: ⚠️ Partial security testing

---

## Recommendations

### Before Release (Required)
1. **[Action 1]**: [Description]
   - Target: [Coverage goal]
   - Effort: [Time estimate]
   - Priority: Critical

2. **[Action 2]**: [Description]
   - Target: [Coverage goal]
   - Effort: [Time estimate]
   - Priority: High

### Post-Release (Recommended)
1. **[Action 1]**: [Description]
   - Target: [Coverage goal]
   - Timeline: [When to address]

---

## Trend Analysis

**Coverage Over Time**:
```
Week 1: 65% (baseline)
Week 2: 72% (+7%) ⬆
Week 3: 81% (+9%) ⬆
Week 4: 89% (+8%) ⬆

Trend: ⬆ Steadily improving
Target: 80% ✅ Achieved in Week 3
```

**Test Count Growth**:
- Week 1: 45 tests
- Week 2: 78 tests (+73%)
- Week 3: 112 tests (+44%)
- Week 4: 133 tests (+19%)

---

## Quality Gates

**Minimum Coverage**: [X]% (from .codepilot.config.json)  
**Current Coverage**: [Y]%  
**Gate Status**: ✅ Pass | ❌ Fail

**Critical Features** (must be 100%):
- [Feature 1]: [Coverage]% [✅ | ❌]
- [Feature 2]: [Coverage]% [✅ | ❌]

---

## Notes

[Any additional observations, testing challenges, or context]

---

**This matrix provides comprehensive view of test coverage to identify gaps and ensure quality.**
