# Progressive Checkpoints - CodePilot v2.0

**Tier**: Core+
**Phase**: 3 (Implementation)
**Feature #**: 16

## Purpose

Auto-save recovery checkpoints at regular intervals during implementation to preserve progress and enable recovery from crashes without losing hours of work.

## When to Use

Throughout Phase 3 implementation. Checkpoints automatically trigger every 45 minutes, after task completion, or before risky operations.

## Configuration Check

```javascript
config = read(".codepilot.config.json");
checkpoints_enabled = config.checkpoints.enabled;
interval_minutes = config.checkpoints.interval_minutes;  // Default: 45
auto_save = config.checkpoints.auto_save;                // Default: true
checkpoint_format = config.checkpoints.format;           // Default: compressed
```

## Auto-Checkpoint Triggers

1. **Time-based**: Every 45 minutes of continuous work
2. **Milestone-based**: After completing each task
3. **Risk-based**: Before complex refactoring or risky changes
4. **Error-based**: When errors or issues encountered
5. **Manual**: User command `/checkpoint`

## Checkpoint Workflow

### Every 45 Minutes

```
[Internal timer: 45 minutes elapsed]

Creating checkpoint...
✅ Checkpoint saved: phase3-checkpoint-003.md

Progress Summary:
- Overall: 60% (12/20 tasks complete)
- Current: Implementing task-012-api-endpoints
- Status: No blockers
- Last save: 45 minutes ago

[Continue working - user not interrupted]
```

### After Task Completion

```
✅ Task 012: API Endpoints Complete

Task Stats:
- Tests: 18/18 passing
- Coverage: 91%
- Time: 6.5 hours (vs 2 days estimated)
- Issues: None critical

Creating checkpoint...
✅ Checkpoint saved: phase3-checkpoint-004.md

Moving to Task 013: Search & Filtering...
```

### Before Risky Operation

```
⚠️ About to refactor authentication system (risky operation)

Creating safety checkpoint...
✅ Checkpoint saved: phase3-checkpoint-risky-001.md

Checkpoint Details:
- Task: 003-user-authentication (75% complete)
- Changes: All recent work saved
- Rollback: Can restore to this point instantly
- Duration: <1 second

If anything goes wrong, we can recover from here.

Proceeding with refactoring...
```

## Checkpoint Format

**Compressed Format** (default, ~400 tokens):

```markdown
# Checkpoint: P3-S2-CP003

**Phase**: 3 (Implementation)
**Date**: 2026-01-03 16:45:00 UTC
**Session**: Session-2
**Checkpoint**: 003

## Progress

**Overall**: 60% (12/20 tasks)
**Current Task**: task-012-api-endpoints.md (80% done)
**Blockers**: None

## Recent Work

**Completed**:
- Tasks 001-011 all passing tests
- All PRs merged
- Security review passed
- 94% avg test coverage

**In Progress**:
- Implementing task-012 (API endpoints)
- All endpoints except search working
- Tests: 18/18 passing
- Just consulted @security for rate limiting

## Next Steps

- Finish task-012 search endpoint
- Start task-013 (Search & Filtering)
- Run integration tests
- Code review before merge

## Context Hash

`hash:a1b2c3d4e5f6g7h8` → Links to previous checkpoint

## Files Modified

```
src/auth/routes.ts (↑)
src/auth/service.ts (↑)
src/auth/middleware.ts (↑)
tests/auth.spec.ts (↑)
```

**Total**: 4 files changed, 250 lines added

## Recovery Info

- **Restore Point**: Immediately before current work
- **Data Integrity**: All tests passing
- **Git Status**: Staged for commit
- **Time to Restore**: <10 seconds
```

**Full Format** (Advanced+, for long sessions):

```markdown
# Checkpoint: P3-S3-CP010 (Full)

[Same as above, plus]:

## Session Timeline

| Time | Action | Status |
|------|--------|--------|
| 14:00 | Session started | ✅ |
| 14:45 | Checkpoint 001 | ✅ |
| 15:30 | Task 010 complete | ✅ |
| 15:31 | Checkpoint 002 | ✅ |
| 16:15 | Checkpoint 003 | ✅ |
| 16:45 | This checkpoint | ✅ |

## Test Results History

- Checkpoint 001: 85/87 tests passing
- Checkpoint 002: 87/87 tests passing (fixed 2)
- Checkpoint 003: 89/87 tests passing (added 2)
- Current: 89/87 tests passing

## Performance Metrics

- Avg API response: 142ms (target: <150ms) ✅
- Database queries: <50ms (target: <50ms) ✅
- Frontend load: 1.8s (target: <2s) ✅

## Decisions Made Since Last Checkpoint

1. Used bcrypt for password hashing (vs scrypt)
2. JWT tokens 15min expiry (vs 30min)
3. Rate limit 5 attempts/min (vs 3)

## Dependencies Status

- TASK-001: ✅ Complete
- TASK-002: ✅ Complete
- TASK-003: ✅ Complete (current base)
- TASK-004: ⏳ Waiting (task-003 unblocked this)
```

## Storage

**Location**: `docs/artifacts/.recovery/`

**File Naming**:
```
phase3-checkpoint-001.md
phase3-checkpoint-002.md
phase3-checkpoint-003.md
phase3-checkpoint-risky-001.md
phase3-checkpoint-crisis-001.md (if error occurred)
```

**Retention**:
- Keep last 10 checkpoints per session
- Delete checkpoints >7 days old
- Keep all risky/crisis checkpoints for 30 days
- Manual checkpoints never auto-deleted

## Recovery Procedure

**If session crashes**:

```
Session resumed after crash...

Checkpoints available:
1. phase3-checkpoint-003.md (45 min ago)
2. phase3-checkpoint-004.md (task complete, 15 min ago)
3. phase3-checkpoint-risky-001.md (refactoring, 5 min ago)

Restore from which checkpoint? [Enter number or filename]

> 4

Restoring from phase3-checkpoint-004.md...

Restored State:
- Tasks 1-12 complete
- Working on task-013
- All tests passing
- No conflicts detected

Ready to continue working!
```

## Manual Checkpoint

Users can trigger manually:

```
/checkpoint "Before major refactoring"

Creating checkpoint...
✅ Checkpoint saved: phase3-checkpoint-005.md

Added Tag: "Before major refactoring"
Can restore to this point with: /restore 005
```

## Checkpoint Metadata

```json
{
  "checkpoint_id": "P3-S2-CP003",
  "timestamp": "2026-01-03T16:45:00Z",
  "phase": 3,
  "session": 2,
  "progress_percent": 60,
  "tasks_complete": 12,
  "tasks_total": 20,
  "current_task": "task-012",
  "test_status": "passing",
  "test_count": 89,
  "coverage_percent": 91,
  "blockers": [],
  "tags": ["routine", "after-task"],
  "git_status": "ready-to-commit",
  "previous_checkpoint": "P3-S2-CP002",
  "files_modified": 4,
  "lines_changed": 250,
  "restore_time_seconds": 5,
  "size_bytes": 15000
}
```

## Token Cost

**Creation**: ~400 tokens per checkpoint (compressed format)
**Storage**: ~15KB per checkpoint (~2,000 tokens)
**Frequency**: ~2-4 per phase = ~1,000 tokens per phase
**Recovery**: Minimal (checkpoint already saved)

**Total Cost**: ~1,000 tokens per phase vs **hours of lost work** if no checkpoints

## Configuration Options

```json
{
  "checkpoints": {
    "enabled": true,
    "interval_minutes": 45,
    "auto_save": true,
    "format": "compressed",  // or "full"
    "max_checkpoints": 10,
    "retention_days": 7,
    "crisis_retention_days": 30,
    "compression_level": "high"
  }
}
```

## Related Features

- [Task-Level Tracking](task-level-tracking.md) - Update checkpoint with task progress
- [Technical Debt Register](technical-debt-register.md) - Document decisions in checkpoints
- [Quality Gates](code-quality-gates.md) - Verify quality before each checkpoint

## Integration with Implementation Phase

Checkpoints run **throughout Phase 3**:

```
Phase 3 Start
  ↓
Auto-checkpoint every 45 min (THIS FEATURE)
Auto-checkpoint after each task
Manual checkpoints before risky ops
  ↓
Phase 3 Complete
  ↓
Final checkpoint: "Phase 3 Complete"
```

## Why This Matters

Without checkpoints:
- ❌ Session crash = hours of work lost
- ❌ Manual recovery = error-prone, slow
- ❌ No progress history = can't identify when issue occurred
- ❌ Risky operations = no safety net

With checkpoints:
- ✅ Crash recovery = 5-10 seconds to restore
- ✅ Full history = know exactly what changed
- ✅ Risk-free refactoring = can always roll back
- ✅ Progress visibility = team sees steady advancement

## Best Practices

1. **Don't ignore checkpoints**: They're created automatically
2. **Use manual checkpoints**: Before big changes, risky operations
3. **Tag them**: Help future recovery with meaningful names
4. **Review periodically**: Check progress via checkpoint history
5. **Archive important**: Save critical checkpoints separately

## Limitations

- Checkpoints are local (not synced to cloud)
- Can't checkpoint across multiple sessions easily
- Compressed format omits some detail (trade-off for tokens)
- Can't branch/merge checkpoints

## Future Enhancements

- Cloud backup of checkpoints
- Checkpoint branching (restore from checkpoint, create new branch)
- Collaborative checkpoints (share across team)
- Analytics on checkpoint frequency and size
