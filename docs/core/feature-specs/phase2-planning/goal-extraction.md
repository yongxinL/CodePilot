# Goal Extraction from One-Line Requirement - CodePilot v2.0

**Tier**: Core+
**Phase**: 2 (Planning)
**Feature #**: 2

## Purpose

Translate the business one-line requirement into measurable SMART technical objectives that the architecture must achieve.

## When to Use

After specification resolutions are complete, use this feature to extract concrete technical goals that guide architecture decisions.

## Workflow

1. Read one-line requirement from Phase 1 handoff
2. Identify core business drivers (3-5 main goals)
3. Translate each into SMART technical objective
4. Document measurable success criteria
5. Link back to original requirement

## Configuration Check

```javascript
config = read(".codepilot.config.json");
if (config.feature_tier >= "core_plus") {
  extract_technical_goals();
} else {
  skip_this_feature();
}
```

## Create Artifact

**Document in**: `docs/artifacts/phase2-planning/technical-design.md` header under "Project Goals"

## Format

### Template

```markdown
## Project Goals (Extracted from One-Line Requirement)

**One-Line Requirement**: "Small teams need collaborative task management to improve project coordination"

---

### Goal 1: Collaboration

**Business Need**: Enable team members to work together effectively

**Technical Translation**:
- Real-time task updates visible to all team members
- Update latency <100ms (perceptual real-time)
- Support concurrent editing without conflicts
- Show presence of other team members

**Measurable Criteria**:
- [ ] All task changes propagate within <100ms
- [ ] No data loss during concurrent updates
- [ ] User can see who else is viewing/editing

**Why This Matters**: Core to "collaborative" requirement

**Architecture Impact**:
- WebSocket server for real-time communication
- Conflict resolution strategy (operational transforms or CRDTs)
- Presence tracking system

---

### Goal 2: Task Management

**Business Need**: Enable efficient task tracking and management

**Technical Translation**:
- Full CRUD operations for tasks with assignment, deadlines, priorities
- Rich task metadata (description, attachments, history)
- Task filtering and search
- Workflow support (status transitions)

**Measurable Criteria**:
- [ ] All CRUD operations functional
- [ ] Task queries return in <50ms
- [ ] Support 10,000+ tasks without performance degradation
- [ ] Full task history available

**Why This Matters**: Core to "task management" requirement

**Architecture Impact**:
- Normalized database schema
- Indexing strategy for search
- Query optimization
- Audit trail/history tracking

---

### Goal 3: Project Coordination

**Business Need**: Give project managers visibility into team progress

**Technical Translation**:
- Team dashboard showing all tasks, assignments, progress
- Filter by project, team member, status
- Timeline/Gantt visualization
- Progress metrics and reporting

**Measurable Criteria**:
- [ ] Dashboard loads in <2 seconds
- [ ] Shows all relevant information
- [ ] Scales to 1000+ tasks
- [ ] Updates reflect changes within 30 seconds

**Why This Matters**: Core to "improve project coordination" requirement

**Architecture Impact**:
- Aggregation and reporting layer
- Dashboard caching strategy
- Real-time updates for dashboards
- Analytics database or materialized views

---

## Goal Summary

| Goal | Priority | Type | Achievable | Timeline |
|------|----------|------|-----------|----------|
| Collaboration | Critical | Real-time | WebSockets proven | Phase 3 Week 3-4 |
| Task Management | Critical | Standard | REST patterns | Phase 3 Week 2-3 |
| Coordination | High | UI | Standard components | Phase 3 Week 4 |

**Total Effort Estimate**: 8 weeks
```

## Example Extractions

### E-commerce Platform
```
One-liner: "Enable small businesses to sell online without technical expertise"

Goals:
1. Easy Product Management: Simple UI for adding/editing products
2. Payment Processing: Secure payment collection with <2% failure rate
3. Order Fulfillment: Track orders from creation to delivery
4. Customer Communication: Automated order status emails
```

### Collaboration Tool
```
One-liner: "Teams need to collaborate asynchronously across time zones"

Goals:
1. Asynchronous Communication: Messages available offline, sync when online
2. Thread Organization: Organize conversations by project/topic
3. Search & Discovery: Find relevant past discussions quickly
4. Notification Control: Users choose when to be notified
```

### Analytics Platform
```
One-liner: "Companies need data-driven insights to improve operations"

Goals:
1. Data Ingestion: Collect data from multiple sources
2. Real-time Dashboards: View metrics as data arrives
3. Custom Reports: Build reports without coding
4. Performance: Query 1B+ rows in <5 seconds
```

## Token Cost

**Creation**: ~400 tokens
**Update**: ~150 tokens per goal

## Related Features

- [Specification Resolutions](specification-resolutions.md) - Resolve ambiguities first
- [Gantt Chart](gantt-chart.md) - Create timeline based on goals
- [Design Principles Checklist](design-principles-checklist.md) - Validate goal achievement

## Integration with Planning Phase

This step occurs **after Step 1.5 (Resolve Specifications)** in the planning workflow:

```
Step 1.5: Resolve Specification Ambiguities
  ↓
Step 1.6: Extract Goals from One-Line Requirement (THIS FEATURE)
  ↓
Step 2: Design System Architecture
```

## Why This Matters

Ensures:
- ✅ Architecture directly addresses business needs
- ✅ Technical decisions traceable to requirements
- ✅ Measurable success criteria defined
- ✅ Team alignment on priorities
- ✅ Scope boundaries clear

Prevents:
- ❌ Over-engineering unimportant features
- ❌ Missing critical requirements
- ❌ Misaligned technical priorities
- ❌ Scope creep
