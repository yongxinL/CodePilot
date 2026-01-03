# Implementation Timeline (Gantt Chart)

**Project**: [Project Name]  
**Created**: [YYYY-MM-DD]  
**Duration**: [X] weeks  
**Team**: [X] developers

---

## Visual Timeline

```mermaid
gantt
    title [Project Name] Implementation Timeline
    dateFormat YYYY-MM-DD
    
    section Phase 1: Foundation
    Database Setup           :task001, [START-DATE], [DURATION]d
    User Authentication      :task002, after task001, [DURATION]d
    User Profile            :task003, after task002, [DURATION]d
    
    section Phase 2: Core Features
    [Feature 1]             :task004, after task003, [DURATION]d
    [Feature 2]             :task005, after task004, [DURATION]d
    [Feature 3]             :task006, after task003, [DURATION]d
    
    section Phase 3: Advanced Features
    [Feature 4]             :crit, task007, after task005, [DURATION]d
    [Feature 5]             :task008, after task007, [DURATION]d
    
    section Phase 4: Polish & Launch
    Testing & Bug Fixes     :task009, after task008, [DURATION]d
    Documentation          :task010, after task008, [DURATION]d
    Deployment Prep        :task011, after task009, [DURATION]d
```

---

## Timeline Summary

**Start Date**: [YYYY-MM-DD]  
**End Date**: [YYYY-MM-DD]  
**Total Duration**: [X] weeks ([Y] days)  
**Buffer**: [Z]% ([N] days contingency)

**Critical Path**: [List task IDs on critical path]  
**Critical Path Duration**: [X] days

**Parallel Opportunities**: [Which tasks can run simultaneously]

---

## Milestones

**M1**: [Milestone Name] - Week [X] - [Date]
- Deliverable: [What's completed]
- Success criteria: [How we know it's done]

**M2**: [Milestone Name] - Week [X] - [Date]
- Deliverable: [What's completed]
- Success criteria: [How we know it's done]

**M3**: [Milestone Name] - Week [X] - [Date]
- Deliverable: [What's completed]
- Success criteria: [How we know it's done]

**M4**: [Final Milestone] - Week [X] - [Date]
- Deliverable: Production deployment
- Success criteria: System live and stable

---

## Task Dependencies

### Blocking Dependencies (Must Complete Sequentially)
- Task [NNN] BLOCKS Task [NNN]: [Reason]
- Task [NNN] BLOCKS Task [NNN]: [Reason]

### Optional Dependencies (Recommended Sequence)
- Task [NNN] SHOULD follow Task [NNN]: [Reason]

### Independent Tasks (Can Parallelize)
- Task [NNN] and Task [NNN]: Can run simultaneously
- Task [NNN] and Task [NNN]: No dependencies

---

## Resource Allocation by Week

**Week 1-2**: [Phase/Focus]
- Developer 1: [Assignment]
- Developer 2: [Assignment]
- Developer 3: [Assignment]

**Week 3-4**: [Phase/Focus]
- Developer 1: [Assignment]
- Developer 2: [Assignment]
- Developer 3: [Assignment]

[Continue for each week or phase]

---

## Risk Factors & Buffers

**Schedule Risks**:
1. **[Risk 1]**: [Description]
   - Impact: [Effect on timeline]
   - Mitigation: [Strategy]
   - Buffer: [Extra time allocated]

2. **[Risk 2]**: [Description]
   - Impact: [Effect on timeline]
   - Mitigation: [Strategy]
   - Buffer: [Extra time allocated]

**Contingency Plan**:
- Built-in buffer: [X]% ([Y] days)
- Can descope: [Which features if needed]
- Can extend: [Maximum acceptable delay]

---

## Timeline Assumptions

**Working Days**:
- [X] days per week
- [Y] hours per day per developer
- Total capacity: [Z] developer-hours per week

**Holidays/Leave**:
- [Date range]: [Holiday/event affecting schedule]
- Impact: [Days lost]

**Other Assumptions**:
- [Assumption 1]
- [Assumption 2]

---

## Tracking & Updates

**Update Frequency**: [Weekly | Bi-weekly]

**Tracking Method**:
- [ ] Update task status in individual task files
- [ ] Update this Gantt chart if timeline changes
- [ ] Report progress in status meetings
- [ ] Adjust for actual vs estimated durations

**Variance Tracking**:
- Track actual vs estimated for each task
- Adjust future estimates based on actuals
- Identify bottlenecks and risks early

---

## Alternative View: Text Timeline

If Mermaid doesn't render:

**Week 1-2**:
```
[Database Setup]──>[Auth]──>[Profile]
     3 days         4 days    3 days
```

**Week 3-4**:
```
                    [Feature 1]──>[Feature 2]
[Profile]──────────>   5 days        3 days
              │
              └───>[Feature 3]
                     4 days
```

[Continue for all weeks]

---

## Notes

[Any additional timeline notes, considerations, or clarifications]

---

**This Gantt chart provides visual project timeline for planning and tracking purposes.**
**Update as actual progress deviates from plan.**
