# Portfolio View - CodePilot v2.0

**Tier**: Advanced+
**Phase**: 5 (Master Control)
**Feature #**: 26

## Purpose

Manage and visualize multiple concurrent projects, tracking dependencies, cross-project impacts, and portfolio-level decisions.

## When to Use

In Phase 5, use portfolio view to manage multiple projects, understand interdependencies, and make cross-project decisions.

## Configuration Check

```javascript
config = read(".codepilot.config.json");
if (config.feature_tier >= "advanced_plus") {
  enable_portfolio_view();
} else {
  skip_this_feature();
}
```

## Create Artifact

**File**: `docs/artifacts/phase5-master/portfolio-view.md`

## Portfolio Overview

```markdown
# Portfolio View

**Organization**: LumenLab
**Last Updated**: 2026-01-10 20:30 UTC

---

## Portfolio Summary

### All Projects

| Project | Status | Owner | Release | Health |
|---------|--------|-------|---------|--------|
| CodePilot | ✅ Complete | Alice | 2026-01-11 | 🟢 |
| Client Portal | 🔄 In Progress | Bob | 2026-01-25 | 🟡 |
| Mobile App | 🔄 In Progress | Carol | 2026-02-15 | 🟡 |
| API Refactor | ✅ Complete | David | 2026-02-01 | 🟢 |
| Data Pipeline | ⏳ Planning | Eve | 2026-03-30 | 🟡 |
| Admin Dashboard | ⏳ Planning | Frank | 2026-04-15 | 🟢 |

**Portfolio Health**: 🟡 YELLOW (2 projects at risk)

---

## Project Details

### CodePilot v1.0.0

**Status**: ✅ COMPLETE
**Owner**: Alice (Backend Lead)
**Release Date**: 2026-01-11 (ON SCHEDULE)
**Stakeholders**: Marketing, Sales, Customer Success

**Scope**:
- ✅ Phase 1-5 complete (100%)
- ✅ All features implemented
- ✅ All tests passing
- ✅ Ready for release

**Key Metrics**:
- Velocity: 23 pts/sprint (target: 20) ⬆️
- Quality: 89% coverage (target: 85%) ✅
- On-time: YES ✅
- Budget: On-budget ✅

**Blockers**: None ✅

---

### Client Portal v2.0

**Status**: 🔄 IN PROGRESS (75%)
**Owner**: Bob (Frontend Lead)
**Release Date**: 2026-01-25 (AT RISK)
**Stakeholders**: Client Success, Product

**Scope**:
- ✅ Phase 1-2 complete
- 🔄 Phase 3 in progress (75%)
- ⏳ Phase 4 not started
- ⏳ Phase 5 not started

**Key Metrics**:
- Velocity: 18 pts/sprint (target: 20) ⬇️
- Quality: 82% coverage (target: 85%) ⚠️
- On-time: AT RISK (27% behind)
- Budget: On-budget ✅

**Blockers**:
1. 🔴 API dependency on CodePilot
   - Impact: Blocks Phase 4 testing
   - Resolution: CodePilot releasing 2026-01-11 ✅

2. 🟡 Insufficient QA capacity
   - Impact: Test coverage below target
   - Resolution: Reallocate 1 QA from completed projects

**Actions**:
- Add 1 backend engineer (+15% capacity)
- Add 1 QA engineer (+20% capacity)
- Expected new release date: 2026-02-01

---

### Mobile App v1.1

**Status**: 🔄 IN PROGRESS (50%)
**Owner**: Carol (Mobile Lead)
**Release Date**: 2026-02-15
**Stakeholders**: Product, Analytics

**Scope**:
- ✅ Phase 1-2 complete
- 🔄 Phase 3 in progress (50%)
- ⏳ Phase 4-5 not started

**Key Metrics**:
- Velocity: 15 pts/sprint (target: 18) ⬇️
- Quality: 76% coverage (target: 80%) ⚠️
- On-time: ON SCHEDULE ✅ (but tight)
- Budget: On-budget ✅

**Blockers**: None currently

**Risks**:
- 🟡 Technical debt accumulating (4+ days)
- 🟡 Test coverage below target
- ⚠️ Tight timeline for Phase 4-5

**Recommendations**:
- Plan 1-week refactor sprint after v1.1
- Add test coverage focus in Phase 4
- Consider parallel Phase 4-5 work to recover time

---

### API Refactor v2.0

**Status**: ✅ COMPLETE
**Owner**: David (Backend Lead)
**Release Date**: 2026-02-01 (EARLY)
**Stakeholders**: All backend teams

**Scope**:
- ✅ All phases complete (100%)
- ✅ All endpoints refactored
- ✅ All tests passing
- ✅ Ready for deployment

**Key Metrics**:
- Velocity: 15 pts/sprint (exceeds 15 target) ✅
- Quality: 94% coverage (exceeds 85% target) ✅
- On-time: EARLY (3 days ahead) ✅
- Budget: Under-budget 10% ✅

**Impact**:
- Unblocks Portal and Mobile
- Improves performance by 30%
- Enables future scaling

---

### Data Pipeline (Planning)

**Status**: ⏳ PLANNING
**Owner**: Eve (Data Lead)
**Release Date**: 2026-03-30
**Stakeholders**: Analytics, Product

**Scope** (estimated):
- Phase 1-2: 2 weeks (starting 2026-02-15)
- Phase 3-4: 4 weeks
- Phase 5: 1 week

**Key Decisions**:
- [ ] Technology stack (Apache Spark vs Kafka)
- [ ] Data source integration (5+ sources)
- [ ] Real-time vs batch processing

**Dependencies**:
- Requires: CodePilot v1.0.0 API ✅ (ready)
- Requires: API Refactor v2.0 (ready 2026-02-01) ✅
- May impact: Infrastructure capacity

**Preliminary Metrics**:
- Estimated velocity: 12-15 pts/sprint
- Estimated budget: $40k
- Team size: 2 engineers

---

### Admin Dashboard (Planning)

**Status**: ⏳ PLANNING
**Owner**: Frank (Frontend Lead)
**Release Date**: 2026-04-15
**Stakeholders**: Operations, Support

**Scope** (estimated):
- Phase 1-2: 1 week (starting 2026-03-15)
- Phase 3-4: 2 weeks
- Phase 5: 1 week

**Key Features**:
- User management
- System health dashboard
- Analytics & reporting
- Audit log viewer

**Dependencies**:
- Requires: CodePilot v1.0.0 ✅
- Requires: Portal v2.0 (planned Feb 1) ✅
- Nice to have: Data Pipeline (planning March 30)

**Preliminary Metrics**:
- Estimated velocity: 8-10 pts/sprint
- Estimated budget: $25k
- Team size: 1.5 engineers

---

## Cross-Project Dependencies

### Dependency Graph

```
Data Pipeline
  ↓ (depends on)
CodePilot v1.0.0 ✅ (ready 2026-01-11)
  ↓ (blocks)
Client Portal v2.0 🔄 (at risk)
  ↓ (enables)
Admin Dashboard ⏳ (planning)

API Refactor v2.0 ✅ (ready 2026-02-01)
  ↑ (unblocks)
Mobile App v1.1 🔄 (on track)
  ↓ (informs)
Data Pipeline ⏳ (planning)
```

### Critical Path

```
Jan 11: CodePilot v1.0.0 releases
  → Unblocks Portal v2.0 testing
  → Enables Mobile v1.1 optimization
  → Ready for Data Pipeline (Feb 15)

Feb 1: API Refactor v2.0 deploys
  → Improves performance for all apps
  → Required for Data Pipeline
  → Enables Admin Dashboard

Feb 15: Data Pipeline planning starts
  → Can begin design and tech spike
  → Depends on API finalization

Mar 15: Admin Dashboard planning starts
  → Can begin design
  → Depends on Portal v2.0

Apr 15: Admin Dashboard launches
  → Final portfolio piece
  → Enables operations workflows

Critical: Portal v2.0 release (Jan 25 deadline)
  If slips to Feb 1:
  - Data Pipeline starts 1 week late
  - Admin Dashboard starts 1 week late
  - Portfolio completion delays
```

---

## Resource Allocation

### Team Utilization

| Team | Allocated | Capacity | Utilization |
|------|-----------|----------|-------------|
| Backend (6) | 5.5 | 6 | 92% |
| Frontend (4) | 3.8 | 4 | 95% |
| QA (3) | 2.7 | 3 | 90% |
| DevOps (2) | 1.8 | 2 | 90% |
| Data (1) | 0.8 | 1 | 80% |

**Portfolio Utilization**: 89% ✅

### By Project Allocation

```
Total: 15 FTE

CodePilot:          (Complete)
├─ Backend: 0.5 (support)
├─ Frontend: 0
├─ QA: 0 (support only)
└─ DevOps: 1 (ops support)

Portal v2.0:        (35% allocation)
├─ Backend: 2 ← add 1 more (RECOMMENDED)
├─ Frontend: 2
├─ QA: 0.5 ← add 0.5 more (RECOMMENDED)
└─ DevOps: 0.2

Mobile App v1.1:    (30% allocation)
├─ Backend: 1.5
├─ Frontend: 1.5
├─ QA: 1
└─ DevOps: 0.2

API Refactor:       (Complete)
├─ Backend: 1.5 (support)
├─ Frontend: 0.3
└─ DevOps: 0.3

Data Pipeline:      (5% allocation - planning)
├─ Backend: 0
├─ Data: 1 (planning)
└─ DevOps: 0

Admin Dashboard:    (Planning - 0% allocation)
├─ (not yet started)
```

### Recommended Rebalancing

**Current Imbalance**:
- Backend: 92% (slightly over)
- Frontend: 95% (maxed out)
- QA: 90% (slightly over)

**Recommendation**:
1. Move 0.5 backend from support to Portal (↑ capacity for Portal)
2. Hire contract QA for 6 weeks to cover Portal testing
3. Delay Admin Dashboard start to early April

**Impact**:
- Portal on track for Feb 1 release
- Mobile on track for Feb 15 release
- Data Pipeline on track for Mar 30

---

## Portfolio Risks

### Critical Risks

| Risk | Project | Probability | Impact | Status | Mitigation |
|------|---------|-------------|--------|--------|-----------|
| Portal deadline | Portal | High | High | 🔴 | Add resources NOW |
| Key person absence | Backend | Low | High | ✅ | Cross-training |
| Data integration complexity | Data Pipeline | Medium | High | 🟡 | Early tech spike |

### Resource Risks

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|-----------|
| Frontend team maxed | Can't support new projects | High | Hire or outsource |
| QA capacity shortage | Test coverage drops | High | Contract QA |
| DevOps on-call burnout | Support quality degrades | Medium | Hire or automate |

---

## Portfolio Roadmap

### Timeline

```
Jan 2026
├─ Jan 11: CodePilot v1.0.0 ✅
└─ Jan 25: Portal v2.0 (target, at risk)

Feb 2026
├─ Feb 01: Portal v2.0 (revised target)
├─ Feb 01: API Refactor v2.0 ✅
├─ Feb 15: Mobile v1.1 ✅
└─ Feb 15: Data Pipeline starts

Mar 2026
├─ Mar 15: Admin Dashboard starts
└─ Mar 30: Data Pipeline v1.0 ✅

Apr 2026
└─ Apr 15: Admin Dashboard v1.0 ✅

May 2026
└─ (Planning for next generation features)
```

### Key Dates

- **Jan 11**: CodePilot release celebration
- **Jan 25/Feb 1**: Portal release (replan if needed)
- **Feb 1**: Infrastructure refactor complete (API v2.0)
- **Feb 15**: Mobile and Data Pipeline active
- **Apr 15**: Full portfolio version 1.0 complete

---

## Portfolio Status Report

### Summary

**Status**: 🟡 YELLOW (manageable risk)

**Highlights**:
- ✅ CodePilot on-time and over-quality
- ✅ API Refactor delivered early
- 🟡 Portal at risk, recovery plan in place
- ✅ Mobile on track if Portal unblocked

**Recommendations**:
1. **URGENT**: Add 1 backend + 0.5 QA to Portal today
2. Negotiate Portal release to Feb 1 if needed
3. Start Data Pipeline planning immediately
4. Cross-train teams for key person coverage

**Budget Status**:
- Year Budget: $225k
- Allocated: $198k (88%)
- Remaining: $27k (for contingency + bonuses)

**Timeline Status**:
- On track: 60% (3 of 5 projects)
- At risk: 40% (2 of 5 projects)

---

## Portfolio Governance

### Review Cadence

- **Weekly**: Project leads brief on risks
- **Bi-weekly**: Portfolio steering committee
- **Monthly**: Full portfolio review + reforecasting

### Approval Gates

**Go/No-Go Decisions**:
- Code freeze approval: Tech leads + PM
- Release approval: CTO + Product SVP
- Major replan: CFO + CTO + Product SVP

### Escalation Path

1. **Project Level** (Project Manager): Resolve in current sprint
2. **Portfolio Level** (Portfolio Manager): Resolve with reallocation
3. **Executive** (CFO/CTO): Scope, schedule, or budget trade-offs

---

## Version: v1.0
**Created**: 2026-01-10
**Last Updated**: 2026-01-10 20:30 UTC
**Next Review**: 2026-01-17 (weekly sync)
```

---

## Portfolio Components

This view provides:
1. **Project Overview** - Status, owner, release dates
2. **Dependencies** - Cross-project impacts
3. **Resource Allocation** - Team capacity planning
4. **Risk Management** - Identifying blockers
5. **Roadmap** - Timeline and milestones
6. **Governance** - Decision rights and escalation

---

## Integration with Master Control

Portfolio view enables:
- Cross-project visibility
- Resource optimization
- Dependency management
- Risk identification
- Strategic planning
- Executive reporting

---

## Token Cost

**Generate Portfolio View**: ~300 tokens
**Dependency Analysis**: ~150 tokens
**Risk Assessment**: ~100 tokens

**Total Per Period**: ~800 tokens (weekly)

---

## Related Features

- [Metrics Dashboard](metrics-dashboard.md) - Detailed metrics
- [Resource Allocation](resource-allocation.md) - Track allocations
- [Portfolio View](portfolio-view.md) - Multi-project view

## Why This Matters

Enables:
- ✅ Multi-project oversight
- ✅ Early risk detection
- ✅ Resource optimization
- ✅ Strategic planning
- ✅ Executive visibility
