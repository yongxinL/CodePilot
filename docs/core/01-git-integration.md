# Git Integration - CodePilot v2.0

**Version Control Integration for Phase Completion and Task Tracking**

## Overview

CodePilot v2.0 integrates with Git for version control at phase boundaries and task completion.

**Tiers**:
- **Minimal**: No git integration
- **Core+**: Manual mode (agent provides commands)
- **Advanced+**: Automatic mode (agent executes commands)
- **Full**: Automatic + per-task commits

## Configuration

In `.codepilot.config.json`:

```json
{
  "git_integration": {
    "enabled": true,                     // Enable git integration
    "mode": "manual",                     // "manual" | "automatic"
    "commit_on_phase_complete": true,    // Commit at phase end
    "commit_per_task": false,             // Core+: no, Advanced+: yes
    "tag_format": "phase{N}-complete",   // Tag naming
    "commit_message_template": "Phase {N} complete: {description}",
    "branch_per_phase": false             // Use same branch
  }
}
```

## Manual Mode (Core+ Tier)

**Philosophy**: Agent provides commands, user executes manually

**Benefits**:
- User has full control
- Can review before committing
- No accidental commits
- Token efficient (+200 tokens per phase)

**Workflow - Phase Completion**:
```
Agent: "✅ Phase 1 Complete!

Created artifacts:
- requirements-spec.md v1.0 (LOCKED)
- locked-specification.md
- user-stories.md
- skill-assessment.md

To commit to version control:

```bash
git add docs/artifacts/phase1-requirements/
git commit -m 'Phase 1 complete: Requirements specification v1.0 locked'
git tag phase1-complete
git push origin main --tags
```

Have you committed these files? [Y/n]"

[User executes commands]

User: "Y"

Agent: "Great! Proceeding to Phase 2 handoff..."
```

**Token Cost**: ~200 tokens (generate commands in message)

## Automatic Mode (Advanced+ Tier)

**Philosophy**: Agent executes git commands automatically via bash_tool

**Benefits**:
- Fully automated
- No user action needed
- Consistent commits
- Audit trail automatic

**Workflow - Phase Completion**:
```
Agent: "✅ Phase 1 Complete!

Committing to version control...

Executing:
```bash
git add docs/artifacts/phase1-requirements/
git commit -m 'Phase 1 complete: Requirements specification v1.0 locked'
git tag phase1-complete
git push origin main --tags
```

✅ Commit created: abc123f
✅ Tag created: phase1-complete  
✅ Pushed to origin/main

Artifacts committed:
- requirements-spec.md v1.0 (LOCKED)
- locked-specification.md
- user-stories.md
- skill-assessment.md

Proceeding to Phase 2 handoff..."
```

**Token Cost**: ~500 tokens (bash_tool execution + verification)

## Per-Task Commits (Advanced+ Tier)

**When**: `config.git_integration.commit_per_task: true`

**Purpose**: Atomic commits for granular history

**Workflow - Task Completion**:
```
engineer agent: "✅ Task 003: User authentication complete

Implementation:
- User registration endpoint
- Login endpoint
- Password reset flow
- JWT token generation
- Auth middleware
- 15 unit tests (all passing, 94% coverage)

Committing task...

Executing:
```bash
git add src/auth/ tests/auth/
git commit -m 'feat: implement user authentication (TASK-003)

- Add registration and login endpoints
- Implement JWT token generation
- Add password reset flow
- Include auth middleware
- Add 15 unit tests (94% coverage)

Closes TASK-003'
git push origin main
```

✅ Commit: def456g
✅ Pushed to origin/main

Task 003 committed. Moving to Task 004: API endpoints..."
```

**Commit Message Format**:
```
feat: {description} (TASK-{NNN})

{detailed changes}

Closes TASK-{NNN}
```

## Commit Message Conventions

### Phase Completion Commits
```
Phase {N} complete: {description}

{what was accomplished}
{key deliverables}
```

**Examples**:
- `Phase 1 complete: Requirements specification v1.0 locked`
- `Phase 2 complete: Technical design for task management API`
- `Phase 3 complete: Implementation with 89% test coverage`

### Task Completion Commits (Advanced+ Tier)
```
{type}: {description} (TASK-{NNN})

{detailed changes}

Closes TASK-{NNN}
```

**Types**: feat, fix, docs, test, refactor, chore

**Examples**:
- `feat: implement user authentication (TASK-003)`
- `fix: resolve password reset email bug (TASK-015)`
- `test: add integration tests for API (TASK-020)`

## Tag Format

**Phase Tags**:
```
phase{N}-complete
```

**Examples**:
- `phase1-complete` - Requirements done
- `phase2-complete` - Planning done
- `phase3-complete` - Implementation done
- `phase4-complete` - Verification done
- `phase5-complete` - Master control done

**Version Tags** (when releasing):
```
v{MAJOR}.{MINOR}.{PATCH}
```

**Examples**:
- `v1.0.0` - First release
- `v1.1.0` - Feature added
- `v1.1.1` - Bug fix

## Branch Strategy

### Single Branch (Default)
All phases work on `main` branch
- Simple and straightforward
- Works for most projects

### Branch Per Phase (Optional)
```json
{
  "git_integration": {
    "branch_per_phase": true
  }
}
```

Creates branches:
- `phase1-requirements`
- `phase2-planning`
- `phase3-implementation`
- Merge to main after phase complete

## Implementation in Agent Prompts

### Add to Phase Completion Section

```markdown
## Phase Completion - Git Integration

**Check configuration**:
```javascript
config = read(".codepilot.config.json");
git_enabled = config.git_integration.enabled;
git_mode = config.git_integration.mode;  // "manual" | "automatic"
```

**If git_enabled && mode === "manual"**:
```
After verifying deliverables:

1. Generate git commands:
   ```bash
   git add docs/artifacts/phase{N}-{name}/
   git commit -m '{commit_message}'
   git tag {tag_name}
   git push origin main --tags
   ```

2. Present to user:
   "To commit to version control:
   [commands]
   
   Have you committed? [Y/n]"

3. Wait for confirmation

4. Continue with handoff
```

**If git_enabled && mode === "automatic"**:
```
After verifying deliverables:

1. Inform user: "Committing to version control..."

2. Execute via bash_tool:
   - git add [files]
   - git commit -m [message]
   - git tag [tag]
   - git push

3. Verify success

4. Report to user:
   "✅ Commit: [hash]
   ✅ Tag: [tag]
   ✅ Pushed to origin/main"

5. Continue with handoff
```
```

## Error Handling

### Git Command Failures (Automatic Mode)

```javascript
try {
  result = bash_tool("git commit -m 'message'");
  if (result.exit_code === 0) {
    success();
  } else {
    handle_git_error(result.stderr);
  }
} catch (error) {
  // Git not available or other error
  inform_user("⚠️  Git commit failed: " + error.message);
  ask_user("Continue without committing? [Y/n]");
}
```

### Common Issues

**Not a git repository**:
```
⚠️  Git repository not initialized

To initialize:
```bash
git init
git add .
git commit -m 'Initial commit: CodePilot project'
```

Shall I continue without git integration? [Y/n]
```

**No remote configured**:
```
⚠️  No git remote configured

To add remote:
```bash
git remote add origin https://github.com/user/repo.git
git push -u origin main
```

Continuing without push (local commits only)
```

**Merge conflicts**:
```
⚠️  Git push failed: merge conflict

Please resolve conflicts:
```bash
git pull origin main
# Resolve conflicts
git commit
git push origin main
```

Then say "Git resolved" to continue.
```

## Best Practices

### When to Commit
✅ **DO commit**:
- Phase completion
- Task completion (if enabled)
- After major milestones
- Before risky changes
- Specification locking

❌ **DON'T commit**:
- Mid-task (incomplete work)
- Broken code
- Failing tests
- Temporary files

### Commit Messages
✅ **Good messages**:
- Clear and descriptive
- Reference task IDs
- Explain what and why
- Follow conventions

❌ **Bad messages**:
- "updates"
- "fixed stuff"
- "asdf"
- No description

### Tag Usage
- Tag all phase completions
- Tag all releases
- Tag major milestones
- Keep tag names consistent

## Token Efficiency

### Manual Mode (Core+)
```
Per phase: ~200 tokens (generate commands)
5 phases: 1,000 tokens total
User execution: 0 tokens
```

### Automatic Mode (Advanced+)
```
Per phase: ~500 tokens (bash_tool + verification)
Per task: ~100 tokens (if per-task commits enabled)
5 phases + 20 tasks: 2,500 + 2,000 = 4,500 tokens
```

**Trade-off**: Automatic uses 3,500 more tokens but saves user time

## Integration with Locked Specifications

When locking specification (Core+ tier):

```bash
git add docs/artifacts/phase1-requirements/locked-specification.md
git commit -m 'Lock requirements specification v1.0

- Baseline requirements established
- Stakeholder approval received
- Changes now require change control

Locked artifacts:
- requirements-spec.md v1.0
- locked-specification.md v1.0'

git tag requirements-locked-v1.0
```

This creates permanent record of approved requirements.

## Troubleshooting

**Git not found**: Install git or disable integration
**Permission denied**: Configure SSH keys or use HTTPS
**Remote rejected**: Check credentials and permissions
**Merge conflicts**: Resolve manually, agent cannot auto-resolve

---

**For implementation in phase prompts, see individual phase prompt files.**
