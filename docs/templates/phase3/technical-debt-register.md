# Technical Debt Register

**Project**: [Project Name]  
**Last Updated**: [YYYY-MM-DD]  
**Maintained By**: Engineering Team  
**Total Items**: [Number]

---

## Purpose

Track shortcuts, deferred work, TODOs, and known limitations that need future attention.

---

## High Priority Debt

### DEBT-[NNN]: [Title]

**Category**: [Security | Performance | Maintainability | Code Quality | Documentation]  
**Severity**: High  
**Incurred**: [YYYY-MM-DD] (Phase [N], Task [NNN])  
**Incurred By**: [Engineer agent | Manual addition]

**Description**:
[Detailed description of the technical debt - what was done and why it's problematic]

**Rationale for Incurring Debt**:
- [Reason 1] - e.g., "Time pressure to meet sprint deadline"
- [Reason 2] - e.g., "Low immediate risk, high fix cost"
- [Reason 3] - e.g., "Waiting for library update"

**Impact if Unaddressed**:
- [Impact 1] - e.g., "Security vulnerability exploitable"
- [Impact 2] - e.g., "Performance degrades with scale"
- [Risk Level]: [High | Medium | Low]

**Remediation Plan**:
[Detailed plan for fixing this debt]

**Code/Implementation**:
```[language]
// Current (problematic):
[Current code or approach]

// Proposed (solution):
[Better code or approach]
```

**Estimated Remediation Effort**: [X] hours / [Y] days  
**Target Remediation**: [Version number or date] - e.g., "v1.1.0" or "Sprint 3"  
**Assigned To**: [Developer name | TBD]  
**Status**: Open | In Progress | Resolved

**Related Issues**:
- [Link to issue tracker if applicable]

---

## Medium Priority Debt

### DEBT-[NNN]: [Title]

**Category**: [Category]  
**Severity**: Medium

[Same structure as High Priority Debt]

---

## Low Priority Debt

### DEBT-[NNN]: [Title]

**Category**: [Category]  
**Severity**: Low

[Same structure as High Priority Debt, but less detail acceptable]

---

## Resolved Debt

### DEBT-[NNN]: [Title] ✅ RESOLVED

**Resolved**: [YYYY-MM-DD]  
**Resolved By**: [Developer name]  
**Actual Effort**: [X] hours (Estimated: [Y] hours)  
**Resolution**: [How it was fixed]  
**Git Commit**: [Commit hash]  
**Verification**: [How fix was verified]

---

## Summary Statistics

**Total Debt Items**: [Number]
- High Priority: [Number] (must fix before production)
- Medium Priority: [Number] (fix in next sprint/version)
- Low Priority: [Number] (backlog)
- Resolved: [Number]

**Total Estimated Remediation Effort**: [X] hours / [Y] days

**Debt by Category**:
- Security: [Number] items
- Performance: [Number] items
- Maintainability: [Number] items
- Code Quality: [Number] items
- Documentation: [Number] items

**Critical Path Items**: [Number] (blocking production release)

---

## Process

### Adding Debt

When incurring technical debt:
1. Create entry immediately (don't defer documentation)
2. Assign priority based on impact
3. Estimate remediation effort
4. Set target remediation timeline
5. Link to code location or issue tracker

### Reviewing Debt

**Review Schedule**: [Weekly | Bi-weekly | Monthly]  
**Next Review**: [YYYY-MM-DD]  
**Review Owner**: [Role]

**Review Process**:
1. Re-assess priorities (have they changed?)
2. Update effort estimates (more accurate now?)
3. Check if debt is being addressed
4. Add new debt discovered
5. Move resolved items to "Resolved" section

### Resolving Debt

When fixing technical debt:
1. Implement fix
2. Test thoroughly
3. Update debt entry with resolution details
4. Move to "Resolved Debt" section
5. Update summary statistics
6. Consider capturing as lesson learned

---

## Guidelines

### When to Add Debt

**DO add to register**:
- Taking shortcut due to time/resource constraints
- Deferring optimization or refactoring
- Implementing workaround for known limitation
- Adding TODO comments in code
- Skipping edge case handling
- Using quick-fix instead of proper solution

**DON'T add to register**:
- Future features (use product backlog)
- Bugs (use bug tracker)
- User requests (use feature requests)
- Things that work fine as-is

### Debt Severity Guidelines

**High**:
- Security vulnerabilities
- Performance issues affecting users
- Data integrity risks
- Scalability blockers
- Must fix before production

**Medium**:
- Maintainability concerns
- Code duplication
- Missing error handling
- Suboptimal patterns
- Fix in next release

**Low**:
- Minor code quality issues
- TODOs for nice-to-haves
- Documentation improvements
- Cosmetic improvements
- Fix when convenient

---

## Integration with Other Processes

**Sprint Planning**:
- Allocate [X]% of each sprint to debt reduction
- High priority debt gets prioritized

**Release Planning**:
- No high priority debt in production releases
- Medium debt documented in release notes

**Code Reviews**:
- Identify new debt during reviews
- Document before merging

**Knowledge Base**:
- Major debt resolutions captured as lessons
- Patterns developed during debt fixes shared

---

## Notes

[Any additional context, considerations, or information about technical debt in this project]

---

**Regular debt tracking prevents accumulation and maintains code quality.**  
**Review and address debt proactively rather than reactively.**
