# MCP Integration - CodePilot v2.0

**Model Context Protocol (MCP) Integration for Version Checking and Security Advisories**

## Overview

CodePilot v2.0 integrates with MCP tools (Context7, web_search, custom servers) to:
- ✅ Verify latest stable framework/library versions
- ✅ Check security advisories (CVEs)
- ✅ Validate compatibility matrices
- ✅ Research current best practices

**Tiers**:
- **Minimal**: MCP disabled
- **Core+**: MCP enabled, manual mode (user triggers)
- **Advanced+**: MCP enabled, automatic mode (agent triggers)
- **Full**: MCP enabled, automatic + advanced queries

## MCP Tools Supported

### 1. Context7 (Preferred)
**Best for**: Version info, security advisories, technical knowledge
**Query Examples**:
- "What is the latest stable version of React?"
- "Are there any security vulnerabilities in Express 4.18.0?"
- "Is React 18 compatible with Node.js 20?"

### 2. web_search (Fallback)
**Best for**: Current information when Context7 unavailable
**Query Examples**:
- "React latest version 2026"
- "Express security vulnerabilities 2026"
- "Node.js LTS version January 2026"

### 3. Custom MCP Servers
**Organization-specific**: Can integrate custom knowledge sources
**Configuration**: Add to `.codepilot.config.json`

## Configuration

In `.codepilot.config.json`:

```json
{
  "mcp_tools": {
    "available": ["context7", "web_search"],
    "version_checking": {
      "enabled": true,                    // Enable MCP integration
      "auto_check": false,                 // Core+: manual, Advanced+: auto
      "preferred_mcp": "context7",         // Try this first
      "fallback_mcp": ["web_search"],      // Try these if preferred fails
      "cache_duration": 3600,              // Cache responses 1 hour
      "check_security_advisories": false   // Core+: no, Advanced+: yes
    }
  }
}
```

## Usage Patterns

### Pattern 1: Manual Version Check (Core+ Tier)

**Trigger**: User explicitly requests or agent asks permission

**Workflow**:
```
architect agent: "I've selected React for frontend. 

MCP version checking is available. Should I verify we're 
using the latest stable version? [Y/n]"

User: "Y"

architect: "Checking via Context7 MCP...
→ Query: 'What is the latest stable version of React?'
→ Response: 'React 18.3.1, released April 25, 2024'
→ Security: No advisories found
✅ React 18.3.1 verified (latest stable)

Documenting in technology-stack.md..."
```

### Pattern 2: Automatic Version Check (Advanced+ Tier)

**Trigger**: Agent automatically when selecting technology

**Workflow**:
```
architect agent: "Selecting technology stack...

Frontend: React
→ Checking latest version via Context7...
→ ✅ React 18.3.1 verified (released 2024-04-25, no advisories)

Backend: Node.js
→ Checking LTS version via Context7...
→ ✅ Node.js 20.11.0 LTS verified (active until 2026-04-30)

Database: PostgreSQL
→ Checking latest version via Context7...
→ ✅ PostgreSQL 16.1 verified (latest stable)

All versions verified and documented in technology-stack.md"
```

### Pattern 3: Security Advisory Check (Advanced+ Tier)

**Trigger**: Before installation or when security review requested

**Workflow**:
```
engineer agent: "Installing dependencies...

Checking for security advisories via Context7...
→ React 18.3.1: ✅ No advisories
→ Express 4.18.0: ⚠️  CVE-2024-29590 (medium severity)
  Fix available: Express 4.19.2
→ PostgreSQL 16.1: ✅ No advisories

⚠️  Security Advisory Found:
Package: Express 4.18.0
Issue: Prototype pollution vulnerability  
CVE: CVE-2024-29590
Severity: Medium
Fixed in: 4.19.2

Recommendation: Update Express to 4.19.2

Update now? [Y/n]"
```

### Pattern 4: Compatibility Validation

**Trigger**: When combining multiple technologies

**Workflow**:
```
architect agent: "Validating technology compatibility...

Checking via Context7 MCP:
→ React 18.3.1 + Node.js 20.11.0: ✅ Compatible
→ Node.js 20.11.0 + PostgreSQL 16.1: ✅ Compatible
→ TypeScript 5.3.3 + React 18.3.1: ✅ Compatible

No compatibility issues detected."
```

## Implementation in Phase Prompts

### Phase 2 (architect agent)

Add after technology selection, before creating technology-stack.md:

```markdown
### Step 3.5: Verify Technology Versions (Core+ with MCP)

**Check Configuration**:
```javascript
config = read(".codepilot.config.json");
if (!config.mcp_tools.version_checking.enabled) {
  skip_this_step();
  use_knowledge_cutoff();
}
```

**Manual Mode Workflow**:
1. After selecting each technology
2. Ask user: "Verify latest versions via MCP? [Y/n]"
3. If yes:
   - Query MCP for each technology
   - Check security advisories (if Advanced+ tier)
   - Document results
   - Report findings to user
4. Continue with planning

**Automatic Mode Workflow**:
1. After selecting each technology
2. Automatically query MCP
3. Inform user of results
4. Document immediately
5. Continue with planning

**MCP Query Template**:
```javascript
function verify_version(technology_name) {
  // Try preferred MCP first
  try {
    query = `What is the latest stable version of ${technology_name}?`;
    response = mcp_query(config.preferred_mcp, query);
    version = parse_version(response);
    release_date = parse_date(response);
    
    // Check security if enabled
    if (config.check_security_advisories) {
      advisories = mcp_query(
        config.preferred_mcp, 
        `Security vulnerabilities in ${technology_name} ${version}`
      );
    }
    
    return {
      technology: technology_name,
      version: version,
      release_date: release_date,
      security: advisories || "none",
      verified_via: config.preferred_mcp,
      verified_at: current_timestamp()
    };
    
  } catch (error) {
    // Try fallback MCP
    if (config.fallback_mcp.length > 0) {
      return verify_via_fallback(technology_name);
    } else {
      return use_knowledge_cutoff(technology_name);
    }
  }
}
```

**Document Results**:
Add to technology-stack.md with verification metadata (see examples earlier)
```

### Phase 3 (engineer agent)

Add before installing dependencies:

```markdown
### Before Installation: Re-verify Versions (if MCP enabled)

**Purpose**: Ensure versions haven't changed since Phase 2

**Workflow**:
1. Read technology-stack.md
2. Check cache age (if < 1 hour, skip)
3. If cache expired or first check:
   - Re-query MCP for each dependency
   - Compare with Phase 2 versions
   - Alert if differences found
   - Check security advisories
4. Proceed with installation

**Alert Example**:
```
⚠️  Version Change Detected:

React: 18.3.1 (Phase 2) → 18.3.2 (now available)
Released: 2 hours ago
Changes: Bug fixes, no breaking changes

Update package.json to 18.3.2? [Y/n]
```
```

## Caching Strategy

### Cache Structure
```javascript
cache = {
  "mcp:context7:react_version": {
    query: "latest stable React version",
    response: "React 18.3.1 (released 2024-04-25)",
    timestamp: 1704286800,
    expires_at: 1704290400,  // +3600 seconds
    tool: "context7"
  }
}
```

### Cache Logic
```javascript
function query_mcp_cached(tool, query) {
  cache_key = `mcp:${tool}:${hash(query)}`;
  cached = get_cache(cache_key);
  
  if (cached && cached.expires_at > now()) {
    // Cache hit
    return cached.response;
  } else {
    // Cache miss or expired
    response = mcp_query(tool, query);
    set_cache(cache_key, {
      query: query,
      response: response,
      timestamp: now(),
      expires_at: now() + config.cache_duration,
      tool: tool
    });
    return response;
  }
}
```

### Cache Benefits
- First query: ~750 tokens
- Cached queries: ~0 tokens
- **Savings**: 100% on repeat queries within 1 hour

## Error Handling

### MCP Query Failures

```javascript
function safe_mcp_query(tool, query) {
  try {
    response = mcp_query(tool, query);
    return { success: true, data: response };
  } catch (error) {
    log_error(`MCP query failed: ${tool} - ${error.message}`);
    
    // Try fallback
    if (fallback_tools.length > 0) {
      fallback_tool = fallback_tools[0];
      try {
        response = mcp_query(fallback_tool, query);
        return { 
          success: true, 
          data: response, 
          via_fallback: fallback_tool 
        };
      } catch (fallback_error) {
        return { 
          success: false, 
          error: "All MCP tools failed" 
        };
      }
    }
    
    return { success: false, error: error.message };
  }
}
```

### Fallback to Knowledge Cutoff

When all MCP queries fail:

```
Agent: "⚠️  Unable to verify latest version (MCP unavailable)

Using knowledge as of January 2025:
- React: 18.x series (18.2.0 common)
- Node.js: 20.x LTS (20.10.x range)
- PostgreSQL: 15.x or 16.x

⚠️  IMPORTANT: Please verify latest versions manually:
- React: https://react.dev
- Node.js: https://nodejs.org
- PostgreSQL: https://www.postgresql.org

Proceeding with planning based on these versions..."
```

## Best Practices

### Query Optimization
- **Be specific**: "latest stable React version" not "React info"
- **Cache results**: Don't re-query same thing
- **Batch queries**: Check all technologies in one session
- **Use appropriate tool**: Context7 for knowledge, web_search for current events

### Security Best Practices
- Always check advisories before installation (Advanced+ tier)
- Block installation if critical vulnerabilities found
- Recommend updates for high/medium severity
- Document all security checks

### User Communication
- **Manual mode**: Always ask permission before MCP queries
- **Auto mode**: Inform user of checks performed
- **Failures**: Explain fallback clearly
- **Results**: Present in user-friendly format

## Token Cost Analysis

### Per Technology Version Check
```
Query construction: ~50 tokens
MCP query execution: ~100 tokens
Response parsing: ~100 tokens
Documentation: ~50 tokens
Total: ~300 tokens per technology
```

### Typical Tech Stack (5 technologies)
```
First check: 5 × 300 = 1,500 tokens
Cached checks: 0 tokens
Average over session: ~750 tokens (50% cache hit rate)
```

### Security Advisory Checks (Advanced+ Tier)
```
Additional per technology: ~200 tokens
5 technologies: +1,000 tokens
Total with security: ~2,500 tokens first check
```

**Recommendation**: 
- Core+ tier: Manual mode, check only when needed (~0-750 tokens)
- Advanced+ tier: Auto mode, budget ~1,500 tokens in Phase 2

## Integration with Existing Workflows

### Doesn't Break v1.0
- If MCP disabled: Works exactly like v1.0
- If MCP enabled: Enhanced, not replaced
- Graceful degradation always

### Complements Other Features
- Works with git integration
- Works with individual task files
- Works with checkpoints
- Works with quality gates

## Customization

### Add Custom MCP Server
```json
{
  "mcp_tools": {
    "available": ["context7", "web_search", "company_standards"],
    "company_standards": {
      "type": "custom",
      "endpoint": "https://internal.company.com/mcp",
      "auth": "bearer_token"
    }
  }
}
```

### Disable for Specific Projects
```json
{
  "mcp_tools": {
    "version_checking": {
      "enabled": false  // Turn off for this project
    }
  }
}
```

---

**For complete MCP usage examples, see phase prompts 02-planning.md and 03-implementation.md**
