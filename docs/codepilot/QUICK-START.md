# CodePilot Quick Start Guide

Get up and running in 15 minutes!

## Prerequisites

- [ ] Terminal access
- [ ] npm installed (for OpenCode)
- [ ] AI provider API key

## Step 1: Install OpenCode (2 minutes)

```bash
# Via npm (recommended)
npm install -g @opencode/cli

# Or via Homebrew (macOS)
brew install opencode

# Verify installation
opencode --version
```

## Step 2: Setup Project (1 minute)

```bash
# Navigate to your project (or create new)
cd my-awesome-project

# Initialize CodePilot
./init-docs.sh
```

You should see:
```
🚀 Initializing CodePilot...
✅ Directory structure created
✨ CodePilot initialization complete!
```

## Step 3: Authenticate (2 minutes)

```bash
opencode auth login

# Select your provider (e.g., Anthropic)
# Enter your API key
```

**Get API keys:**
- Anthropic: https://console.anthropic.com/
- OpenAI: https://platform.openai.com/api-keys
- Google: https://aistudio.google.com/app/apikey

## Step 4: Your First Feature (10 minutes)

### Start Phase 1: Requirements

```bash
opencode --agent requirements
```

In the OpenCode interface, type:
```
Build a REST API for user authentication with JWT tokens, 
including registration, login, and password reset.
```

**What happens:**
1. Agent asks clarifying questions
2. You provide answers
3. Agent creates requirements specification
4. Agent generates user stories
5. Agent saves artifacts to `docs/artifacts/phase1-requirements/`
6. Agent suggests moving to Phase 2

### Move to Phase 2: Planning

When Phase 1 completes, the agent will say something like:
```
✅ Requirements Phase Complete

To begin Planning Phase:
opencode --agent architect --mode new
```

Follow the instruction:
```bash
# Exit current session (Ctrl+D or /exit)
opencode --agent architect --mode new
```

Provide the handoff context (agent will guide you), then:
```
Design the technical architecture for the authentication system.
```

**What happens:**
1. Agent reviews requirements
2. Agent designs system architecture
3. Agent creates technical specifications
4. Agent develops implementation plan
5. Agent saves artifacts to `docs/artifacts/phase2-planning/`
6. Agent suggests moving to Phase 3

### Continue Through Phases

Follow the same pattern for:
- **Phase 3** (Implementation): `opencode --agent engineer --mode new`
- **Phase 4** (Verification): `opencode --agent verifier --mode new`

## Using Specialist Subagents

At any time, consult specialists:

```bash
# While in any phase:
> "@security Review JWT implementation approach"
> "@performance Optimize database query performance"
> "@ux Evaluate user registration flow"
```

**Example in Phase 3:**
```
opencode --agent engineer

# After implementing authentication
> "@security Review this authentication code for vulnerabilities"

[Security subagent provides assessment and recommendations]

> "Applying security recommendations..."
[Engineer integrates the advice]
```

## Quick Reference

### Phase Commands
```bash
/phase1 [requirement]  # Start requirements
/phase2                # Start planning
/phase3                # Start implementation
/phase4                # Start verification
/phase5                # Start master control
```

### Specialist Consultations
```bash
@security [question]      # Security expert
@ux [question]           # UX expert
@performance [question]  # Performance expert
@devops [question]       # DevOps expert
@qa [question]           # QA expert
@docs [question]         # Documentation expert
@ethics [question]       # Ethics expert
```

### Utility Commands
```bash
/status       # Show project status
/checkpoint   # Save progress
/help         # Show help
/exit         # Exit OpenCode
Tab           # Switch between agents
```

## What You Just Did

✅ Installed OpenCode
✅ Initialized CodePilot
✅ Authenticated with AI provider
✅ Created requirements specification
✅ Designed technical architecture
✅ Ready to implement!

## Common First-Time Issues

### "Command not found: opencode"

**Solution:**
```bash
# Check npm global path
npm config get prefix

# Add to PATH
export PATH="$PATH:$(npm config get prefix)/bin"

# Or reinstall
npm install -g @opencode/cli
```

### "Agent not loading"

**Solution:**
```bash
# Verify prompt files exist
ls -la docs/prompts/

# Check opencode.json is valid
cat opencode.json | jq .

# Restart OpenCode
```

### "Authentication failed"

**Solution:**
```bash
# Re-authenticate
opencode auth logout
opencode auth login

# Verify API key is correct
```

## Next Steps

### Try a Simple Project
```bash
opencode --agent requirements
> "Build a simple todo list app with create, read, update, delete"
```

### Try Consulting Specialists
```bash
opencode --agent requirements
> "Build a user dashboard"
> "@ux What accessibility features should we include?"
```

### Try a Complex Project
```bash
opencode --agent master
> "Build a complete e-commerce platform with products, cart, checkout, and admin panel"
```

## Tips for Success

1. **Be Specific** - The more detail you provide, the better the output
2. **Ask Questions** - Agents will ask clarifying questions - answer them!
3. **Use Specialists** - Don't try to do everything yourself
4. **Trust the Process** - Let each phase complete before moving on
5. **Review Artifacts** - Check `docs/artifacts/` to see what was created

## Learning Resources

- **README.md** - Complete documentation
- **docs/AGENTS.md** - Project context and agent guide
- **docs/core/00-core.md** - Core system configuration
- **OpenCode Docs** - https://opencode.ai/docs

## Example Session

Here's what a complete simple feature looks like:

```bash
# Phase 1: Requirements
opencode --agent requirements
> "Build password reset feature for existing auth system"
[Agent creates requirements]
✅ Phase 1 complete (5 minutes)

# Phase 2: Planning  
opencode --agent architect --mode new
> [Provide handoff] "Design password reset system"
[Agent creates technical design]
✅ Phase 2 complete (5 minutes)

# Phase 3: Implementation
opencode --agent engineer --mode new
> [Provide handoff] "Implement password reset"
> "@security Review password reset security"
[Agent implements with security input]
✅ Phase 3 complete (15 minutes)

# Phase 4: Verification
opencode --agent verifier --mode new
> [Provide handoff] "Test password reset feature"
[Agent tests and validates]
✅ Phase 4 complete (10 minutes)

# Total: 35 minutes from idea to tested feature!
```

## Get Help

- Something not working? Check **README.md** troubleshooting section
- Want to customize? See **README.md** customization section
- Need inspiration? Try the examples above

---

**You're ready to build!** 🎉

Start with: `opencode --agent requirements "Build a [your idea]"`
