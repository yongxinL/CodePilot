# Metrics Dashboard - Phase 5 Master Control

**Purpose**: Consolidated portfolio-level metrics and KPI tracking across all active projects

**Status**: Phase 5 (Master Control)
**Audience**: Portfolio managers, executives, stakeholders
**Update Frequency**: Real-time dashboard, reports generated daily/weekly

---

## Dashboard Overview

### Portfolio Health Summary

```
┌─────────────────────────────────────────────────────────────┐
│               PORTFOLIO HEALTH DASHBOARD                     │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Overall Status:  🟢 GREEN    Schedule Health: 🟡 YELLOW   │
│  Projects:        5/5 active  Resource Util:    87%         │
│  Completion:      72% average Budget Usage:    65%         │
│                                                              │
│  Top Risk: Database migration timeline (Project A)         │
│  Next Milestone: Phase 3 completion (3 projects) - 2 days  │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Multi-Project Status Board

```
PROJECT TIMELINE & STATUS

Project A: SaaS Platform        [████████████░░░░░░░░] 65%
├─ Phase 1: ✅ Complete
├─ Phase 2: ✅ Complete
├─ Phase 3: ⏳ In Progress (60%)
├─ Timeline: 2 days ahead
└─ Risk: Medium (database migration)

Project B: Mobile App           [██████████░░░░░░░░░░] 55%
├─ Phase 1: ✅ Complete
├─ Phase 2: ⏳ In Progress (75%)
├─ Phase 3: ⏳ Blocked (waiting for Project A API)
├─ Timeline: 3 days behind
└─ Risk: High (dependency on Project A)

Project C: Analytics Platform   [████████░░░░░░░░░░░░] 40%
├─ Phase 1: ✅ Complete
├─ Phase 2: ⏳ In Progress (40%)
├─ Phase 3: 🔴 Not Started
├─ Timeline: On track
└─ Risk: Low (independent track)

Project D: Admin Dashboard      [██████░░░░░░░░░░░░░░] 30%
├─ Phase 1: ⏳ In Progress (90%)
├─ Phase 2: 🔴 Not Started
├─ Phase 3: 🔴 Not Started
├─ Timeline: 1 week ahead
└─ Risk: Low (simple project)

Project E: Data Migration       [████░░░░░░░░░░░░░░░░] 20%
├─ Phase 1: ⏳ In Progress (50%)
├─ Phase 2: 🔴 Blocked (waiting for Project A design)
├─ Phase 3: 🔴 Not Started
├─ Timeline: 5 days behind
└─ Risk: Critical (foundational work)
```

---

## Key Performance Indicators (KPIs)

### Portfolio-Level Metrics

| Metric | Target | Current | Status | Trend |
|--------|--------|---------|--------|-------|
| **Schedule Health** | 100% (on-time) | 92% | 🟡 YELLOW | ↘ (2% down) |
| **Budget Utilization** | 70-80% | 65% | 🟢 GREEN | → (stable) |
| **Resource Utilization** | 90%+ | 87% | 🟡 YELLOW | ↗ (up 5%) |
| **Quality (Bug Escape)** | <2% | 1.2% | 🟢 GREEN | ↗ (improving) |
| **Code Coverage** | 80%+ | 78% | 🟡 YELLOW | ↗ (up 3%) |
| **Test Pass Rate** | 99%+ | 97.8% | 🟡 YELLOW | ↘ (1% down) |
| **Performance (P95)** | <200ms | 180ms | 🟢 GREEN | ↗ (improving) |
| **Security Issues** | 0 critical | 0 critical | 🟢 GREEN | → (stable) |

### Project-Level Velocity

```
SPRINT VELOCITY TREND (Last 8 sprints)

Sprint:     1   2   3   4   5   6   7   8
Velocity:  [15][18][16][19][17][20][18][19] SP/sprint
Target:    ──────────────── 18 SP/sprint ───

Project A:  Strong, consistent (↗ trending up)
Project B:  Volatile, improving (↗ recent improvement)
Project C:  Stable (→ consistent)
Project D:  Strong start (↗ highest velocity)
Project E:  Ramping up (↗ should improve as Phase 2 starts)

Portfolio Average: 17.5 SP/sprint (97% of target)
```

### Resource Allocation Heat Map

```
TEAM UTILIZATION BY ROLE

Role              Target  Current  Status  Notes
─────────────────────────────────────────────
Frontend Devs      90%     92%    🟡    Slightly over capacity
Backend Devs       90%     85%    🟢    Adequate capacity
QA Engineers       85%     88%    🟡    Slight overallocation
Architects         80%     78%    🟢    Available for review
DevOps             80%     90%    🟡    Critical path operations
PMs                90%     95%    🔴    At full capacity

TEAM CONSTRAINTS:
- Frontend bottleneck: 2 developers on Project A critical path
- QA bottleneck: 1 tester split across 3 projects
- DevOps: Database migrations taking 25% capacity through week 3
```

---

## Trend Analysis

### Schedule Performance

**By Project:**
```
Project Completion vs. Plan (Days delta)

Week 1:  A(-0) B(-1) C(+2) D(+1) E(-3)  Portfolio: -0.2 days
Week 2:  A(+2) B(-2) C(+1) D(+1) E(-2)  Portfolio: 0.0 days
Week 3:  A(+2) B(-3) C(0)  D(+2) E(-4)  Portfolio: -0.6 days ↘

Interpretation:
- Projects A, D ahead (all phases running smoothly)
- Project B falling behind (Phase 2 complexity higher than estimated)
- Project E critical (dependency on A blocking progress)
- Portfolio: 0.6 days behind target (manageable)
```

### Quality Trends

```
BUG ESCAPE RATE (% of bugs found in production)

Month 1:  2.1%  ← Above target (2%)
Month 2:  1.8%  ← Within target (improving)
Month 3:  1.2%  ← Well within target (↗ strong improvement)

ROOT CAUSES:
- Month 1-2: QA team ramping up, test coverage gaps
- Month 3: Improved test coverage (+8%), better code reviews

PROGNOSIS: Continuing downward trend, expect <1% by end Q1
```

### Performance Metrics

```
API RESPONSE TIME TREND (P95 percentile)

Month 1:  215ms  ← Above target (200ms)
Month 2:  195ms  ← Target achieved
Month 3:  180ms  ← 10% better than target (↗ strong)

OPTIMIZATIONS APPLIED:
- Implemented caching (60ms improvement)
- Database query optimization (45ms improvement)
- CDN for static assets (15ms improvement)

PROGNOSIS: On track for P99 <300ms target
```

---

## Dependency Analysis

### Critical Path

```
                    Project E
                   (blocking)
                      │
                      ↓
              ┌────────┴─────────┐
              │                  │
          Project B          Project A
          (waiting)          (core API)
              │                  │
              └────────┬─────────┘
                       │
                       ↓
              Project C (depends on both)
              Project D (independent)

CRITICAL PATH:
Project E → Project A → Project C
Duration: 18 weeks
Slack: 0 days (on critical path)
Risk: HIGH - Any delay cascades

MITIGATION:
- Project E Phase 1 parallelized (already in progress)
- Project A architectureReview accelerated (complete)
- Project C queued, ready to start immediately after A
```

### Cross-Project Dependencies

| From | To | Type | Status | Impact if Delayed |
|------|-----|------|--------|------------------|
| **A** | B | Hard (API) | 90% ready | Blocks B Phase 3 |
| **A** | C | Hard (Data) | 80% ready | Delays C start |
| **A** | E | Soft (Design) | 85% ready | Moderate delay |
| **B** | D | Soft (Auth) | 95% ready | No impact (soft) |
| **E** | A | Soft (Infrastructure) | 70% ready | Could impact timeline |

**Mitigation**: Project A Phase 2 on accelerated track, targeting 3-day buffer

---

## Risk Heat Map

### High-Risk Areas

```
RISK GRID (Probability vs. Impact)

                    LOW PROB      HIGH PROB

CRITICAL IMPACT      Monitor      MITIGATE
                     R-003        R-001 🔴
                                  R-005 🔴

HIGH IMPACT           Monitor      WATCH
                     R-002        R-004 🟡
                                  R-006 🟡

MEDIUM IMPACT        Monitor      Monitor
                     R-007        R-008

DETAIL:
🔴 R-001: Project E database schema causes delays (Probability: 60%)
🔴 R-005: Frontend performance issues delay Project B (Prob: 40%)
🟡 R-004: QA bottleneck extends Phase 4 (Probability: 70%)
🟡 R-006: Project C scope expansion (Probability: 30%)
```

### Risk Trend

```
PORTFOLIO RISK SCORE OVER TIME

Week 1:   Risk Score: 42/100  ← Starting risk baseline
Week 2:   Risk Score: 38/100  ← Improved (↗ R-001 mitigated)
Week 3:   Risk Score: 45/100  ← Increased (↘ R-004 realized)
Week 4:   Risk Score: 40/100  ← Stabilized

Mitigation Actions:
✅ R-001: Database schema completed (risk reduced 15%)
✅ R-005: Performance optimization plan in place (monitoring)
⏳ R-004: QA hiring 2 contractors (risk remains, working on it)
```

---

## Resource Capacity Analysis

### Team Allocation by Project

```
PROJECT RESOURCE ALLOCATION (FTE = Full Time Equivalent)

            Frontend  Backend  QA   Arch  DevOps  Total
Project A:    2.0     1.5     0.8  0.3   0.4     5.0
Project B:    1.5     1.2     0.5  0.2   0.2     3.6
Project C:    0.5     1.0     0.3  0.2   0.1     2.1
Project D:    1.0     0.8     0.4  0.1   0.1     2.4
Project E:    0.5     0.5     0.2  0.1   0.3     1.6

Overhead:     0.5     0.3     0.3  0.3   0.4     1.8

TOTAL:        6.0     5.3     2.5  1.2   1.5    16.5 FTE

CAPACITY NOTES:
- Frontend: 6 FTE capacity, at 100% (at limit)
- Backend: 5.5 FTE capacity, at 96% (near limit)
- QA: 3 FTE capacity, at 83% (adequate)
- Arch: 1.5 FTE capacity, at 80% (good)
- DevOps: 2 FTE capacity, at 75% (good)
```

### Skills Gap Analysis

```
CRITICAL SKILLS ASSESSMENT

Skill                 Need  Have  Gap  Risk Level
──────────────────────────────────────────────
Database Design        2     2     0   🟢 Low
Real-time Dev          2     1     1   🟡 Medium
DevOps/K8s            2     1.5   0.5  🟡 Medium
Mobile Dev             2     1     1   🔴 High
Security Review        2     1.5   0.5  🟡 Medium
Performance Tuning     2     2     0   🟢 Low

MITIGATION:
- Mobile Dev: Contractor hired (starts week 3)
- DevOps/K8s: Training plan for 1 person (weeks 1-4)
- Security: External audit scheduled (week 4)
```

---

## Financial Tracking

### Budget vs. Actuals

```
BUDGET OVERVIEW

Category          Budget    Actual   Variance  % Used
─────────────────────────────────────────────────
Salaries          $300K     $195K    -$105K    65%
Contractors       $50K      $18K     -$32K     36%
Tools/Software    $25K      $16.2K   -$8.8K    65%
Infrastructure    $30K      $19.5K   -$10.5K   65%
Training          $15K      $2.3K    -$12.7K   15%

TOTAL             $420K     $251K    -$169K    60%

FORECAST (to completion):
- Current burn rate: $41.8K/week
- Remaining weeks: 8
- Projected total: ~$585K (39% over budget)
- Mitigation: Request budget increase OR reduce scope

REASONS FOR OVERRUN:
- Contractor rates higher than budgeted (+$12K)
- Infrastructure costs for multi-project (+$8K)
- Additional QA resources needed (+$15K)
```

### ROI Projection

```
EXPECTED ROI METRICS (Post-Launch)

Project A (SaaS):
- Development Cost: $125K
- Year 1 Revenue: $200K
- ROI: 60% (Year 1)
- Break-even: 7.5 months

Project B (Mobile):
- Development Cost: $85K
- Year 1 Revenue: $150K
- ROI: 76% (Year 1)
- Break-even: 6.8 months

Project C (Analytics):
- Development Cost: $95K
- Year 1 Revenue: $180K
- ROI: 89% (Year 1)
- Break-even: 6.3 months

Portfolio Total:
- Total Investment: $420K
- Year 1 Revenue: $600K
- Portfolio ROI: 43%
- Break-even: 8.4 months
```

---

## Executive Summary Report

### For Leadership

```
PORTFOLIO PERFORMANCE SUMMARY - Week 4

✅ ON TRACK ITEMS:
- Overall schedule: 92% on-time (acceptable variance)
- Quality metrics: Better than target (1.2% bug escape vs. 2% target)
- Performance: 10% better than SLA (180ms vs. 200ms P95)
- Budget: 60% utilized (within expected range)

⚠️ ATTENTION ITEMS:
- Project B: Phase 2 running 3 days behind (estimated recovery: 5 days)
- QA capacity: At 88% utilization (contractor onboarding week 3)
- Database migration: Critical path item, on schedule but 0 float

🔴 CRITICAL ITEMS:
None at executive level. All risks being managed.

NEXT MILESTONES:
- Week 5: Project A Phase 3 starts (dependent for Projects B, C)
- Week 6: Mobile dev contractor starts (alleviates Project B constraint)
- Week 8: Phase 4 (verification) begins for Project A

RECOMMENDATION:
No immediate action required. Continue current trajectory.
Revisit budget forecast in week 6 after contractor rates finalized.
```

---

## How to Use This Dashboard

### For Portfolio Managers
- **Daily**: Check multi-project status board and critical path
- **Weekly**: Review KPIs, trends, and risk heat map
- **Monthly**: Executive summary and budget forecast

### For Project Managers
- **Weekly**: Check individual project metrics and velocity
- **Monthly**: Resource allocation and skills gap analysis

### For Executives
- **Weekly**: Executive summary and critical items
- **Monthly**: Portfolio ROI and budget tracking

### For Team Leads
- **Daily**: Resource utilization and capacity
- **Weekly**: Risk status and dependencies

---

## Integration with Other Systems

This dashboard is updated by:
- `@data-interpreter`: Processes raw metrics data
- `@portfolio-manager`: Cross-project aggregation
- `@performance`: Performance benchmarks
- `@security`: Security metrics
- `@qa`: Quality and test metrics

---

## Customization

### Dashboard Views Available

1. **Executive Dashboard**: High-level KPIs, budget, timeline
2. **Portfolio Dashboard**: All projects, dependencies, risks
3. **Project Dashboard**: Single project detailed view
4. **Resource Dashboard**: Team utilization, capacity
5. **Financial Dashboard**: Budget, costs, ROI
6. **Risk Dashboard**: All risks with heat map

To customize, update configuration in `opencode.json`:
```json
{
  "metrics_dashboard": {
    "refresh_frequency": "real-time",
    "widgets": ["status", "timeline", "kpi", "risks", "resources"],
    "detail_level": "advanced"
  }
}
```

---

**Last Updated**: 2026-01-03 15:30 UTC
**Data Source**: Live project tracking data
**Next Update**: Daily at 09:00 UTC
**Refresh Rate**: Real-time for active projects
