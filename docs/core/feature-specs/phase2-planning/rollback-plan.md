# Rollback Plan - CodePilot v2.0

**Tier**: Core+
**Phase**: 2 (Planning)
**Feature #**: 6

## Purpose

Define recovery strategy if deployment fails, including specific procedures, backup strategy, and communication plan.

## When to Use

Before Phase 3 implementation begins, document rollback procedures so the team is prepared if things go wrong in production.

## Workflow

1. Identify rollback triggers (when we'll rollback)
2. Design rollback procedures (how we'll rollback)
3. Plan backup strategy (what we can recover)
4. Define communication plan (who to notify)
5. Plan post-rollback actions (what happens next)
6. Test rollback in staging before production

## Configuration Check

```javascript
config = read(".codepilot.config.json");
if (config.feature_tier >= "core_plus") {
  create_rollback_plan();
} else {
  skip_this_feature();
}
```

## Create Artifact

**File**: `docs/artifacts/phase2-planning/rollback-plan.md`

**Template**: `docs/templates/phase2/rollback-plan.md`

## Format

```markdown
# Deployment Rollback Plan

**Project**: [Project Name]
**Version**: v1.0.0
**Date**: YYYY-MM-DD
**Last Updated**: YYYY-MM-DD

## Rollback Triggers

**Automatic Triggers** (execute without discussion):
- [ ] Critical bug affecting >50% of users
- [ ] Data corruption or loss detected
- [ ] Security vulnerability with active exploitation
- [ ] Performance degradation >100% from baseline
- [ ] Service unavailable >15 minutes

**Manual Review Triggers** (discuss first):
- [ ] Critical bug affecting 10-50% of users
- [ ] Security vulnerability without active exploitation
- [ ] Performance degradation 50-100%
- [ ] Unknown issue causing user impact

### Decision Authority

**Auto-execute**: On-call engineer (if automatic trigger met)
**Manual**: Engineering lead + Product manager (>15 min unavailable, bug < critical)
**Escalate**: CTO (if manual decision unclear)

### Notification Required

On any rollback:
1. Notify stakeholders immediately
2. Update status page
3. Send user notification (if manual)
4. Document incident

---

## Rollback Procedures

### Procedure 1: Application Rollback (Fast - 2 minutes)

**Scenario**: Application code issue, database schema unchanged

**Conditions**:
- No database migrations in this release
- Just code changes
- Previous version known to work

**Steps**:

```bash
# 1. Prepare previous version
docker pull registry/myapp:v0.9.0
docker image inspect registry/myapp:v0.9.0

# 2. Stop current version gracefully
curl http://app:3000/shutdown  # Graceful shutdown
sleep 5
docker stop myapp-container

# 3. Start previous version
docker run -d \
  --name myapp-container \
  -e NODE_ENV=production \
  -e DB_URL=$DB_URL \
  -p 3000:3000 \
  registry/myapp:v0.9.0

# 4. Verify health
sleep 10
curl http://localhost:3000/health
echo "HTTP Status: $?"

# 5. Verify functionality
curl -X GET http://localhost:3000/api/health \
  -H "Authorization: Bearer $TEST_TOKEN"

# 6. Monitor
docker logs -f myapp-container | tail -20
```

**Expected Downtime**: 2-3 minutes
**Data Loss**: None
**Success Criteria**:
- [ ] Health check passes
- [ ] API endpoints responsive
- [ ] No error spikes in logs
- [ ] User reports normal operation

---

### Procedure 2: Database Rollback (Moderate - 15 minutes)

**Scenario**: Database migration or schema changes caused issues

**Conditions**:
- Database schema changed
- Data integrity confirmed in backup
- Previous database version available

**Steps**:

```bash
# 1. Alert users
curl -X POST https://status-page/api/incidents \
  -d "status=investigating&message=Database recovery in progress"

# 2. Stop application
docker stop myapp-container

# 3. Create backup of current database (just in case)
pg_dump -U postgres -h db-host mydb > /backups/db-latest-failed.dump
echo "Backup created: /backups/db-latest-failed.dump"

# 4. List available backups
ls -lh /backups/db-*

# 5. Restore from pre-migration backup
pg_restore -U postgres -h db-host \
  --clean \
  --if-exists \
  -d mydb \
  /backups/db-pre-v1.0.0.dump
echo "Database restore started..."

# 6. Verify database integrity
psql -U postgres -h db-host -c "SELECT COUNT(*) FROM users;" -d mydb
psql -U postgres -h db-host -c "SELECT COUNT(*) FROM tasks;" -d mydb
psql -U postgres -h db-host -c "CHECK INTEGRITY;" -d mydb

# 7. Rollback application (see Procedure 1)
docker run -d --name myapp-container registry/myapp:v0.9.0

# 8. Verify end-to-end
sleep 15
curl -X GET http://localhost:3000/api/tasks \
  -H "Authorization: Bearer $TEST_TOKEN"

# 9. Update status
curl -X POST https://status-page/api/incidents \
  -d "status=resolved&message=Database restored"
```

**Expected Downtime**: 15-20 minutes
**Data Loss**: Changes since last backup (document RPO/RTO goals)
**Success Criteria**:
- [ ] Database integrity verified
- [ ] Foreign key constraints checked
- [ ] Application starts without errors
- [ ] Smoke tests pass

---

### Procedure 3: Full Rollback (Complete - 30 minutes)

**Scenario**: Complete system failure, both app and database affected

**Conditions**:
- Unknown failure affecting multiple systems
- Need to restore both application and data
- Blue-green environment available

**Steps**:

```bash
# 1. Activate blue-green rollback
# Update load balancer to point to previous environment
aws elb set-instance-ports \
  --load-balancer-name myapp-lb \
  --instances i-old-environment

# 2. Verify old version responding
curl http://old-env.myapp.com/health -v

# 3. Verify database accessible from old app
curl -X GET http://old-env.myapp.com/api/status -v

# 4. If database also corrupted, restore (Procedure 2)
# Only if old environment also needs database restore

# 5. Gradual traffic shift (prevent thundering herd)
# Shift 10% → 50% → 100% over 5 minutes

# 6. Monitor for issues
watch -n 5 'curl http://myapp.com/health && echo "OK" || echo "FAIL"'

# 7. If all OK: Decommission new environment
docker stop new-app-container
docker stop new-db-container

# 8. Update status page
curl -X POST https://status-page/api/incidents \
  -d "status=resolved&message=Rollback complete, service restored"

# 9. Schedule incident review
echo "Incident review: $(date -d '1 day')"
```

**Expected Downtime**: 5 minutes (with blue-green), 20+ minutes (without)
**Data Loss**: Depends on backup timing
**Success Criteria**:
- [ ] Users can access application
- [ ] All features functional
- [ ] No new errors in logs
- [ ] Performance baseline met

---

## Backup Strategy

### Automated Backups

**Database**:
- Frequency: Every 6 hours
- Retention: 7 days rolling (keep last 28 backups)
- Storage: AWS S3 encrypted, separate region
- Format: pg_dump SQL dump

**Application Code**:
- Frequency: Per release (automatic)
- Retention: Last 10 releases
- Storage: Docker registry
- Retention Policy: Delete releases >1 month old, except LTS

### Pre-Deployment Backup

**Before every production release**:

```bash
# 1. Database backup
pg_dump -U postgres mydb > /backups/db-pre-v1.0.0.dump
echo "Backup: /backups/db-pre-v1.0.0.dump"

# 2. Tag backup with version
cp /backups/db-pre-v1.0.0.dump \
   s3://myapp-backups/db-v1.0.0-pre.dump

# 3. Verify backup integrity
pg_restore -l s3://myapp-backups/db-v1.0.0-pre.dump | head

# 4. Document backup
echo "Pre-v1.0.0 database backup created"
echo "Size: $(du -h s3://myapp-backups/db-v1.0.0-pre.dump)"
echo "Time: $(date)"
```

### Backup Verification

**Monthly (calendar event: 1st of month)**:
- [ ] Test restore from oldest backup
- [ ] Verify data integrity of restored DB
- [ ] Document restore time
- [ ] Identify any restore issues
- [ ] Plan remediation if needed

---

## Version Pinning

### Docker Images

**Current Release**:
```
registry/myapp:v1.0.0 (production)
registry/myapp:v1.0.0-rc1 (staging)
```

**Previous Releases** (keep for rollback):
```
registry/myapp:v0.9.0 (safe to rollback to)
registry/myapp:v0.8.5 (backup, if v0.9.0 fails)
registry/myapp:v0.8.0 (historical)
```

**Retention Policy**:
- Keep last 3 versions always available
- Delete version >3 months old

### Database Migrations

**Schema Version Tracking**:

```sql
CREATE TABLE schema_version (
  version VARCHAR(20) PRIMARY KEY,
  applied_at TIMESTAMP DEFAULT NOW(),
  description TEXT,
  rollback_supported BOOLEAN DEFAULT true
);

SELECT * FROM schema_version ORDER BY applied_at DESC LIMIT 5;
```

**Before Migration**:
```bash
# Check current version
psql -c "SELECT version FROM schema_version ORDER BY applied_at DESC LIMIT 1;"

# Verify rollback path exists
psql -c "SELECT * FROM schema_version WHERE rollback_supported = false;"
```

---

## Communication Plan

### During Rollback

**Immediate** (minute 0-2):
- [ ] Status page: "Investigating critical issue"
- [ ] Slack #incidents: Post link to status page
- [ ] PagerDuty: Page on-call engineer if not already engaged

**Within 5 minutes**:
- [ ] Status page: "Rolling back to stable version"
- [ ] Email users (opt-in): "Brief service disruption, we're investigating"
- [ ] Slack #company: Heads up (keep positive, brief)

**Within 15 minutes**:
- [ ] Status page: "Service restored to previous version"
- [ ] Summary: What happened, what we did, next steps

### Post-Rollback

**Immediately After** (within 1 hour):
- [ ] Gather team for incident response
- [ ] Document: What we know, what we don't, what's happening next
- [ ] Estimate: How long before we can re-release (with fix)

**Next Business Day**:
- [ ] Send post-mortem to stakeholders
- [ ] Explain: What failed, why it failed, how we'll prevent it
- [ ] Timeline: When the fix will be available and re-released
- [ ] Ask: Any questions or concerns?

---

## Post-Rollback Actions

### Immediate (0-4 hours)

- [ ] Verify service stability (error rates, performance)
- [ ] Monitor error logs for anomalies
- [ ] Respond to user complaints/inquiries
- [ ] Document incident timeline
- [ ] Gather initial facts on root cause

### Short-term (4-24 hours)

- [ ] Root cause analysis (what actually failed)
- [ ] Implement fix for issue
- [ ] Test fix in staging thoroughly
- [ ] Plan re-release (when, how, rollback if needed)
- [ ] Get approval before re-deploying

### Medium-term (1-7 days)

- [ ] Conduct post-mortem meeting
- [ ] Update deployment checklist (prevent recurrence)
- [ ] Add monitoring/alerting for similar issues
- [ ] Document lessons learned
- [ ] Share findings with team

### Retrospective Questions

**Mandatory**:
1. What was the root cause?
2. Why didn't we catch it before production?
3. How could we have detected it faster?
4. What process changes prevent recurrence?

**Discuss**:
- How quickly did we detect the issue?
- How quickly did we rollback?
- Was communication clear?
- What worked well?
- What could be better?

---

## Testing Rollback

### Pre-Production Exercises

**Staging Environment** (after every release):
- [ ] Practice Procedure 1 (app rollback)
- [ ] Time the procedure (document actual time)
- [ ] Verify functionality after rollback
- [ ] Train team on process

**Quarterly Rollback Drills**:
- [ ] Full rollback exercise (Procedure 1 + 2)
- [ ] Test backup restoration
- [ ] Verify data integrity
- [ ] Time the full procedure
- [ ] Document any issues

### Rollback Success Criteria

- [x] Service restored within [X] minutes
- [x] No data loss beyond RPO (6 hours)
- [x] Users can access and use system
- [x] No new issues introduced by rollback
- [x] Error rate returns to baseline

---

## Monitoring Post-Rollback

### First Hour
- Error rate: Check every 5 minutes
- Performance: Check every 5 minutes
- User complaints: Monitor in real-time
- Database: Monitor connection count

### First 24 Hours
- Error rate: Check every 30 minutes
- Performance baseline: Compare to pre-release
- Database integrity: Check once
- User reports: Respond to all complaints

### First Week
- Daily stability reviews
- User feedback monitoring
- Plan for re-release (when safe)
- Measure impact (user churn, support load)

---

## Rollback Decision Matrix

| Scenario | Auto? | Time | Procedure | Owner |
|----------|-------|------|-----------|-------|
| Critical bug >50% users | ✅ Yes | <2min | 1 | On-call |
| Data loss | ✅ Yes | <5min | 2/3 | On-call |
| Security breach active | ✅ Yes | <5min | 3 | CTO |
| Severe perf (>100%) | ✅ Yes | <5min | 1 | On-call |
| Unavailable >15min | ✅ Yes | <5min | 3 | On-call |
| Bug 10-50% users | ⚠️ Review | <5min | 1/2 | Tech Lead |
| Perf 50-100% | ⚠️ Review | <5min | 1 | Eng Lead |

---

## Version: YYYY-MM-DD
**Last Tested**: [Date]
**Next Test Due**: [Date + 3 months]
**Owner**: Engineering Lead
**Stakeholders**: Product, Operations, Support
```

## Key Sections Explained

1. **Triggers**: When we actually rollback (clear criteria)
2. **Procedures**: Three levels: app-only, app+data, full-stack
3. **Backups**: What we can recover and how often
4. **Communication**: Who knows what, when
5. **Post-Recovery**: What happens after we rollback
6. **Testing**: Practice in staging first

## Token Cost

**Creation**: ~800 tokens
**Update**: ~300 tokens

## Related Features

- [Specification Resolutions](specification-resolutions.md) - Understand requirements we're protecting
- [Gantt Chart](gantt-chart.md) - Know critical deployment windows

## Integration with Planning Phase

This planning occurs **before Phase 3 begins**:

```
Step 7: Create Rollback Plan (THIS FEATURE)
  ↓
Step 8: Plan Data Model Evolution
  ↓
Phase 2 Complete → Handoff to Phase 3
```

## Why This Matters

Rollback plan enables:
- ✅ Faster incident response (procedures documented)
- ✅ Reduced downtime (clear decisions, no debate)
- ✅ Data protection (backups tested, verified)
- ✅ Team confidence (clear procedures, trained)
- ✅ User communication (templates prepared)

Without plan:
- ❌ Panic decision-making
- ❌ Data loss from improper recovery
- ❌ Long downtime while figuring things out
- ❌ Poor communication, user frustration
