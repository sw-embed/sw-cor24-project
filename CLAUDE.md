# sw-cor24-project — Claude Instructions

## Project Overview

This is the hub/portal repo for Softwarewrighter's COR24 ecosystem.
It contains documentation, planning, and will host a GitHub Pages
intro site. No Rust code lives here — only docs, config, and the
agentrail saga tracking the multi-repo refactoring.

## CRITICAL: AgentRail Session Protocol (MUST follow exactly)

### 1. START (do this FIRST, before anything else)
```bash
agentrail next
```
Read the output carefully. It contains your current step, prompt,
plan context, and any relevant skills/trajectories.

### 2. BEGIN (immediately after reading the next output)
```bash
agentrail begin
```

### 3. WORK (do what the step prompt says)
Do NOT ask "want me to proceed?". The step prompt IS your instruction.
Execute it directly.

### 4. COMMIT (after the work is done)
Commit your code changes with git. Use `/mw-cp` for the checkpoint
process (pre-commit checks, docs, detailed commit, push).
**Run `/mw-cp` in every repo that was modified during the step.**

### 5. COMPLETE (LAST thing, after committing)
```bash
agentrail complete --summary "what you accomplished" \
  --reward 1 \
  --actions "tools and approach used"
```
- If the step failed: `--reward -1 --failure-mode "what went wrong"`
- If the saga is finished: add `--done`

### 6. STOP (after complete, DO NOT continue working)
Do NOT make further code changes after running `agentrail complete`.
Any changes after complete are untracked and invisible to the next
session. Future work belongs in the NEXT step, not this one.

## Key Rules

- **Do NOT skip steps** — the next session depends on accurate tracking
- **Do NOT ask for permission** — the step prompt is the instruction
- **Do NOT continue working** after `agentrail complete`
- **Commit before complete** — always commit first, then record completion

## Useful Commands

```bash
agentrail status          # Current saga state
agentrail history         # All completed steps
agentrail plan            # View the plan
agentrail next            # Current step + context
```

## Build / Deploy

This is a docs-only repo. No cargo build. The GitHub Pages site
(planned) will use Trunk or static HTML.

## Cross-Repo Context

All COR24 repos live under `~/github/sw-embed/` as siblings:
- `sw-cor24-emulator` — emulator + ISA (foundation)
- `sw-cor24-x-assembler` — cross-assembler in Rust (runs on host)
- `sw-cor24-x-tinyc` — cross C compiler in Rust (runs on host)
- `sw-cor24-assembler` — native assembler in C (runs on COR24)
- `sw-cor24-tinyc` — native C compiler in C (future)
- `web-sw-cor24-assembler` — web IDE
- `sw-cor24-rust` — Rust-to-COR24 pipeline
- See `docs/refactoring-plan.md` for the full migration plan

You are the only agent running for this project and have direct r/w
access to all sw-embed repos. No wiki coordination needed — the
agent-cas-wiki server is offline until parallel feature development
resumes after this refactor is complete.
