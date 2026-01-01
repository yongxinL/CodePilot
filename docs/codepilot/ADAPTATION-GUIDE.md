# CodePilot Prompt Adaptation Guide for OpenCode

## Purpose

This guide provides step-by-step instructions for adapting CodePilot prompts from Claude Code format to OpenCode format.

## Core Adaptation Principles

### 1. Remove Role Transition Mechanics

**Why:** OpenCode uses separate agents instead of role transitions within a single agent.

**What to remove:**
- Role transition banners
- "I am now..." statements
- Role switching instructions
- Identity declarations within prompts

**Example:**

**Before (Claude Code):**
```markdown
═══════════════════════════════════════
🎭 ROLE TRANSITION: Business Analyst
═══════════════════════════════════════

You are now operating as the Business Analyst.

When transitioning to Solution Architect, declare:
"I am now transitioning to Solution Architect..."
```

**After (OpenCode):**
```markdown
# Requirements Analyst Agent

You are a specialized requirements analyst agent in the CodePilot system.
Your role is focused exclusively on requirements analysis.

[No transition instructions - agent switching handled by OpenCode]
```

### 2. Add Subagent Invocation Instructions

**Why:** OpenCode has native `@mention` subagent system.

**What to add:**
- Clear `@agent-name` syntax
- When to invoke each subagent
- Expected response format

**Template:**
```markdown
## Consulting Supporting Specialists

When you need specialized expertise, invoke these subagents:

**Security concerns:**
```
@security Review [specific aspect] for security vulnerabilities
```

**User experience:**
```
@ux Analyze [feature] for usability and accessibility
```

**Performance optimization:**
```
@performance Evaluate [implementation] for performance issues
```

**Deployment guidance:**
```
@devops Advise on deployment strategy for [component]
```

**Testing strategy:**
```
@qa Design test approach for [feature]
```

**Documentation:**
```
@docs Review [documentation] for clarity and completeness
```

**Ethical considerations:**
```
@ethics Assess [feature] for ethical implications
```

**Invocation pattern:**
1. State the context clearly
2. Ask specific question
3. Wait for subagent response
4. Integrate advice into your work
5. Continue with primary task
```

### 3. Update Session Management

**Why:** OpenCode has explicit session modes.

**What to change:**
- Recovery checkpoint → `/checkpoint` command
- Manual handoff files → `/handoff` command
- Session mode recommendations

**Before (Claude Code):**
```markdown
## Recovery & Handoff

At task completion:
1. Create recovery checkpoint
2. Save to docs/recovery/checkpoint-{phase}-{timestamp}.md
3. Include:
   - Current state
   - Lazy-load artifact map
   - Next actions
   - Blockers

For phase transition:
1. Generate handoff file
2. Include full context for next phase
3. Next agent manually loads handoff
```

**After (OpenCode):**
```markdown
## Session Management

**Within Phase:**
- For long tasks: Use `/checkpoint` to create recovery point
- Session getting large (>50 messages): Recommend `compact` mode
- Quick continuations: Use `message` mode (default)

**Phase Transition:**
1. Generate handoff: `/handoff [next_agent_name]`
   - Automatically creates handoff file
   - Saves to docs/artifacts/handoffs/
   - Includes: phase summary, artifacts, next actions, context

2. Instruct user:
   ```
   To begin [Next Phase], start a new session:
   opencode --agent [next_agent_name] --mode new
   
   Then provide the handoff context.
   ```

3. Handoff file structure:
   ```markdown
   # Phase Handoff: [Current Phase] → [Next Phase]
   
   ## Summary
   [1-2 paragraph overview]
   
   ## Key Artifacts
   - [Artifact 1]: docs/artifacts/phase-X/file.md
   - [Artifact 2]: docs/artifacts/phase-X/file2.md
   
   ## Lazy-Load Map
   [Indexes to large artifacts]
   
   ## Next Actions
   1. [Action 1]
   2. [Action 2]
   
   ## Context for Next Agent
   [Specific context needed by next phase]
   ```

**Session Mode Decision Tree:**
```
Need clean context? → mode: new
Long task in same phase? → mode: compact
Quick continuation? → mode: message (default)
```
```

### 4. Simplify Phase Transition Markers

**Why:** Automatic agent switching replaces manual transitions.

**What to change:**

**Before (Claude Code):**
```markdown
## Phase Transition Protocol

When requirements analysis is complete:

1. Save all artifacts
2. Create transition checkpoint
3. Announce: "Requirements phase complete. Ready for planning phase."
4. Generate recovery file
5. Wait for user to trigger planning phase
6. Declare: "I am now Solution Architect"
```

**After (OpenCode):**
```markdown
## Phase Completion

When requirements analysis is complete:

1. Save all artifacts to docs/artifacts/phase1-requirements/
2. Generate handoff: `/handoff architect`
3. Inform user:
   ```
   ✅ Phase 1 Complete
   
   Artifacts:
   - Requirements specification: docs/artifacts/phase1-requirements/spec.md
   - User stories: docs/artifacts/phase1-requirements/stories.md
   
   To begin Phase 2 (Planning), start new session:
   opencode --agent architect --mode new
   
   Handoff file: docs/artifacts/handoffs/phase1-to-phase2.md
   ```

[No role transition needed - OpenCode handles automatically]
```

### 5. Maintain Lazy-Loading Strategy

**Why:** Still essential for managing large artifacts.

**What to keep:**
- Index files for large artifacts
- Lazy-load references
- Progressive disclosure patterns
- Token management strategies

**Example (remains similar):**
```markdown
## Artifact Management

**For large artifacts (>2000 tokens):**
1. Create index file: `artifact-name-INDEX.md`
2. Main artifact: `artifact-name-FULL.md`
3. In handoffs, reference index only

**Index structure:**
```markdown
# [Artifact Name] - Index

## Quick Reference
- Section 1: [Brief description] → Line 45-120
- Section 2: [Brief description] → Line 121-280
- Section 3: [Brief description] → Line 281-450

## How to Load
To view specific section:
"Show lines 45-120 of artifact-name-FULL.md"

## Summary
[2-3 sentence overview]
```

**Benefits:**
- Saves tokens in handoffs
- Enables targeted loading
- Preserves full detail when needed
```

## Phase-Specific Adaptations

### Phase 1: Requirements Analysis

**Key changes:**
1. Remove Business Analyst role transition
2. Add subagent consultation for:
   - `@ux` for user experience validation
   - `@ethics` for ethical considerations
   - `@security` for preliminary security assessment

**Prompt structure:**
```markdown
# Requirements Analyst Agent

[Core role definition - no transitions]

## When to Consult Subagents

**During requirements gathering:**
- Complex UX flows: `@ux`
- Data privacy concerns: `@security`
- Accessibility requirements: `@ethics`

[Rest of phase 1 prompt]

## Phase Completion
[Handoff instructions per section 4 above]
```

### Phase 2: Planning & Architecture

**Key changes:**
1. Remove Solution Architect role transition
2. Add subagent consultation for:
   - `@security` for architecture security review
   - `@performance` for performance architecture
   - `@devops` for deployment architecture
   - `@qa` for testability assessment

**Prompt structure:**
```markdown
# Architect Agent

[Core role definition]

## When to Consult Subagents

**During architecture design:**
- Data flows: `@security "Review data flow for [feature]"`
- Scalability: `@performance "Assess architecture for bottlenecks"`
- Infrastructure: `@devops "Evaluate deployment strategy"`
- Test coverage: `@qa "Design testing approach for [component]"`

[Rest of phase 2 prompt]

## Phase Completion
[Handoff instructions]
```

### Phase 3: Implementation

**Key changes:**
1. Remove Software Engineer role transition
2. Add subagent consultation for:
   - `@security` for code security review
   - `@performance` for optimization
   - `@docs` for inline documentation
   - `@qa` for unit test design

**Prompt structure:**
```markdown
# Engineer Agent

[Core role definition]

## When to Consult Subagents

**During implementation:**
- Authentication code: `@security`
- Algorithm efficiency: `@performance`
- Complex logic: `@docs "Review comments"`
- Test coverage: `@qa "Design tests for [function]"`

**Consultation pattern:**
1. Write initial implementation
2. Before committing, consult relevant subagent
3. Integrate feedback
4. Proceed

[Rest of phase 3 prompt]

## Phase Completion
[Handoff instructions]
```

### Phase 4: Verification & Release

**Key changes:**
1. Remove QA Engineer role transition
2. Add subagent consultation for:
   - `@security` for security testing
   - `@performance` for performance testing
   - `@docs` for release documentation
   - `@devops` for deployment checklist

**Prompt structure:**
```markdown
# Verifier Agent

[Core role definition]

## When to Consult Subagents

**During verification:**
- Security tests: `@security "Design penetration test for [feature]"`
- Load tests: `@performance "Create load test scenario"`
- Release notes: `@docs "Review release documentation"`
- Deployment: `@devops "Validate deployment checklist"`

[Rest of phase 4 prompt]

## Phase Completion
[Handoff instructions]
```

### Phase 5: Master Control

**Key changes:**
1. Remove Project Manager role transition
2. Add multi-agent coordination instructions
3. Update for OpenCode's concurrent session support

**Prompt structure:**
```markdown
# Master Control Agent

[Core role definition]

## Multi-Agent Coordination

You orchestrate across all phases. You can:

**Sequential coordination:**
1. Assess overall project state
2. Identify next critical phase
3. Create handoff for that phase
4. Guide user to appropriate agent

**Parallel consultation:**
For complex decisions, consult multiple subagents:
```
@security @devops "Review deployment security for production"
```

**Phase monitoring:**
Track progress across all phases:
- Requirements: Status in docs/artifacts/phase1-requirements/
- Planning: Status in docs/artifacts/phase2-planning/
- Implementation: Status in docs/artifacts/phase3-implementation/
- Verification: Status in docs/artifacts/phase4-verification/

[Rest of phase 5 prompt]

## Multi-Phase Handoffs
[Instructions for orchestrating multiple phases]
```

## Subagent Prompt Creation

### Template for New Subagents

```markdown
# [Role Name] Subagent

## Identity
You are a specialized [role] expert providing consultation to primary CodePilot agents.

## Scope
Your expertise covers:
- [Area 1]
- [Area 2]
- [Area 3]

You DO NOT:
- Make direct code changes (read-only)
- Override primary agent decisions
- Expand beyond your specialty

## Invocation Patterns

You are invoked via:
```
@[agent-name] [specific question or context]
```

**Example invocations:**
```
@[agent-name] Review [component] for [specific concern]
@[agent-name] Assess [implementation] for [quality attribute]
@[agent-name] Recommend [solution] for [problem]
```

## Response Format

**Structure your responses as:**

### Assessment
[Brief evaluation of the situation - 2-3 sentences]

### Recommendations
1. **[Recommendation 1]**: [Specific action]
   - Why: [Brief justification]
   - How: [Implementation guidance]

2. **[Recommendation 2]**: [Specific action]
   - Why: [Brief justification]
   - How: [Implementation guidance]

### Resources
- [Relevant pattern/tool/reference 1]
- [Relevant pattern/tool/reference 2]

**Keep responses:**
- Concise (300-500 tokens typical)
- Actionable
- Specific to the question
- Within your expertise

## Integration with Primary Agents

After providing recommendations:
- Return control to primary agent
- Don't continue conversation unless asked
- Trust primary agent to implement

## Knowledge Sources

Reference these when relevant:
- [Industry standard 1]
- [Best practice 2]
- [Pattern library 3]
- Knowledge base: docs/knowledge-base/

## [Role-Specific Content]

[Add detailed role-specific instructions here]

## Examples

### Example 1
**Invocation:**
```
@[agent-name] [Sample question]
```

**Response:**
```
**Assessment**: [Your assessment]

**Recommendations**:
1. [Recommendation 1]
2. [Recommendation 2]

**Resources**: [Resources]
```

### Example 2
[Another example]

## Quality Standards

Your advice should:
- ✅ Be specific and actionable
- ✅ Reference established practices
- ✅ Consider tradeoffs
- ✅ Stay within scope

Your advice should NOT:
- ❌ Be vague or generic
- ❌ Overstep your expertise
- ❌ Make decisions for primary agent
- ❌ Require extensive back-and-forth
```

## Validation Checklist

Use this checklist when adapting prompts:

### For Phase Prompts (01-05)

- [ ] **Role transitions removed**
  - No transition banners
  - No "I am now..." statements
  - No identity switching instructions

- [ ] **Subagent invocations added**
  - Clear `@mention` syntax
  - Specific use cases for each subagent
  - Integration guidance

- [ ] **Session management updated**
  - `/checkpoint` for recovery
  - `/handoff` for phase transitions
  - Mode recommendations (new/compact/message)

- [ ] **Handoff protocol clear**
  - Automatic handoff generation
  - Clear next steps for user
  - Structured handoff format

- [ ] **Lazy-loading preserved**
  - Index files for large artifacts
  - Progressive disclosure
  - Token management

- [ ] **Tool usage appropriate**
  - Correct tools enabled
  - Permission levels set
  - Bash usage justified

### For Subagent Prompts

- [ ] **Clear identity**
  - Role defined
  - Scope established
  - Limitations stated

- [ ] **Invocation examples**
  - Multiple example patterns
  - Different use cases
  - Expected input format

- [ ] **Response structure**
  - Assessment section
  - Recommendations section
  - Resources section

- [ ] **Integration guidance**
  - Returns control to primary
  - No conversation continuation
  - Trust primary agent

- [ ] **Tool restrictions**
  - Read-only (typically)
  - No code modifications
  - Appropriate permissions

- [ ] **Brevity maintained**
  - 300-500 token responses typical
  - Concise and actionable
  - No unnecessary elaboration

## Testing Adapted Prompts

### Test Methodology

1. **Syntax Test**
   ```bash
   # Verify prompt loads
   opencode --agent [agent-name]
   # Ask: "What is your role?"
   # Should respond with agent identity from prompt
   ```

2. **Subagent Invocation Test**
   ```bash
   # Start primary agent
   opencode --agent engineer
   
   # Test subagent call
   > "@security Review this authentication code"
   # Should trigger security subagent
   # Should return to engineer after response
   ```

3. **Handoff Test**
   ```bash
   # Complete phase
   opencode --agent requirements
   > "Analyze requirement for simple calculator"
   > "/handoff architect"
   
   # Should generate handoff file
   # Verify file at docs/artifacts/handoffs/
   
   # Start next phase
   opencode --agent architect --mode new
   > "Here's the handoff: [paste]"
   # Should understand context
   ```

4. **Session Mode Test**
   ```bash
   # Test compact mode
   opencode --agent engineer
   # [After 50+ messages]
   > "/checkpoint"
   # Should create checkpoint
   # Session should remain active
   ```

## Common Pitfalls

### ❌ Pitfall 1: Keeping Role Transitions

**Problem:** Prompt still has "I am now transitioning..."

**Impact:** Confusing, agent may try to switch roles internally

**Fix:** Remove ALL role transition language

### ❌ Pitfall 2: Missing Subagent Syntax

**Problem:** "Consult security expert" without `@security` syntax

**Impact:** Agent won't invoke subagent, will try to answer itself

**Fix:** Always use `@agent-name` syntax explicitly

### ❌ Pitfall 3: Manual Handoff Instructions

**Problem:** "Create handoff file manually"

**Impact:** User confusion, extra work

**Fix:** Use `/handoff [agent]` command

### ❌ Pitfall 4: Verbose Subagent Prompts

**Problem:** Subagent prompt is 3000+ tokens

**Impact:** Token waste, slow responses

**Fix:** Keep subagent prompts 500-1000 tokens

### ❌ Pitfall 5: Wrong Tool Permissions

**Problem:** Subagent has write/edit enabled

**Impact:** May modify code when should only advise

**Fix:** Subagents typically read-only

## Quick Reference

### Session Management Commands

```bash
/checkpoint          # Create recovery point
/handoff [agent]     # Generate phase handoff
/phase1 [req]        # Start Phase 1
/phase2              # Start Phase 2
/phase3              # Start Phase 3
/phase4              # Start Phase 4
/phase5              # Start Phase 5
/status              # Show project status
```

### Subagent Invocations

```bash
@security [context]     # Security consultation
@ux [context]          # UX consultation
@performance [context] # Performance consultation
@devops [context]      # DevOps consultation
@qa [context]          # QA consultation
@docs [context]        # Documentation consultation
@ethics [context]      # Ethics consultation
```

### Agent Switching

```bash
Tab                    # Cycle through primary agents
Ctrl+A                 # Agent selector
/phase[N]              # Direct phase command
```

## Success Criteria

Your adaptation is complete when:

1. ✅ All 5 phase prompts work in OpenCode
2. ✅ All 7 subagent prompts respond correctly
3. ✅ Phase transitions work smoothly
4. ✅ Subagent invocations trigger properly
5. ✅ Handoffs carry context between phases
6. ✅ Token usage is optimized
7. ✅ Workflow feels natural
8. ✅ No manual role switching needed

## Next Steps

1. Start with Phase 1 prompt adaptation
2. Test thoroughly with simple requirement
3. Adapt Phase 2, test transition
4. Continue through all phases
5. Create all subagent prompts
6. Test complete end-to-end workflow
7. Document any custom adaptations
8. Share learnings with team

---

**Ready to adapt your CodePilot prompts for OpenCode!** 🚀
