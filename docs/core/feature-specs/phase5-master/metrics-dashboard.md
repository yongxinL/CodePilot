# Metrics Dashboard - CodePilot v2.0

**Tier**: Advanced+
**Phase**: 5 (Master Control)
**Feature #**: 25

## Purpose

Aggregate and visualize key metrics across projects and phases, tracking velocity, quality, efficiency, and team performance for portfolio management.

## When to Use

In Phase 5, use metrics dashboard to track multi-project performance and make resource allocation decisions.

## Configuration Check

```javascript
config = read(".codepilot.config.json");
if (config.feature_tier >= "advanced_plus") {
  enable_metrics_dashboard();
} else {
  skip_this_feature();
}
```

## Create Artifact

**File**: `docs/artifacts/phase5-master/metrics-dashboard.md`

## Metrics Dashboard Overview

```markdown
# Metrics Dashboard

**Organization**: LumenLab
**Period**: 2026 Q1
**Last Updated**: 2026-01-10 20:00 UTC

---

## Executive Dashboard

### Key Performance Indicators

| Metric | Current | Target | Trend |
|--------|---------|--------|-------|
| Delivery Velocity | 18 pts/sprint | 20 pts | ⬆️ +8% |
| Quality Score | 89% | 85% | ⬆️ +2% |
| On-Time Delivery | 92% | 90% | ⬆️ +1% |
| Team Utilization | 85% | 80% | ⬆️ +3% |
| Technical Debt | 12 days | <20 days | ✅ OK |
| Defect Escape Rate | 1.2% | <2% | ✅ OK |

**Overall Health**: 🟢 GREEN

---

## Project Velocity

### By Project

| Project | Sprint | Committed | Completed | % Complete | Trend |
|---------|--------|-----------|-----------|------------|-------|
| CodePilot | S5 | 25 | 23 | 92% | ⬆️ |
| Client Portal | S5 | 20 | 18 | 90% | ➡️ |
| Mobile App | S5 | 18 | 15 | 83% | ⬇️ |
| API Refactor | S5 | 15 | 15 | 100% | ⬆️ |

**Average**: 91% ✅

### Velocity Trend (Last 5 Sprints)

```
Sprint  CodePilot  Portal  Mobile  API  Avg
───────────────────────────────────────────
S1      18         16      14      12   15
S2      19         17      15      13   16
S3      21         18      16      14   17
S4      22         19      17      15   18
S5      23         18      15      15   18

Trend: ⬆️ +20% growth
```

---

## Quality Metrics

### Test Coverage by Project

| Project | Coverage | Target | Status |
|---------|----------|--------|--------|
| CodePilot | 89% | 85% | ✅ Exceeds |
| Client Portal | 82% | 85% | ⚠️ Below |
| Mobile App | 76% | 80% | ⚠️ Below |
| API Refactor | 94% | 85% | ✅ Exceeds |

**Portfolio Average**: 85.25% ✅

### Defect Escape Rate

| Project | Escaped | Found | Escape Rate | Trend |
|---------|---------|-------|-------------|-------|
| CodePilot | 2 | 150 | 1.3% | ⬇️ |
| Client Portal | 3 | 120 | 2.5% | ⬆️ |
| Mobile App | 4 | 100 | 4.0% | ⬆️ |
| API Refactor | 0 | 85 | 0% | ✅ |

**Portfolio Average**: 1.95% ⚠️ (target: <2%)

---

## On-Time Delivery

### By Release

| Release | Date | On-Time? | Status |
|---------|------|----------|--------|
| v1.0.0 CodePilot | 2026-01-11 | ✅ YES | Delivered |
| v2.0 Client Portal | 2026-01-25 | 🟡 AT RISK | 75% done |
| v1.1 Mobile App | 2026-02-15 | ⏳ Pending | 50% done |
| v2.0 API | 2026-02-01 | ✅ YES | Delivered |

**On-Time Rate**: 75% (3/4) ✅

---

## Team Performance

### Productivity

| Team | Velocity | Utilization | Morale | Notes |
|------|----------|-------------|--------|-------|
| Backend | 22 pts | 88% | 4.2/5 | Strong sprint |
| Frontend | 18 pts | 82% | 4.0/5 | Managing tech debt |
| DevOps | 12 pts | 90% | 3.8/5 | On-call rotation heavy |
| QA | 15 pts | 85% | 4.1/5 | Hiring new person |

**Average Utilization**: 86% ✅

### Individual Contributors

| Name | Velocity | Quality | Notes |
|------|----------|---------|-------|
| Alice | 6 pts | 94% | Strong performer |
| Bob | 5 pts | 87% | Ramping up |
| Carol | 4 pts | 92% | Mentoring new hires |
| David | 5 pts | 85% | Senior engineer |

---

## Technical Debt

### Debt Accumulation

```
Backlog Total: 12 person-days

By Category:
- Refactoring: 5 days (42%)
- Testing: 4 days (33%)
- Documentation: 2 days (17%)
- Performance: 1 day (8%)
```

### Debt Resolution

| Item | Added | Resolved | Status |
|------|-------|----------|--------|
| N+1 Queries | S2 | Pending | 🟡 High Priority |
| Missing Tests | S2 | S4 | ✅ Resolved |
| Docs | S1 | Pending | ⏳ Deferred |
| Commented Code | S3 | S5 | ✅ Resolved |

**Resolution Rate**: 50% per sprint ✅

---

## Resources

### Allocation

```
Total Capacity: 100%

Backend Team:  35%
├─ CodePilot: 15%
├─ Portal: 12%
├─ Mobile: 8%
└─ API: 0%

Frontend Team: 30%
├─ CodePilot: 12%
├─ Portal: 12%
├─ Mobile: 6%
└─ Web: 0%

QA Team: 20%
├─ Testing: 12%
├─ Automation: 5%
└─ Manual: 3%

DevOps: 15%
├─ Infrastructure: 8%
├─ On-call: 5%
└─ Monitoring: 2%
```

### Budget Utilization

| Category | Budget | Spent | % Used | Status |
|----------|--------|-------|--------|--------|
| Development | $150k | $138k | 92% | ✅ OK |
| QA/Testing | $40k | $35k | 87% | ✅ OK |
| Infrastructure | $25k | $23k | 92% | ✅ OK |
| Training | $10k | $2k | 20% | 🟡 Underspent |

**Total Budget**: $225k / $225k = 100% ✅

---

## Cycle Time & Lead Time

### By Project

| Project | Avg Lead Time | Avg Cycle Time | WIP |
|---------|---------------|----------------|-----|
| CodePilot | 4.2 days | 3.1 days | 3 |
| Portal | 5.1 days | 3.8 days | 4 |
| Mobile | 6.3 days | 4.2 days | 5 |
| API | 3.8 days | 2.9 days | 2 |

**Portfolio Average**: 4.85 days ✅

### Trend

```
Timeline    CodePilot  Portal  Mobile  API   Avg
─────────────────────────────────────────────────
Baseline    6.2 days   7.1 days 7.5 days 5.2 days
Current     4.2 days   5.1 days 6.3 days 3.8 days

Improvement: 28% faster ⬆️
```

---

## Burndown Charts

### Current Sprint (S5)

```
Sprint Goal: Complete 23 story points

   |     * (actual)
25 |    *
   |   *
20 |  *
   | *
15 | *___ (ideal)
   |*
10 |
   |
 5 |
   |
 0 |___________________
   1 2 3 4 5 (days)

Status: ✅ On track (23 of 25 committed completed)
```

---

## Risk Dashboard

### Current Risks

| Risk | Probability | Impact | Status | Mitigation |
|------|-------------|--------|--------|-----------|
| Portal deadline slipped | Medium | High | 🟡 | Add resources |
| Mobile technical debt | High | Medium | 🟡 | Plan refactor |
| Key person absence | Low | High | ✅ | Cross-training |
| Infrastructure capacity | Low | High | ✅ | Monitor + plan |

**Overall Risk**: 🟡 MEDIUM

---

## Recommendations

### Immediate Actions

1. 🔴 **Allocate resources to Portal project**
   - Current: 18/20 (90%)
   - Risk: Missing Jan 25 deadline
   - Action: Add 1 backend engineer

2. 🟡 **Schedule Mobile App refactor**
   - Technical debt: 4+ days
   - Current test coverage: 76% (below 80% target)
   - Action: Plan 1-week sprint after v1.1 release

### Short-term Improvements

3. 🟡 **Improve QA for Mobile team**
   - Escape rate: 4.0% (above 2% target)
   - Action: Increase test coverage from 76% to 85%

4. ✅ **Continue Backend team momentum**
   - Velocity: 22 pts (exceeds 20 target)
   - Quality: 94% (exceeds 85% target)
   - Action: Keep current workload

---

## Next Review

- **Weekly**: Team leads review individual metrics
- **Sprint**: Full metrics review at sprint retrospective
- **Quarterly**: Executive dashboard review

---

## Version: v1.0
**Updated**: 2026-01-10 20:00 UTC
**Next Update**: 2026-01-17 (end of sprint)
```

---

## Dashboard Components

This dashboard tracks:
1. **Velocity & Delivery** - Predictability and pace
2. **Quality** - Test coverage, defect rate
3. **Team Performance** - Utilization, productivity
4. **Technical Debt** - Accumulation vs resolution
5. **Resources** - Allocation and budget
6. **Risks** - Current blockers and threats

---

## Integration Points

Dashboard pulls data from:
- Sprint planning tools (Jira, Azure DevOps)
- Code repositories (GitHub, GitLab)
- CI/CD pipelines (Jenkins, GitHub Actions)
- Monitoring systems (Datadog, NewRelic)
- Team surveys (morale, satisfaction)

---

## Token Cost

**Generate Dashboard**: ~300 tokens
**Data Collection**: ~200 tokens (tool integration)
**Analysis**: ~150 tokens

**Total Per Period**: ~1,000 tokens (weekly)

---

## Related Features

- [Portfolio View](portfolio-view.md) - See projects in portfolio
- [Resource Allocation](resource-allocation.md) - Track allocations
- [Metrics Dashboard](metrics-dashboard.md) - Aggregated metrics

## Why This Matters

Enables:
- ✅ Data-driven decision making
- ✅ Early risk detection
- ✅ Team performance visibility
- ✅ Predictable delivery
- ✅ Resource optimization
- ✅ Portfolio management
