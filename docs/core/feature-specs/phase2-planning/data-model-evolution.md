# Data Model Evolution Plan - CodePilot v2.0

**Tier**: Advanced+
**Phase**: 2 (Planning)
**Feature #**: 7

## Purpose

Strategy for evolving database schema over time without breaking changes, enabling zero-downtime migrations and backward compatibility.

## When to Use

During data model design, plan for future schema changes (tags, subtasks, multi-team, audit logs). Document migration strategy so team can evolve safely.

## Workflow

1. Design initial schema
2. Identify likely future changes (6-18 month timeline)
3. Plan backward-compatible migration path
4. Document versioning strategy
5. Define zero-downtime migration procedure
6. Test migrations on production copy

## Configuration Check

```javascript
config = read(".codepilot.config.json");
if (config.feature_tier >= "advanced_plus") {
  create_evolution_plan();
} else {
  skip_this_feature();
}
```

## Create Artifact

**File**: `docs/artifacts/phase2-planning/data-models.md` (add as final section)

**Key**: Plan for evolution DURING initial design

## Format

```markdown
## Data Model Evolution Strategy

### Current Schema Version

**Version**: 1.0.0
**Date**: YYYY-MM-DD
**Status**: Active

Current tables: users, tasks, teams, task_assignments

---

### Migration Approach

**Tool**: Flyway (or Liquibase, Prisma Migrate)

**Process**:
1. Create migration file per schema change
2. Test on production data copy first
3. Version migrations sequentially (001_*.sql, 002_*.sql)
4. Never edit existing migrations (immutable history)
5. Always include rollback capability
6. Document rationale and impact

**Migration Naming**:
```
migrations/
├── 001_initial_schema.sql
├── 001_rollback_initial_schema.sql
├── 002_add_task_tags.sql
├── 002_rollback_task_tags.sql
├── 003_add_subtasks.sql
├── 003_rollback_subtasks.sql
```

### Backward Compatibility Strategy

**v1.x releases** (backward compatible):
- Add columns (with defaults)
- Add tables
- Add indexes
- Deprecate column (don't use, but keep)
- Add optional fields

**v2.0 release** (breaking changes OK):
- Remove deprecated columns
- Rename columns
- Change data types
- Merge/split tables
- Remove tables

### Migration Pattern for Breaking Changes

When you eventually need a breaking change:

```
Phase 1 (v1.1): Add new column alongside old
  ALTER TABLE tasks ADD COLUMN title_new VARCHAR(255);

Phase 2 (v1.2): Dual-write to both columns
  // App writes to both title and title_new
  UPDATE tasks SET title_new = title WHERE title_new IS NULL;

Phase 3 (v1.3): Migrate existing data
  // Background job migrates all data
  UPDATE tasks SET title_new = title;

Phase 4 (v1.4): Deprecate old column
  // New code only uses title_new, old code still works
  ALTER TABLE tasks RENAME COLUMN title TO title_deprecated;

Phase 5 (v2.0): Remove old column (BREAKING)
  ALTER TABLE tasks DROP COLUMN title_deprecated;
```

### Schema Versioning in Database

```sql
CREATE TABLE schema_version (
  version VARCHAR(10) PRIMARY KEY,
  applied_at TIMESTAMP DEFAULT NOW(),
  description TEXT,
  status VARCHAR(20) -- ACTIVE, DEPRECATED, RETIRED
);

-- Current schema version
SELECT version FROM schema_version
WHERE status = 'ACTIVE'
ORDER BY applied_at DESC LIMIT 1;
```

### Future Considerations (Don't Build Yet)

**These are likely needed in 6-18 months. Plan migration strategy now.**

#### 1. Task Tags (6-12 months)
**Problem**: Users want to categorize tasks
**Solution**: Add `tags` column (TEXT array)

```sql
-- Migration 003: Add task tags
ALTER TABLE tasks ADD COLUMN tags TEXT[] DEFAULT '{}';
CREATE INDEX idx_tasks_tags ON tasks USING GIN(tags);

-- Rollback: Remove tags
ALTER TABLE tasks DROP COLUMN tags;
DROP INDEX idx_tasks_tags;
```

**Impact**:
- Schema: Simple column addition
- Migration: <1 second on 1M rows
- Backward compatible: ✅ Yes
- Client code: Optional feature

#### 2. Task Subtasks (12+ months)
**Problem**: Tasks need hierarchy
**Solution**: Add `parent_task_id` column

```sql
-- Migration 004: Add task hierarchy
ALTER TABLE tasks ADD COLUMN parent_task_id UUID REFERENCES tasks(id);
CREATE INDEX idx_tasks_parent ON tasks(parent_task_id);

-- Rollback: Remove hierarchy
ALTER TABLE tasks DROP COLUMN parent_task_id;
DROP INDEX idx_tasks_parent;
```

**Impact**:
- Schema: FK + index
- Migration: <1 second
- Backward compatible: ✅ Yes
- Queries: Need recursive CTE for depth

#### 3. Multiple Teams Per User (12+ months)
**Problem**: Users need to belong to multiple teams
**Solution**: Add junction table

```sql
-- Current (v1.0): One team per user
ALTER TABLE users ADD COLUMN team_id UUID REFERENCES teams(id);

-- Future (v1.5): Many teams per user
CREATE TABLE user_teams (
  user_id UUID REFERENCES users(id),
  team_id UUID REFERENCES teams(id),
  role VARCHAR(20), -- admin, member, viewer
  PRIMARY KEY (user_id, team_id)
);

-- Migration: Copy existing team_id to user_teams
INSERT INTO user_teams (user_id, team_id, role)
SELECT id, team_id, 'member' FROM users WHERE team_id IS NOT NULL;

-- Migration (v2.0): Drop old column
ALTER TABLE users DROP COLUMN team_id;
```

**Impact**:
- Schema: New table + migration
- Migration: Depends on user count
- Backward compatible: ⚠️ Requires dual-write period
- Queries: More complex JOINs

#### 4. Task Audit/History (18+ months)
**Problem**: Need to track who changed what when
**Solution**: Event sourcing or audit table

```sql
-- Audit table (alternative to event sourcing)
CREATE TABLE task_events (
  id SERIAL PRIMARY KEY,
  task_id UUID REFERENCES tasks(id),
  event_type VARCHAR(50), -- created, updated, deleted
  old_values JSONB,
  new_values JSONB,
  changed_by UUID REFERENCES users(id),
  changed_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_task_events_task ON task_events(task_id);
CREATE INDEX idx_task_events_user ON task_events(changed_by);
```

**Impact**:
- Schema: New table
- Migration: Complex (need app-side dual-write)
- Backward compatible: ⚠️ Requires careful rollout
- Queries: Can get full history

### Recommendation

**YAGNI Principle**: Don't build these yet. Build them when:
- Users request the feature
- Business metrics justify it
- You understand the requirements

Design the schema to ALLOW these changes, but don't implement them upfront.

---

### Zero-Downtime Migrations

**Strategy**: Blue-green deployment with pre-migration

```
1. Deploy version v1.0.1 (NEW CODE - blue)
   - Code handles both old and new schema
   - Dual-write logic implemented
   - Dual-read logic (try new first, fall back to old)

2. Run migration on database
   - Add new columns/tables
   - Migrate data from old to new
   - Keep old columns (for rollback)

3. Switch traffic to blue (10% → 50% → 100%)
   - Monitor errors
   - Verify new data works
   - Gradual rollout reduces risk

4. Monitor dual-write period
   - Check data consistency
   - Verify no data loss
   - All new data in new location

5. Remove dual-write logic in v1.0.2
   - Code no longer writes to old columns
   - Code reads only from new columns
   - Old columns still there (safety)

6. Decommission old columns in v2.0 (breaking)
   - Drop old columns
   - Clean up code
```

### Testing Migrations

**Required before running in production**:

```sql
-- 1. Test on empty database
CREATE DATABASE test_migration_empty;
-- Run forward migration
-- Verify schema

-- 2. Test on copy of production data
CREATE DATABASE test_migration_prod_copy;
-- Restore production data
-- Run migration
-- Verify data integrity
-- SELECT COUNT(*) FROM tasks; -- Compare to production
-- SELECT * FROM tasks LIMIT 5; -- Spot check
-- PRAGMA integrity_check; -- Database integrity

-- 3. Test rollback
-- Run rollback migration
-- Verify old schema restored
-- Verify no data loss

-- 4. Test performance
-- Run on 10M row copy
-- Measure duration
-- Check lock contention
-- Verify no table locks during DDL

-- 5. Test application compatibility
-- Deploy app code for new schema
-- Run integration tests
-- Verify no broken queries
```

### Documentation Template

**For Each Migration**:

```markdown
# Migration 003: Add Task Tags

**Version**: 1.1.0 → 1.1.1
**Date**: YYYY-MM-DD
**Author**: [Your Name]

## Purpose
Allow users to categorize and filter tasks with custom tags.

## Changes
- Add `tags` column (TEXT array)
- Add `idx_tasks_tags` GIN index for fast filtering
- Default value: empty array for existing tasks

## Migration
```sql
ALTER TABLE tasks ADD COLUMN tags TEXT[] DEFAULT '{}';
CREATE INDEX idx_tasks_tags ON tasks USING GIN(tags);
```

## Rollback
```sql
ALTER TABLE tasks DROP COLUMN tags;
DROP INDEX idx_tasks_tags;
```

## Impact
- Duration: ~30 seconds (on 1M rows)
- Downtime: None (online migration)
- Data loss risk: None (additive)
- Application impact: None (backward compatible)

## Testing Results
- Empty DB: ✅ PASS (5 seconds)
- 1M row copy: ✅ PASS (28 seconds)
- Rollback: ✅ PASS (works)
- App tests: ✅ PASS (all tests passing)

## Sign-off
- [ ] DBA reviewed
- [ ] App team verified compatibility
- [ ] Performance acceptable
- [ ] Rollback tested
```

---

### Version History

| Version | Date | Status | Notes |
|---------|------|--------|-------|
| 1.0.0 | YYYY-MM-DD | Active | Initial schema |
| 1.1.0 | TBD | Planned | Task tags (6mo) |
| 1.2.0 | TBD | Planned | Task subtasks (12mo) |
| 1.3.0 | TBD | Planned | Multi-team (12mo) |
| 2.0.0 | TBD | Future | Drop old columns, breaking changes |
```

## Key Principles

1. **Additive Only** (v1.x): Add columns, tables, indexes
2. **Backward Compatible** (v1.x): Old code still works
3. **Immutable Migrations**: Never edit existing migration files
4. **Dual Write/Read**: Plan for both old and new schema
5. **Test Before**: Always test on production data copy
6. **Zero Downtime**: Use blue-green for cutover

## Token Cost

**Creation**: ~500 tokens
**Update**: ~200 tokens per migration

## Related Features

- [Rollback Plan](rollback-plan.md) - Have recovery plan for failed migrations
- [Individual Task Files](individual-task-files.md) - Track data migration work as tasks

## Integration with Planning Phase

This planning occurs **during data model design** (Step 4):

```
Step 3: Technology Selection
  ↓
Step 4: Create Technical Design
  ├── Design data models
  └── Plan evolution (THIS FEATURE)
  ↓
Step 5: Develop Implementation Plan
```

## When Evolution Plan Essential

- **Small databases** (<1M rows): Can handle breaking changes
- **Large databases** (>100M rows): Need zero-downtime strategy
- **High availability** (24/7 uptime): Plan every schema change
- **Distributed data**: Extra care with schema sync

## Why Plan for Evolution

Prevents:
- ❌ Downtime for schema changes
- ❌ Data loss from improper migrations
- ❌ Application bugs during migration
- ❌ Tight coupling to initial schema

Enables:
- ✅ Safe schema evolution
- ✅ Zero-downtime deployments
- ✅ Easy rollback if needed
- ✅ Confident feature development
