# Specification Resolutions - CodePilot v2.0

**Tier**: Core+
**Phase**: 2 (Planning)
**Feature #**: 1

## Purpose

Bridge any unclear items from Phase 1 requirements into concrete technical decisions. This feature ensures ambiguities are resolved before implementation starts.

## When to Use

After reviewing locked-specification.md from Phase 1, use this feature to document technical interpretations of any unclear or conflicting requirements.

## Workflow

1. Review `docs/artifacts/phase1-requirements/locked-specification.md`
2. Identify ambiguities, undefined terms, or unclear requirements
3. Make technical interpretations and decisions
4. Document each resolution with rationale
5. Document impact on architecture and implementation

## Configuration Check

```javascript
config = read(".codepilot.config.json");
if (config.feature_tier >= "core_plus") {
  create_specification_resolutions();
} else {
  skip_this_feature();
}
```

## Create Artifact

**File**: `docs/artifacts/phase2-planning/specification-resolutions.md`

**Template**: `docs/templates/phase2/specification-resolutions.md`

## Format

```markdown
# Specification Resolutions

**Phase**: 2 (Planning)
**Date**: YYYY-MM-DD
**Resolved By**: Architect Agent

## Ambiguity 1: "Real-time updates"

**Original Requirement**: "System should provide real-time updates"

**Ambiguity**: What constitutes "real-time"? Immediate (WebSockets) or near-real-time (polling)?

**Resolution**: WebSockets for true real-time (<100ms latency)

**Rationale**:
- User collaboration requires immediate visibility
- WebSockets provide better UX than polling
- Team has capacity to implement
- Slightly more complex but worthwhile

**Impact on Design**:
- Need WebSocket server
- Need connection management
- Need reconnection handling
- Estimated +40% implementation time for real-time features

---

## Ambiguity 2: "User permissions"

**Original Requirement**: "Role-based permissions"

**Ambiguity**: What specific roles and permissions needed?

**Resolution**: 3 roles defined:
- Admin: Full access (create/edit/delete anything)
- Member: Create own, edit assigned, view all
- Viewer: Read-only access

**Rationale**:
- Covers stated needs (small teams)
- Simple enough for mid-level team
- Can expand later if needed

**Impact on Design**:
- Need role enum in database
- Need permission middleware
- Need role assignment UI

---

## Summary

**Total Ambiguities Resolved**: [N]
**Architecture Impact**: [Low/Medium/High]
**Implementation Impact**: [Low/Medium/High]
**Approved**: [Yes/No]
```

## Example Ambiguities to Resolve

Common ambiguities found in requirements:

- **Performance**: "Fast response" → Define specific latency (e.g., <200ms p95)
- **Scale**: "Handle many users" → Define exact number (e.g., 10K concurrent)
- **Real-time**: "Live updates" → Define latency requirement (e.g., <100ms)
- **Permissions**: "Role-based access" → Define specific roles and permissions
- **Data**: "Unlimited storage" → Define retention policy and limits
- **Security**: "Secure system" → Define specific requirements (encryption, MFA, etc.)
- **UI**: "User-friendly" → Define accessibility standards (WCAG AA)

## Token Cost

**Creation**: ~300 tokens
**Update**: ~150 tokens per ambiguity

## Related Features

- [Goal Extraction](goal-extraction.md) - Extract technical goals after resolving ambiguities
- [Design Principles Checklist](design-principles-checklist.md) - Validate resulting design

## Integration with Planning Phase

This step occurs **after Step 1 (Review Requirements)** in the planning workflow:

```
Step 1: Review locked-specification.md
  ↓
Step 1.5: Resolve Specification Ambiguities (THIS FEATURE)
  ↓
Step 1.6: Extract Goals from One-Line Requirement
  ↓
Step 2: Design System Architecture
```

## Why This Matters

Prevents:
- ❌ Implementation confusion (unclear requirements)
- ❌ Scope creep (undefined boundaries)
- ❌ Rework (misaligned technical decisions)
- ❌ Team debate (explicit decisions documented)

Enables:
- ✅ Clear technical direction
- ✅ Aligned team understanding
- ✅ Measurable success criteria
- ✅ Design validation
