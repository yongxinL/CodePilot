# CodePilot v2.0 - File Completion Guide

## 🎯 Current Status
- ✅ Configuration files complete (opencode.json, .codepilot.config.json)
- ✅ Setup script complete (init-docs.sh)
- ✅ Directory structure created
- ⏳ Phase prompts partially created
- ❌ Templates need creation
- ❌ Guides need creation

## 📋 Files Needing Completion

### **CRITICAL: Enhanced Phase Prompts**

Each phase prompt needs these sections added:

**01-requirement.md** - Add these features:
1. ✅ Skill Assessment (started)
2. ✅ One-line requirement (started)  
3. ✅ Specification versioning (started)
4. ⏳ Locked specification system
5. ⏳ Formal approval workflow
6. ⏳ Competitive analysis (optional)
7. ⏳ Git integration workflow

**02-planning.md** - Add these features:
1. Specification resolution document
2. Goal extraction from one-liner
3. Gantt chart generation
4. Individual task file creation
5. KISS/DRY/SOLID checklist
6. Rollback plan
7. Data model evolution plan
8. **MCP version checking** (KEY NEW FEATURE)

**03-implementation.md** - Add these features:
1. Progressive session checkpoints
2. Task-level tracking
3. Code quality gates
4. Technical debt register
5. Git per-task (automatic mode)

**04-verification.md** - Add these features:
1. Formal test coverage matrix
2. Release readiness checklist
3. Performance benchmark results
4. Security scan reports

**05-master-control.md** - Add these features:
1. Portfolio view (Advanced+ tier)
2. Cross-project dependencies (Full tier)
3. Resource allocation (Full tier)

### **Completion Options**

**Option A: Use v1.0 as Base**
1. Copy all v1.0 prompt files to docs/prompts/
2. Manually add v2.0 features from specs below
3. Test with: `opencode --agent requirements`

**Option B: Request Detailed Specs**
1. Ask me for detailed specifications for each feature
2. I'll provide complete feature specs
3. You implement following the specs

**Option C: Incremental Approach**
1. Use v1.0 prompts now (works immediately)
2. Add v2.0 features one at a time
3. Test each feature before adding next

## 🎯 RECOMMENDED: Use v1.0 + Gradual Enhancement

**Step 1**: Copy v1.0 files
```bash
# Copy from attached files in conversation:
cp [v1.0]/01-requirement.md docs/prompts/
cp [v1.0]/02-planning.md docs/prompts/
cp [v1.0]/03-implementation.md docs/prompts/
cp [v1.0]/04-verification.md docs/prompts/
cp [v1.0]/05-master-control.md docs/prompts/

# Copy subagents
cp [v1.0]/security.md docs/subagents/
cp [v1.0]/ux.md docs/subagents/
cp [v1.0]/performance.md docs/subagents/
cp [v1.0]/devops.md docs/subagents/
cp [v1.0]/qa.md docs/subagents/
cp [v1.0]/docs.md docs/subagents/
cp [v1.0]/ethics.md docs/subagents/

# Copy core docs
cp [v1.0]/AGENTS.md docs/
cp [v1.0]/00-core.md docs/core/
```

**Step 2**: Test it works
```bash
./init-docs.sh
opencode --agent requirements "Build a simple todo app"
```

**Step 3**: Add v2.0 features gradually
Enhance one prompt file at a time with v2.0 features

## 📚 Feature Specifications

### **Feature: Locked Specification System**

**Add to Phase 1 (requirements agent)**

**Purpose**: Create immutable baseline after approval

**Workflow**:
1. After requirements-spec.md is approved
2. Create locked-specification.md (identical copy)
3. Add version: 1.0
4. Prompt user: "Requirements approved. Creating locked specification..."
5. Explain: Changes now require formal change control

**Template Location**: `docs/templates/phase1/locked-specification.md`

**Output Format**:
```markdown
# Locked Specification v1.0

**LOCKED DATE**: 2026-01-03
**LOCKED BY**: Requirements Analyst
**STATUS**: IMMUTABLE - Changes require change control

---
[Exact copy of requirements-spec.md]
---

## Change Control Process
To modify this locked specification:
1. Submit change request to docs/artifacts/cross-cutting/change-requests.md
2. Impact analysis required
3. Stakeholder approval needed
4. Creates new version (v1.1, v2.0, etc.)
```

### **Feature: MCP Version Checking**

**Add to Phase 2 (architect agent)**

**Purpose**: Verify latest framework/library versions using MCP tools

**Configuration Check**:
```javascript
if (config.mcp_tools.version_checking.enabled) {
  // MCP available
  if (config.mcp_tools.version_checking.auto_check) {
    // Auto mode (Advanced+ tier)
    automatically_check_versions();
  } else {
    // Manual mode (Core+ tier)
    inform_user_mcp_available();
  }
}
```

**Workflow (Auto Mode - Advanced+ Tier)**:
```
1. User provides requirement: "Build React app"
2. Architect selects React for frontend
3. AUTO-TRIGGER: Query MCP for latest React version
4. MCP returns: "React 18.3.1 (released 2024-04-25)"
5. Document in technology-stack.md with timestamp
6. Check security advisories if enabled
7. Continue with planning
```

**Workflow (Manual Mode - Core+ Tier)**:
```
1. Architect selects technology stack
2. INFORM user: "MCP version checking available"
3. Ask: "Check latest versions? [Y/n]"
4. If yes: Query MCP for each technology
5. Document verified versions
6. Continue with planning
```

**MCP Query Examples**:
```javascript
// Using Context7 (preferred)
query_mcp("context7", "latest stable React version")
// Returns: "React 18.3.1 released April 25, 2024"

query_mcp("context7", "Node.js LTS version")
// Returns: "Node.js 20.11.0 LTS (active until 2026-04-30)"

// Security advisory check
query_mcp("context7", "security advisories for Express 4.18.0")
// Returns: "1 medium severity: CVE-2024-XXXX"

// Fallback to web_search if Context7 unavailable
query_mcp("web_search", "React latest version 2026")
```

**Output in technology-stack.md**:
```markdown
# Technology Stack

## Frontend
**Framework**: React 18.3.1
- **Verified**: 2026-01-03 14:30 UTC via Context7 MCP
- **Status**: Latest stable release
- **Released**: 2024-04-25
- **Security Advisories**: None
- **Breaking Changes**: None from 18.3.0
- **Rationale**: [Why chosen]

## Backend  
**Runtime**: Node.js 20.11.0 LTS
- **Verified**: 2026-01-03 14:31 UTC via Context7 MCP
- **Status**: Active LTS (until 2026-04-30)
- **Security Advisories**: None
- **Rationale**: [Why chosen]
```

**Caching**:
- Cache MCP responses for 1 hour (3600 seconds)
- Avoid redundant queries within same session
- Cache stored in memory, cleared on session end

**Error Handling**:
```
If MCP fails:
1. Log error (don't interrupt workflow)
2. Fallback to knowledge cutoff
3. Add disclaimer: "⚠️  Could not verify latest version (MCP unavailable). Using knowledge as of Jan 2025. Please verify manually at [official site]"
```

**Token Cost**:
- MCP query: ~50-100 tokens
- MCP response: ~100-200 tokens
- Total per technology: ~150-300 tokens
- 5 technologies: ~750-1500 tokens (one-time, cached)

---

## 🆕 New Files Needed

### **docs/prompts/06-data-interpreter.md**

**Create this for Full tier**:

```markdown
# Data Interpreter Agent - CodePilot v2.0

## Agent Identity
You are a **Data Interpreter** specializing in visualizing metrics, performance data, and project analytics.

## Tier Requirement
**Full tier only** - Loaded when `optional_agents.data_interpreter: true`

## Purpose
Transform raw metrics into actionable visualizations and insights.

## Capabilities
1. Parse metrics from test reports, benchmarks, logs
2. Generate charts (Mermaid, ASCII, or recommend tools)
3. Trend analysis over time
4. Performance regression detection
5. Resource utilization analysis

## Invocation
User: "@data-interpreter Visualize test coverage trends"
User: "@data-interpreter Generate performance chart from benchmarks"

## Output Format
- Text-based charts (ASCII/Mermaid) for inline viewing
- Recommendations for proper visualization tools if needed
- Insights and anomaly detection

## Example
User: "@data-interpreter Show velocity trends"

Response:
```
Analyzing velocity from docs/artifacts/phase5-master/metrics-dashboard.md...

Sprint Velocity Trend:
```
Sprint 1: ████████████░░ 12 points
Sprint 2: ████████████████ 16 points  
Sprint 3: ████████████████████ 20 points (+25%)
Sprint 4: ████████████████ 16 points  (-20%)
Sprint 5: ██████████████████████ 22 points (+37%)
```

Insights:
- Average velocity: 17.2 points/sprint
- Trend: +20% improvement over 5 sprints
- Sprint 4 dip: Coincides with Q4 holidays (expected)
- Recommendation: Sprint 5 pace is sustainable, maintain for Sprint 6
```
```

### **docs/subagents/version-checker.md**

```markdown
# Version Checker Subagent - CodePilot v2.0

## Identity
You are a **Version Checker** specialist providing version verification and security advisories via MCP tools.

## Tier Requirement
**Advanced+ tier** - Loaded when `optional_agents.version_checker: true`

## Invocation
@version-checker Check React version
@version-checker Security advisories for our stack
@version-checker Is Express 4.18 up to date?

## MCP Integration
Use Context7 (preferred) or web_search (fallback):
- Query latest versions
- Check security advisories (CVEs)
- Validate compatibility matrices
- Detect breaking changes

## Response Format
```
Checking version via Context7 MCP...

**React**
- Current (in project): 18.2.0
- Latest stable: 18.3.1 (released 2024-04-25)
- Recommendation: Update (minor version, safe)
- Breaking changes: None
- Security: No advisories

**Express**
- Current: 4.18.0
- Latest: 4.19.2
- ⚠️  Security: CVE-2024-XXXX (medium severity)
- Recommendation: Update immediately
```

## Tool Usage
```javascript
// Query latest version
mcp_query("context7", "latest React stable version")

// Security check
mcp_query("context7", "CVE vulnerabilities React 18.2.0")

// Compatibility check
mcp_query("context7", "React 18 compatible with Node 20")
```
```

---

## ✅ Quick Start (Use What You Have Now)

**Your v2.0 is partially functional already!**

1. Copy v1.0 prompt files → `docs/prompts/`
2. Copy v1.0 subagents → `docs/subagents/`  
3. Run: `./init-docs.sh`
4. Use: `opencode --agent requirements`

**This works immediately with:**
- ✅ 4-tier configuration
- ✅ Git integration  
- ✅ MCP detection
- ✅ v1.0 functionality

**Then enhance gradually:**
- Add locked specs to Phase 1
- Add MCP checking to Phase 2
- Add checkpoints to Phase 3
- Test each enhancement

## 📞 Need Help?

Ask me:
- "Detailed spec for [specific feature]"
- "How to implement [feature name]"
- "Example of [feature] in action"

I'll provide complete specifications for any feature you want to add.
