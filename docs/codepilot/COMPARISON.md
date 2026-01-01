# CodePilot: Claude Code vs OpenCode Comparison

## Executive Summary

This document compares CodePilot implementations for Claude Code and OpenCode, helping you choose the right version for your needs.

## Quick Comparison Table

| Feature | Claude Code Version | OpenCode Version |
|---------|-------------------|------------------|
| **Setup Complexity** | Simple (single CLAUDE.md) | Moderate (opencode.json + prompts) |
| **Agent System** | Single agent with roles | Multiple agents (5 primary + 7 subagents) |
| **Agent Switching** | Manual role transitions | Native agent switching (Tab key) |
| **Session Management** | Manual checkpoints | Explicit modes (new/compact/message) |
| **Provider Support** | Anthropic only | Multi-provider (Anthropic, OpenAI, Google, etc.) |
| **Subagent Invocation** | Manual consultation | Native @mention system |
| **Extensibility** | Limited | Highly extensible |
| **Learning Curve** | Lower | Moderate |
| **Best For** | Solo developers, simple projects | Teams, complex projects, power users |
| **Maintenance** | Lower | Moderate |
| **Cost** | Claude subscription | Provider-dependent |
| **Maturity** | Stable | Growing ecosystem |

## Detailed Feature Comparison

### 1. Configuration System

#### Claude Code
```markdown
# CLAUDE.md
- Single file configuration
- Plain markdown
- Easy to understand
- Limited structure
- Manual role definitions
```

**Pros:**
- Simple to set up
- Easy to edit
- Quick to get started
- No JSON syntax to learn

**Cons:**
- Limited programmatic control
- Harder to share across projects
- No schema validation
- Manual updates needed

#### OpenCode
```json
// opencode.json
{
  "$schema": "https://opencode.ai/config.json",
  "agent": { /* agent configs */ },
  "command": { /* custom commands */ },
  "tools": { /* tool permissions */ }
}
```

**Pros:**
- Schema validation
- Structured configuration
- Easy to share/version
- Programmatic updates
- IDE autocomplete support

**Cons:**
- More complex initially
- JSON syntax required
- More files to manage
- Steeper learning curve

### 2. Agent Architecture

#### Claude Code: Single Agent with Roles

**How it works:**
```
User → Claude Code → Single AI Instance
                    ↓
               Role Transitions
               ("I am now X...")
               ↓
               Different Behaviors
```

**Characteristics:**
- One continuous conversation
- Manual role declarations
- State carried throughout
- Simpler mental model
- Context never lost
- Can blur between roles

**Example interaction:**
```
User: "Analyze this requirement"
Claude: [Business Analyst mode]
         "Here's the analysis..."

User: "Now design the solution"
Claude: [Transitions to Architect]
         "I am now Solution Architect..."
         "Here's the design..."
```

#### OpenCode: Multiple Specialized Agents

**How it works:**
```
User → OpenCode → Agent Router
                 ↓
         [Requirements Agent]
         [Architect Agent]
         [Engineer Agent]
         [Verifier Agent]
         [Master Agent]
                 ↓
              Subagents
         [@security, @ux, etc.]
```

**Characteristics:**
- Separate agent instances
- Native agent switching
- Clean role separation
- Explicit context handoffs
- Steeper learning curve
- Can run parallel sessions

**Example interaction:**
```
User: [In requirements agent]
      "Analyze this requirement"
Agent: "Here's the analysis..."

User: [Switches to architect agent via Tab]
      "Design solution for [handoff context]"
Agent: "Here's the design..."

User: "@security Review the design"
Security: "Security assessment..."
Agent: [Continues with design]
```

### 3. Session Management

#### Claude Code: Manual Recovery

**Approach:**
- Single long conversation
- Manual recovery checkpoints
- Handoff files for phase transitions
- User creates checkpoints
- No automatic compression

**Recovery checkpoint format:**
```markdown
# Recovery Checkpoint - Phase 2
Date: 2026-01-01
Phase: Planning
Status: In progress

## Context
[Manual context summary]

## Lazy-Load Map
- Artifact 1: Location...
- Artifact 2: Location...

## Next Actions
1. Complete architecture
2. Generate plan
```

**Pros:**
- Full control over what's saved
- Can customize checkpoint format
- No session interruptions
- Simple continuation

**Cons:**
- Manual effort required
- Easy to forget checkpoints
- No automatic compression
- Context can get very large

#### OpenCode: Explicit Session Modes

**Approach:**
- Built-in session modes
- Automatic checkpoint capability
- Programmatic handoffs
- Session API integration
- Automatic compression available

**Session modes:**
```typescript
// Continue current session
session({ mode: "message" })

// Compress history, continue
session({ mode: "compact" })

// Start fresh
session({ mode: "new", agent: "architect" })
```

**Pros:**
- Automatic management options
- Built-in compression
- API-driven handoffs
- Clear mode semantics
- Better for long projects

**Cons:**
- Need to understand modes
- More complex conceptually
- Requires mode decisions
- Can lose context if wrong mode

### 4. Multi-Agent Coordination

#### Claude Code: Simulated Consultation

**How it works:**
```
Engineer: "I need Security input"
         [Manually switches context]
         "As Security Engineer..."
         [Provides advice]
         [Manually switches back]
         "Back to Engineer..."
```

**Characteristics:**
- Single agent simulates multiple roles
- Manual context switching
- State maintained throughout
- Simple but verbose
- No true parallelism

**Pros:**
- All in one conversation
- No agent switching needed
- Context always available
- Simpler for user

**Cons:**
- Verbose role switching
- Can confuse roles
- No true specialization
- Manual state management

#### OpenCode: Native Subagent System

**How it works:**
```
Engineer: [Working on code]
         @security "Review authentication"
         ↓
Security: [Separate subagent instance]
         "Assessment: ..."
         "Recommendations: ..."
         ↓
Engineer: [Receives advice, continues]
```

**Characteristics:**
- True agent separation
- Native @mention syntax
- Automatic invocation
- Parallel consultation possible
- Clear role boundaries

**Pros:**
- Clean separation of concerns
- True specialization
- Concise invocation
- Multiple simultaneous consultations
- Better token efficiency

**Cons:**
- Need to learn @syntax
- Subagent setup required
- More moving parts
- Context not shared by default

### 5. Provider Flexibility

#### Claude Code: Anthropic Only

**Configuration:**
```markdown
# CLAUDE.md
Uses Claude 3.5 Sonnet
(No provider choice)
```

**Pros:**
- Simple setup
- Consistent experience
- Optimized for Claude
- No provider decisions

**Cons:**
- Locked to Anthropic
- Can't optimize by phase
- Price sensitive to Claude costs
- No fallback options

#### OpenCode: Multi-Provider

**Configuration:**
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

**Pros:**
- Provider choice per agent
- Cost optimization
- Best model for each task
- Fallback options
- Competition benefits

**Cons:**
- More complexity
- Need multiple API keys
- Inconsistent responses possible
- Provider management overhead

### 6. Customization & Extensibility

#### Claude Code: Limited

**What you can customize:**
- Prompt content
- File structure
- Templates
- Recovery format

**What you cannot:**
- Tool permissions
- Model selection
- Agent behavior
- System integration

**Extensibility: Low**

#### OpenCode: Extensive

**What you can customize:**
```json
{
  "agent": { /* Custom agents */ },
  "command": { /* Custom commands */ },
  "tools": { /* Tool permissions */ },
  "mcp": { /* MCP servers */ },
  "plugin": { /* Plugins */ }
}
```

**What you can add:**
- Custom agents
- Custom commands
- MCP integrations
- Plugins
- Formatters
- LSP servers
- Workflows

**Extensibility: High**

### 7. Learning Curve & Setup

#### Claude Code

**Initial Setup:**
```bash
# 1. Create CLAUDE.md
# 2. Add prompts
# 3. Start Claude Code
# Total: ~5 minutes
```

**Learning:**
- Understand phases
- Learn role transitions
- Create checkpoints
- Time to proficiency: 1-2 hours

**Documentation:**
- Single CLAUDE.md file
- Prompt files
- Templates

#### OpenCode

**Initial Setup:**
```bash
# 1. Install OpenCode
# 2. Create opencode.json
# 3. Create agent prompts
# 4. Create subagent prompts
# 5. Configure provider
# 6. Test agents
# Total: ~30-60 minutes
```

**Learning:**
- Understand agents
- Learn session modes
- Master @mentions
- Configure tools
- Time to proficiency: 4-8 hours

**Documentation:**
- opencode.json schema
- Agent prompts (12+ files)
- Commands
- Configuration guide
- Migration guide
- Adaptation guide

### 8. Team Collaboration

#### Claude Code

**Sharing:**
- Share CLAUDE.md file
- Share prompt directory
- Share artifacts

**Collaboration:**
- Everyone uses same configuration
- No per-agent customization
- Simple version control
- Easy to onboard

**Best for:**
- Solo developers
- Small teams (2-3)
- Simple workflows

#### OpenCode

**Sharing:**
- Share opencode.json
- Share agent directory
- Share configuration
- Per-user customization possible

**Collaboration:**
- Team can use different providers
- Custom agent per role
- Shared knowledge base
- Complex coordination possible

**Best for:**
- Large teams (4+)
- Distributed teams
- Complex projects
- Organizations

### 9. Cost Considerations

#### Claude Code

**Costs:**
- Claude Pro: $20/month
- Claude Code access: Included with subscription
- No per-token billing (flat rate)

**Best for:**
- Heavy usage
- Predictable budgets
- Simple cost tracking

**Total: ~$20/month fixed**

#### OpenCode

**Costs:**
- Provider API costs (variable)
- Per-token billing
- Multiple provider costs possible

**Examples:**
```
Anthropic Claude: ~$3-15/1M tokens
OpenAI GPT-4: ~$10-30/1M tokens
Google Gemini: ~$0.50-7/1M tokens
```

**Best for:**
- Light to moderate usage
- Cost optimization
- Mixed provider strategy

**Total: Variable, usage-based**

### 10. Use Case Fit

#### Claude Code: Best For

✅ **Solo developers**
- Simple setup
- Single provider
- Easy maintenance

✅ **Learning CodePilot**
- Gentler learning curve
- Easier to understand
- Less configuration

✅ **Simple projects**
- 1-2 phases typically
- Short-lived projects
- Low complexity

✅ **Prototyping**
- Quick setup
- Rapid iteration
- Minimal overhead

✅ **Claude enthusiasts**
- Prefer Anthropic
- Optimize for Claude
- Trust single provider

#### OpenCode: Best For

✅ **Teams**
- Multiple developers
- Role specialization
- Shared configuration

✅ **Complex projects**
- Multi-phase workflows
- Multiple agents needed
- Long-running projects

✅ **Power users**
- Want customization
- Need extensibility
- Comfortable with JSON

✅ **Cost optimization**
- Large scale usage
- Want provider choice
- Need cost control

✅ **Advanced workflows**
- Parallel agents
- Custom integrations
- Automated pipelines

## Migration Path

### From Claude Code to OpenCode

**When to migrate:**
- Project outgrows single agent
- Need provider flexibility
- Team expanding
- Want better agent separation

**Migration effort:**
- Small project: 2-4 hours
- Medium project: 4-8 hours
- Large project: 8-16 hours

**Steps:**
1. Install OpenCode
2. Create opencode.json
3. Adapt prompts (5 phases + 7 subagents)
4. Test each agent
5. Train team

### From OpenCode to Claude Code

**When to migrate:**
- Simplify workflow
- Reduce maintenance
- Solo developer transition
- Prefer flat-rate pricing

**Migration effort:**
- Small project: 1-2 hours
- Medium project: 2-4 hours
- Large project: 4-8 hours

**Steps:**
1. Consolidate prompts into CLAUDE.md
2. Add role transitions
3. Remove agent-specific configs
4. Test workflow
5. Adjust team process

## Hybrid Approach

**Is it possible?**
Yes! Maintain both versions:

```
project/
├── CLAUDE.md                    # Claude Code
├── opencode.json                # OpenCode
├── docs/
│   ├── prompts/                 # Shared prompts
│   ├── subagents/               # OpenCode only
│   └── artifacts/               # Shared
```

**When to use hybrid:**
- Transitioning between versions
- Different team members prefer different tools
- Specific phases better in one version
- Testing before full migration

## Decision Framework

### Choose Claude Code if:
- [ ] Solo developer or small team (2-3)
- [ ] Simple to moderate complexity
- [ ] Want quick setup (<10 minutes)
- [ ] Prefer flat-rate pricing
- [ ] Learning CodePilot
- [ ] Trust Anthropic for all needs
- [ ] Want minimal maintenance

### Choose OpenCode if:
- [ ] Team of 4+ developers
- [ ] Complex multi-phase projects
- [ ] Need provider flexibility
- [ ] Want extensibility
- [ ] Comfortable with configuration
- [ ] Need cost optimization at scale
- [ ] Want native multi-agent support
- [ ] Plan to integrate with other tools

### Choose Hybrid if:
- [ ] Transitioning between versions
- [ ] Team has mixed preferences
- [ ] Want best of both worlds
- [ ] Testing before commitment
- [ ] Specific phases suit each version

## Future Considerations

### Claude Code Evolution
- Likely to remain simple
- Focused on Anthropic ecosystem
- May add more native features
- Stable and predictable

### OpenCode Evolution
- Rapidly growing ecosystem
- More integrations
- Community plugins
- More providers
- Advanced features

**Recommendation:** 
- Start with Claude Code for learning
- Migrate to OpenCode as needs grow
- Or start with OpenCode if team/scale warrants

## Conclusion

Both versions are production-ready and effective:

**Claude Code** = Simplicity, ease of use, flat-rate pricing
**OpenCode** = Power, flexibility, extensibility

Choose based on your:
- Team size
- Project complexity  
- Technical comfort
- Budget model
- Long-term vision

**Can't decide?** Start with Claude Code, migrate later if needed.

---

**Questions to Consider:**

1. How many people will use this? → 1-3: Claude Code, 4+: OpenCode
2. How complex is the project? → Simple: Claude Code, Complex: OpenCode
3. Do you need provider choice? → No: Claude Code, Yes: OpenCode
4. What's your technical comfort? → Basic: Claude Code, Advanced: OpenCode
5. What's your budget model? → Flat-rate: Claude Code, Usage-based: OpenCode

**Still unsure?** Try Claude Code first. It's easier to learn CodePilot concepts with the simpler version, then migrate if you outgrow it.
