# MCP Version Checking Integration - CodePilot v2.0

**Tier**: Core+ (manual mode) / Advanced+ (automatic mode)
**Phase**: 2 (Planning)
**Feature #**: 8

## Purpose

Verify that selected technologies are using latest stable versions with no critical security advisories via MCP tools (Context7 or web_search).

## When to Use

After selecting technology stack in Step 3, use this feature to verify all versions are current and secure before finalizing architecture.

## Configuration Check

```javascript
config = read(".codepilot.config.json");
mcp_enabled = config.mcp_tools.version_checking.enabled;
mcp_auto = config.mcp_tools.version_checking.auto_check;
mcp_preferred = config.mcp_tools.version_checking.preferred_mcp; // "context7" or "web_search"

if (!mcp_enabled) {
  use_knowledge_cutoff_versions();
  add_manual_verification_note();
} else if (mcp_auto) {
  // Advanced+ tier: Automatic
  automatically_verify_all_versions();
} else {
  // Core+ tier: Manual
  ask_user_permission_to_verify();
}
```

## Workflow

1. Select technology stack
2. Check if MCP version checking enabled
3. If enabled:
   - Core+ tier: Ask user for permission
   - Advanced+ tier: Automatically verify all
4. Query MCP for latest versions
5. Check security advisories
6. Document verified versions
7. Update technology-stack.md with metadata

## MCP Tools

**Primary (Preferred)**:
- Context7: Better for version info and security advisories

**Fallback**:
- web_search: Current information from web
- knowledge_cutoff: If MCP unavailable (Jan 2025)

## Core+ Mode: Manual Verification

**User Experience**:

```
Technology stack selected:
- Frontend: React 18.2.0
- Backend: Node.js 20.11.0
- Database: PostgreSQL 16.0
- Caching: Redis 7.2.0

MCP version checking available via Context7.
Would you like me to verify we're using the latest stable versions? [Y/n]
```

**If User Says Yes**:

```
Checking via Context7 MCP...

Frontend:
→ React: Checking latest version...
  ✅ React 18.3.1 (released 2024-04-25)
  Status: Latest stable
  Security: No advisories
  Recommendation: Update from 18.2.0 → 18.3.1 (bug fixes, minor)

Backend:
→ Node.js: Checking LTS version...
  ✅ Node.js 20.11.0 LTS (active until 2026-04-30)
  Status: Active LTS (good choice)
  Security: No advisories

→ Express: Checking latest version...
  ⚠️ Express 4.19.2 (released 2024-03-25)
  Current: 4.18.0
  Status: Update available
  Security: Previous 4.18.x had CVE-2024-XXXX - FIXED in 4.19.2
  Recommendation: Update to 4.19.2+ for security fix

Database:
→ PostgreSQL: Checking latest version...
  ✅ PostgreSQL 16.1 (released 2024-11-09)
  Status: Latest stable
  Security: No advisories

Caching:
→ Redis: Checking latest version...
  ✅ Redis 7.2.4 (released 2024-01-15)
  Status: Latest stable
  Security: No advisories

All versions verified! Documenting in technology-stack.md...
```

## Advanced+ Mode: Automatic Verification

**Happens automatically as each technology selected**:

```
Selecting technology stack...

Frontend: React
→ Verifying via Context7 MCP...
→ ✅ React 18.3.1 confirmed (latest stable, released 2024-04-25, no advisories)

Backend: Node.js
→ Verifying via Context7 MCP...
→ ✅ Node.js 20.11.0 LTS confirmed (active until 2026-04-30)

Backend Framework: Express
→ Verifying via Context7 MCP...
→ ✅ Express 4.19.2 confirmed (includes security fix from CVE-2024-XXXX)
→ ⚠️ Note: Version 4.18.x had vulnerability - ensure 4.19.2+

Database: PostgreSQL
→ Verifying via Context7 MCP...
→ ✅ PostgreSQL 16.1 confirmed (latest stable)

Cache: Redis
→ Verifying via Context7 MCP...
→ ✅ Redis 7.2.4 confirmed (latest stable)

All versions automatically verified and documented.
Security scan: No critical or high severity advisories.
Proceeding with technical design...
```

## Implementation Logic

```javascript
async function verify_version_via_mcp(technology_name, current_version) {
  // 1. Check cache first (1 hour TTL)
  const cache_key = `mcp:version:${technology_name}`;
  const cached = get_cache(cache_key);

  if (cached && cache_age(cached) < 3600) {
    return cached.data;
  }

  // 2. Get preferred MCP tool
  const preferred_tool = config.mcp_tools.version_checking.preferred_mcp;
  const fallback_tools = config.mcp_tools.version_checking.fallback_mcp;

  // 3. Try primary tool
  try {
    const query = `What is the latest stable version of ${technology_name}?`;
    const response = await mcp_query(preferred_tool, query);

    const result = {
      technology: technology_name,
      current: current_version,
      latest: parse_version(response),
      release_date: parse_date(response),
      status: determine_status(current_version, latest),
      verified_via: preferred_tool,
      verified_at: new Date().toISOString()
    };

    // 4. Check security (if Advanced+ tier)
    if (config.tier >= "advanced_plus") {
      const advisory_query = `Security vulnerabilities in ${technology_name} ${result.current}`;
      const advisories = await mcp_query(preferred_tool, advisory_query);
      result.security_advisories = parse_advisories(advisories);
    } else {
      result.security_advisories = "not checked (enable in Advanced+ tier)";
    }

    // 5. Cache result
    set_cache(cache_key, result, ttl=3600);

    return result;

  } catch (error) {
    // 6. Try fallback tools
    for (const fallback_tool of fallback_tools) {
      try {
        const response = await mcp_query(fallback_tool, query);
        const result = { /* parse response */ };
        result.verified_via = `${fallback_tool} (fallback)`;
        return result;
      } catch (fallback_error) {
        continue;
      }
    }

    // 7. All failed - use knowledge cutoff
    return {
      technology: technology_name,
      current: current_version,
      latest: "unknown",
      verified_via: "knowledge_cutoff (Jan 2025)",
      note: "⚠️ Could not verify via MCP. Using knowledge as of Jan 2025. Verify manually."
    };
  }
}

function determine_status(current, latest) {
  if (current === latest) return "✅ Up to date";
  if (is_patch(current, latest)) return "⚠️ Patch available";
  if (is_minor(current, latest)) return "⚠️ Minor update available";
  if (is_major(current, latest)) return "🔴 Major update available";
}
```

## Document in Technology Stack

**Update** `docs/artifacts/phase2-planning/technology-stack.md`:

```markdown
## Frontend Framework

**Technology**: React
**Selected Version**: 18.3.1
**Status**: ✅ Latest stable

**Verification**:
- Verified Via: Context7 MCP
- Verified Date: 2026-01-03
- Latest Available: 18.3.1 ✅
- Security Advisories: None

**Link**: https://react.dev
**Rationale**: Latest stable, team familiar, all features needed available

---

## Backend Runtime

**Technology**: Node.js
**Selected Version**: 20.11.0 LTS
**Status**: ✅ Active LTS

**Verification**:
- Verified Via: Context7 MCP
- Verified Date: 2026-01-03
- LTS Status: Active (until 2026-04-30)
- Security Advisories: None

**Link**: https://nodejs.org
**Rationale**: Latest LTS, long-term support, team expertise
```

## Verification Response Template

```markdown
### [Technology] Version Verification

**Query**: What is the latest stable version of [Technology]?

**Findings**:
- **Current Version**: [Version in project]
- **Latest Stable**: [Latest version from MCP]
- **Release Date**: [When latest was released]
- **Status**: [✅ Up to date | ⚠️ Update available | 🔴 Critical update]

**Security Status**:
- **Advisories**: [None | CVE descriptions if any]
- **Risk**: [None | Low | Medium | High | Critical]
- **Recommendation**: [Use current | Update when convenient | Update ASAP]

**Impact**:
- Breaking Changes: [None | Minor | Major]
- Migration Effort: [None | Easy | Medium | Hard]
- Benefit: [Bug fixes | Performance | Features | Security]
```

## Token Cost

**Core+ Mode**:
- First verification (5 technologies): ~750 tokens
- Subsequent loads: 0 tokens (cached)
- Cache TTL: 1 hour

**Advanced+ Mode**:
- Automatic verification: ~750 tokens
- Security advisories: +250 tokens
- Cached: 0 tokens

**Total**: ~1,000 tokens first run, 0 tokens thereafter (1 hour cache)

## Best Practices

1. **Verify Before Starting**: Check all versions before finalizing architecture
2. **Cache Results**: Don't re-query for 1 hour (saves tokens)
3. **Document Everything**: Record what was verified and when
4. **Re-Verify Before Deployment**: Check again at Phase 4 before release
5. **Update Regularly**: Monthly checks for dependencies

## Related Features

- [Technology Selection](design-principles-checklist.md) - Select tech stack before verification
- [Individual Task Files](individual-task-files.md) - Track version update work as tasks

## Integration with Planning Phase

This verification occurs **after Step 3 (Technology Selection)**:

```
Step 3: Technology Selection
  ↓
Step 3.5: Verify Versions via MCP (THIS FEATURE)
  ↓
Step 4: Create Technical Design
```

## Limitations

- MCP availability required (falls back to knowledge cutoff)
- Only checks official versions (not pre-releases, betas)
- Cannot verify internal/private packages
- Security advisories limited to public databases

## When to Disable

Disable version checking if:
- Working offline (no MCP access)
- Using private/internal versions
- Verifying manually elsewhere
- Token budget constrained

Disable in config:
```json
{
  "mcp_tools": {
    "version_checking": {
      "enabled": false
    }
  }
}
```

## Why This Matters

Prevents:
- ❌ Using outdated versions with known vulnerabilities
- ❌ Missing security patches
- ❌ Incompatible technology combinations
- ❌ Deprecated libraries with no support

Enables:
- ✅ Confidence in technology choices
- ✅ Early detection of breaking changes
- ✅ Security-first approach
- ✅ Documentation of decisions
