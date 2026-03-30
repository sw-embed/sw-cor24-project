---
name: Wiki server offline during refactor
description: agent-cas-wiki is offline; single agent has direct r/w to all sw-embed repos; wiki resumes after refactor for parallel feature dev
type: project
---

Agent-cas-wiki coordination server is offline during the COR24 ecosystem refactor. This agent has direct r/w access to all sw-embed repos — no wiki needed.

**Why:** The refactor is a single-agent sequential workflow. The wiki is for coordinating multiple per-repo agents during parallel feature development.

**How to apply:** Don't attempt wiki API calls. Work directly in each repo. Once the refactor completes (saga step 019), the wiki will be brought back online (likely a replacement) for parallel development across the new canonical repos.
