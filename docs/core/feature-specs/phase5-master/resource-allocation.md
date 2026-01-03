# Resource Allocation - CodePilot v2.0

**Tier**: Full (Enterprise)
**Phase**: 5 (Master Control)
**Feature #**: 27

## Purpose

Track detailed team allocation across multiple concurrent projects, enabling capacity planning, utilization optimization, and multi-team orchestration.

## When to Use

In Phase 5, use resource allocation to manage team capacity across portfolio and make staffing decisions.

## Configuration Check

```javascript
config = read(".codepilot.config.json");
if (config.feature_tier >= "full") {
  enable_resource_allocation();
} else {
  skip_this_feature();
}
```

## Create Artifact

**File**: `docs/artifacts/phase5-master/resource-allocation.md`

## Resource Allocation Framework

```markdown
# Resource Allocation

**Organization**: LumenLab
**Period**: 2026 Q1
**Last Updated**: 2026-01-10 21:00 UTC

---

## Organization Structure

### Teams & Capacity

| Team | Members | Capacity | Allocated | Available |
|------|---------|----------|-----------|-----------|
| Backend | 6 | 600 hrs | 552 hrs | 48 hrs |
| Frontend | 4 | 400 hrs | 380 hrs | 20 hrs |
| QA | 3 | 300 hrs | 270 hrs | 30 hrs |
| DevOps | 2 | 200 hrs | 180 hrs | 20 hrs |
| Data | 1 | 100 hrs | 80 hrs | 20 hrs |

**Total**: 16 people, 1600 hrs capacity, 1462 hrs allocated = **91% utilization** ✅

---

## Detailed Team Allocation

### Backend Team (6 people, 600 hrs/month)

| Person | Role | Allocation | Hours | Projects |
|--------|------|-----------|-------|----------|
| David | Senior | 100% | 160 | Portal (80%) + CodePilot support (20%) |
| Emma | Senior | 95% | 152 | API Refactor (100%) |
| Frank | Mid | 90% | 144 | Mobile (100%) |
| Grace | Mid | 85% | 136 | Mobile (60%) + Data Planning (40%) |
| Henry | Junior | 80% | 128 | Portal (100%) |
| Ivan | Junior | 75% | 120 | CodePilot support (100%) |

**Backend Allocation**: 840 hrs allocated / 960 hrs capacity = 87.5% ✅

**Notes**:
- Emma's API Refactor finishing Feb 1 (will free up 160 hrs/month)
- Ivan's CodePilot support reducing after release (will free up 120 hrs/month)
- Available capacity: 160 hrs/month for new work or contingency

---

### Frontend Team (4 people, 400 hrs/month)

| Person | Role | Allocation | Hours | Projects |
|--------|------|-----------|-------|----------|
| Jack | Senior | 100% | 160 | Portal (100%) |
| Kelly | Mid | 90% | 144 | Portal (80%) + Mobile (20%) |
| Liam | Mid | 85% | 136 | Mobile (100%) |
| Mia | Junior | 75% | 120 | CodePilot (40%) + Training (60%) |

**Frontend Allocation**: 560 hrs allocated / 640 hrs capacity = 87.5% ✅

**Notes**:
- Mia in ramp-up phase (60% training, 40% production work)
- After Portal release (Feb 1), Jack becomes available (160 hrs)
- Available capacity: 80 hrs/month for training + contingency

---

### QA Team (3 people, 300 hrs/month)

| Person | Role | Allocation | Hours | Projects |
|--------|------|-----------|-------|----------|
| Noah | Lead | 100% | 160 | Portal (60%) + Mobile (40%) |
| Olivia | Mid | 85% | 136 | Mobile (100%) |
| Peter | Junior | 65% | 104 | CodePilot support (100%) |

**QA Allocation**: 400 hrs allocated / 480 hrs capacity = 83% ⚠️

**Notes**:
- Portal QA coverage below target (60% instead of 80%)
- Peter reducing after CodePilot release (will have 80 hrs available)
- **ACTION**: Allocate Peter 50% to Portal QA starting now

---

### DevOps Team (2 people, 200 hrs/month)

| Person | Role | Allocation | Hours | Projects |
|--------|------|-----------|-------|----------|
| Quinn | Senior | 100% | 160 | Infrastructure (80%) + On-call (20%) |
| Rachel | Mid | 80% | 128 | Infrastructure (60%) + Automation (40%) |

**DevOps Allocation**: 288 hrs allocated / 320 hrs capacity = 90% ✅

**Notes**:
- Quinn on heavy on-call rotation (high burnout risk)
- Rachel working on CI/CD automation (medium priority)
- Available capacity: 32 hrs/month
- **RECOMMENDATION**: Hire 1 DevOps engineer, rotate on-call

---

### Data Team (1 person, 100 hrs/month)

| Person | Role | Allocation | Hours | Projects |
|--------|------|-----------|-------|----------|
| Steve | Lead | 100% | 160 | Data Pipeline planning (80%) + Ad-hoc (20%) |

**Data Allocation**: 160 hrs allocated / 160 hrs capacity = 100%

**Notes**:
- Steve fully allocated to Data Pipeline planning
- Starting Feb 15, will need 1-2 additional engineers
- **RECOMMENDATION**: Hire 1 contract data engineer for 6 months

---

## Project Allocations

### CodePilot v1.0.0 (Complete - Support Only)

**Total Allocation**: 40 hrs/month (support phase)

| Team | Allocation | Hours | Role |
|------|-----------|-------|------|
| Backend | 20 hrs | Ivan | Support + ops |
| Frontend | 10 hrs | Mia | Training + support |
| QA | 5 hrs | Peter | Smoke tests |
| DevOps | 5 hrs | Quinn | Deployment |

**Notes**: Transitioning to support-only mode after release

---

### Client Portal v2.0 (In Progress - 75% Complete)

**Total Allocation**: 480 hrs/month (current)
**Target**: 520 hrs/month (to meet deadline)

| Team | Current | Target | Gap |
|------|---------|--------|-----|
| Backend | 160 hrs | 200 hrs | +40 hrs |
| Frontend | 224 hrs | 240 hrs | +16 hrs |
| QA | 96 hrs | 80 hrs | -16 hrs ✅ |

**Current Allocation**:
- David (Backend): 80 hrs (50% of Portal)
- Emma (Senior): 80 hrs (30% from API)
- Henry (Junior): 80 hrs (Portal lead)
- Jack (Frontend): 160 hrs (Portal lead)
- Kelly (Frontend): 128 hrs (80% of Portal)
- Noah (QA): 96 hrs (60% of Portal)

**Gap Closure Actions**:
1. ✅ Move Emma from API to Portal (frees up 80 hrs, use 40 to Portal)
2. ✅ Move Peter from CodePilot to Portal QA (frees up 50 hrs/month starting Jan 11)
3. ✅ Allocate Liam 20 hrs from Mobile to Portal (frontend help)
4. ✅ Allocate Grace 30 hrs from Data planning to Portal (backend help)

**Result**: +96 hrs available, Portal gets +40 hrs ✅

---

### Mobile App v1.1 (In Progress - 50% Complete)

**Total Allocation**: 280 hrs/month

| Team | Allocation | Hours | Role |
|------|-----------|-------|------|
| Backend | 144 hrs | Frank (90 hrs) + Grace (54 hrs) | Lead + support |
| Frontend | 96 hrs | Liam (100%) + Kelly (20%) | Development |
| QA | 40 hrs | Olivia (100%) | Testing |

**Status**: On track for Feb 15 release ✅

---

### API Refactor v2.0 (Complete - Support Only)

**Total Allocation**: 40 hrs/month (support phase)

| Team | Allocation | Hours | Role |
|------|-----------|-------|------|
| Backend | 160 hrs | Emma | Maintenance + support |
| DevOps | 20 hrs | Quinn/Rachel | Deployment |

**Notes**: Transitions to support-only after Feb 1 deployment

---

### Data Pipeline (Planning - 5% Allocation)

**Current Allocation**: 80 hrs/month (planning)

| Team | Allocation | Hours | Role |
|------|-----------|-------|------|
| Data | 80 hrs | Steve | Planning + tech spike |
| Backend | 20 hrs | Grace (40%) | Planning support |

**Future Need** (starting Feb 15): 400-480 hrs/month

**Staffing for Feb 15+**:
- Steve (Lead): 160 hrs
- Contract Data Engineer: 160 hrs (hired by Feb 1)
- Grace (Backend): 80 hrs (20% allocation)
- Possible: 1 more data engineer (depending on scope)

---

### Admin Dashboard (Planning - 0% Allocation)

**Future Need** (starting Mar 15): 240 hrs/month

| Team | Future Allocation | Hours | Role |
|------|------------------|-------|------|
| Frontend | 160 hrs | Jack (100% available after Portal) | Lead |
| Backend | 80 hrs | TBD | Support |

**Staffing Plan**:
- Use available frontend capacity from Portal completion
- Allocate junior backend to support
- Start after Data Pipeline team formed

---

## Capacity Planning

### Current Month (January 2026)

```
Available Capacity: 138 hrs/month
Used for:
- Portal acceleration: +40 hrs (priority 1)
- Buffer/Contingency: +20 hrs
- Training: +18 hrs (Mia ramping)
- Miscellaneous: +60 hrs

Balance: 0 hrs (fully allocated)
```

### Next Month (February 2026)

**When API Refactor completes**:
- Emma frees up: 160 hrs
- Ivan frees up: 120 hrs
- Peter frees up: 80 hrs (from Portal)
- Total freed: 360 hrs

**Allocated to**:
- Data Pipeline startup: 300 hrs (Steve + contract + support)
- Buffer/Contingency: 60 hrs

**Result**: 0 hrs remaining (tight)

### March 2026

**When Portal releases**:
- Jack frees up: 160 hrs
- Henry frees up: 80 hrs (to support)
- Kelly frees up: 40 hrs (to other projects)
- Total freed: 280 hrs

**Allocated to**:
- Admin Dashboard: 240 hrs
- Buffer: 40 hrs

**Result**: Balanced

### April 2026+

**When Admin Dashboard launches**:
- Full team capacity available
- Data Pipeline mature (no ramp-up)
- Available for next generation work: ~200-300 hrs/month

---

## Staffing Needs

### Immediate (January)

**Priority**: HIGH

- [ ] Allocate Peter to Portal QA (50% starting now)
- [ ] Allocate Grace to Portal backend (30% starting now)
- [ ] Allocate Liam to Portal frontend (20% starting now)

**Action**: Update project assignments, notify team

---

### Short-term (February)

**Priority**: HIGH

- [ ] Hire 1 contract data engineer (6-month contract)
  - Start: Feb 1
  - Cost: $25k/month
  - Duration: Feb 1 - Jul 31
  - Skill: Data engineering + Python/Spark

**Action**: Begin recruitment now (4-week lead time)

---

### Medium-term (March-April)

**Priority**: MEDIUM

- [ ] Hire 1 permanent DevOps engineer
  - Start: Mar 1
  - Cost: $120k/year
  - Reason: Burnout risk, on-call rotation

- [ ] Consider 1 permanent data engineer
  - Start: May 1 (if Data Pipeline growth)
  - Cost: $110k/year
  - Conditional on business decision

---

### Long-term (Q2+)

**Priority**: LOW (strategic)

- [ ] Hire 2 backend engineers
  - Timeline: By June 30
  - Cost: $220k/year
  - Reason: Growth, next-gen projects

- [ ] Hire 1 frontend engineer
  - Timeline: By June 30
  - Cost: $110k/year
  - Reason: Growth, new projects

---

## Team Utilization Metrics

### By Team

```
Backend:   87.5% (healthy - has buffer)
Frontend:  87.5% (healthy - has buffer)
QA:        83% (needs boost - allocate Peter)
DevOps:    90% (risky - on-call heavy)
Data:      100% (maxed - hire contract)

Portfolio: 91% (good - balanced risk)
```

### By Project

```
CodePilot:      Support only (5% allocation)
Portal:         High priority (35% allocation)
Mobile:         On track (20% allocation)
API:            Support only (5% allocation)
Data Planning:  Starting (5% allocation)
Buffer/Training: 30% (contingency + learning)
```

---

## Burnout & Morale Risks

### At-Risk Individuals

1. **Quinn (DevOps Lead)** - 🔴 HIGH RISK
   - On-call: 20% of time
   - On-call rotation: Heavy weekends
   - Stress level: High
   - Action: Hire additional DevOps engineer by Mar 1

2. **Emma (Backend Senior)** - 🟡 MEDIUM RISK
   - Allocation: 95% (API lead)
   - Complex work: High (API refactor)
   - Stress level: Medium
   - Action: Reduce to 80% after API complete (Feb 1)

3. **Steve (Data Lead)** - 🟡 MEDIUM RISK
   - Allocation: 100% (sole data person)
   - Planning work: High complexity
   - Isolation: No team support
   - Action: Hire contract engineer by Feb 1

### Morale Initiatives

- [ ] Monthly team lunches (budget: $500/month)
- [ ] Quarterly learning budget (code review sessions)
- [ ] Annual bonuses tied to successful releases
- [ ] Flexible work-from-home (2 days/week)
- [ ] Professional development time (4 hrs/month)

---

## Budget Implications

### Payroll (Annual)

```
Current Team:    $1,600k
├─ Backend (6):  $660k
├─ Frontend (4): $440k
├─ QA (3):       $300k
├─ DevOps (2):   $240k
└─ Data (1):     $100k (senior)

Additional Hiring (Q1-Q2):
├─ DevOps engineer: $120k (start Mar 1)
├─ Data engineer (contract): $150k (6 months, Feb-Jul)
├─ Backend engineer (2): $220k (start Jun 1)
└─ Frontend engineer: $110k (start Jun 1)

New Total (Q3 2026): $2,440k (+52% growth) 🔴
```

### Mitigation Options

1. **Contract staff instead of full-time**
   - Cost: Same ($150k data contract)
   - Risk: Knowledge loss, continuity
   - Benefit: Flexibility, cost reduction

2. **Delay hiring**
   - Delay Data engineer: Slip Data Pipeline to Apr
   - Delay DevOps: Slip hiring to May 1
   - Benefit: Save $50k Q1, risk burnout

3. **Prioritize hiring**
   - DevOps ASAP (burnout risk)
   - Data engineer as planned (project-critical)
   - Backend/Frontend: Reevaluate Q2

**Recommendation**: Hire DevOps + Data engineer as planned

---

## Resource Optimization Strategies

### Efficiency Improvements

1. **Reduce context switching**
   - Limit project changes per month
   - Create sprint boundaries
   - Benefit: +5-10% productivity

2. **Pair programming on complex work**
   - Frontend complex components
   - Backend infrastructure
   - QA automation
   - Benefit: Better code quality, knowledge transfer

3. **Automation and tools**
   - CI/CD improvements (save 10 hrs/week)
   - Test automation (save 15 hrs/week)
   - Benefit: +25 hrs/week freed up

4. **Code reuse & libraries**
   - Share authentication code across projects
   - Shared UI component library
   - Backend utilities
   - Benefit: -15% development time

**Total Potential Gains**: +40-60 hrs/month ✅

---

## Allocation Board (Real-time Example)

```
Team          Available  Assigned  % Used  Status
──────────────────────────────────────────────────
Backend (600) 552        48        92%     🟡 High
Frontend(400) 380        20        95%     🔴 Max
QA (300)      270        30        90%     ✅ OK
DevOps (200)  180        20        90%     🟡 High
Data (100)    80         20        80%     ✅ OK
──────────────────────────────────────────────────
TOTAL (1600)  1462       138       91%     ✅ OK
```

---

## Monthly Review Cycle

### Weekly (Fridays)

- [ ] Team leads check utilization
- [ ] Flag new capacity needs
- [ ] Identify bottlenecks

### Monthly (Last Friday)

- [ ] Full allocation review
- [ ] Update capacity forecasts
- [ ] Plan staffing adjustments
- [ ] Update next month's allocation

### Quarterly (End of Q)

- [ ] Strategic capacity planning
- [ ] Hiring/budget planning
- [ ] Team feedback review
- [ ] Burnout risk assessment

---

## Tools & Systems

**Tracking**:
- Jira for time tracking (project allocation)
- Harvest for timesheet (actual hours)
- Tableau for dashboard
- Google Sheets for planning

**Reporting**:
- Weekly utilization report (email)
- Monthly capacity forecast (stakeholders)
- Quarterly business review (executive)

---

## Version: v1.0
**Created**: 2026-01-10
**Last Updated**: 2026-01-10 21:00 UTC
**Next Review**: 2026-01-31 (monthly)

---

## Appendix: Calculation Examples

### FTE Calculation

```
1 FTE = 40 hours/week × 52 weeks - vacation/holidays
      = 2,080 hours/year - 240 hours (vacation + holidays)
      = 1,840 hours/year
      = 160 hours/month
```

### Utilization Formula

```
Utilization % = (Allocated Hours / Available Hours) × 100%

Example:
- Backend team: 6 people × 160 hrs = 960 hrs available
- Allocated: 840 hrs
- Utilization: 840/960 = 87.5%
```

### Capacity Buffer

```
Recommended buffer: 10-20% of capacity

With 91% utilization:
- Buffer: 9% (below 10% target) 🟡
- Recommendation: Reduce to 85-87% allocation
- Action: Hire before demand increases
```
```

---

## Summary

This comprehensive resource allocation framework enables:
- **Real-time visibility** into team capacity
- **Proactive planning** for hiring and reallocation
- **Risk identification** for burnout and bottlenecks
- **Efficiency optimization** through better assignment
- **Strategic planning** for portfolio growth

---

## Token Cost

**Generate Allocation Report**: ~300 tokens
**Capacity Analysis**: ~150 tokens
**Forecasting**: ~150 tokens

**Total Per Period**: ~800 tokens (monthly)

---

## Related Features

- [Metrics Dashboard](metrics-dashboard.md) - Overall metrics
- [Portfolio View](portfolio-view.md) - Project overview
- [Resource Allocation](resource-allocation.md) - Detailed allocations

## Why This Matters

Enables:
- ✅ Optimized team capacity utilization
- ✅ Proactive staffing decisions
- ✅ Burnout prevention and team health
- ✅ Project timeline predictability
- ✅ Cost and budget management
- ✅ Strategic growth planning
- ✅ Multi-team orchestration
