# Performance Benchmark Results

**Project**: [Project Name]  
**Version**: [Version]  
**Date**: [YYYY-MM-DD]  
**Environment**: [Staging/Production/Load Test Environment]

## Summary
- API Performance: [✅ Pass | ⚠️ At Risk | ❌ Fail]
- Load Handling: [Status]
- Resource Usage: [Status]
- Overall: [Assessment]

## API Response Times
### Endpoints Tested
| Endpoint | Method | p50 | p95 | p99 | Target | Status |
|----------|--------|-----|-----|-----|--------|--------|
| /api/tasks | GET | [X]ms | [Y]ms | [Z]ms | <200ms | [✅/⚠️/❌] |
| /api/auth/login | POST | [X]ms | [Y]ms | [Z]ms | <300ms | [✅/⚠️/❌] |

### Summary
- Average p95: [X]ms (target: <[Y]ms)
- Slowest endpoint: [Endpoint] ([X]ms)

## Load Test Results
### Normal Load ([N] concurrent users)
- Duration: [X] minutes
- Success rate: [X]%
- Error rate: [Y]%
- Avg response: [X]ms

### Peak Load ([N] concurrent users)
- Success rate: [X]%
- p95 response: [X]ms
- Errors: [Y]%

### Stress Test
- Breaking point: [N] concurrent users
- Failure mode: [Description]

## Database Performance
- Query avg: [X]ms
- Slow queries: [N] (>[Y]ms)
- Connection pool: [X]% utilization

## Resource Utilization
- CPU: [X]% avg, [Y]% peak
- Memory: [X]MB avg, [Y]MB peak
- Network: [X]Mbps avg

## Recommendations
1. [Recommendation with priority]
2. [Recommendation with priority]

---
See ENHANCED-PROMPT-SPECS.md for complete format
