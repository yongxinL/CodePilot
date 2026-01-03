# CodePilot v2.0 Feature Specifications Index

Quick navigation to all v2.0 feature specifications, organized by phase and tier.

**Last Updated**: 2026-01-03
**Status**: Phase 2 specs complete, Phases 3-5 in progress

---

## 📊 Quick Summary

| Phase | Features | Tier | Location | Status |
|-------|----------|------|----------|--------|
| Phase 2 | 8 features | Core+ | [phase2-planning/](phase2-planning/) | ✅ Complete |
| Phase 3 | 4 features | Core+ | [phase3-implementation/](phase3-implementation/) | 🔄 In Progress |
| Phase 4 | 4 features | Core+/Adv+ | [phase4-verification/](phase4-verification/) | ⏳ Pending |
| Phase 5 | 3 features | Adv+ | [phase5-master/](phase5-master/) | ⏳ Pending |

**Total Specifications**: 19 features across all phases
**Token Saved vs Monolithic**: ~2,500 tokens per phase load

---

## Phase 2: Planning

**Base Prompt**: `docs/prompts/02-planning.md`
**Total Features**: 8 (all Core+ tier)
**Purpose**: Enhance architecture and planning phase with v2.0 features

### Feature List

| # | Feature | Tier | File | Purpose |
|---|---------|------|------|---------|
| 1 | Specification Resolutions | Core+ | [specification-resolutions.md](phase2-planning/specification-resolutions.md) | Resolve ambiguities before design |
| 2 | Goal Extraction | Core+ | [goal-extraction.md](phase2-planning/goal-extraction.md) | Translate requirements to SMART goals |
| 3 | Gantt Chart | Core+ | [gantt-chart.md](phase2-planning/gantt-chart.md) | Visual timeline with dependencies |
| 4 | Individual Task Files | Core+ | [individual-task-files.md](phase2-planning/individual-task-files.md) | Token-efficient task tracking |
| 5 | Design Principles | Core+ | [design-principles-checklist.md](phase2-planning/design-principles-checklist.md) | Validate KISS/DRY/SOLID |
| 6 | Rollback Plan | Core+ | [rollback-plan.md](phase2-planning/rollback-plan.md) | Recovery strategy for deployments |
| 7 | Data Model Evolution | Advanced+ | [data-model-evolution.md](phase2-planning/data-model-evolution.md) | Plan schema changes safely |
| 8 | MCP Version Checking | Core+/Adv+ | [mcp-version-checking.md](phase2-planning/mcp-version-checking.md) | Verify technology versions via MCP |

### Integration Points in 02-planning.md

```
Step 1: Review Requirements
  ↓
Step 1.5: Specification Resolutions (#1) ⭐ NEW
Step 1.6: Goal Extraction (#2) ⭐ NEW
  ↓
Step 2: Design Architecture
Step 3: Technology Selection
  ↓
Step 3.5: MCP Version Checking (#8) ⭐ NEW
  ↓
Step 4: Task Breakdown
  ↓
Step 4.5: Individual Task Files (#4) ⭐ NEW
  ↓
Step 5: Implementation Plan
  ↓
Step 5.5: Gantt Chart (#3) ⭐ NEW
  ↓
Step 6: Validate Design Principles (#5) ⭐ NEW
  ↓
Step 7: Rollback Plan (#6) ⭐ NEW
Step 8: Data Model Evolution (#7) ⭐ NEW (Advanced+ only)
  ↓
Phase 2 Complete → Handoff to Phase 3
```

---

## Phase 3: Implementation

**Base Prompt**: `docs/prompts/03-implementation.md`
**Total Features**: 4 (all Core+ tier)
**Purpose**: Enhance implementation with checkpoints, tracking, quality gates

### Feature List (In Progress)

| # | Feature | Tier | File | Purpose |
|---|---------|------|------|---------|
| 16 | Progressive Checkpoints | Core+ | phase3-implementation/progressive-checkpoints.md | Auto-save progress every 45min |
| 17 | Task-Level Tracking | Core+ | phase3-implementation/task-level-tracking.md | Track status of individual tasks |
| 19 | Code Quality Gates | Core+ | phase3-implementation/code-quality-gates.md | Enforce quality before Phase 4 |
| 20 | Technical Debt Register | Core+ | phase3-implementation/technical-debt-register.md | Document shortcuts & TODOs |

### Integration Points in 03-implementation.md

```
Step 1: Review Design
Step 2: Setup Environment
Step 3: Implement Features
  ↓
Step 3.5: Progressive Checkpoints (#16) ⭐ NEW
  - Auto-checkpoint every 45 minutes
  - Checkpoint after each task
  - Manual checkpoints anytime
  ↓
Step 4: Code Quality & Testing
Step 5: Documentation
Step 6: Final Review
  ↓
Step 7: Track Technical Debt (#20) ⭐ NEW
  - Document shortcuts taken
  - Track deferred work
  - Remediation planning
  ↓
Step 8: Quality Gates (#19) ⭐ NEW
  - Verify ≥80% test coverage
  - Verify all tests passing
  - Verify linting clean
  - Block on critical issues
  ↓
Phase 3 Complete → Handoff to Phase 4
```

---

## Phase 4: Verification

**Base Prompt**: `docs/prompts/04-verification.md`
**Total Features**: 4 (Core+/Advanced+)
**Purpose**: Comprehensive testing and release preparation

### Feature List (Coming Soon)

| # | Feature | Tier | File | Purpose |
|---|---------|------|------|---------|
| 21 | Test Coverage Matrix | Core+ | phase4-verification/test-coverage-matrix.md | Visual grid of coverage by feature |
| 22 | Release Readiness Checklist | Core+ | phase4-verification/release-readiness-checklist.md | Go/no-go decision framework |
| 23 | Performance Benchmarks | Advanced+ | phase4-verification/performance-benchmarks.md | Load test and stress test results |
| 24 | Security Scan Report | Advanced+ | phase4-verification/security-scan-report.md | OWASP Top 10 assessment |

---

## Phase 5: Master Control

**Base Prompt**: `docs/prompts/05-master-control.md`
**Total Features**: 3 (Advanced+/Full)
**Purpose**: Multi-project orchestration and portfolio management

### Feature List (Coming Soon)

| # | Feature | Tier | File | Purpose |
|---|---------|------|------|---------|
| 25 | Metrics Dashboard | Advanced+ | phase5-master/metrics-dashboard.md | Track velocity, quality, efficiency |
| 26 | Portfolio View | Advanced+ | phase5-master/portfolio-view.md | Manage multiple concurrent projects |
| 27 | Resource Allocation | Full | phase5-master/resource-allocation.md | Track team allocation across portfolio |

---

## Feature Tiers

### Minimal (Free)
- Basic 5-phase workflow
- Standard templates
- Core documentation

### Core+ (Standard)
- All Minimal features
- Individual task files (#4)
- Progressive checkpoints (#16)
- Task-level tracking (#17)
- Quality gates (#19)
- Technical debt register (#20)
- Design validation (#5)
- Rollback planning (#6)
- Specification resolutions (#1)
- Goal extraction (#2)
- Gantt charts (#3)
- MCP version checking (#8, manual mode)
- Test coverage matrix (#21)
- Release readiness checklist (#22)

### Advanced+
- All Core+ features
- Data model evolution (#7)
- MCP version checking (#8, automatic mode)
- Performance benchmarks (#23)
- Security scan reports (#24)
- Metrics dashboard (#25)
- Portfolio view (#26)

### Full (Enterprise)
- All Advanced+ features
- Cross-project dependencies (#27)
- Resource allocation (#27)
- Multi-team orchestration
- Advanced portfolio management

---

## How to Use This Index

### For Agents During Execution

**Phase 2 (Architect)**:
1. Load [specification-resolutions.md](phase2-planning/specification-resolutions.md) after Phase 1
2. Load [goal-extraction.md](phase2-planning/goal-extraction.md) for technical objectives
3. Load [mcp-version-checking.md](phase2-planning/mcp-version-checking.md) for technology verification
4. Load [individual-task-files.md](phase2-planning/individual-task-files.md) for task breakdown
5. Load [gantt-chart.md](phase2-planning/gantt-chart.md) for timeline
6. Load [design-principles-checklist.md](phase2-planning/design-principles-checklist.md) for validation
7. Load [rollback-plan.md](phase2-planning/rollback-plan.md) for recovery
8. Load [data-model-evolution.md](phase2-planning/data-model-evolution.md) if Advanced+ tier

**Phase 3 (Engineer)**:
1. Load [progressive-checkpoints.md](phase3-implementation/progressive-checkpoints.md) at start
2. Load [task-level-tracking.md](phase3-implementation/task-level-tracking.md) per task
3. Load [technical-debt-register.md](phase3-implementation/technical-debt-register.md) when documenting shortcuts
4. Load [code-quality-gates.md](phase3-implementation/code-quality-gates.md) before Phase 3 complete

### For Users

**Looking for specific feature**: Use this index to find the file
**Learning about v2.0**: Read feature list in order by phase
**Checking implementation status**: See status column

### Token Efficiency

Instead of loading 2,350-line ENHANCED-PROMPT-SPECS.md:

**Monolithic Approach**:
- Load full file: ~3,000 tokens
- Use it during phase: ~3,000 tokens
- Total: ~6,000 tokens per phase

**Distributed Approach**:
- Load index: ~400 tokens
- Load feature files as needed: ~300 tokens each
- Total: ~700 tokens + per feature

**Savings**: ~85-90% token reduction per phase

---

## Status by Phase

### ✅ Phase 2: Complete
All 8 features specified, integrated into 02-planning.md references

### 🔄 Phase 3: In Progress
Creating 4 feature specifications for implementation phase

### ⏳ Phase 4: Pending
4 features to be specified for verification phase

### ⏳ Phase 5: Pending
3 features to be specified for master control phase

---

## New Agents & Features

### Data Interpreter Agent
**File**: `docs/prompts/06-data-interpreter.md` (new agent)
**Tier**: Full
**Purpose**: Visualize metrics and analytics from Phase 5

### Version Checker Subagent
**File**: `docs/prompts/version-checker.md` (new subagent)
**Tier**: Advanced+
**Purpose**: Check version updates and security advisories via MCP

---

## Related Core Documents

- [Core System Overview](../00-core.md)
- [Git Integration](../01-git-integration.md)
- [Checkpoint System](../02-checkpoint-system.md)
- [Knowledge Capture](../03-knowledge-capture.md)
- [MCP Integration](../04-mcp-integration.md)

---

## Quick Links

### Phase 2 Features
- [Specification Resolutions](phase2-planning/specification-resolutions.md)
- [Goal Extraction](phase2-planning/goal-extraction.md)
- [Gantt Chart](phase2-planning/gantt-chart.md)
- [Individual Task Files](phase2-planning/individual-task-files.md)
- [Design Principles Checklist](phase2-planning/design-principles-checklist.md)
- [Rollback Plan](phase2-planning/rollback-plan.md)
- [Data Model Evolution](phase2-planning/data-model-evolution.md)
- [MCP Version Checking](phase2-planning/mcp-version-checking.md)

### Phase 3 Features
- [Progressive Checkpoints](phase3-implementation/progressive-checkpoints.md)
- [Task-Level Tracking](phase3-implementation/task-level-tracking.md)
- [Code Quality Gates](phase3-implementation/code-quality-gates.md)
- [Technical Debt Register](phase3-implementation/technical-debt-register.md)

### Phase 4 Features
- [Test Coverage Matrix](phase4-verification/test-coverage-matrix.md)
- [Release Readiness Checklist](phase4-verification/release-readiness-checklist.md)
- [Performance Benchmarks](phase4-verification/performance-benchmarks.md)
- [Security Scan Report](phase4-verification/security-scan-report.md)

### Phase 5 Features
- [Metrics Dashboard](phase5-master/metrics-dashboard.md)
- [Portfolio View](phase5-master/portfolio-view.md)
- [Resource Allocation](phase5-master/resource-allocation.md)

---

## Maintenance

**Last Updated**: 2026-01-10
**Status**: ✅ Complete - All Phase 2-5 specs distributed
**Owner**: CodePilot Development Team

To request new features or report issues, see project documentation.
