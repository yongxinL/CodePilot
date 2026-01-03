# Session Auto-Compression System

## Overview

Session Auto-Compression automatically manages token usage during long CodePilot sessions, preventing "out of context" errors by compressing completed phases when token usage reaches 75% of the limit.

**Problem Solved:**
- ❌ Sessions crash near token limit (200K)
- ❌ Manual checkpointing required
- ❌ Context loss between sessions
- ❌ Long projects require multiple fragmented sessions

**Solution:**
- ✅ Automatic compression at 75% threshold
- ✅ Seamless session continuation
- ✅ Completed phases compressed to summaries
- ✅ Recovery mechanism for restoring context

---

## How It Works

### Token Budget Lifecycle

```
Session Start
│
├─ Available: 200K tokens
├─ 50K: Initial context (prompts, project structure)
├─ 50K: User input and interaction (Phase 1)
├─ 50K: More work (Phase 2 planning begins)
│
├─ [CHECKPOINT] At 150K (75% of limit)
│   │
│   ├─ Compress Phase 1 (50K → 7.5K) = 42.5K freed
│   ├─ Save to: .recovery/phase1-compressed-20260103-1430.md
│   │
│   └─ Resume with:
│       ├─ Available: 104.5K tokens (freed up)
│       ├─ Continue Phase 2: 30K tokens
│       └─ Continue Phase 3: 40K+ available
│
└─ [AUTO-REPEAT] If hit 75% again
    └─ Compress Phase 2 automatically
```

### Compression Algorithm

**Phase 1 (Requirements) Compression:**
```
BEFORE: 50K tokens
├─ requirements-spec.md (8K)
├─ user-stories.md (12K)
├─ questions-and-answers.md (8K)
├─ skill-assessment.md (6K)
├─ requirements-summary.md (5K)
└─ locked-specification.md (5K)

AFTER: 7.5K tokens (85% reduction)
├─ MVP definition (1-liner)
├─ 3-5 most critical user stories
├─ Key constraints and non-functional requirements
├─ Team skill profile (one-liner)
├─ Top 3 risks identified
└─ Reference: Link to full phase1-compressed.md
```

**Phase 2 (Planning) Compression:**
```
BEFORE: 45K tokens
├─ architecture.md (12K)
├─ technology-decisions.md (10K)
├─ data-model.md (8K)
├─ api-spec.md (10K)
├─ gantt-chart.md (5K)

AFTER: 6K tokens (87% reduction)
├─ Chosen architecture (1-paragraph)
├─ Technology stack (3 lines)
├─ Data model diagram (ASCII)
├─ API endpoint list (5-10 lines)
├─ Timeline and dependencies
└─ Reference: Link to full phase2-compressed.md
```

**Phase 3 (Implementation) Compression:**
```
BEFORE: 40K tokens
├─ Code files (20K)
├─ Development log (10K)
├─ Test results (8K)
└─ Performance data (2K)

AFTER: 5K tokens (88% reduction)
├─ Completed features list
├─ Code statistics (lines, coverage %)
├─ Test summary (pass/fail count)
├─ Known issues and tech debt
└─ Reference: Link to full phase3-compressed.md
```

---

## Configuration

### In opencode.json

```json
{
  "auto_compression": {
    "enabled": true,
    "threshold_percent": 75,
    "token_limit": 200000,
    "compression_target_percent": 85,
    "checkpoint_interval_minutes": 45,
    "keep_full_files": true,
    "archive_location": ".recovery/compressed"
  },
  "session": {
    "checkpoint_frequency": "auto",
    "recovery_mode": "automatic"
  }
}
```

### Configuration Options

| Option | Default | Range | Description |
|--------|---------|-------|-------------|
| `enabled` | true | boolean | Enable/disable auto-compression |
| `threshold_percent` | 75 | 50-90 | Trigger compression at X% of token limit |
| `token_limit` | 200000 | 100K-1M | Total tokens available per session |
| `compression_target_percent` | 85 | 70-95 | Compress phases to X% smaller |
| `checkpoint_interval_minutes` | 45 | 30-120 | Save checkpoint every N minutes |
| `keep_full_files` | true | boolean | Keep original uncompressed files |
| `archive_location` | .recovery/compressed | path | Where to store compressed phases |

---

## Compression Workflow

### Step 1: Token Monitoring (Continuous)

```python
# Pseudo-code
while session_active:
    current_tokens = count_tokens(session_context)
    percent_used = (current_tokens / token_limit) * 100

    if percent_used >= threshold_percent:
        trigger_compression()

    sleep(5_seconds)  # Monitor every 5 seconds
```

### Step 2: Phase Selection

When compression triggered, analyze which phase(s) to compress:

1. **Find completed phases** (status = "completed")
2. **Order by age** (oldest first)
3. **Compress largest first** (maximize token recovery)

**Example Decision:**
```
Phase 1 (Requirements): COMPLETED ✅ → Compress (50K saved)
Phase 2 (Planning): COMPLETED ✅ → Queue for next compression
Phase 3 (Implementation): IN PROGRESS ⏳ → Don't compress
Phase 4 (Verification): NOT STARTED ❌ → Don't touch
Phase 5 (Master Control): NOT STARTED ❌ → Don't touch
```

### Step 3: Smart Summarization

For each phase to compress:

1. **Extract key information** (decisions, outputs, constraints)
2. **Remove verbose documentation** (keep structure)
3. **Keep references** to full files for later retrieval
4. **Preserve metadata** (timestamps, decision log)

**Summarization Rules:**
```
Documents to Keep (Essential):
- One-line summary of phase outcome
- Key decisions made (from decision log)
- Critical constraints discovered
- Dependencies and blockers
- Metrics (test coverage %, velocity, etc.)

Documents to Remove (Verbose):
- Full architecture diagrams (keep one-liner)
- Complete user stories (keep 3-5 critical)
- Detailed code explanations (keep summary)
- Meeting notes (keep decisions only)
- Exploratory analysis (keep conclusions)
```

### Step 4: Save Compressed Checkpoint

```
.recovery/
├── phase1-compressed-20260103-1430.md (7.5K)
├── phase2-compressed-20260103-1615.md (6K)
├── session-checkpoint-20260103-1615.json
└── README.md (recovery instructions)
```

**Checkpoint file includes:**
- Timestamp of compression
- Tokens recovered
- Phases compressed
- Link to full files
- How to restore if needed

### Step 5: Inject Compressed Summary into Context

After compression:

```
[AUTO-COMPRESSION SUMMARY - 42.5K tokens freed]

Restoring context from Phase 1...

## Phase 1 Summary (Compressed)
- **MVP**: User registration, task mgmt, team collaboration
- **Team**: 3 developers (2 full-time, 1 part-time), familiar with React
- **Timeline**: Flexible, 3-month target
- **Key Risks**:
  1. Node.js learning curve (team stronger in frontend)
  2. Real-time features complexity
- **Next Steps**: Phase 2 architecture review scheduled

[Full Phase 1 docs saved to: .recovery/phase1-compressed-20260103-1430.md]

Continuing with Phase 2 planning...
```

---

## Recovery & Restoration

### Scenario 1: Session Continues (No Recovery Needed)
```
Session runs → Hits 75% → Compresses Phase 1 → Continues automatically
✅ User unaware, work continues seamlessly
```

### Scenario 2: Session Ends, User Resumes Later

**On next session start:**
```
opencode --agent architect --mode resume
│
├─ Detect previous session checkpoint
├─ Load compressed summaries
├─ Inject into context
├─ Offer to restore full Phase 1 files if needed
│
└─ Resume Phase 2 with full context
```

**Recovery command (manual):**
```bash
# Restore Phase 1 from compression
opencode --restore-phase 1 --checkpoint 20260103-1430

# Show all available checkpoints
opencode --list-checkpoints

# Calculate token savings
opencode --show-compression-stats
```

---

## Messaging for Agents

### All Primary Agent Prompts (01-05)

**Add to "Session Management" section:**

```markdown
## Auto-Compression & Token Management

### How Compression Works

During long sessions, when token usage approaches 75% of the session limit:

1. **Automatic Detection**: System monitors token count continuously
2. **Phase Analysis**: Identifies completed phases for compression
3. **Smart Summarization**: Compresses Phase 1-3 to key summaries
4. **Context Injection**: Reinserts summaries into your context
5. **Seamless Continuation**: You continue work with freed tokens

**You will see**: Occasional "[AUTO-COMPRESSION]" messages showing:
- Tokens recovered
- Phases compressed
- How to access full phase files if needed

### What Gets Compressed

✅ **Compressed after completion** (keep summaries):
- Phase 1: Requirements (keep MVP, constraints, key decisions)
- Phase 2: Architecture (keep tech stack, key design decisions)
- Phase 3: Implementation (keep feature summary, metrics)

❌ **Never compressed** (always available):
- Phase 4: Verification (quality gates, test results)
- Phase 5: Master Control (portfolio decisions)
- Your current working phase
- Decision log and risk register

### Accessing Compressed Phases

If you need the full Phase 1 documentation after compression:

```markdown
@docs I need the full Phase 1 requirements. Please restore from:
docs/.recovery/phase1-compressed-20260103-1430.md
```

### Configuration

To adjust compression settings:

**In `.codepilot.config.json`:**
```json
{
  "auto_compression": {
    "enabled": true,
    "threshold_percent": 75,
    "compression_target_percent": 85
  }
}
```

**Options:**
- `enabled`: true/false - Enable/disable compression
- `threshold_percent`: 50-90 - When to trigger (default 75%)
- `compression_target_percent`: 70-95 - How much to reduce (default 85%)

### Benefits

- ⏱️ **Session Duration**: Work for 3+ hours without interruption
- 💾 **Token Efficiency**: Reclaim 40-50K tokens per compression
- 🔄 **Seamless**: Compression happens automatically, you keep working
- 📚 **Accessibility**: Full phase files preserved for later review
- 🎯 **Smart**: Only compresses completed phases, never active work
```

---

## Monitoring & Metrics

### Token Usage Dashboard

```
┌─ SESSION STATUS ──────────────────────────────┐
│ Elapsed: 1h 32m                              │
│ Token Limit: 200,000                         │
│                                              │
│ Used: ████████████████░░░░░░░░░░ 72% (144K) │
│ Available: 56,000                            │
│                                              │
│ Compressions: 1 (Phase 1)                    │
│ Tokens Freed: 42,500                         │
│ Savings: 85%                                 │
│                                              │
│ Current Phase: Implementation (Phase 3)      │
│ Phase Completion: 65%                        │
└──────────────────────────────────────────────┘
```

### Compression Log

Each session creates `session-metrics.json`:

```json
{
  "session_id": "20260103-1400-phase2-planning",
  "start_time": "2026-01-03T14:00:00Z",
  "compressions": [
    {
      "timestamp": "2026-01-03T15:15:00Z",
      "phase": "Phase 1 (Requirements)",
      "tokens_before": 50000,
      "tokens_after": 7500,
      "tokens_freed": 42500,
      "compression_ratio": 0.85,
      "checkpoint_file": ".recovery/phase1-compressed-20260103-1515.md"
    }
  ],
  "total_tokens_freed": 42500,
  "session_duration_minutes": 75,
  "current_phase": "Phase 3 (Implementation)",
  "current_token_usage": 144000
}
```

---

## Troubleshooting

### Issue: Compression triggered too early
**Solution**: Increase `threshold_percent` in config (e.g., 80 instead of 75)

### Issue: Compression not aggressive enough
**Solution**: Increase `compression_target_percent` (e.g., 90% instead of 85%)

### Issue: Can't find compressed phase file
**Solution**: List checkpoints with:
```bash
opencode --list-checkpoints
opencode --show-compression-stats
```

### Issue: Lost work after compression
**Solution**: Compression only summarizes completed phases. All work is preserved:
- Full files saved to `.recovery/`
- Can restore anytime with `opencode --restore-phase X`
- Session continues with summaries in context

---

## Implementation Details

### Required Changes

1. **Core System** (New file):
   - `lib/token-manager.js` - Token counting and monitoring
   - `lib/phase-compressor.js` - Compression algorithm
   - `lib/checkpoint-manager.js` - Save/restore logic

2. **Configuration** (Update):
   - `opencode.json` - Add auto_compression settings
   - `.recovery/README.md` - Recovery procedures

3. **Agent Prompts** (Update):
   - All 5 primary agents (01-05-*.md)
   - Add "Auto-Compression" messaging section

4. **Documentation** (New):
   - This file: `docs/core/05-auto-compression.md`
   - Recovery guide: `.recovery/RECOVERY-GUIDE.md`

---

## Success Criteria

Session Auto-Compression is complete when:

- ✅ Token monitoring active (checks every 5 seconds)
- ✅ Compression triggers at 75% threshold
- ✅ Completed phases compress to 85% smaller
- ✅ Context summaries automatically injected
- ✅ Session continues seamlessly
- ✅ Checkpoint files saved to `.recovery/`
- ✅ Recovery commands work (--restore-phase, --list-checkpoints)
- ✅ All agents have auto-compression messaging
- ✅ Configuration options in opencode.json
- ✅ Metrics tracking operational

---

## Future Enhancements

- Multi-compression (compress multiple phases in one pass)
- Adaptive compression (adjust target % based on phase complexity)
- Selective restoration (restore only specific documents from phase)
- Compression prediction (warn before hitting threshold)
- AI-powered summarization (use Claude to create smarter summaries)

---

**Status**: Ready for implementation
**Priority**: 🔴 CRITICAL (blocks long sessions)
**Effort**: 9-13 hours (implementation + testing)
**Token Impact**: +42-50K per compression cycle
