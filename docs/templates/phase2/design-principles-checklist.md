# Design Principles Validation Checklist

**Project**: [Project Name]  
**Date**: [YYYY-MM-DD]  
**Validated By**: Architect Agent  
**Architecture**: [Architecture type - e.g., Monolithic, Microservices, etc.]

---

## Purpose

Validate that the technical design follows fundamental software engineering principles:
- **KISS** (Keep It Simple, Stupid)
- **DRY** (Don't Repeat Yourself)
- **SOLID** (5 object-oriented design principles)

---

## KISS (Keep It Simple, Stupid)

### Principle
Use the simplest solution that solves the problem. Avoid over-engineering.

### Validation Checklist

- [ ] **Solution uses simplest approach that works**
  - ✅ Evidence: [Explain why approach is simple]
  - ❌ Concern: [Any over-engineering identified]

- [ ] **No premature optimization**
  - ✅ Evidence: [What we're NOT optimizing prematurely]
  - ❌ Concern: [Any premature optimization found]

- [ ] **Clear over clever**
  - ✅ Evidence: [Examples of clear, straightforward design]
  - ❌ Concern: [Any overly clever solutions]

- [ ] **Appropriate for team skill level**
  - ✅ Evidence: [How design matches team capability from skill-assessment.md]
  - ❌ Concern: [Any complexity mismatches]

### Examples

**Simple Choices Made**:
1. [Choice 1]: [Why this is KISS] - e.g., "Using REST instead of GraphQL - team familiar with REST"
2. [Choice 2]: [Why this is KISS] - e.g., "Monolith over microservices - team size doesn't justify complexity"

**Avoided Over-Engineering**:
1. [What we avoided]: [Why] - e.g., "No complex caching layer initially - add when performance data shows need"

### Overall KISS Assessment
**Status**: ✅ Pass | ⚠️ Review Needed | ❌ Fail  
**Notes**: [Overall assessment]

---

## DRY (Don't Repeat Yourself)

### Principle
Every piece of knowledge should have a single, authoritative representation.

### Validation Checklist

- [ ] **No duplicated business logic**
  - ✅ Evidence: [How logic is centralized]
  - ❌ Duplication: [Any duplication found]

- [ ] **Reusable components identified**
  - ✅ Identified: [List of reusable components]
  - ❌ Missing: [Opportunities for reuse not captured]

- [ ] **Shared utilities extracted**
  - ✅ Utilities: [Common utilities defined]
  - ❌ Missing: [Code that should be utilities but isn't]

- [ ] **Configuration centralized**
  - ✅ Evidence: [Where configuration lives]
  - ❌ Scattered: [Any hardcoded or duplicated config]

### Examples

**Reusable Components Identified**:
1. [Component 1]: [What it does] - e.g., "Error handling middleware - used by all API routes"
2. [Component 2]: [What it does] - e.g., "Response formatting utility - consistent API responses"

**Shared Utilities**:
1. [Utility 1]: [Purpose] - e.g., "JWT token utilities - generation and validation"
2. [Utility 2]: [Purpose] - e.g., "Validation helpers - reusable validation rules"

**Centralized Configuration**:
- Database: [Where configured]
- Authentication: [Where configured]
- External services: [Where configured]

### Overall DRY Assessment
**Status**: ✅ Pass | ⚠️ Review Needed | ❌ Fail  
**Notes**: [Overall assessment]

---

## SOLID Principles

### S: Single Responsibility Principle

**Principle**: Each module/class should have one reason to change.

**Validation**:
- [ ] **Each component has single responsibility**

**Evidence**:
- [Component 1]: [Single responsibility] - e.g., "AuthService: Only handles authentication logic"
- [Component 2]: [Single responsibility] - e.g., "TaskService: Only handles task business logic"

**Violations** (if any):
- [Component]: [Has multiple responsibilities] - Remediation: [How to fix]

**Assessment**: ✅ Pass | ⚠️ Review | ❌ Fail

---

### O: Open/Closed Principle

**Principle**: Open for extension, closed for modification.

**Validation**:
- [ ] **Can extend without modifying existing code**

**Evidence**:
- [Example 1]: [How extensibility is achieved] - e.g., "Middleware pipeline - add new middleware without changing existing"
- [Example 2]: [Extensibility mechanism] - e.g., "Plugin system for notifications - add channels without core changes"

**Assessment**: ✅ Pass | ⚠️ Review | ❌ Fail

---

### L: Liskov Substitution Principle

**Principle**: Subtypes must be substitutable for base types.

**Validation**:
- [ ] **Subtypes are substitutable**

**Evidence**:
- [Example 1]: [Substitutability] - e.g., "All repository implementations follow common interface"
- [Example 2]: [Substitutability] - e.g., "Email and SMS notifications both implement NotificationProvider"

**Assessment**: ✅ Pass | ⚠️ Review | ❌ Fail

---

### I: Interface Segregation Principle

**Principle**: Clients shouldn't depend on interfaces they don't use.

**Validation**:
- [ ] **Specific interfaces over general**

**Evidence**:
- [Example 1]: [Segregation] - e.g., "Separate ReadRepository and WriteRepository interfaces"
- [Example 2]: [Segregation] - e.g., "Public API vs Internal API separation"

**Violations** (if any):
- [Interface]: [Too broad] - Remediation: [Split into smaller interfaces]

**Assessment**: ✅ Pass | ⚠️ Review | ❌ Fail

---

### D: Dependency Inversion Principle

**Principle**: Depend on abstractions, not concretions.

**Validation**:
- [ ] **Dependencies use abstractions**

**Evidence**:
- [Example 1]: [Abstraction] - e.g., "Services depend on IRepository interface, not specific PostgreSQL implementation"
- [Example 2]: [Abstraction] - e.g., "Auth depends on ITokenProvider, can swap JWT for OAuth"

**Assessment**: ✅ Pass | ⚠️ Review | ❌ Fail

---

## Overall Assessment

### Summary

**KISS**: [✅ Pass | ⚠️ Review | ❌ Fail]  
**DRY**: [✅ Pass | ⚠️ Review | ❌ Fail]  
**SOLID**:
- Single Responsibility: [Status]
- Open/Closed: [Status]
- Liskov Substitution: [Status]
- Interface Segregation: [Status]
- Dependency Inversion: [Status]

### Design Quality Rating

**Overall**: [Excellent | Good | Acceptable | Needs Improvement | Poor]

**Strengths**:
1. [Strength 1]
2. [Strength 2]

**Areas for Improvement**:
1. [Improvement 1]: [How to address]
2. [Improvement 2]: [How to address]

### Recommendations

**Immediate** (before implementation):
- [ ] [Action 1]: [What needs to change]
- [ ] [Action 2]: [What needs to change]

**Future** (can address later):
- [ ] [Enhancement 1]: [Potential improvement]
- [ ] [Enhancement 2]: [Potential improvement]

### Approval

**Design Principles Validated**: [YES | NO - requires revision]  
**Approved to Proceed**: [YES | NO]  
**Approved By**: Architect Agent  
**Date**: [YYYY-MM-DD]

---

## Notes

[Any additional observations, considerations, or context]

---

**This checklist ensures the architecture follows fundamental software engineering best practices.**
**Validated design is more maintainable, testable, and scalable.**
