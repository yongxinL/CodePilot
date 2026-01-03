# Deployment Rollback Plan

**Project**: [Project Name]  
**Version**: [Version number - e.g., v1.0.0]  
**Date**: [YYYY-MM-DD]  
**Prepared By**: Architect Agent

---

## Overview

This document defines procedures for rolling back deployment if critical issues occur.

**Recovery Point Objective (RPO)**: [Maximum acceptable data loss - e.g., 6 hours]  
**Recovery Time Objective (RTO)**: [Maximum acceptable downtime - e.g., 15 minutes]

---

## Rollback Triggers

### When to Rollback

Rollback is triggered if:
- [ ] Critical bug affecting >[X]% of users
- [ ] Data corruption or data loss detected
- [ ] Security vulnerability discovered in production
- [ ] Performance degradation >[X]% from baseline
- [ ] Service unavailable for >[X] minutes
- [ ] Error rate >[X]% for >[Y] minutes
- [ ] Customer-facing critical feature broken

### Decision Authority

**Who decides to rollback**:
- Primary: [Role - e.g., Engineering Lead]
- Secondary: [Role - e.g., Product Manager]
- Escalation: [Role - e.g., CTO] if unavailable

**Decision timeframe**: Within [X] minutes of incident detection

---

## Rollback Procedures

### Procedure 1: Application Rollback (Fast - ~2 minutes)

**Scenario**: Application code issue, database schema unchanged

**Pre-requisites**:
- Previous version Docker image available
- No database migrations in this release
- Configuration compatible

**Steps**:
```bash
# 1. Stop current version
[stop command for your environment]

# 2. Start previous version
[start command with previous version tag]

# 3. Verify health
curl http://[your-domain]/health

# 4. Monitor logs for errors
[log viewing command]

# 5. Update status page
# Post: "Issue resolved, service restored to stable version"
```

**Expected Downtime**: 2-3 minutes  
**Data Loss**: None  
**Complexity**: Low

**Success Criteria**:
- [ ] Health check returns 200 OK
- [ ] Error rate <1%
- [ ] Response times within normal range
- [ ] Core features functional

---

### Procedure 2: Database Rollback (Moderate - ~15 minutes)

**Scenario**: Database migration caused issues

**Pre-requisites**:
- Database backup from before migration
- Backup tested and verified
- Application compatible with pre-migration schema

**Steps**:
```bash
# 1. Stop application
[stop application command]

# 2. Restore database from pre-migration backup
[database restore command]
# Example: pg_restore -d [dbname] -C [backup-file]

# 3. Verify database integrity
[verification queries]

# 4. Rollback application code (see Procedure 1)

# 5. Verify end-to-end functionality
[smoke test commands or manual verification]

# 6. Resume service

# 7. Notify users of restoration
```

**Expected Downtime**: 15-20 minutes  
**Data Loss**: Changes since last backup (max [RPO] hours)  
**Complexity**: Moderate

**Success Criteria**:
- [ ] Database restored successfully
- [ ] Data integrity verified
- [ ] Application functional
- [ ] No data corruption

---

### Procedure 3: Full System Rollback (Complete - ~30 minutes)

**Scenario**: Complete system failure or multiple component issues

**Pre-requisites**:
- Blue-green deployment setup OR
- Complete backup of entire system state

**Steps (Blue-Green)**:
```bash
# 1. Switch load balancer to old environment (green)
[load balancer update command]

# 2. Verify old version working
curl http://[green-environment]/health

# 3. Restore database if needed (see Procedure 2)

# 4. Monitor old environment stability

# 5. Investigate issues in new environment (blue) offline

# 6. Fix and redeploy when ready
```

**Expected Downtime**: 5 minutes (with blue-green) or 30 minutes (without)  
**Data Loss**: Depends on backup timing (max [RPO])  
**Complexity**: High

---

## Backup Strategy

### Automated Backups

**Database Backups**:
- Frequency: Every [X] hours
- Retention: [X] days rolling
- Storage location: [S3 bucket, filesystem path, etc.]
- Encryption: [Yes/No - method if yes]

**Application State** (if applicable):
- Uploaded files: [Backup strategy]
- Session data: [Backup strategy]
- Cache: [Backup strategy - or acceptable to lose]

### Pre-Deployment Backup

**Required Actions Before Each Deployment**:
```bash
# 1. Create tagged backup
[backup command with version tag]

# 2. Verify backup integrity
[verification command]

# 3. Test restore procedure
[restore test command - on staging]

# 4. Document backup location and credentials
```

**Backup Naming**: `backup-pre-v[VERSION]-[TIMESTAMP]`

**Retention**: 
- Major versions (v1.0, v2.0): Permanent
- Minor versions (v1.1, v1.2): [X] days
- Patch versions (v1.0.1): [Y] days

### Backup Verification

**Testing Schedule**: [Weekly | Monthly | Per deployment]

**Verification Steps**:
```bash
# 1. Restore to test environment
[restore command]

# 2. Verify data integrity
[verification queries]

# 3. Measure restore time
[timing]

# 4. Document results
```

**Last Verified**: [DATE]  
**Restore Time**: [X] minutes  
**Success Rate**: [Percentage]

---

## Version Pinning

### Docker Images

**Current Version**: `[registry]/[image]:[current-tag]`  
**Previous Version**: `[registry]/[image]:[previous-tag]`  
**Retention Policy**: Keep last [N] versions always available

**Example**:
```
Current:  registry.io/task-manager-api:v1.0.0
Previous: registry.io/task-manager-api:v0.9.0
Older:    registry.io/task-manager-api:v0.8.0
```

### Database Schema

**Version Tracking**: [How schema version is tracked]

**Rollback Capability**:
- Migration tool: [Prisma | Flyway | Liquibase | etc.]
- Rollback migrations: [Available for all migrations | Last N migrations]
- Testing: [Rollback tested in staging]

---

## Communication Plan

### During Incident

**Status Page Update**:
```
"We're currently experiencing issues and are investigating. 
Updates every 15 minutes."
```

**User Communication**:
- Email: [Template or approach]
- In-app notification: [If applicable]
- Social media: [If applicable]

**Internal Communication**:
- Slack/Teams channel: [Channel name]
- Incident commander: [Who leads response]
- Stakeholder notification: [Who to inform and when]

### During Rollback

**Status Page Update**:
```
"We've identified the issue and are rolling back to the previous stable version.
Expected restoration: [X] minutes."
```

### After Rollback Complete

**Status Page Update**:
```
"Service has been restored to the previous stable version.
We're investigating the issue and will provide updates on the fix timeline."
```

**Post-Mortem**:
- Timeline: Within 24 hours of incident
- Format: [Written report | Meeting | Both]
- Distribution: [Who receives post-mortem]

---

## Rollback Testing

### Pre-Production Testing

**Test Rollback Procedure**:
- Frequency: [Quarterly | Per major release | Before each deployment]
- Environment: Staging (production-like)
- Success criteria: Can rollback in [RTO] minutes

**Last Drill**:
- Date: [YYYY-MM-DD]
- Result: [Success | Issues found]
- Time: [Actual rollback time]
- Issues: [Any problems encountered]

### Drill Checklist

- [ ] Practice Procedure 1 (application rollback)
- [ ] Practice Procedure 2 (database rollback)
- [ ] Practice Procedure 3 (full system rollback)
- [ ] Time each procedure
- [ ] Verify data integrity after rollback
- [ ] Test all critical user flows after rollback
- [ ] Update procedures based on findings

---

## Post-Rollback Actions

### Immediate (0-4 hours)
- [ ] Verify service stability
- [ ] Monitor error rates (every 5 min for first hour)
- [ ] Check user impact and complaints
- [ ] Document incident timeline
- [ ] Identify root cause

### Short-term (4-24 hours)
- [ ] Complete root cause analysis
- [ ] Develop fix for identified issues
- [ ] Test fix thoroughly in staging
- [ ] Plan redeployment
- [ ] Communicate timeline to stakeholders

### Medium-term (1-7 days)
- [ ] Conduct post-mortem meeting
- [ ] Update deployment process to prevent recurrence
- [ ] Add monitoring/alerts for similar issues
- [ ] Document lessons learned (save to knowledge base)
- [ ] Update this rollback plan if needed

---

## Monitoring Post-Rollback

### First Hour (Critical Monitoring)
- Error rate: Every 5 minutes
- Response time: Every 5 minutes
- Active users: Every 5 minutes
- Database connections: Every 5 minutes

### First 24 Hours (Active Monitoring)
- Error rate: Every 30 minutes
- Performance metrics: Every 30 minutes
- User complaints: Continuous monitoring
- System resource usage: Every 30 minutes

### First Week (Ongoing Monitoring)
- Daily stability reviews
- User feedback analysis
- Performance trend analysis
- Plan timeline for fix deployment

---

## Success Criteria

**Rollback is successful if**:
- [ ] Service restored within [RTO]
- [ ] Data loss within [RPO] acceptable range
- [ ] No data corruption
- [ ] Users can access system normally
- [ ] Error rates return to baseline (<[X]%)
- [ ] Performance returns to baseline (±[Y]%)
- [ ] No new issues introduced by rollback

---

## Emergency Contacts

**Incident Response Team**:
- Engineering Lead: [Name] - [Contact]
- DevOps Lead: [Name] - [Contact]
- Product Manager: [Name] - [Contact]
- On-Call Engineer: [Rotation schedule link]

**Escalation Path**:
1. On-call engineer (0-15 min)
2. Engineering lead (15-30 min)
3. [CTO/VP Engineering] (30+ min or critical)

**External Contacts**:
- Hosting provider support: [Contact]
- Database provider support: [Contact]
- CDN provider support: [Contact]

---

## Appendix

### Rollback Command Reference

```bash
# Application rollback
[Complete commands for your environment]

# Database rollback
[Complete restore commands]

# Load balancer update
[Complete traffic switching commands]

# Monitoring commands
[Commands to check system health]
```

### Configuration Files

**Location of critical configs**:
- Application: [Path]
- Database: [Path]
- Infrastructure: [Path]

### Access Credentials

**Stored securely at**: [Password manager, secrets vault, etc.]

---

**This rollback plan should be reviewed and tested regularly.**  
**Update after each deployment or when infrastructure changes.**
