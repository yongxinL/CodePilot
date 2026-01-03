# Checkpoint System - CodePilot v2.0

**Progressive Session Recovery System**

## Overview

The checkpoint system enables mid-phase session recovery with compressed context preservation.

**Tiers**:
- **Minimal**: No checkpoints
- **Core+**: Checkpoints enabled
- **Advanced+**: Checkpoints + automatic triggers
- **Full**: All checkpoint features + knowledge capture

## Purpose

Prevent context loss from:
- Session timeouts
- Browser crashes
- Network interruptions
- Context window overflow
- Long-running tasks

## Checkpoint Triggers

### Automatic Triggers (Core+ Tier)

1. **Time-Based**: Every 45 minutes (configurable)
2. **Milestone-Based**: After completing major tasks
3. **Risk-Based**: Before complex/risky operations
4. **Error-Based**: On failures or exceptions
5. **Context-Based**: At 75% of context window

### Manual Triggers (All Tiers)

User command: `/checkpoint` or "Create checkpoint"

## Checkpoint Format

### Compressed Checkpoint (Core+ Default)

**Token Target**: ~400 tokens (vs ~2,000 for full context)

**Format**:
```markdown
# Checkpoint: P2-S3-CP002

**Phase**: 2 (Planning)
**Session**: 3
**Checkpoint**: 002
**Time**: 2026-01-03 15:45:30 UTC
**Tier**: core

## Progress
**Overall**: 60% complete
**Tasks**: 12/20 planned
**Current**: Working on task-012-api-endpoints.md

## Recent Actions (Last 10)
1. Created tasks 001-011 in tasks/ directory
2. Consulted @security on authentication approach
3. Verified React 18.3.1 via Context7 MCP
4. Verified Node.js 20.11.0 LTS via Context7 MCP
5. Created technical-design.md
6. Created architecture-diagram.md
7. Started gantt-chart.md
8. Validated KISS/DRY/SOLID principles
9. Created rollback-plan.md
10. Started task-012-api-endpoints.md

## Next Actions
1. Complete task-012 (API endpoint design)
2. Create tasks 013-020
3. Generate Gantt chart
4. Create data-models.md
5. Finalize implementation-plan.md

## Context Links
- Previous checkpoint: P2-S3-CP001 (hash: a3f8e9c)
- Handoff from Phase 1: docs/artifacts/handoffs/requirements-to-architect.md
- One-line requirement: "Small teams need collaborative task management..."
- Skill level: Mid (3 devs, familiar React, learning Node.js)

## Active Consultations
- @security: Authentication review (completed, recommendations integrated)
- @performance: Database query optimization (pending)

## Blockers
None

## Technical Debt
1. TODO: Add rate limiting to auth endpoints (low priority)

## Decisions Made
1. Selected PostgreSQL over MongoDB (better for relations)
2. Using Prisma ORM (team learning curve manageable)
3. JWT tokens with 15-min expiry (security best practice)

## Artifacts Created This Session
- technical-design.md (complete)
- architecture-diagram.md (complete)
- tasks/task-001.md through task-011.md (complete)
- rollback-plan.md (complete)
- task-012-api-endpoints.md (in progress, 40% complete)

## Recovery Instructions
To recover from this checkpoint:
1. Load this checkpoint file
2. Read context links (previous checkpoint, handoff)
3. Review recent actions and decisions
4. Load current artifact (task-012-api-endpoints.md)
5. Continue from "Next Actions" list
```

**Compression Ratio**: ~80% (400 tokens vs 2,000 tokens full context)

### Full Checkpoint (Optional, for critical moments)

**Token Size**: ~2,000 tokens

Includes complete context dump. Use only when:
- Before major architectural decisions
- Before risky refactoring
- User explicitly requests full checkpoint
- Preparing for long break

## Checkpoint Storage

### Location
```
docs/artifacts/.recovery/
├── phase1-checkpoint-001.md
├── phase1-checkpoint-002.md
├── phase2-checkpoint-001.md
├── phase2-checkpoint-002.md
├── phase2-checkpoint-003.md ← Latest
└── phase3-checkpoint-001.md
```

### Naming Convention
`phase{N}-checkpoint-{NNN}.md`
- N: Phase number (1-5)
- NNN: Sequential checkpoint number (001, 002, 003...)

### Retention
- Keep last 5 checkpoints per phase
- Older checkpoints auto-deleted
- Can archive important checkpoints manually

## Recovery Workflow

### Scenario: Session Crashed

**User**: "Continue from where we left off"

**Agent**:
```
Checking for recovery checkpoint...

Found: phase2-checkpoint-003.md
Date: 2026-01-03 15:45 UTC (18 minutes ago)
Progress: 60% complete (12/20 tasks)

Loading checkpoint...

✅ Context restored!

You were working on Phase 2 (Planning):
- Progress: 60% (12/20 tasks completed)
- Current task: task-012-api-endpoints.md (40% done)
- No blockers

Recent work:
- Created 11 task files
- Consulted @security (completed)
- Verified versions via MCP
- Created technical design and architecture

Next steps:
1. Complete task-012 (API endpoints)
2. Create remaining 8 tasks
3. Generate Gantt chart

Shall I continue with task-012? [Yes]
```

### Scenario: Long Break

**User**: "I need to stop for the day"

**Agent** (Core+ tier):
```
Creating checkpoint before pause...

✅ Checkpoint created: phase2-checkpoint-004.md
Saved: 2026-01-03 17:30 UTC
Progress: 75% (15/20 tasks)

When you return, say "Continue from checkpoint" and I'll 
restore exactly where we left off.

Have a great evening!
```

## Implementation in Agent Prompts

### Add to All Phase Agents

```markdown
## Session Management (Core+ Tier)

### Checkpoint Creation

**Automatic triggers**:
```javascript
if (config.checkpoints.enabled) {
  // Time-based
  if (session_duration > config.checkpoints.interval_minutes * 60) {
    create_checkpoint();
  }
  
  // Milestone-based
  if (major_milestone_completed) {
    create_checkpoint();
  }
  
  // Context-based
  if (context_usage > 0.75 * context_limit) {
    create_checkpoint();
    trigger_compact_mode();
  }
  
  // Error-based
  if (error_occurred) {
    create_checkpoint();
  }
}
```

**Manual trigger**:
User says: "/checkpoint" or "Create checkpoint"
→ Immediately create checkpoint
→ Confirm to user

### Checkpoint Recovery

At session start:
```javascript
if (user_says_continue && checkpoints_exist) {
  latest_checkpoint = find_latest_checkpoint(current_phase);
  
  ask_user: "Found checkpoint from ${time_ago(latest_checkpoint.time)}.
  Progress: ${latest_checkpoint.progress}
  
  Load this checkpoint? [Y/n]"
  
  if (yes) {
    restore_from_checkpoint();
  } else {
    start_fresh();
  }
}
```
```

### Checkpoint Workflow Example

**45-minute work session**:
```
0:00 - Session starts
0:45 - ⏰ Auto-checkpoint created (CP-001)
      User not interrupted, continues working
1:30 - ⏰ Auto-checkpoint created (CP-002)
      User not interrupted
2:00 - Major milestone reached
      ✅ Milestone checkpoint created (CP-003)
      User informed: "✅ Checkpoint saved"
2:15 - User: "I need to stop"
      Agent: "✅ Checkpoint CP-004 ready for recovery"
```

**Recovery next day**:
```
User: "Continue from where we left off"
Agent loads CP-004, restores context, continues seamlessly
```

## Token Efficiency

### Traditional Approach (No Checkpoints)
```
Long session breaks:
- Lose context
- Start over
- Re-explain everything
- Cost: 8,000+ tokens to rebuild context
```

### With Compressed Checkpoints (Core+)
```
Long session with checkpoints:
- Auto-save every 45 min (~400 tokens each)
- Session breaks: Load checkpoint (400 tokens)
- Continue immediately
- Cost: 400 tokens to restore vs 8,000 to rebuild
- Savings: 7,600 tokens (95% reduction!)
```

## Integration with Other Features

### With Git Integration
Checkpoints can include git status:
```markdown
## Git Status
Last commit: abc123f "Created tasks 001-011"
Uncommitted: task-012-api-endpoints.md (in progress)
Branch: main
```

### With Individual Task Files
Checkpoints reference specific task files:
```markdown
## Current Work
File: docs/artifacts/phase2-planning/tasks/task-012-api-endpoints.md
Progress: 40% (2/5 endpoints designed)
```

### With Knowledge Base (Advanced+ Tier)
Important checkpoints can be archived to knowledge-base/:
```
Checkpoint with major breakthrough
→ Extract pattern
→ Save to knowledge-base/patterns/
```

## Configuration Options

In `.codepilot.config.json`:

```json
{
  "checkpoints": {
    "enabled": true,
    "frequency": "auto",               // "auto" | "manual"
    "interval_minutes": 45,             // Time between auto-checkpoints
    "compression": true,                // Use compressed format
    "max_checkpoints_per_phase": 5,    // Retention limit
    "checkpoint_on_error": true,        // Auto on errors
    "checkpoint_before_risky": true     // Before complex ops
  }
}
```

---

**This checkpoint system provides robust session recovery with minimal token overhead.**
