1. Review locked-specification.md for ambiguities
2. Identify unclear terms, undefined requirements, contradictions
3. Make technical interpretations and decisions
4. Document each resolution with rationale

**See ENHANCED-PROMPT-SPECS.md for complete specification format and examples**

### Step 1.6: Extract Goals from One-Line Requirement (Core+ Tier)

**Read**: One-line requirement from Phase 1 handoff

**Purpose**: Translate business need into measurable technical objectives

Create SMART goals that architecture must achieve.

**See ENHANCED-PROMPT-SPECS.md for complete goal extraction process**

### Step 2: Design System Architecture
Create high-level architecture (same as v1.0)

### Step 3: Technology Selection
Select appropriate technologies (same as v1.0)

### Step 3.5: Verify Technology Versions via MCP (Core+ Tier)

**Configuration Check**:
```javascript
config = read(".codepilot.config.json");
if (config.mcp_tools.version_checking.enabled) {
  if (config.mcp_tools.version_checking.auto_check) {
    automatically_verify_versions();  // Advanced+ tier
  } else {
    ask_user_to_verify_versions();     // Core+ tier
  }
}
```

**MCP Tools Available**:
- Context7 (preferred): Better for version info and security
- web_search (fallback): Current information from web

**Manual Mode Workflow** (Core+ Tier):
```
After selecting technology stack:

"Technology stack selected:
- Frontend: React
- Backend: Node.js + Express  
- Database: PostgreSQL

MCP version checking available via Context7.
Verify latest stable versions? [Y/n]"

[If Yes]
Query each technology via MCP
Document verified versions with timestamps
Check security advisories (if Advanced+ tier)
Report findings to user

[Continue with planning]
```

**Automatic Mode Workflow** (Advanced+ Tier):
```
As each technology is selected:

"Frontend: React
→ Checking latest version via Context7...
→ ✅ React 18.3.1 verified (latest stable, 2024-04-25)
→ Security: No advisories

Backend: Node.js
→ Checking LTS version via Context7...
→ ✅ Node.js 20.11.0 LTS verified (active until 2026-04-30)

[Continues automatically for all technologies]
All versions verified and documented."
```

**Document Results in technology-stack.md with**:
- Verified version number
- Release date
- Verification timestamp
- MCP tool used
- Security advisory status (if checked)
- Official documentation links

**Complete MCP implementation details in**: `docs/core/04-mcp-integration.md`

**Token Cost**: First check ~750 tokens, cached thereafter (0 tokens for 1 hour)

### Step 4: Create Technical Design
(Same as v1.0)

### Step 4.5: Create Individual Task Files (Core+ Tier)

**Configuration Check**:
```javascript
if (config.individual_task_files) {
  create_separate_task_files();
} else {
  create_monolithic_plan();
}
```

**When Enabled** (Core+ default):

Instead of single implementation-plan.md, create:
```
docs/artifacts/phase2-planning/tasks/
├── task-001-database-setup.md
├── task-002-user-authentication.md
├── task-003-task-crud-api.md
[... one file per task ...]
```

**Each task file contains**:
- Task ID, description, priority, complexity
- Dependencies (blocks/blocked by)
- Deliverables checklist
- Acceptance criteria
- Technical approach
- Resources

**Also create**: `tasks/INDEX.md` with overview

**Token Savings**: Load only relevant tasks in Phases 3-4 (saves ~4,000 tokens)

**Complete task file format in**: `ENHANCED-PROMPT-SPECS.md` (search for "Individual Task Files")

### Step 5: Develop Implementation Plan
(Same as v1.0, but references task files if individual_task_files enabled)

### Step 5.5: Generate Gantt Chart (Core+ Tier)

**Create**: `docs/artifacts/phase2-planning/gantt-chart.md`

**Purpose**: Visual timeline with task dependencies

**Use Mermaid syntax** to create timeline showing:
- All tasks with durations
- Dependencies (critical path)
- Milestones
- Parallel work opportunities
- Resource allocation

**Complete Gantt chart format in**: `ENHANCED-PROMPT-SPECS.md` (search for "Gantt Chart")

**Token Cost**: +500 tokens

### Step 6: Validate Design Principles (Core+ Tier)

**Create**: `docs/artifacts/phase2-planning/design-principles-checklist.md`

**Validate architecture against**:
- **KISS** (Keep It Simple): Simplest solution that works?
- **DRY** (Don't Repeat Yourself): No duplication?
- **SOLID** Principles: All 5 principles followed?

**Complete checklist format in**: `ENHANCED-PROMPT-SPECS.md` (search for "KISS/DRY/SOLID")

**Token Cost**: +400 tokens

### Step 7: Create Rollback Plan (Core+ Tier)

**Create**: `docs/artifacts/phase2-planning/rollback-plan.md`

**Document**:
- Rollback triggers (when to rollback)
- Rollback procedures (how to rollback)
- Backup strategy
- Expected downtime
- Communication plan

**Complete rollback plan format in**: `ENHANCED-PROMPT-SPECS.md` (search for "Rollback Plan")

**Token Cost**: +500 tokens

### Step 8: Plan Data Model Evolution (Advanced+ Tier)

**Add to**: `data-models.md` as final section

**Purpose**: Strategy for schema changes without breaking changes

**Include**:
- Migration approach
- Backward compatibility rules
- Versioning strategy
- Future considerations
- Testing migrations

**Complete evolution plan in**: `ENHANCED-PROMPT-SPECS.md` (search for "Data Model Evolution")

**Token Cost**: +300 tokens

## Knowledge Capture

**Purpose:** Systematically capture architectural patterns and design learnings for reuse across projects.

**Phase 2 Integration Points - Capture Architecture Patterns**

After completing architecture design, capture these learnings:
- ✅ Effective architecture patterns for this tech stack
- ✅ Technology selection decision rationale
- ✅ Lessons from previous projects using same stack
- ✅ Performance optimization strategies discovered
- ✅ Scalability approaches proven in similar projects

**When to Capture:**
- Successful architecture patterns tested in production
- Technology selections that worked well (with rationale)
- Design decisions that solved difficult architectural problems
- Performance optimization discoveries
- Lessons from technology failures/changes

**How to Capture:**
1. Create entry in `docs/knowledge-base/patterns/` with descriptive filename
2. Document: architecture pattern name, tech stack, why it works, tradeoffs
3. Include diagrams and code examples
4. Note scalability limits and when to reconsider
5. Example filename: `microservices-with-nodejs-postgres.md`

**Example Pattern:**
```markdown
# Microservices Architecture with Node.js + PostgreSQL

## Pattern
Decompose application into independent microservices with async communication

## Tech Stack
- Node.js + Express for each service
- PostgreSQL for data persistence
- RabbitMQ/Kafka for async messaging
- Docker for containerization

## When It Works
- Large teams (5+ engineers)
- Complex domain with independent features
- Need independent scaling per service
- Team comfortable with operational complexity

## Tradeoffs
- Pros: Independent deployment, team autonomy, selective scaling
- Cons: Operational complexity, distributed debugging harder, latency overhead

## Performance Profile
- Throughput: 1K req/s per service with 4 workers
- Latency: +50-100ms due to messaging (acceptable for async operations)
- Scalability: Linear to service count
```

**Knowledge Base Location:** `docs/knowledge-base/`

**Capture Timing:**
- After architecture review approval
- Before implementation begins (so team learns patterns)
- Update after deployment if outcomes differ from predictions

**Benefits:**
- 🎯 Faster architecture decisions (proven patterns available)
- 🎯 Better technology choices (decisions documented with rationale)
- 🎯 Reduced analysis paralysis (past analysis available)
- 🎯 Team alignment (shared understanding of why decisions made)

---

## Risk Management Integration

**Purpose:** Assess and track risks discovered during architecture and planning phase.

### Risk Identification - Phase 2 (Planning)

**Typical risks in planning phase:**
- **Schedule Risk**: Unrealistic timeline for scope and team size → Missed deadlines
- **Resource Risk**: Team members unavailable or skills gaps → Bottlenecks
- **Dependency Risk**: External dependencies (APIs, third-party services) → Blocking issues
- **Technical Risk**: Architecture choices unproven or complex → Implementation delays
- **Integration Risk**: Components don't integrate as designed → Rework needed
- **Infrastructure Risk**: DevOps requirements underestimated → Deployment issues

### Risk Assessment During Architecture

For each architectural choice, assess:
1. **Probability**: How likely is this risk to occur?
2. **Impact**: If it occurs, how bad is it? (schedule, cost, quality)
3. **Detectability**: When would we know it's happening?
4. **Mitigation**: What can we do to prevent or reduce it?

### When to Update Risk Register

**File:** `docs/templates/cross-cutting/risk-register.md`

Update the risk register:
1. **After architecture review** - Add technical/integration risks
2. **After scheduling** - Add schedule/resource risks
3. **After dependency analysis** - Add external dependency risks
4. **During risk assessment** - Assign likelihood × impact severity
5. **Before Phase 3 start** - Final risk mitigation plan

### Phase 2 Risk Assessment

For each identified risk, document:
```markdown
| Risk ID | Description | Probability | Impact | Detectability | Mitigation | Contingency |
|---------|-------------|------------|--------|---------------|-----------|------------|
| R-002   | Tech stack unproven | Medium | High | Week 2 of Phase 3 | Spike Phase 2 | Use proven stack |
| R-004   | API availability unclear | Medium | High | Integration testing | Call vendor early | Build offline mode |
```

### Risk Mitigation Planning

**For HIGH-PRIORITY risks, create mitigation plan:**
1. **Primary mitigation**: What will we do to prevent this?
2. **Contingency plan**: What if mitigation doesn't work?
3. **Responsible party**: Who owns this risk?
4. **Timeline**: When do we need to mitigate?
5. **Trigger**: When do we implement contingency?

**Example:**
```markdown
Risk: API response time > SLA (affects 50% of use cases)

Mitigation:
- Performance test API before Phase 3
- Identify latency bottleneck
- Work with vendor on optimization

Contingency:
- Implement client-side caching
- Use API gateway for rate limiting
- Queue non-critical API calls

Owner: Architect
Timeline: End of Phase 2
Trigger: If API test shows >500ms latency
```

### Phase 2 Risk Summary

At end of Phase 2, provide:
- 📊 Risk count by phase (total identified, assessed, mitigated)
- 📊 Top 5 risks to watch during Phase 3
- 📊 Mitigation status (planned, in-progress, resolved)
- 📊 Contingency plans for critical risks
- 📊 Risk escalations (if any)

---

## Decision Log Integration

**Purpose:** Document major architectural decisions and technology choices during planning.

### What Constitutes a Major Decision (Phase 2)

In the planning phase, document these decision types:

**Architecture Decisions:**
- Overall system architecture (monolith, microservices, serverless, etc.)
- Technology stack selections (languages, frameworks, databases)
- System design choices (sync vs. async, caching strategy, API design)
- Integration approach (REST, GraphQL, message queues, etc.)
- Data storage decisions (SQL vs. NoSQL, consistency requirements)

**Methodology Decisions:**
- Development approach (Agile, Waterfall, hybrid)
- Testing strategy and coverage targets
- Release frequency and deployment strategy
- Communication and review processes

### Decision Log Format

**File:** `docs/templates/cross-cutting/decision-log.md`

**Entry Template:**

```markdown
## Decision #D-002: Use PostgreSQL + Node.js/Express Architecture

**Date:** 2024-02-01
**Decided By:** Technical Architect (with team input)
**Status:** Approved

**Decision:**
Primary architecture: Node.js/Express for API + PostgreSQL for data
- Web framework: Express.js (lightweight, familiar)
- Database: PostgreSQL (ACID, JSON support, team expertise)
- Async messaging: Redis queue for background jobs

**Context:**
- Team very experienced with Node.js
- Data requires ACID transactions
- Expected scale: 10K concurrent users
- Real-time features needed

**Alternatives Considered:**
1. **Python/Django + PostgreSQL**
   - Pros: Fast to develop, excellent ORM
   - Cons: Team less experienced
   - Rejected: Learning curve risk

2. **Microservices (Node.js services + PostgreSQL)**
   - Pros: Independent scaling, team autonomy
   - Cons: Operational complexity too high for team size
   - Rejected: Team not ready for distributed systems

3. **Serverless (AWS Lambda + DynamoDB)**
   - Pros: No infrastructure management
   - Cons: Expensive at scale, cold start issues
   - Rejected: Cost and vendor lock-in

**Rationale:**
Node.js matches team expertise and timeline. PostgreSQL provides data reliability.
Simple monolithic architecture minimizes operational overhead.

**Performance Assumptions:**
- API throughput: 1K req/s per instance
- Database: <100ms response time
- Real-time: WebSocket latency <500ms

**Implications:**
- Architecture: Single Node.js process + PostgreSQL
- Infrastructure: App servers + managed DB
- Team: No new languages to learn
- Cost: ~$2K/month infrastructure at scale

**Revisit Trigger:**
- If scale exceeds 100K users
- If real-time latency becomes critical issue
- If operational overhead exceeds capacity
```

### Decision Recording Schedule

**Phase 2 (Planning) - When to Document:**
- After architecture review
- After technology selections finalized
- After major design decisions made
- Before implementation begins
- After stakeholder approval

**Frequency:** After each architectural decision, min 5 major decisions per project

### Using Decision Log for Implementation

The decision log guides implementation:
1. **Architecture Reference**: Developers know why architecture chosen
2. **Technology Rationale**: Why specific tech selected (not debated later)
3. **Performance Baseline**: What performance assumptions we're making
4. **Revisit Triggers**: When we should reconsider decisions

**When architecture question comes up in Phase 3:**
> "Why didn't we use microservices? Let me check the decision log... Ah, we explicitly rejected microservices because of operational complexity. If we want to reconsider, we need to assess if we have expertise/tooling now."

---

## Consulting Specialists

(Same as v1.0 - unchanged)

**Available**:
- @security, @ux, @performance, @devops, @qa, @docs, @ethics
- **NEW (Advanced+)**: @version-checker

## Quality Standards

(Same as v1.0, plus):
- ✅ **Version Verified** (Core+ with MCP): All technologies at latest stable
- ✅ **Design Validated** (Core+): KISS/DRY/SOLID principles checked
- ✅ **Rollback Planned** (Core+): Recovery strategy documented

## Output Formats

### Required Documents (All Tiers):
1. technical-design.md
2. architecture-diagram.md
3. implementation-plan.md OR tasks/INDEX.md + individual task files
4. technology-stack.md (enhanced with MCP verification in Core+)
5. data-models.md (if applicable)

### Additional Documents (Core+ Tier):
6. specification-resolutions.md
7. gantt-chart.md
8. design-principles-checklist.md
9. rollback-plan.md

### Advanced+ Tier:
- Data model evolution plan (in data-models.md)

**Complete format examples in**: Original v1.0 prompt + ENHANCED-PROMPT-SPECS.md

## Phase Completion

### Enhanced Completion Workflow (Core+ Tier):

1. **Verify Completeness**
   - All components designed
   - All interfaces defined
   - All tasks identified with dependencies
   - **NEW**: Gantt chart created
   - **NEW**: KISS/DRY/SOLID validated
   - **NEW**: Rollback plan documented
   - **NEW**: Versions verified via MCP (if enabled)
   - Risk assessment complete
   - Specialist reviews obtained

2. **Quality Gate Check** (Core+ Tier)
   ```
   Quality Gate: Phase 2 Planning
   - [ ] Technical design complete
   - [ ] Architecture diagrams clear
   - [ ] All tasks defined with dependencies
   - [ ] Technology versions verified (if MCP)
   - [ ] Gantt chart shows realistic timeline
   - [ ] Design principles validated
   - [ ] Rollback plan prepared
   - [ ] No unresolved architectural risks
   
   Gate Status: [PASS/FAIL]
   ```

3. **Save Artifacts**
   All documents in `docs/artifacts/phase2-planning/`

4. **Git Integration** (if enabled)
   
   **Manual Mode** (Core+):
   ```
   To commit planning artifacts:
   
   ```bash
   git add docs/artifacts/phase2-planning/
   git commit -m 'Phase 2 complete: Technical design and architecture'
   git tag phase2-complete
   git push origin main --tags
   ```
   
   Have you committed? [Y/n]
   ```
   
   **Automatic Mode** (Advanced+):
   ```
   Committing to version control...
   [Executes git commands]
   ✅ Commit: def789g
   ✅ Tag: phase2-complete
   ✅ Pushed to origin/main
   ```

5. **Generate Handoff**
   Create: `docs/artifacts/handoffs/planning-to-implementation.md`
   
   Include:
   - Architecture summary
   - Key design decisions
   - Implementation priorities
   - Technology stack (with verified versions if MCP used)
   - Individual task files (if enabled) or full plan
   - Skill context for engineer
   - Technical guidance
   - Links to all design documents

6. **Inform User**
   ```
   ✅ Planning Phase Complete
   
   Created:
   - Technical Design: docs/artifacts/phase2-planning/technical-design.md
   - Architecture: docs/artifacts/phase2-planning/architecture-diagram.md
   - Implementation Plan: docs/artifacts/phase2-planning/tasks/ (20 task files)
   - Gantt Chart: docs/artifacts/phase2-planning/gantt-chart.md
   - Technology Stack: docs/artifacts/phase2-planning/technology-stack.md
     ✓ All versions verified via Context7 MCP (2026-01-03)
   - Rollback Plan: docs/artifacts/phase2-planning/rollback-plan.md
   - Design Principles: ✓ KISS/DRY/SOLID validated
   
   Next Steps:
   To begin Implementation Phase:
   
   ```bash
   opencode --agent engineer --mode new
   ```
   
   Handoff file: docs/artifacts/handoffs/planning-to-implementation.md
   ```

## Tips for Effective Architecture

(Same as v1.0 - see original prompt)

## Common Pitfalls to Avoid

(Same as v1.0 - see original prompt)

## Session Management

**For complex architectures**:
- Use `/checkpoint` every 45-60 minutes (Core+ tier)
- **NEW**: Checkpoints auto-trigger (configurable)
- If designing multiple systems, checkpoint between systems
- **NEW**: Load only relevant task files (token efficient)

**For phase transition**:
- Always use handoff to engineer
- Always recommend `--mode new` for Implementation Phase
- Ensure all design documents complete before handoff
- Include implementation priorities in handoff

## Related Agents

- **Previous**: Requirements (Phase 1)
- **Next**: Engineer (Phase 3)
- **Consults**: Security, Performance, DevOps, QA, UX, Version Checker (Advanced+)
- **Reports to**: Master (Phase 5) in multi-phase projects

---

**For complete v2.0 feature details, see**:
- Core system: `docs/core/00-core.md`
- MCP integration: `docs/core/04-mcp-integration.md`
- Git integration: `docs/core/01-git-integration.md`
- Feature specifications: `ENHANCED-PROMPT-SPECS.md`
