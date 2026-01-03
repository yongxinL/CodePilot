# Data Model Evolution Plan Template - CodePilot v2.0

**Phase**: 2 (Planning)
**Feature #**: 7
**Tier**: Advanced+

---

## Current Schema Version

**Version**: 1.0.0
**Date**: [Date created]
**Status**: Active

**Current Tables**:
- [table_name] - [brief description]
- [table_name] - [brief description]

---

## Migration Approach

**Tool**: [Prisma Migrate | Flyway | Liquibase | Other]

**Migration Process**:
1. [ ] Create migration file per schema change
2. [ ] Test on production data copy first
3. [ ] Version migrations sequentially
4. [ ] Never edit existing migrations
5. [ ] Always include rollback capability

**Migration Naming Convention**:
```
migrations/
├── 001_initial_schema.sql
├── 001_rollback_initial_schema.sql
├── 002_add_feature_name.sql
├── 002_rollback_feature_name.sql
└── 003_modify_table.sql
```

---

## Backward Compatibility Strategy

### Current Version Rules (v1.x)

**Allowed changes** (backward compatible):
- [ ] Add columns (with defaults)
- [ ] Add tables
- [ ] Add indexes
- [ ] Deprecate column (mark but keep)
- [ ] Add optional fields

**Not allowed** (breaking):
- [ ] Remove columns
- [ ] Rename columns
- [ ] Change data types
- [ ] Merge/split tables

### Breaking Changes (v2.0+)

Future major versions can have breaking changes after planning migration path.

---

## Migration Pattern for Breaking Changes

**When eventual breaking change needed**:

```sql
-- Phase 1: Add new column alongside old
ALTER TABLE [table] ADD COLUMN [new_field] [type];

-- Phase 2: Dual-write to both columns
-- Application writes to both [field] and [new_field]
UPDATE [table] SET [new_field] = [field] WHERE [new_field] IS NULL;

-- Phase 3: Migrate existing data
-- Background job migrates all data

-- Phase 4: Deprecate old column
-- New code uses [new_field] only, old code still works

-- Phase 5 (v2.0): Remove old column - BREAKING
ALTER TABLE [table] DROP COLUMN [field];
```

---

## Future Considerations (6-18 months)

**Don't build yet, but plan for**:

### Future Feature 1: [Feature Name]

**Timeline**: [6-12 months]

**What**: [Description of feature]

**Why**: [Business need]

**Migration Strategy**:
```sql
-- Migration: Add feature_name support
ALTER TABLE [table] ADD COLUMN [new_column] [type];
```

**Impact**:
- Schema: [Simple/Complex]
- Migration Time: [Estimate on 1M rows]
- Backward Compatible: ✅ Yes / ❌ No
- Effort: [Days estimate]

---

### Future Feature 2: [Feature Name]

**Timeline**: [12+ months]

**What**: [Description]

**Why**: [Business need]

**Migration Strategy**:
```sql
-- Migration code
```

**Impact**:
- Schema: [Simple/Complex]
- Migration Time: [Estimate]
- Backward Compatible: ✅ Yes / ❌ No
- Effort: [Estimate]

---

## Zero-Downtime Migration Strategy

**Deployment approach for zero downtime**:

```
1. Deploy new version (blue) with migration code
2. Run migration on blue database copy
3. Verify migration success
4. Gradually shift traffic (10% → 50% → 100%)
5. Monitor for issues
6. If issues: Rollback traffic to green
7. If success: Decommission green after 24h
```

---

## Migration Testing Checklist

**Before running in production**:

- [ ] Test on empty database
- [ ] Test on copy of production data
- [ ] Test rollback migration
- [ ] Test application with new schema
- [ ] Test application with old schema (transition period)
- [ ] Test performance after migration
- [ ] Verify no data loss

---

## Version History

| Version | Date | Status | Notes |
|---------|------|--------|-------|
| 1.0.0 | [Date] | Active | Initial schema |
| 1.1.0 | TBD | Planned | [Feature] - 6mo |
| 1.2.0 | TBD | Planned | [Feature] - 12mo |
| 2.0.0 | TBD | Future | Breaking changes - [Details] |

---

## Key Principles

1. **Additive Only** (v1.x): Add columns, tables, indexes only
2. **Backward Compatible** (v1.x): Old code still works
3. **Immutable Migrations**: Never edit existing migration files
4. **Dual Write/Read**: Plan for both old and new schema
5. **Test Before**: Always test on production data copy
6. **Zero Downtime**: Use blue-green for cutover

---

## Documentation Template for Each Migration

```markdown
# Migration [NNN]: [Feature Name]

**Version**: [Old] → [New]
**Date**: [Date]
**Author**: [Name]

## Purpose
[Why this migration is needed]

## Changes
- [Change 1]
- [Change 2]

## Migration SQL
\`\`\`sql
[SQL code]
\`\`\`

## Rollback SQL
\`\`\`sql
[Rollback code]
\`\`\`

## Impact
- Duration: [Estimate on 1M rows]
- Downtime: [None/Minimal/[Time]]
- Data loss risk: [None/Minimal/[Risk]]
- Application impact: [Backward compatible/Breaking]

## Testing Results
- Empty DB: ✅ [Time]
- 1M row copy: ✅ [Time]
- Rollback: ✅ Works
- App tests: ✅ All passing

## Sign-off
- [ ] DBA reviewed
- [ ] App team verified
- [ ] Performance acceptable
- [ ] Rollback tested
```

---

## Related Documents

- [Rollback Plan](rollback-plan.md) - Have recovery plan for failed migrations
- [Individual Task Files](individual-task-files.md) - Track data migration work as tasks

---

**Created By**: [Architect/Agent]
**Date**: [Date]
**Approved By**: [Technical Lead]
**Next Review**: [Date]
