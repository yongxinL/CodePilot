# Knowledge Capture System - CodePilot v2.0

**Organizational Learning and Pattern Library**

## Overview

The knowledge base system captures and organizes learnings from projects for reuse.

**Tiers**:
- **Minimal/Core+**: No knowledge capture
- **Advanced+**: Manual capture enabled
- **Full**: Automatic capture + portfolio-wide knowledge

## Purpose

Build organizational assets:
- **Patterns**: Reusable technical solutions
- **Lessons**: What worked, what didn't
- **Metrics**: Performance data and benchmarks
- **Decisions**: Major technical decisions with rationale

## Directory Structure

```
docs/knowledge-base/
├── patterns/
│   ├── jwt-authentication-pattern.md
│   ├── react-state-management-pattern.md
│   └── database-migration-pattern.md
├── lessons/
│   ├── postgres-performance-lesson.md
│   ├── deployment-automation-lesson.md
│   └── testing-strategy-lesson.md
├── metrics/
│   ├── project-velocity-metrics.md
│   ├── test-coverage-metrics.md
│   └── bug-rate-metrics.md
└── decisions/
    ├── react-vs-vue-decision.md
    ├── postgres-vs-mongo-decision.md
    └── monolith-vs-microservices-decision.md
```

## Knowledge Types

### 1. Patterns (Reusable Solutions)

**When to Capture**:
- Elegant solution to common problem
- Reusable across projects
- Solves recurring challenge
- Worth sharing with team

**Format**:
```markdown
# Pattern: JWT Authentication with Refresh Tokens

## Context
Need secure, stateless authentication for REST API with mobile clients.

## Problem
- Sessions don't scale horizontally
- Cookies don't work well with mobile apps
- Need to support logout and token revocation
- Security requires short-lived tokens

## Solution
JWT access tokens (15 min) + refresh tokens (7 days)

## Implementation
```javascript
// Access token generation
const accessToken = jwt.sign(
  { userId: user.id, role: user.role },
  process.env.JWT_SECRET,
  { expiresIn: '15m', algorithm: 'HS256' }
);

// Refresh token generation  
const refreshToken = jwt.sign(
  { userId: user.id, tokenFamily: uuid() },
  process.env.REFRESH_SECRET,
  { expiresIn: '7d', algorithm: 'HS256' }
);

// Store refresh token in Redis with family ID
await redis.setex(
  `refresh:${user.id}:${tokenFamily}`,
  7 * 24 * 60 * 60,
  refreshToken
);
```

## Benefits
- ✅ Stateless (scales horizontally)
- ✅ Works with mobile (no cookies)
- ✅ Can revoke (via token families)
- ✅ Short access token (limits exposure)
- ✅ Long refresh token (good UX)

## Trade-offs
- ❌ More complex than sessions
- ❌ Requires Redis for revocation
- ❌ Larger token size
- ❌ Cannot immediately revoke access tokens

## When to Use
- REST APIs with mobile clients
- Microservices architecture
- Horizontal scaling required
- Stateless authentication needed

## When NOT to Use
- Simple web apps (sessions simpler)
- Low traffic (sessions fine)
- No mobile clients needed

## Related Patterns
- OAuth 2.0 integration
- API key authentication
- Session-based auth

## Used In
- Project: Task Manager API (2026-01)
- Project: E-commerce Backend (2025-12)

## References
- RFC 8725: JWT Best Practices
- OWASP JWT Cheat Sheet
```
```

### 2. Lessons (What We Learned)

**When to Capture**:
- Something didn't go as planned
- Discovered better approach
- Made mistake and recovered
- Want to avoid repeating

**Format**:
```markdown
# Lesson: Database Migration Strategy

## What We Did
Ran database migrations manually in production during deployment.

## What Happened
- Downtime: 30 minutes (unplanned)
- Users affected: 500+ (couldn't access app)
- Data risk: Migration failed halfway, manual rollback needed
- Team stress: High (emergency response required)

## What We Learned

**Problems**:
1. Migration not tested on production-like data
2. No rollback script prepared
3. Migration ran during peak hours
4. Single-step process (all or nothing)

**Root Causes**:
1. Insufficient planning for data migration
2. No blue-green deployment strategy
3. No communication with users
4. Time pressure (deployed in rush)

## What We'll Do Differently

**Immediate**:
1. Always test migrations on production data copy
2. Create rollback script before deployment
3. Schedule maintenance windows (announce 48h in advance)
4. Use blue-green deployment (zero downtime)

**Process Changes**:
1. Add "migration plan" to Phase 2 deliverables
2. Require migration testing in Phase 4
3. Include rollback procedures in deployment guide
4. Never deploy during peak hours

**Technical Improvements**:
1. Use migration tools with rollback support (Flyway, Liquibase)
2. Split large migrations into smaller steps
3. Use feature flags to decouple deployment from migration
4. Implement health checks that verify migration success

## Impact
- Next migration: Zero downtime ✅
- User communication: 48h advance notice ✅
- Rollback tested: <2 minute recovery ✅
- Team confidence: High ✅

## Metrics
- Before: 30 min downtime
- After: 0 min downtime (blue-green)
- Before: No rollback plan
- After: 2 min rollback tested

## Related
- Pattern: Blue-Green Deployment
- Decision: Use Prisma for migrations
- Lesson: Always test on production copy

## Tagged
#database #migrations #deployment #incident #lesson-learned

## Date
2026-01-03

## Project
Task Manager API v1.0
```
```

### 3. Metrics (Performance Data)

**When to Capture**:
- Project completion
- Major milestones
- Quarterly reviews
- Performance baselines

**Format**:
```markdown
# Metrics: Task Manager API - Phase 3 Implementation

## Project Info
**Project**: Task Manager API
**Phase**: 3 (Implementation)
**Duration**: 21 days
**Team**: 3 developers
**Tier**: Advanced+

## Velocity Metrics

### Story Points
- Week 1: 12 points
- Week 2: 16 points (+33%)
- Week 3: 20 points (+25%)
- Average: 16 points/week
- Trend: +20% improvement

### Tasks Completed
- Total tasks: 20
- Completed on time: 18 (90%)
- Delayed: 2 (10%)
- Blocked: 0

### Time Estimates
- Estimated total: 120 hours
- Actual total: 135 hours
- Variance: +12.5%
- Estimation accuracy: 87.5%

## Quality Metrics

### Test Coverage
- Unit tests: 87%
- Integration tests: 78%
- E2E tests: 65%
- Overall: 82%
- Target: 80% ✅

### Code Quality
- Files created: 47
- Lines of code: 3,847
- Linter warnings: 0 ✅
- Code review issues: 3 (minor)

### Bug Rate
- Bugs found in testing: 5
- Bugs per 100 LOC: 0.13
- Critical bugs: 0 ✅
- High priority: 1
- Medium: 2
- Low: 2

## Performance Metrics

### Build Performance
- Initial build: 45 seconds
- Incremental build: 8 seconds
- Test suite runtime: 12 seconds

### Application Performance
- API response time (p95): 180ms ✅ (<200ms target)
- Database queries (avg): 42ms ✅ (<50ms target)
- Memory usage: 245MB
- CPU usage (avg): 35%

## Knowledge Captured

### Patterns Created
1. JWT authentication with refresh tokens
2. WebSocket connection management
3. Task state machine

### Lessons Learned
1. Real-time features take 40% longer than estimated
2. Database query optimization crucial (saved 60% time)
3. Early security reviews prevent late redesigns

### Decisions Made
1. PostgreSQL over MongoDB (relational data better)
2. Prisma ORM (team learning curve acceptable)
3. JWT over sessions (mobile client support)

## Efficiency Analysis

### Token Usage
- Average per interaction: 16,500 tokens
- With individual task files: Saved 4,000 tokens
- With checkpoints: 3 recoveries (saved 7,000 tokens each)
- Total savings: 25,000 tokens over project

### Time Savings
- Checkpoint recoveries: Saved 6 hours (3 sessions)
- MCP version checking: Saved 2 hours (no manual research)
- Individual task files: Saved 4 hours (easier navigation)

## Recommendations for Next Project

### Do More Of
- Early security consultations (@security)
- Performance testing during implementation (not after)
- Individual task files (huge time saver)
- Frequent checkpoints (3 saved us)

### Do Less Of
- Estimating real-time features (add 40% buffer)
- Deferring performance optimization (do early)

### Start Doing
- Load testing before verification phase
- Architecture decision records (ADRs)
- Weekly velocity reviews

## Benchmark for Future

This project establishes baseline metrics:
- Velocity: 16 points/week (3 devs)
- Quality: 82% test coverage, 0.13 bugs/100 LOC
- Performance: 180ms API response
- Efficiency: 16.5K tokens/interaction

Use these for estimating similar projects.

## Date
2026-01-03

## Tagged
#metrics #implementation #baseline #reference
```
```

### 4. Decisions (Major Technical Decisions)

**When to Capture**:
- Technology selection
- Architecture choices
- Design pattern decisions
- Trade-off evaluations

**Format**:
```markdown
# Decision: PostgreSQL vs MongoDB

## Decision
**Chosen**: PostgreSQL  
**Alternative**: MongoDB  
**Date**: 2026-01-03  
**Decided By**: Architect Agent (Phase 2)  
**Project**: Task Manager API

## Context
Need database for task management system with:
- User accounts
- Tasks with assignees
- Team structure
- Task comments and history
- Search and filtering

## Options Considered

### Option A: PostgreSQL (Chosen)
**Pros**:
- ✅ ACID compliance (data integrity crucial)
- ✅ Relational data (users, tasks, teams naturally relational)
- ✅ Complex queries (JOIN, aggregate, full-text search)
- ✅ JSON support (flexibility where needed)
- ✅ Mature ecosystem
- ✅ Team wants to learn SQL

**Cons**:
- ❌ Vertical scaling limits
- ❌ Schema migrations more complex
- ❌ Learning curve for team (new to PostgreSQL)

### Option B: MongoDB (Not Chosen)
**Pros**:
- ✅ Flexible schema (easy changes)
- ✅ Horizontal scaling easier
- ✅ JSON-native
- ✅ Simpler for rapid prototyping

**Cons**:
- ❌ No ACID transactions (before v4.0, weaker after)
- ❌ Relational data requires manual joins
- ❌ Complex queries harder
- ❌ Data integrity less guaranteed

## Decision Rationale

**Primary Factors**:
1. **Data Integrity**: Task management requires ACID (can't lose tasks)
2. **Relational Nature**: Users ↔ Tasks ↔ Teams are inherently relational
3. **Query Complexity**: Need JOINs for team task views, reporting
4. **Learning Opportunity**: Team wants SQL experience

**Risk Mitigation**:
- Use Prisma ORM (abstracts complexity)
- Allocate 1 week for PostgreSQL learning
- Vertical scaling sufficient for 10,000 users (current requirement)
- Can shard later if needed (unlikely)

## Expected Impact

**Positive**:
- Data integrity guaranteed
- Complex queries efficient
- Team gains SQL skills
- Professional database choice

**Negative**:
- 1 week learning curve
- More complex migrations
- Vertical scaling limit (mitigated: won't hit for years)

## Monitoring

Track these to validate decision:
- Query performance (target: <50ms avg)
- Migration success rate
- Team productivity with PostgreSQL
- Scalability (monitor at 5,000+ users)

## Outcome (Update Post-Project)

[To be filled after project completion]

## If We Could Decide Again

[To be filled if we'd change decision]

## Related
- Pattern: Database migration with zero downtime
- Lesson: PostgreSQL performance tuning
- Decision: Prisma vs TypeORM

## Tagged
#decision #database #architecture #postgresql

## References
- PostgreSQL Documentation
- Prisma ORM Documentation
- Team discussion thread: [link]
```
```

## Capture Workflow

### Manual Capture (Advanced+ Tier)

**User Triggers**:
```
User: "Save this authentication pattern to knowledge base"
User: "Document this lesson learned"
User: "Add this decision to knowledge base"
```

**Agent Response**:
```
agent: "Capturing to knowledge base...

Pattern identified: JWT Authentication with Refresh Tokens

Creating: docs/knowledge-base/patterns/jwt-auth-pattern.md

✅ Pattern captured!

This pattern is now available for reuse in future projects.
Tags: #authentication #jwt #security #pattern"
```

### Automatic Capture (Full Tier)

**Triggers**:
- End of each phase
- Major technical decision
- Problem solved elegantly
- Lesson learned from issue

**Agent Behavior**:
```
[Phase 3 completion]

agent: "Phase 3 complete!

Analyzing for knowledge capture...

Patterns identified:
1. JWT authentication → Captured
2. WebSocket connection pooling → Captured
3. Task state machine → Captured

Lessons learned:
1. Real-time features estimation → Captured

Decisions made:
1. PostgreSQL selection → Captured

✅ 5 knowledge artifacts created in docs/knowledge-base/

These are now available for future projects."
```

## Integration with Phases

### Phase 2 (Planning)
Capture architectural patterns and major decisions:
- Technology selection decisions
- Architecture pattern choices
- Design pattern selections

### Phase 3 (Implementation)
Capture code patterns and implementation lessons:
- Elegant code solutions
- Bug fixes and lessons
- Performance optimizations

### Phase 4 (Verification)
Capture testing patterns and quality lessons:
- Effective test strategies
- Bug patterns and preventions
- Performance benchmarks

### Phase 5 (Master)
Capture project-level metrics and lessons:
- Overall velocity and productivity
- Cross-phase learnings
- Process improvements

## Knowledge Reuse

### Consulting Knowledge Base

**User**: "Do we have a pattern for authentication?"

**Agent**: 
```
Searching knowledge base...

Found 2 related patterns:

1. **JWT Authentication with Refresh Tokens**
   - Location: docs/knowledge-base/patterns/jwt-auth-pattern.md
   - Used in: 2 previous projects
   - Rating: ⭐⭐⭐⭐⭐ (works well)
   - Context: REST APIs with mobile clients

2. **OAuth 2.0 Integration Pattern**
   - Location: docs/knowledge-base/patterns/oauth2-pattern.md
   - Used in: 1 previous project
   - Rating: ⭐⭐⭐⭐ (complex but powerful)
   - Context: Third-party authentication

Recommend: JWT pattern for your use case (internal auth)

Shall I apply this pattern? [Yes/No/Show me details]
```

### Pattern Application

```
User: "Yes, apply JWT pattern"

Agent: "Applying JWT authentication pattern...

Loading: docs/knowledge-base/patterns/jwt-auth-pattern.md

Adapting pattern to current project:
- Using Node.js (pattern was Node.js ✅)
- Using Express (pattern was Express ✅)
- Mobile clients: Yes (pattern designed for this ✅)

Creating implementation tasks based on pattern:
- Task 003: Implement access token generation
- Task 004: Implement refresh token mechanism
- Task 005: Create token refresh endpoint
- Task 006: Implement logout with revocation

Pattern applied! Implementation will follow proven approach."
```

## Token Efficiency

### Without Knowledge Base
```
Every project:
- Research authentication approaches: ~2,000 tokens
- Design from scratch: ~3,000 tokens
- Total: 5,000 tokens

Over 10 projects: 50,000 tokens
```

### With Knowledge Base
```
First project:
- Research and design: 5,000 tokens
- Capture pattern: +500 tokens
- Total: 5,500 tokens

Projects 2-10:
- Load pattern: 800 tokens
- Adapt to project: 1,200 tokens
- Total: 2,000 tokens each

Over 10 projects: 5,500 + (9 × 2,000) = 23,500 tokens
Savings: 26,500 tokens (53% reduction)
```

## Quality Standards

### Pattern Quality
✅ Clear context (when to use)
✅ Complete implementation (working code)
✅ Benefits and trade-offs explicit
✅ Multiple real-world uses
✅ Maintained and updated

### Lesson Quality
✅ Specific incident described
✅ Root causes identified
✅ Improvements implemented
✅ Results measured
✅ Actionable for future

### Decision Quality
✅ All options considered
✅ Criteria explicit
✅ Rationale clear
✅ Trade-offs documented
✅ Validated over time

## Configuration

```json
{
  "knowledge_base": {
    "enabled": true,                   // Enable knowledge capture
    "auto_capture": true,              // Advanced+: no, Full: yes
    "capture_patterns": true,          // Capture reusable patterns
    "capture_lessons": true,           // Capture lessons learned
    "capture_metrics": true,           // Capture project metrics
    "capture_decisions": true,         // Capture major decisions
    "min_pattern_uses": 1,             // Capture after N uses
    "review_before_capture": true      // User approval for auto-capture
  }
}
```

## Best Practices

### When to Capture
✅ **DO capture**:
- Solved non-trivial problem
- Made important decision
- Learned from mistake
- Created reusable solution

❌ **DON'T capture**:
- Trivial or obvious solutions
- One-off workarounds
- Incomplete solutions
- Untested approaches

### Pattern Naming
- Descriptive: "JWT Authentication with Refresh Tokens"
- Not vague: "Auth Pattern"
- Include key technologies: "React Context State Management"
- Include problem domain: "E-commerce Checkout Flow"

### Tagging
Use consistent tags:
- Technology: #react #nodejs #postgresql
- Domain: #authentication #payments #search
- Type: #pattern #lesson #decision #metrics
- Quality: #production-ready #experimental #deprecated

---

**Knowledge base grows with each project, making future projects faster and better.**
