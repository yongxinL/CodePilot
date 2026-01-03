# MCP Auto-Check: Automated Version Verification & Security Advisories

## Overview

MCP Auto-Check automatically verifies framework versions and fetches security advisories during CodePilot sessions, catching vulnerabilities and deprecated versions before they impact development.

**Scope**: Advanced+ tier (manual mode available in Core+, auto mode in Advanced+)
**Trigger**: At session start and after each phase completion
**Output**: Version report with security advisories and recommendations

---

## How It Works

### Session Start Verification

```
Session Start
    ↓
[MCP Auto-Check]
    ├─ Query installed MCP versions
    ├─ Check against latest stable
    ├─ Fetch CVE database for vulnerabilities
    ├─ Generate version report
    └─ Display recommendations

Output:
✅ All versions current (no action needed)
🟡 Update available: framework-x from v1.2.0 → v1.2.1 (recommended)
🔴 CRITICAL: security-lib v0.8.0 has active CVE (update to v0.9.2)
```

### Post-Phase Verification

After each phase completion:
- Re-check versions (new packages may have been added)
- Scan for new advisories released since session start
- Alert if critical vulnerabilities discovered

### Integration with Version-Checker Subagent

```
[Phase Complete]
    ↓
[Auto-Check System]
    ├─ Trigger @version-checker subagent
    ├─ Pass current versions
    ├─ Request security advisory analysis
    └─ Incorporate recommendations into handoff

Output added to handoff:
"✅ Version Security Review (Phase X Complete)
- All dependencies current as of [timestamp]
- No active vulnerabilities
- Recommended updates: [list]"
```

---

## Configuration

### In opencode.json

```json
{
  "mcp": {
    "version_checking": {
      "enabled": true,
      "mode": "auto",
      "trigger": ["session_start", "phase_complete"],
      "cve_sources": [
        "npm_audit",
        "github_advisories",
        "nvd"
      ],
      "alert_levels": ["critical", "high"],
      "auto_notify": true
    }
  }
}
```

### Configuration Options

| Option | Default | Description |
|--------|---------|-------------|
| `enabled` | true | Enable/disable auto-checking |
| `mode` | auto | "auto" (Advanced+) or "manual" (Core+) |
| `trigger` | session_start, phase_complete | When to check |
| `cve_sources` | npm_audit, github_advisories, nvd | Advisory databases to query |
| `alert_levels` | critical, high | Show alerts for these severities |
| `auto_notify` | true | Automatically display alerts |

---

## Version Report Template

### Example Output

```
╔═══════════════════════════════════════════════════════════════╗
║         MCP VERSION & SECURITY CHECK                          ║
║         Session: 20260103-1400 | Phase: Implementation       ║
╚═══════════════════════════════════════════════════════════════╝

FRAMEWORK VERSIONS:
┌─────────────────────────────────────────────────────────────┐
│ Component                Current    Latest    Status        │
├─────────────────────────────────────────────────────────────┤
│ claude-sdk              v0.12.0    v0.12.1   🟡 Minor Update│
│ opencode-core           v2.1.0     v2.1.0    ✅ Current     │
│ node-runtime            v18.14.0   v20.10.0  🟠 Major Update│
│ anthropic-api           v1.2.5     v1.2.5    ✅ Current     │
└─────────────────────────────────────────────────────────────┘

SECURITY ADVISORIES:
┌─────────────────────────────────────────────────────────────┐
│ 🔴 CRITICAL (1):                                            │
│ - dependency-lib v1.0.0: Remote code execution (CVE-xxx)   │
│   Status: Unpatched                                         │
│   Action: UPDATE to v1.0.1 immediately                      │
│   Affected: 2 projects                                      │
│                                                              │
│ 🟠 HIGH (2):                                                │
│ - auth-package v2.1.0: Weak token validation (CVE-yyy)     │
│   Status: Patched in v2.1.2                                 │
│   Action: Update when convenient (not critical)            │
│                                                              │
│ 🟡 MEDIUM (3): [collapsed, view with --verbose]            │
└─────────────────────────────────────────────────────────────┘

RECOMMENDATIONS:
✅ claude-sdk: No action needed (minor update available, not urgent)
🔴 dependency-lib: URGENT - Update immediately before proceeding
🟠 auth-package: Review and update within 2 weeks
🟡 node-runtime: Consider updating for new features, not security-critical

REPORT GENERATED: 2026-01-03 14:00:00 UTC
NEXT CHECK: After Phase 4 completion (estimated 2026-01-10)
```

---

## Security Advisory Details

### CVE Lookup Integration

For each advisory, system provides:

```markdown
CVE-2025-XXXXX: Remote Code Execution in dependency-lib

Severity: CRITICAL (CVSS 9.8)
Published: 2025-01-02
Affects: v1.0.0 - v1.0.0
Fixed: v1.0.1

Description:
Improperly validated user input in request handler allows
unauthenticated remote code execution.

Workaround (if cannot patch immediately):
- Disable public API endpoints (if applicable)
- Use web application firewall to filter malicious requests
- Monitor logs for exploitation attempts

Impact on CodePilot:
- Affects Phase 3 (Implementation) if library used
- Does not affect Phase 1-2 (dependencies not active)
- Phase 4-5: Recommended to patch before security testing

Update Command:
npm install dependency-lib@1.0.1

Resources:
- GitHub advisory: [link]
- NVD entry: [link]
- Package release notes: [link]
```

---

## Automated Actions (Advanced+ Mode)

In Advanced+ tier with auto mode enabled:

### Severity-Based Responses

**CRITICAL Vulnerabilities:**
```
[AUTO-ACTION] CRITICAL vulnerability detected
- Stop: Phase blocked until vulnerability addressed
- Alert: Display prominently in all agent prompts
- Recommendation: Update immediately or document exception
- Timeline: Cannot proceed until resolved or waived
```

**HIGH Vulnerabilities:**
```
[AUTO-ACTION] HIGH severity vulnerability detected
- Continue: Phase continues with warning
- Alert: Included in phase completion checklist
- Recommendation: Address within current sprint
- Timeline: No blocker, but high priority
```

**MEDIUM Vulnerabilities:**
```
[AUTO-ACTION] MEDIUM severity vulnerabilities detected
- Continue: Phase proceeds normally
- Alert: Included in weekly status report
- Recommendation: Address within 2 weeks
- Timeline: Track but not urgent
```

### Automatic Notifications

Send notifications to:
- **Phase agents**: Added to context at phase start
- **Handoff documents**: Included in next phase handoff
- **Security subagent**: Flagged for security review
- **Team leads**: Email alert for critical issues

---

## Manual Mode (Core+ Tier)

In Core+ tier, version checking available manually:

```bash
# Check versions at any time
opencode --check-versions

# Get detailed security report
opencode --check-versions --verbose

# Check specific package
opencode --check-package express --cves

# Check against specific CVE database
opencode --check-versions --source github_advisories
```

Example usage in Core+ workflow:
```
User: "Can we use this new library?"
Architect: "Let me check versions and security"
$ opencode --check-versions
→ Display: Library has 2 medium CVEs, last updated 6 months ago
Architect: "Recommend using different library or waiting for patch"
```

---

## Integration Checklist

### For Implementation (Phase 3)

✅ Verify all dependencies secure before merge:
```javascript
// Phase 3 Quality Gate:
// 1. Run: opencode --check-versions
// 2. Verify: No CRITICAL vulnerabilities
// 3. Document: Any MEDIUM vulnerabilities in tech debt log
// 4. Pass: Can proceed to Phase 4
```

### For Verification (Phase 4)

✅ Security testing includes version verification:
```markdown
## Security Testing Checklist (Phase 4)
- [ ] Run @security scanning
- [ ] Run opencode --check-versions --verbose
- [ ] Resolve any CVEs discovered
- [ ] Document exceptions (if any) with rationale
- [ ] Include version report in release notes
```

### For Release

✅ Version report included in release documentation:
```markdown
## Release Security Certification
- Dependency version check: ✅ Passed (date: [])
- CVE scan results: ✅ No active CVEs (date: [])
- Security advisories: ✅ Addressed or documented (date: [])
```

---

## Integration with Decision Log

Each security decision documented:

```markdown
## Decision #D-006: Defer Dependency Update

**Date**: 2026-01-03
**Decided By**: Security Engineer + Team Lead
**Status**: Approved

**Decision**:
Defer updating auth-package from v2.1.0 to v2.1.2 (HIGH CVE fix)
to Phase 2, as it's not exploitable in current deployment model.

**Context**:
- CVE in weak token validation (not used in our architecture)
- Update requires regression testing (1 day effort)
- Current phase critical path: cannot afford 1-day delay
- No public internet exposure (internal API)

**Risk Assessment**:
- Risk: Unpatched HIGH severity CVE
- Mitigation: Internal network only, no public exposure
- Monitoring: Security team watching for exploitation patterns
- Timeline: Must update before Phase 4 security review

**Revisit Trigger**:
- If deployment changes to public API
- If new CVE released for this package
- Before Phase 4 security testing (hard deadline)
```

---

## Messaging for Agents

### Add to All Phase Prompts

**Session Management Section:**

```markdown
### Version Security Management

At the start and end of each phase, the system automatically:
1. Checks all installed MCP versions
2. Queries security advisory databases (npm audit, GitHub, NVD)
3. Alerts you to any new vulnerabilities
4. Provides patch recommendations

**You will see messages like:**
```
[MCP VERSION CHECK COMPLETE]
✅ All versions current and secure
🟡 Minor updates available (not urgent):
   - claude-sdk: v0.12.0 → v0.12.1
🔴 CRITICAL: Update auth-lib v1.0.0 → v1.0.1 before proceeding
   (Remote code execution vulnerability - CVE-2025-XXXXX)
```

**Actions required:**
- 🔴 CRITICAL: Must be addressed before phase completion
- 🟠 HIGH: Address in current sprint
- 🟡 MEDIUM: Address within 2 weeks
- ✅ Updates: Optional, evaluate separately

**To check versions manually:**
```
opencode --check-versions       # Quick summary
opencode --check-versions --verbose  # Detailed with advisories
@version-checker Any security concerns with current dependencies?
```

**Documentation:**
See [docs/core/06-mcp-auto-check.md](../../core/06-mcp-auto-check.md) for full details
```

---

## Status Indicators

**Version Status:**
- ✅ **Current**: Latest version or within 1 minor version
- 🟡 **Update Available**: New minor/patch version (not urgent)
- 🟠 **Update Recommended**: New major version or security patch available
- 🔴 **Critical Update**: Security vulnerability (action required)

**Vulnerability Severity:**
- 🔴 **CRITICAL** (CVSS 9.0+): Immediate action required
- 🟠 **HIGH** (CVSS 7.0-8.9): High priority, address soon
- 🟡 **MEDIUM** (CVSS 4.0-6.9): Monitor and plan update
- 🟢 **LOW** (CVSS 0-3.9): Informational only

---

## Troubleshooting

### Issue: Advisory database unreachable
**Solution**: System falls back to local npm audit database, checks succeed

### Issue: False positive CVE (not applicable)
**Solution**: Document exception in decision log with security team approval

### Issue: Auto-check disabled, need manual verification
**Solution**: Use `opencode --check-versions --force` to run manually

### Issue: Need to ignore specific CVE
**Solution**: Add to `.codepilot.config.json`:
```json
{
  "mcp": {
    "version_checking": {
      "ignore_cves": ["CVE-2025-XXXXX"],
      "ignore_reason": "Not applicable to our deployment model"
    }
  }
}
```

---

## Success Criteria

MCP Auto-Check is complete when:

- ✅ Version checking works at session start and phase completion
- ✅ Security advisories fetched from 3+ sources (npm, GitHub, NVD)
- ✅ Alerts display based on severity (CRITICAL, HIGH, MEDIUM)
- ✅ Manual commands work (`--check-versions`, `--check-package`)
- ✅ Integration with @version-checker subagent operational
- ✅ Documentation includes version checks in all phase prompts
- ✅ Decision log integration for security exceptions
- ✅ Release notes include version verification certification

---

**Status**: Ready for implementation
**Priority**: 🟠 MEDIUM (nice-to-have, not blocking)
**Effort**: 4-5 hours (API integration + UI + testing)
**Dependency**: Requires @version-checker subagent (already exists)
