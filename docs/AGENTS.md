# CodePilot Project Context

## Project Overview

This project uses **CodePilot**, a role-based automated development system with 5 specialized phases:

1. **Requirements Analysis** (requirements agent)
2. **Planning & Architecture** (architect agent)
3. **Implementation** (engineer agent)
4. **Verification & Release** (verifier agent)
5. **Master Control** (master agent)

## Agent Usage Guidelines

### Primary Agents (Switch with Tab or /phase commands)

**requirements** - Start here for new features
- Deconstruct and analyze requirements
- Create comprehensive specifications
- Generate user stories with acceptance criteria
- Output: Requirements documents in `docs/artifacts/phase1-requirements/`

**architect** - Design technical solutions
- Design system architecture
- Create technical specifications
- Develop implementation plans
- Output: Technical designs in `docs/artifacts/phase2-planning/`

**engineer** - Implement features
- Write clean, tested code
- Follow best practices
- Create comprehensive tests
- Output: Code and documentation in `docs/artifacts/phase3-implementation/`

**verifier** - Test and validate
- Execute comprehensive testing
- Verify quality standards
- Prepare release documentation
- Output: Test reports and release docs in `docs/artifacts/phase4-verification/`

**master** - Orchestrate complex projects
- Coordinate multi-phase work
- Manage project lifecycle
- Track quality and metrics
- Output: Project plans and status reports in `docs/artifacts/phase5-master/`

### Supporting Subagents (Invoke with @mention)

Specialist consultants available to all primary agents:

**@security** - Security assessment and recommendations
- Review code for vulnerabilities
- Assess architecture security
- Design security testing
- Provide security guidance

**@ux** - User experience and accessibility
- Evaluate usability
- Assess accessibility (WCAG compliance)
- Review user flows
- Provide UX recommendations

**@performance** - Performance optimization
- Optimize algorithms and queries
- Design load tests
- Review scalability
- Provide performance guidance

**@devops** - Deployment and infrastructure
- Review deployment procedures
- Design CI/CD pipelines
- Assess infrastructure
- Provide operational guidance

**@qa** - Testing strategy and quality
- Design test strategies
- Review test coverage
- Prioritize bugs
- Provide QA guidance

**@docs** - Documentation quality
- Review documentation clarity
- Assess completeness
- Improve structure
- Provide writing guidance

**@ethics** - Ethical implications
- Assess privacy concerns
- Review fairness and bias
- Evaluate inclusivity
- Provide ethical guidance

## Workflow Pattern

### Simple Feature (Single Pass)
```
1. /phase1 "Your requirement"
2. Complete Phase 1
3. /phase2
4. Complete Phase 2
5. /phase3
6. Complete Phase 3
7. /phase4
8. Done!
```

### Complex Project (Multi-Phase)
```
1. /phase5 "Complex project with multiple features"
2. Master orchestrates phases
3. Follow guided workflow through all phases
4. Coordinate multiple feature sequences
```

### Consulting Specialists
```
In any phase:
> "@security Review authentication approach"
> "@performance Optimize this query"
> "@ux Evaluate this user flow"
```

## File Organization

All artifacts organized by phase:

```
docs/artifacts/
├── phase1-requirements/
│   ├── requirements-spec.md
│   ├── user-stories.md
│   └── questions-and-answers.md
├── phase2-planning/
│   ├── technical-design.md
│   ├── architecture-diagram.md
│   └── implementation-plan.md
├── phase3-implementation/
│   ├── implementation-summary.md
│   ├── code-structure.md
│   └── api-documentation.md
├── phase4-verification/
│   ├── test-report.md
│   ├── release-notes.md
│   └── deployment-guide.md
└── phase5-master/
    ├── project-plan.md
    └── status-report.md
```

## Session Management

**Within Phase:**
- Continue working: Just keep chatting
- Long tasks: Agent will suggest `/checkpoint`
- Session gets large: Agent suggests `compact` mode

**Phase Transitions:**
- Agent completes phase and provides handoff instructions
- Start new session with next agent using `--mode new`
- Provide handoff context to new agent

## Quality Standards

All phases maintain:
- ✅ Comprehensive documentation
- ✅ Clear deliverables
- ✅ Appropriate specialist consultation
- ✅ Quality gates before proceeding

## Getting Started

### First Time
```bash
opencode --agent requirements
> "Build a [your project idea]"
```

### Continuing Work
```bash
opencode --agent [phase-you're-on]
> "Continue from where we left off"
```

### Need Help
```bash
> "/status" - Show project status
> "/help" - Show available commands
```

## Tips

- Start with `requirements` for new projects
- Use `master` for complex multi-feature projects
- Consult specialists (@security, @ux, etc.) proactively
- Let agents guide phase transitions
- Save important decisions in knowledge base
- Trust the process - each phase builds on previous

## Project-Specific Notes

Add your project-specific information here:
- Technology stack
- Team conventions
- Special requirements
- Known constraints
