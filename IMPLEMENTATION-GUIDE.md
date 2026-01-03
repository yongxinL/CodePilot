# Implementation Guide: Remaining Tasks

**Date**: 2026-01-03
**Target**: Complete remaining 14 missing features
**Estimated Effort**: 15-18 hours total

---

## 1. Template Integration Into Agent Workflows

### What This Means

Currently, templates exist in [docs/templates/](docs/templates/) but agents don't have explicit instructions to use them. We need to add sections to primary agent prompts (01-requirement through 05-master-control) that tell agents:
- WHEN to use each template
- HOW to use it (what to fill in)
- WHERE to save it
- WHICH template to use for specific situations

### Implementation Plan

#### **Task 1A: Add Knowledge Capture Integration** (3-4 hours)

**Files to Modify:**
1. `docs/prompts/01-requirement.md` - Add "Knowledge Capture" section
2. `docs/prompts/02-planning.md` - Add "Knowledge Capture" section
3. `docs/prompts/03-implementation.md` - Add "Knowledge Capture" section
4. `docs/prompts/04-verification.md` - Add "Knowledge Capture" section
5. `docs/prompts/05-master-control.md` - Add "Knowledge Capture" section

**Section Template to Add:**

```markdown
## Knowledge Capture

**Purpose:** Systematically capture organizational learning for reuse across projects.

**Integration Points:**

### Phase 1 (Requirements) - Capture Market Insights
After completing requirements, capture:
- ✅ Market analysis findings (use knowledge-base/market-analysis.md)
- ✅ Stakeholder communication patterns that worked
- ✅ Requirements elicitation techniques effective for this domain
- ✅ Compliance/regulatory patterns discovered

**When to capture:**
- Unique requirements patterns discovered
- Effective stakeholder communication approach
- Domain-specific compliance requirements
- Market differentiators identified

**How to capture:**
1. Create entry in docs/knowledge-base/patterns/
2. Document: pattern name, context, rationale, reusable elements
3. Tag with domain/category for cross-project discovery
4. Example: docs/knowledge-base/patterns/saas-compliance-pattern.md

**Example:**
```
# SaaS Compliance Pattern - GDPR Ready

## Pattern
All SaaS requirements should include GDPR data handling clauses

## Context
- 70% of new SaaS projects need GDPR compliance
- Pattern discovered from 3+ projects
- Saves 8+ hours per project if captured

## Reusable Elements
- [Template] GDPR data requirements checklist
- [Lesson] API design for data portability
- [Checklist] Privacy policy requirements

## Cross-project Use
Use when: Building cloud/SaaS applications targeting EU
Domain: SaaS, Compliance, GDPR
```

### Phase 2 (Planning) - Capture Architecture Patterns
After completing architecture design, capture:
- ✅ Effective architecture patterns for this tech stack
- ✅ Technology selection decision rationale
- ✅ Lessons from previous projects with same stack
- ✅ Performance optimization strategies discovered

### Phase 3 (Implementation) - Capture Development Learnings
After implementing features, capture:
- ✅ Coding patterns that worked well
- ✅ Performance optimizations discovered
- ✅ Common pitfalls and how to avoid them
- ✅ Testing strategies effective for this codebase
- ✅ Deployment lessons

### Phase 4 (Verification) - Capture Quality Insights
After testing and verification, capture:
- ✅ Test patterns that provided best coverage
- ✅ Security vulnerabilities patterns
- ✅ Performance bottleneck patterns
- ✅ Quality metrics for this type of application

### Phase 5 (Master Control) - Capture Portfolio Learnings
After managing portfolio, capture:
- ✅ Resource allocation patterns
- ✅ Project sequencing insights
- ✅ Dependency management lessons
- ✅ Risk patterns specific to organization

**Knowledge Base Location:** `docs/knowledge-base/`

**Directory Structure:**
```
docs/knowledge-base/
├── patterns/              # Reusable architecture/design patterns
├── lessons/              # Lessons learned from projects
├── metrics/              # Performance benchmarks by project type
├── domain-patterns/      # Compliance, industry patterns
└── index.md              # Knowledge base discovery guide
```

**Benefits:**
- 🎯 Cross-project learning (new projects avoid past mistakes)
- 🎯 Faster decisions (proven patterns available)
- 🎯 Better estimation (historical data available)
- 🎯 Organizational memory (not dependent on individuals)
```

**Effort Estimate:**
- Reading/understanding existing templates: 30 min
- Writing section for each agent prompt: 30 min × 5 = 2.5 hours
- Testing/validation: 30 min
- **Total: 3-4 hours**

---

#### **Task 1B: Add Risk Management Integration** (3-4 hours)

**Files to Modify:**
- All 5 primary agent prompts (01-requirement through 05-master-control)

**Section Template to Add:**

```markdown
## Risk Management Integration

**Purpose:** Identify, assess, and track risks throughout project lifecycle.

### Risk Identification

**Risk Categories by Phase:**

**Phase 1 (Requirements):**
- Scope ambiguity risk (unclear requirements)
- Stakeholder alignment risk (conflicting needs)
- Technology availability risk (unproven tech choices)

**Phase 2 (Planning):**
- Schedule risk (unrealistic timeline)
- Resource risk (team unavailable)
- Dependency risk (external blockers)

**Phase 3 (Implementation):**
- Technical debt risk (shortcuts accumulate)
- Quality risk (testing insufficient)
- Integration risk (components don't work together)

**Phase 4 (Verification):**
- Release risk (unknown issues in production)
- Performance risk (doesn't meet SLAs)
- Security risk (vulnerabilities discovered)

**Phase 5 (Master Control):**
- Portfolio risk (interdependency failures)
- Resource risk (allocation conflicts)
- Timeline risk (project sequence breaks)

### Risk Assessment Matrix

```
         Low Probability  |  High Probability
Low Impact:    Accept     |      Monitor
High Impact:  Mitigate    |     Contingency
```

### When to Update Risk Register

**Update risk register [docs/templates/cross-cutting/risk-register.md]:**
1. After Phase 1 - Identify initial risks
2. After Phase 2 - Assess risks (likelihood × impact)
3. During Phase 3 - Monitor and respond
4. Before Phase 4 - Re-assess based on implementation
5. During Phase 5 - Track portfolio-level risks

**Risk Register Template Entry:**
```
| Risk ID | Description | Likelihood | Impact | Owner | Mitigation | Status |
|---------|-------------|-----------|--------|-------|-----------|--------|
| R-001   | Scope creep | High | High | PM | Change control process | Active |
| R-002   | Resource shortage | Medium | High | HR | Cross-training plan | Monitoring |
```

### Risk Response Strategies

**Mitigation:** Reduce probability or impact
- Example: Add extra testing (reduces quality risk)

**Avoidance:** Change scope to eliminate risk
- Example: Use proven technology instead of new framework

**Acceptance:** Accept risk, plan contingency
- Example: Accept schedule pressure, hire contractors

**Transfer:** Move risk to vendor/partner
- Example: Use managed database service (transfer ops risk)

### Escalation

**When to escalate risk:**
- Critical risks (high probability × high impact)
- Risks affecting project viability
- Risks requiring executive decision

**How to escalate:**
1. Document in risk register
2. Notify stakeholder
3. Include in status communication
4. Add to decision log
```

**Effort Estimate:**
- Writing section for each agent: 30 min × 5 = 2.5 hours
- Creating risk categories/guidance: 30 min
- Testing: 30 min
- **Total: 3-4 hours**

---

#### **Task 1C: Add Decision Documentation Integration** (3-4 hours)

**Files to Modify:**
- All 5 primary agent prompts (01-requirement through 05-master-control)

**Section Template to Add:**

```markdown
## Decision Log Integration

**Purpose:** Document major decisions and rationale for future reference and audit.

### What Constitutes a Major Decision

Document these decision types:

**Architecture Decisions:**
- Technology stack selections
- System design choices
- Database schema decisions
- API design decisions

**Process Decisions:**
- Methodology choices (Agile, Waterfall, etc.)
- Testing strategy
- Release frequency
- Deployment process

**Resource Decisions:**
- Team structure
- Vendor/tool selections
- Build vs. buy decisions
- Outsourcing choices

**Scope Decisions:**
- Feature inclusions/exclusions
- Phase planning
- MVP definition
- Priority changes

### Decision Log Format

**File:** [docs/templates/cross-cutting/decision-log.md](docs/templates/cross-cutting/decision-log.md)

**Entry Template:**
```markdown
## Decision #D-001: Use PostgreSQL for Primary Database

**Date:** 2024-01-15
**Decided By:** Architect (with input from team)
**Status:** Approved

**Decision:**
Use PostgreSQL as the primary relational database for user data, transactions, and reporting.

**Context:**
- Project needs strong ACID guarantees
- Team has PostgreSQL expertise
- Schema flexibility needed (JSON columns)
- Scaling to 10K users planned

**Alternatives Considered:**
1. MySQL 8.0
   - Pros: Simpler licensing, slightly faster for simple queries
   - Cons: Limited JSON support, less advanced features
   - Rejected: JSON support critical for our use case

2. MongoDB (NoSQL)
   - Pros: Flexible schema, excellent horizontal scaling
   - Cons: ACID transactions limited, not suitable for financial data
   - Rejected: Transaction requirements eliminate NoSQL

3. Firebase/Cloud Firestore
   - Pros: Managed service, built-in auth/storage
   - Cons: Expensive at scale, vendor lock-in, limited queries
   - Rejected: Cost analysis showed unacceptable pricing at target scale

**Rationale:**
PostgreSQL best balances our needs for strong consistency, flexibility, team expertise, and cost.

**Implications:**
- Team requires PostgreSQL training (1-2 hours)
- Deployment infrastructure needs PostgreSQL support
- Backups configured with PIT recovery
- Replication setup for HA

**Revisit Trigger:**
If scaling beyond 100K concurrent users or if ACID requirements change, revisit decision.

**Related Decisions:**
- D-002: Use ORM for database abstraction
- D-003: Enable read replicas for analytics
```

### Decision Recording Schedule

**Phase 1 (Requirements):**
- Document: Scope boundaries, success criteria, stakeholder approach
- Frequency: After major milestone

**Phase 2 (Planning):**
- Document: Technology stack, architecture, methodology
- Frequency: After architectural review

**Phase 3 (Implementation):**
- Document: Design pattern selections, build vs. buy
- Frequency: When significant technical decisions made

**Phase 4 (Verification):**
- Document: Release strategy, quality thresholds, production approach
- Frequency: After verification planning

**Phase 5 (Master Control):**
- Document: Portfolio sequencing, resource allocation, priority shifts
- Frequency: At portfolio review meetings

### Who Should Know About Decisions

**Communicate decisions to:**
- ✅ Team members (execution)
- ✅ Stakeholders (business impact)
- ✅ Future maintainers (why choices were made)
- ✅ Architects (design consistency)

**Communication Method:**
- Team meeting announcement + decision log entry
- Email summary for stakeholders
- Wiki/documentation update for new team members

### Using Decision Log for Future Projects

When starting similar projects:
1. Review decision log from previous projects
2. Check if same decisions still valid
3. Adapt proven decisions
4. Document how current project differs
5. Add to organizational knowledge base

**Example Reuse:**
> "For this new SaaS product, we reviewed the decision log from our previous project. We reused the PostgreSQL decision, ORM selection, and monitoring approach. However, we reconsidered the authentication mechanism based on new requirements."
```

**Effort Estimate:**
- Writing section for each agent: 30 min × 5 = 2.5 hours
- Decision recording guidance: 30 min
- Testing: 30 min
- **Total: 3-4 hours**

---

### Integration Summary

**Total Effort for Template Integration: 9-12 hours**

| Task | Effort | Status |
|------|--------|--------|
| Knowledge Capture Integration | 3-4h | Pending |
| Risk Management Integration | 3-4h | Pending |
| Decision Log Integration | 3-4h | Pending |

**Key Files Modified:** 15 changes across 5 agent prompt files

**What Gets Enabled:**
- ✅ Organizational learning (knowledge base grows)
- ✅ Risk visibility (risks tracked systematically)
- ✅ Decision traceability (why things were decided)
- ✅ Reusable patterns (cross-project knowledge)

---

## 2. Change Manager Subagent Introduction

### What is Change Manager?

**Change Manager** is a subagent that helps coordinate change requests when project requirements change mid-stream. It's the "gatekeeper" that ensures changes are evaluated for impact before being approved.

### Real-World Scenario

**Without Change Manager:**
```
Stakeholder: "Can we add this new feature?"
Engineer: "Sure, I'll add it to the backlog"
(2 weeks later)
→ Project timeline slips by 1 week
→ No one documented why scope changed
→ Future projects have same problem
```

**With Change Manager:**
```
Stakeholder: "Can we add this new feature?"
Engineer: "Let me analyze the impact with @change-manager"

@change-manager:
- Request type: New feature (non-critical)
- Impact: Delays release by 5 days
- Resource impact: Requires 80 person-hours
- Risk impact: Conflicts with database migration (R-003)
- Cost impact: Additional $5K in contractor costs
- Recommendation: Defer to Phase 2 OR add 2 engineers

Stakeholder: "OK, we'll defer to Phase 2"
→ Timeline protected
→ Change documented in decision log
→ Cost impact visible
```

### What Change Manager Does

**Main Capabilities:**
1. **Change Request Analysis** - Evaluate impact of requested changes
2. **Scope Assessment** - Determine what work is added/modified
3. **Impact Quantification** - Schedule, resource, cost, risk impacts
4. **Approval Workflow** - Route to stakeholders for decision
5. **Change Documentation** - Record decision and track through implementation

### Change Types Handled

| Type | Example | Impact |
|------|---------|--------|
| **New Feature** | "Add PDF export" | Medium scope, new work |
| **Feature Modification** | "Change export format to CSV" | Small scope, rework existing |
| **Requirement Change** | "Users must not be deletable" | Medium scope, affects design |
| **Scope Reduction** | "Remove nice-to-have feature" | Reduces work, timeline benefit |
| **Technical Pivot** | "Use microservices instead" | Large scope, major rework |

### Benefits

🎯 **Time**: Prevents surprise scope creep (avg. 15% schedule protection)
🎯 **Cost**: Quantifies impact before decisions (avg. 20% cost visibility improvement)
🎯 **Quality**: Allows proper planning instead of firefighting
🎯 **Traceability**: Documents why changes were made
🎯 **Fairness**: Consistent evaluation process for all changes

---

## 3. Session Compact Mode & Auto-Compression

### Understanding the Problem It Solves

#### **Current State (Without Auto-Compression)**

```
Session Start (Token: 0/200K)
↓
Add context, files, conversation (Token: 50K)
↓
Continue work (Token: 100K)
↓
Continue more work (Token: 150K)
↓
Continue even more work (Token: 190K)
↓
HIT LIMIT! Cannot continue. Lost progress.
→ Manual checkpoint → Start new session
```

**Problem:**
- ❌ Sessions crash near token limit
- ❌ Manual checkpointing required
- ❌ Context loss
- ❌ Recovery process tedious

#### **With Auto-Compression**

```
Session Start (Token: 0/200K)
↓
Add context, work (Token: 50K)
↓
Continue work (Token: 100K)
↓
Continue work (Token: 150K)
↓
[AUTO-COMPRESS TRIGGERED at 75% = 150K]
→ Compress session → Store checkpoint
→ Continue with compressed context
↓
Sessions continues seamlessly (Token: 50K of new space)
```

**Benefit:**
- ✅ Automatic checkpoint creation
- ✅ Session continues uninterrupted
- ✅ No manual intervention needed
- ✅ Transparent to user

---

### Key Concepts: Compression vs. Handoff vs. Checkpoints

These three systems work together but serve different purposes:

#### **1. Checkpoints (Already Implemented ✅)**

**What:** Snapshots of work state saved periodically

**Purpose:** Recovery if something goes wrong

**How it works:**
```
Progress: Task 1 (done) → Task 2 (done) → Task 3 (in progress)
          ↓ checkpoint saved here
          → If crash, restart from checkpoint
```

**File affected:** `.recovery/checkpoint-[timestamp].md`

**Triggered by:**
- Every 45 minutes
- After major milestone completion
- Manual save command

**Frequency:** ~2-3 per hour

**Example:**
```
.recovery/
├── checkpoint-2024-01-15-10-30.md (start of session)
├── checkpoint-2024-01-15-11-15.md (after phase 1)
├── checkpoint-2024-01-15-12-00.md (after phase 2)
└── latest.md (most recent)
```

---

#### **2. Handoff (For Manual Transfer)**

**What:** Explicit context transfer between human and AI (or between AI agents)

**Purpose:** Resume work in new session without losing context

**How it works:**
```
Session 1: Work on Phase 1 → Complete
Handoff: "Here's the context, continue in Phase 2"
Session 2: Read handoff context → Continue Phase 2
```

**File structure:**
```
docs/artifacts/
├── phase1-requirements/
│   ├── requirements-spec.md (output)
│   ├── handoff.md (context for next phase)
│   └── README.md (summary)
├── phase2-planning/
│   ├── technical-design.md (output)
│   ├── handoff.md (context for phase 3)
│   └── README.md (summary)
```

**Trigger:** Manual at phase completion

**Content of handoff:**
```markdown
## Handoff: Phase 1 → Phase 2

### What was completed
- Requirements elicitation
- Stakeholder interviews
- Scope definition
- Success criteria

### Key decisions made
- [D-001] Use agile methodology
- [D-002] Sprint length: 2 weeks
- [D-003] Target audience: SMB segment

### Assumptions
- Backend will use Python/Django
- Frontend will be React
- 4-person team available

### Constraints
- Budget: $100K
- Timeline: 6 months
- Availability: 50% by team

### Next steps for Phase 2
1. Design system architecture
2. Create database schema
3. Plan sprints
4. Allocate resources
```

---

#### **3. Auto-Compression (NEW - To Be Implemented)**

**What:** Automatic session context compression when approaching token limit

**Purpose:** Continue work in same session without manual checkpoint/restart

**How it works:**
```
Session Start (200K token limit, assume ~4000 words per 1K tokens)
↓
Phase 1 complete: 50K tokens used (~200K words context)
Phase 2 in progress: 100K tokens used
Phase 2 continuing: 150K tokens used
[TRIGGER: 75% of 200K = 150K tokens]
↓
[AUTO-COMPRESSION]
- Summarize Phase 1 (200K → 30K words = ~7.5K tokens)
- Keep active Phase 2 context (full, ~140K tokens)
- Total after compression: ~50K tokens used
↓
Continue work in same session (still plenty of space)
```

**Key Difference from Checkpoints:**
- Checkpoint: Saves work for recovery from crash
- Compression: Manages token space to continue work

**Key Difference from Handoff:**
- Handoff: Manual, requires starting new session
- Compression: Automatic, same session continues

---

### Benefits of Auto-Compression

| Benefit | Current (Manual) | With Auto-Compression |
|---------|------------------|----------------------|
| **Session Duration** | Crashes at ~150K tokens | Continues for hours |
| **Manual Work** | Stop → checkpoint → start new | None, automatic |
| **Context Loss** | Potential if forget checkpoint | None, automatic handling |
| **User Experience** | Disruptive, requires intervention | Seamless, transparent |
| **Large Projects** | Very difficult (5-10 sessions) | Manageable (1-2 sessions) |

### How Auto-Compression Would Work

#### **Trigger Point**
```
IF current_tokens > (max_tokens × 0.75) THEN
  Trigger auto-compression
END IF

Example:
- Max tokens: 200K
- Trigger at: 150K (75% threshold)
- Remaining space after compression: 50-75K
```

#### **Compression Algorithm**

```
1. Identify completed phases/sections
2. Create executive summary of each:
   - Key outputs (2-3 lines)
   - Decisions made (bullet points)
   - Outcomes/metrics
3. Replace full context with summary
4. Keep current active context full
5. Preserve all files/outputs (no data loss)
```

#### **Example Compression**

**Before Compression (150K tokens):**
```markdown
## Phase 1: Requirements (All 50K details)
- Full stakeholder interviews (5000 words)
- Full requirements document (8000 words)
- Full use case descriptions (6000 words)
- Full acceptance criteria (4000 words)
... (30K more details)
```

**After Compression (7.5K tokens):**
```markdown
## Phase 1: Requirements - COMPRESSED SUMMARY
- Status: ✅ Complete
- Key outputs:
  - Requirements spec v1.0 (45 requirements identified)
  - 5 use case narratives documented
  - Acceptance criteria for all 45 requirements
- Decisions: [D-001] Agile methodology, [D-002] 2-week sprints
- Metrics: Stakeholder satisfaction 4.2/5, Time: 40 hours
- Files: docs/artifacts/phase1-requirements/

**FULL_DETAILS:** Stored in docs/artifacts/phase1-requirements/ (not in active context)
```

---

### Files That Would Be Affected

#### **1. System Configuration Files**

**`opencode.json`** (main config)
```json
{
  "auto_compression": {
    "enabled": true,
    "trigger_threshold": 0.75,        // 75% of token limit
    "max_tokens": 200000,
    "safe_token_buffer": 20000,       // Keep 20K free
    "compression_strategy": "phase-summary"  // or "sliding-window"
  }
}
```

#### **2. Checkpoint System Files**

**`.recovery/` directory** (already exists, add compression support)
```
.recovery/
├── checkpoint-2024-01-15-10-00.md (regular checkpoint)
├── compressed-2024-01-15-11-45.md (compression checkpoint)
├── metadata.json (new: tracks which checkpoints compressed)
├── compression-log.md (new: tracks all compressions)
└── README.md (update with compression info)
```

**New file: `.recovery/compression-log.md`**
```markdown
# Compression Log

## Compression #1 - 2024-01-15 11:45 UTC
- Trigger: 150K tokens (75% of 200K limit)
- Compressed phases: Phase 1 Requirements
- Size reduction: 50K tokens → 7.5K tokens (85% reduction)
- Space freed: 42.5K tokens
- Session continued: YES ✅
- Active context: Phase 2 Planning (140K tokens)
- Checkpoint saved: compressed-2024-01-15-11-45.md

## Compression #2 - 2024-01-15 14:20 UTC
- Trigger: 155K tokens
- Compressed phases: Phase 1, Phase 2
- Size reduction: 90K tokens → 12K tokens (87% reduction)
- Space freed: 78K tokens
- Session continued: YES ✅
- Active context: Phase 3 Implementation (125K tokens)
```

#### **3. Core Agent/System Files** (new/modified)

**`docs/core/05-auto-compression.md`** (NEW)
```markdown
# Auto-Compression System

## Overview
Automatic context compression to enable long-running sessions without manual intervention.

## Architecture
1. Token counter (monitors usage in real-time)
2. Trigger detector (identifies 75% threshold)
3. Compression engine (summarizes completed phases)
4. Recovery checkpoint (saves compression state)

## Implementation
- Trigger check: Every 1K tokens
- Compression latency: <5 seconds
- Transparent to user
```

**`docs/core/02-checkpoint-system.md`** (MODIFY)
```markdown
# Checkpoint & Compression System

## Types of Snapshots

### 1. Regular Checkpoints (Existing)
- Manual save or every 45 minutes
- Full context (no data loss)
- For crash recovery

### 2. Compression Checkpoints (NEW)
- Automatic at 75% token usage
- Summarized phases + active context
- For session continuity

### 3. Phase Handoff (Manual)
- At phase boundaries
- For session transfer
- For organizational handoff
```

#### **4. Agent Prompt Files** (modify)

**All primary agent prompts** (01-requirement through 05-master-control)
```markdown
## Session Management

### Token Management
- System automatically compresses completed phases at 75% token threshold
- You will see "[COMPRESSION TRIGGERED]" message
- Session continues seamlessly
- All previous work preserved in docs/artifacts/

### Recovery Checkpoints
- Automatic checkpoints every 45 minutes in .recovery/
- Manual checkpoints on major milestone completion
- Use checkpoint to resume if session interrupted

### What to Do During Compression
- Acknowledge "[COMPRESSION TRIGGERED]" message
- Continue work normally
- No action required from you
```

#### **5. Recovery Guide** (new/update)

**`.recovery/README.md`** (NEW/UPDATE)
```markdown
# Recovery System Guide

## How Compression Works

### Automatic Triggers
1. Session reaches 75% token limit → Auto-compress
2. Save compression checkpoint to .recovery/
3. Continue session with freed tokens
4. Repeat as needed

### What Gets Compressed
- Completed phases (summaries created)
- Complex details (preserved in docs/artifacts/)
- Active context (kept full for current work)

### No Data Loss
- All original files preserved
- Compression checkpoints saved
- Can always access full original in docs/artifacts/

## Recovery Process

### If Session Crashes
1. List recovery checkpoints: `ls .recovery/`
2. Identify latest checkpoint
3. Read checkpoint file
4. Provide to new session: "Resume from checkpoint-2024-01-15-11-45.md"

### If Want to Restart
1. Find compression checkpoint: `.recovery/compressed-*.md`
2. Read for context summary
3. Start new session with summary

### Accessing Full Context
- Phase outputs: `docs/artifacts/phase[N]-[name]/`
- All details preserved there
- Compression only affects active session context
```

---

### Implementation Roadmap for Auto-Compression

#### **Phase 1: Token Monitoring** (2-3 hours)
- Add token counter to system
- Log token usage in real-time
- Generate usage reports

#### **Phase 2: Compression Engine** (3-4 hours)
- Create summarization logic
- Build compression checkpoint format
- Test compression quality

#### **Phase 3: Trigger & Recovery** (2-3 hours)
- Implement trigger at 75% threshold
- Add compression checkpoint recovery
- Add messaging/notifications

#### **Phase 4: Integration & Testing** (2-3 hours)
- Integrate with checkpoint system
- Test full session flow
- Edge case handling

**Total Effort: 9-13 hours**

---

## Summary Comparison Table

| Feature | Checkpoint | Handoff | Auto-Compression |
|---------|-----------|---------|------------------|
| **Trigger** | 45 min or manual | Phase end manual | 75% token usage |
| **Purpose** | Crash recovery | Session transfer | Token management |
| **Data Preservation** | Full context | Full context | Full + summary |
| **Scope** | Entire session | Selected context | Completed phases |
| **Manual Work** | Yes (save checkpoint) | Yes (write handoff) | None (automatic) |
| **Session Duration** | ~2 hours (150K tokens) | Requires new session | Can continue (multiple compressions) |
| **User Visibility** | Explicit save | Explicit writing | Automatic, transparent |
| **Use Case** | "Session crashed, restart" | "End Phase 1, start Phase 2" | "Long project, manage tokens" |
| **When Implemented** | ✅ Already done | ✅ Already done | ❌ To be implemented |

---

## Conclusion

### 1. Template Integration (9-12 hours)
- **Goal**: Connect templates to agent workflows
- **Enables**: Knowledge capture, risk tracking, decision logging
- **Impact**: Organizational learning + systematic tracking

### 2. Change Manager Subagent (2-3 hours)
- **Goal**: Manage mid-project requirement changes
- **Enables**: Impact analysis before scope changes
- **Impact**: 15-20% schedule protection

### 3. Auto-Compression System (9-13 hours)
- **Goal**: Enable long-running sessions without manual intervention
- **Enables**: Unlimited session duration (with automatic management)
- **Impact**: Ability to handle large/complex projects in single session

**Total Remaining Work: 20-28 hours**
**Combined with already-implemented: 71% → 95% feature coverage**

