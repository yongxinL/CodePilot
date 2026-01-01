# CodePilot

**A complete, ready-to-use automated development system for OpenCode**

CodePilot is a multi-agent development workflow that orchestrates software development through 5 specialized phases with 7 expert consultants.

## Features

✅ **5 Phase Agents** - Complete development lifecycle
✅ **7 Specialist Subagents** - Expert consultation on demand
✅ **Production-Ready Prompts** - Comprehensive, tested workflows
✅ **Multi-Provider Support** - Works with Anthropic, OpenAI, Google, etc.
✅ **Zero Migration** - Ready to use, no adaptation needed
✅ **Extensible** - Customize for your needs

## Quick Start

```bash
# 1. Initialize
./init-docs.sh

# 2. Authenticate
opencode auth login

# 3. Start building
opencode --agent requirements
> "Build a task management app for small teams"
```

## Phase Agents

### Phase 1: Requirements (`requirements` agent)
Analyze and document what to build
- Deconstruct requirements
- Create specifications
- Generate user stories
- **Output**: docs/artifacts/phase1-requirements/

### Phase 2: Planning (`architect` agent)
Design architecture and create plans
- Design system architecture
- Create technical specifications
- Develop implementation plans
- **Output**: docs/artifacts/phase2-planning/

### Phase 3: Implementation (`engineer` agent)
Write code with best practices
- Implement features
- Write comprehensive tests
- Document code
- **Output**: docs/artifacts/phase3-implementation/

### Phase 4: Verification (`verifier` agent)
Test, validate, and prepare release
- Execute comprehensive testing
- Verify quality standards
- Prepare release documentation
- **Output**: docs/artifacts/phase4-verification/

### Phase 5: Master Control (`master` agent)
Orchestrate complex multi-phase projects
- Coordinate multiple features
- Track overall progress
- Manage project lifecycle
- **Output**: docs/artifacts/phase5-master/

## Specialist Subagents

Invoke specialists anytime with `@mention`:

- **@security** - Security assessment and recommendations
- **@ux** - User experience and accessibility
- **@performance** - Performance optimization
- **@devops** - Deployment and infrastructure
- **@qa** - Testing strategy and quality
- **@docs** - Documentation quality
- **@ethics** - Ethical implications and privacy

**Example:**
```
opencode --agent engineer

> "Implement user authentication with JWT"
[engineer works on implementation]

> "@security Review this authentication code"
[security subagent provides assessment]

> [engineer integrates security recommendations]
```

## Workflow Examples

### Simple Feature
```
Phase 1 (requirements) → Phase 2 (architect) → 
Phase 3 (engineer) → Phase 4 (verifier) → Done!
```

### Complex Project
```
Phase 5 (master) coordinates:
  → Feature A: Phase 1-4
  → Feature B: Phase 1-4
  → Feature C: Phase 1-4
  → Integration & Release
```

## Commands

### Phase Commands
- `/phase1 [requirement]` - Start requirements analysis
- `/phase2` - Start planning
- `/phase3` - Start implementation
- `/phase4` - Start verification
- `/phase5` - Start master control

### Utility Commands
- `/status` - Show project status
- `/checkpoint` - Create recovery point
- `/help` - Show available commands

### Agent Switching
- **Tab** - Cycle through primary agents
- **Ctrl+A** - Agent selector
- Or use `/phase[N]` commands

## Configuration

The package includes:
- `opencode.json` - All 12 agents configured
- `docs/prompts/` - 5 complete phase prompts
- `docs/subagents/` - 7 complete specialist prompts
- `docs/core/00-core.md` - Core system configuration
- `docs/AGENTS.md` - Project context

No additional configuration needed!

## File Structure

```
project/
├── opencode.json           # Configuration
├── init-docs.sh            # Setup script
├── docs/
│   ├── AGENTS.md          # Project context (auto-loaded)
│   ├── core/
│   │   └── 00-core.md     # Core config (auto-loaded)
│   ├── prompts/           # Phase prompts
│   │   ├── 01-requirement.md
│   │   ├── 02-planning.md
│   │   ├── 03-implementation.md
│   │   ├── 04-verification.md
│   │   └── 05-master-control.md
│   ├── subagents/         # Specialist prompts
│   │   ├── security.md
│   │   ├── ux.md
│   │   ├── performance.md
│   │   ├── devops.md
│   │   ├── qa.md
│   │   ├── docs.md
│   │   └── ethics.md
│   └── artifacts/         # Generated outputs
│       ├── phase1-requirements/
│       ├── phase2-planning/
│       ├── phase3-implementation/
│       ├── phase4-verification/
│       └── phase5-master/
```

## Requirements

- OpenCode CLI installed
- AI provider API key (Anthropic, OpenAI, Google, etc.)
- Terminal access

## Installation

```bash
# Install OpenCode
npm install -g @opencode/cli

# Or via Homebrew (macOS)
brew install opencode

# Or download from https://opencode.ai
```

## Customization

### Change Default Model
Edit `opencode.json`:
```json
{
  "model": "anthropic/claude-sonnet-4-20250514",
  "agent": {
    "requirements": {
      "model": "openai/gpt-4-turbo"  // Override for specific agent
    }
  }
}
```

### Add Custom Commands
Edit `opencode.json`:
```json
{
  "command": {
    "analyze": {
      "description": "Quick requirement analysis",
      "template": "Analyze: $REQUIREMENT",
      "agent": "requirements"
    }
  }
}
```

### Adjust Agent Behavior
Edit prompts in `docs/prompts/` and `docs/subagents/`

## Tips

- **Start with requirements** - Even if you think you know the solution
- **Use master for complex projects** - Let it orchestrate multiple features
- **Consult specialists proactively** - Don't wait for problems
- **Trust the process** - Each phase builds on the previous
- **Document decisions** - Future you will thank present you

## Troubleshooting

### Agent not responding correctly
- Check prompt file exists: `ls docs/prompts/01-requirement.md`
- Verify opencode.json references correct paths
- Restart OpenCode

### Subagent not triggering
- Use `@mention` syntax: `@security [question]`
- Or use command: `/consult-security [question]`
- Check subagent exists in opencode.json

### Session issues
- Use `/checkpoint` to save progress
- Use `--mode new` for fresh starts
- Use `--mode compact` to compress history

## Support

- OpenCode Documentation: https://opencode.ai/docs
- OpenCode GitHub: https://github.com/sst/opencode
- Report Issues: [Your issue tracker]

## What Makes This Special

### vs Claude Code
- ✅ Native multi-agent support (vs simulated roles)
- ✅ True specialist subagents (vs manual consultation)
- ✅ Provider flexibility (vs Anthropic-only)
- ✅ Explicit session management (vs manual)
- ✅ Open and extensible

### vs Other Tools
- ✅ Structured phases (vs freeform)
- ✅ Progressive disclosure (vs overwhelming)
- ✅ Knowledge capture (vs starting fresh)
- ✅ Production-ready (vs experimental)

## Contributing

Contributions welcome! Areas to improve:
- Additional specialist subagents
- Domain-specific prompts
- Integration examples
- Documentation improvements

---

**Ready to build intelligent software!** 🚀

Start with: `opencode --agent requirements`
