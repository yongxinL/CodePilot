# Migration Guide: Claude Code → OpenCode

## Overview

This guide helps you migrate your CodePilot project from Claude Code to OpenCode.

## Key Differences

### Configuration Format

**Claude Code:**
```markdown
# CLAUDE.md
Custom instructions in markdown
```

**OpenCode:**
```json
// opencode.json
{
  "$schema": "https://opencode.ai/config.json",
  "agent": { ... },
  "command": { ... }
}
```

### Agent System

| Aspect | Claude Code | OpenCode |
|--------|-------------|----------|
| **Agents** | Single agent with role transitions | Multiple agents (5 primary + 7 subagents) |
| **Switching** | Manual "I am now..." statements | Tab key or `/phase` commands |
| **Roles** | Declared in prompt | Separate agent configs |
| **Context** | Single continuous session | Per-agent sessions with handoffs |

### Session Management

**Claude Code:**
- Manual recovery checkpoints
- Handoff files for context
- Single long conversation

**OpenCode:**
- Explicit session modes: `new`, `compact`, `message`
- API-based session control
- Multiple concurrent sessions possible

### File Structure

**Claude Code:**
```
project/
├── CLAUDE.md
├── docs/prompts/
└── docs/artifacts/
```

**OpenCode:**
```
project/
├── opencode.json
├── docs/
│   ├── AGENTS.md
│   ├── core/00-core.md
│   ├── prompts/
│   ├── subagents/
│   └── artifacts/
└── .opencode/
```

## Migration Steps

### Step 1: Install OpenCode

```bash
# Via npm
npm install -g @opencode/cli

# Or via brew (macOS)
brew install opencode

# Or download from https://opencode.ai
```

### Step 2: Copy Project Files

```bash
# Create new OpenCode project directory
mkdir my-project-opencode
cd my-project-opencode

# Copy your CodePilot package
cp -r /path/to/CodePilot-v1.0/* .

# Initialize
./init-docs.sh
```

### Step 3: Migrate Prompts

For each prompt file in your Claude Code version:

1. **Copy the base prompt:**
   ```bash
   cp ../claude-code-project/docs/prompts/01-requirement.md \
      docs/prompts/01-requirement.md
   ```

2. **Adapt for OpenCode:**

   **Remove:** Role transition banners
   ```markdown
   # ❌ REMOVE THIS
   ═══════════════════════════════════════
   🎭 ROLE TRANSITION: Business Analyst
   ═══════════════════════════════════════
   ```

   **Add:** Subagent invocation instructions
   ```markdown
   # ✅ ADD THIS
   ## Consulting Supporting Roles
   
   When you need specialized expertise, invoke subagents:
   - Security concerns: `@security [your question]`
   - UX feedback: `@ux [your question]`
   - Performance optimization: `@performance [your question]`
   - Deployment guidance: `@devops [your question]`
   - Testing strategy: `@qa [your question]`
   - Documentation review: `@docs [your question]`
   - Ethical considerations: `@ethics [your question]`
   ```

   **Update:** Session management
   ```markdown
   # ❌ OLD (Claude Code)
   At phase completion, create a recovery checkpoint:
   - Save to docs/recovery/checkpoint-{phase}.md
   - Include lazy-load map
   
   # ✅ NEW (OpenCode)
   At phase completion, generate handoff:
   - Use `/handoff [next_phase_agent]` command
   - This creates handoff file in docs/artifacts/
   - Start new session with next agent
   - Provide handoff context in first message
   ```

3. **Repeat for all phase prompts** (01-05)

### Step 4: Create Subagent Prompts

Create new files in `docs/subagents/` for each supporting role:

**Template:**
```markdown
# [Role Name] Subagent

## Role
You are a [role] expert providing specialized consultation.

## Scope
- [Primary responsibility 1]
- [Primary responsibility 2]
- [Primary responsibility 3]

## Invocation
You are invoked via:
- `@[agent-name] [context/question]`
- `/consult-[agent-name] [context]`

## Response Format
1. **Assessment**: Brief evaluation
2. **Recommendations**: Specific, actionable advice
3. **Resources**: Relevant patterns, tools, or references

## Constraints
- Read-only access (no code modifications)
- Focus on your area of expertise
- Be concise but thorough
- Reference best practices

## Example Interaction

**Invocation:**
```
@[agent-name] Review the authentication implementation for security issues
```

**Response:**
```
**Assessment**: The JWT implementation has several security concerns...
**Recommendations**:
1. Add token rotation: ...
2. Implement rate limiting: ...
3. Use secure cookies: ...
**Resources**: See OWASP JWT Security Cheat Sheet
```

[Include role-specific guidance from your CodePilot documentation]
```

**Create these files:**
- `docs/subagents/security.md`
- `docs/subagents/ux.md`
- `docs/subagents/performance.md`
- `docs/subagents/devops.md`
- `docs/subagents/qa.md`
- `docs/subagents/docs.md`
- `docs/subagents/ethics.md`

### Step 5: Configure OpenCode

1. **Authenticate with provider:**
   ```bash
   opencode auth login
   # Choose: Anthropic (or your preferred provider)
   # Provide API key
   ```

2. **Verify configuration:**
   ```bash
   # Check that opencode.json is valid
   cat opencode.json
   
   # Test agent loading
   opencode --agent requirements --help
   ```

3. **Test project context:**
   ```bash
   opencode --agent requirements
   # In TUI: "What project am I working on?"
   # Should describe CodePilot based on AGENTS.md
   ```

### Step 6: Test Workflow

Run a simple end-to-end test:

```bash
# Start Phase 1
opencode --agent requirements

# In TUI:
> "Create requirements for a simple calculator app with add, subtract, multiply, divide"

# Agent should:
# 1. Analyze requirement
# 2. Create requirements doc
# 3. Save to docs/artifacts/phase1-requirements/
# 4. Suggest handoff to architect

# Test handoff
> "/handoff architect"

# Start Phase 2
opencode --agent architect --mode new

# In TUI:
> "Here's the handoff from Phase 1: [paste handoff content]"
> "Create technical design for the calculator"

# Test subagent invocation
> "@security Review the calculator design for any security concerns"

# Continue testing through phases...
```

### Step 7: Migrate Existing Work

If you have existing artifacts from Claude Code:

```bash
# Copy artifacts
cp -r ../claude-code-project/docs/artifacts/* \
      docs/artifacts/

# Update references in prompts
# (OpenCode uses same paths, should work automatically)

# Copy knowledge base
cp -r ../claude-code-project/docs/knowledge-base/* \
      docs/knowledge-base/
```

## Workflow Changes

### Claude Code Workflow

```
1. Start Claude Code
2. "I am now Business Analyst" (role transition)
3. Analyze requirements
4. "I am now Solution Architect" (role transition)
5. Design solution
6. [Continue in single session]
```

### OpenCode Workflow

```
1. opencode --agent requirements
2. Analyze requirements (no transition needed)
3. /handoff architect
4. opencode --agent architect --mode new
5. Provide handoff context
6. Design solution (no transition needed)
7. [Phase-based sessions with clean handoffs]
```

### Subagent Consultation

**Claude Code:**
```markdown
As Business Analyst, I need Security Engineer input...
[Manually switch context]
[Manually return to original role]
```

**OpenCode:**
```markdown
@security Review this authentication approach
[Subagent responds]
[Automatically returns to primary agent]
```

## Command Mapping

| Claude Code | OpenCode | Notes |
|-------------|----------|-------|
| "Begin Phase 1" | `/phase1 [requirement]` | Custom command |
| Manual role transition | `Tab` key or `/phase` commands | Agent switching |
| Manual checkpoint | `/checkpoint` | Creates recovery checkpoint |
| Manual handoff file | `/handoff [agent]` | Generates handoff |
| Check status | `/status` | Project status report |
| N/A | `@security`, `@ux`, etc. | Subagent invocation |

## Session Mode Guide

### When to Use Each Mode

**`message` (default):**
- Continuing current work
- Same phase, same agent
- Context from previous messages needed

**`compact`:**
- Long task within a phase
- Session getting large (>50 messages)
- Want to compress history but keep agent

**`new`:**
- Phase transitions
- Starting fresh feature
- Clean context needed
- After completing major milestone

## Troubleshooting

### Issue: Prompts not loading

**Symptoms:** Agent responses are generic, don't follow CodePilot structure

**Solution:**
1. Check file paths in `opencode.json`
2. Verify files exist:
   ```bash
   ls -la docs/prompts/
   ls -la docs/subagents/
   ```
3. Use absolute paths if needed:
   ```json
   "prompt": "{file:/absolute/path/to/prompt.md}"
   ```

### Issue: Subagents not responding

**Symptoms:** `@security` doesn't trigger subagent

**Solution:**
1. Verify subagent config in `opencode.json`
2. Ensure `mode: "subagent"` is set
3. Check prompt file exists
4. Try explicit command: `/consult-security`

### Issue: Context not carrying over

**Symptoms:** Agent doesn't remember previous phase work

**Solution:**
1. Always create handoff: `/handoff [next_agent]`
2. Provide handoff context when starting new agent
3. Use `compact` mode instead of `new` if staying in same phase
4. Check that `instructions` files are loaded (AGENTS.md, 00-core.md)

### Issue: Agent switching not working

**Symptoms:** Tab key doesn't switch agents

**Solution:**
1. Only primary agents can be switched to with Tab
2. Check agent mode: `"mode": "primary"` in opencode.json
3. Use `/phase[N]` commands instead
4. Verify default_agent is set

## Advanced Migration

### Multi-Provider Setup

OpenCode supports different providers per agent:

```json
{
  "agent": {
    "requirements": {
      "model": "anthropic/claude-sonnet-4-20250514"
    },
    "architect": {
      "model": "openai/gpt-4-turbo"
    },
    "engineer": {
      "model": "anthropic/claude-sonnet-4-20250514"
    },
    "verifier": {
      "model": "google/gemini-1.5-pro"
    }
  }
}
```

### Custom Tool Configuration

Restrict tools per agent:

```json
{
  "agent": {
    "security": {
      "mode": "subagent",
      "tools": {
        "write": false,
        "edit": false,
        "bash": false,
        "read": true
      }
    }
  }
}
```

### MCP Integration

Add MCP servers for extended capabilities:

```json
{
  "mcp": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"]
    },
    "database": {
      "command": "mcp-server-postgres",
      "args": ["postgresql://localhost/mydb"]
    }
  }
}
```

## Rollback Plan

If migration encounters issues:

1. **Keep Claude Code version:**
   ```bash
   # Original project remains intact
   cd ../claude-code-project
   ```

2. **Compare outputs:**
   ```bash
   diff -r claude-code-project/docs/artifacts/ \
           opencode-project/docs/artifacts/
   ```

3. **Gradual migration:**
   - Migrate one phase at a time
   - Test thoroughly before moving to next phase
   - Keep both versions running in parallel initially

## Benefits of OpenCode

After migration, you'll gain:

1. **Better multi-agent orchestration** - Native support for multiple specialized agents
2. **Explicit session control** - Clear modes for different scenarios
3. **Provider flexibility** - Use best model for each phase
4. **Subagent system** - Easy consultation with specialists
5. **Extensibility** - Custom commands, tools, integrations
6. **Open architecture** - Community plugins and extensions

## Next Steps

1. **Complete prompt migration** - Adapt all 5 phase prompts + 7 subagents
2. **Test end-to-end** - Run simple project through all phases
3. **Customize** - Adjust agent configs based on your needs
4. **Document learnings** - Add to knowledge base
5. **Share feedback** - Help improve CodePilot

## Support

- OpenCode docs: https://opencode.ai/docs
- CodePilot issues: [Your repo]
- Community: [Your community links]

---

**Migration Status Checklist:**

- [ ] OpenCode installed
- [ ] Project initialized (`init-docs.sh`)
- [ ] Prompts migrated and adapted
- [ ] Subagent prompts created
- [ ] Configuration tested
- [ ] End-to-end workflow tested
- [ ] Existing artifacts migrated
- [ ] Knowledge base copied
- [ ] Team trained on new workflow
- [ ] Documentation updated

**Ready to build with CodePilot!** 🚀
