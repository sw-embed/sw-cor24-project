# COR24 Ecosystem Refactoring Plan

> **Strategy: Rename / Fork / Clone+Push → Redirect → Deprecate → Archive**
>
> Git history is always preserved. The method depends on the situation:
>
> - **Rename**: For the primary successor of a repo (e.g., `cor24-rs` →
>   `sw-cor24-emulator`). Preserves stars, issues, GH Pages, Actions
>   history. GitHub auto-redirects old URLs permanently.
> - **Fork**: For the first derivative of a renamed/existing repo (e.g.,
>   fork `sw-cor24-emulator` → `sw-cor24-assembler`). Preserves full
>   history and shows GitHub fork relationship. Limited to one fork per
>   source per org.
> - **Clone+push**: For additional derivatives when the fork slot is taken.
>   Full history preserved; no GitHub fork badge.
>
> Old repos that aren't renamed get a deprecation notice and eventually
> a redirect-only README. They remain functional until all external
> references are updated, then are archived.

---

## 1. Current Inventory

### sw-embed (org)

| Old Repo | What | Impl | Live Demo | Status |
|----------|------|------|-----------|--------|
| `cor24-rs` | Assembler + emulator + web IDE | Rust/Yew/WASM | [sw-embed.github.io/cor24-rs](https://sw-embed.github.io/cor24-rs/) | Mature |
| `sw-cor24-project` | Hub repo (this repo) | Docs | — | Planning |

### sw-vibe-coding (org)

| Old Repo | What | Impl | Live Demo | Status |
|----------|------|------|-----------|--------|
| `tc24r` | Tiny C compiler | Rust (~50 crates) | — | Functional |
| `tf24a` | Tiny Forth (DTC) | COR24 asm | — | Functional |
| `tml24c` | Tiny Macro Lisp | C (via tc24r) | — | Mature |
| `pv24a` | P-code VM + pasm | COR24 asm | — | Mature |
| `web-tc24r` | Web IDE for C compiler | Rust/Yew/WASM | [sw-vibe-coding.github.io/web-tc24r](https://sw-vibe-coding.github.io/web-tc24r/) | Early |
| `web-tf24a` | Web debugger for Forth | Rust/Yew/WASM | [sw-vibe-coding.github.io/web-tf24a](https://sw-vibe-coding.github.io/web-tf24a/) | Mature |
| `web-tml24c` | Web REPL for Lisp | Rust/Yew/WASM | [sw-vibe-coding.github.io/web-tml24c](https://sw-vibe-coding.github.io/web-tml24c/) | Mature |
| `old-cc24` | Archived predecessor of tc24r | Rust | — | Obsolete |

### softwarewrighter (owner)

| Old Repo | What | Impl | Live Demo | Status |
|----------|------|------|-----------|--------|
| `p24p` | Pascal compiler → .spc | C | — | Active |
| `p24c` | Pascal compiler II (next-gen) | C | — | Early/research |
| `pa24r` | P-code assembler (.spc → .p24) | Rust | — | Mature (52 tests) |
| `pl24r` | P-code linker (merges .spc) | Rust | — | Mature |
| `pr24p` | Pascal runtime library | Hand-coded .spc | — | Mature (11 suites) |
| `f24a` | Fortran compiler | TBD | — | Research |
| `a24a` | APL interpreter | TBD | — | Research |
| `web-p24c` | Browser Pascal IDE | Rust/Yew/WASM | [softwarewrighter.github.io/web-p24c](https://softwarewrighter.github.io/web-p24c/) | Mature |
| `web-dv24r` | P-code debugger (browser) | Rust/Yew/WASM | [softwarewrighter.github.io/web-dv24r](https://softwarewrighter.github.io/web-dv24r/) | Mature |

### Future ISA families (not yet in scope)

| Old Repo | Org | What |
|----------|-----|------|
| `S1130` | softwarewrighter | IBM 1130 emulator (C#) |
| `demo-ibm-1130-system` | softwarewrighter | IBM 1130 web simulator (Rust/Yew) |

---

## 2. Target State

All new repos live under the **`sw-embed`** org with canonical `sw-cor24-*` names.
No implementation-language suffixes. Web companion repos use `web-sw-cor24-*`.

### Library / CLI repos

| New Repo | Source(s) | Purpose |
|----------|-----------|---------|
| `sw-cor24-project` | *(already exists)* | Hub, portal, GH Pages intro site |
| `sw-cor24-assembler` | fork `cor24-rs` (assembler + ISA crates) | COR24 assembler library + CLI |
| `sw-cor24-emulator` | fork `cor24-rs` (emulator + CPU + ISA crates) | COR24 emulator library + CLI |
| `sw-cor24-tinyc` | fork `tc24r` | Tiny C compiler |
| `sw-cor24-forth` | fork `tf24a` | Forth system |
| `sw-cor24-macrolisp` | fork `tml24c` | Macro Lisp system |
| `sw-cor24-pcode` | fork `pv24a` + absorb `pa24r` + `pl24r` | P-code VM + assembler + linker |
| `sw-cor24-pascal` | fork `p24p` + absorb `p24c` + `pr24p` | Pascal compiler(s) + runtime |
| `sw-cor24-rust` | fork `cor24-rs` (rust-to-cor24/ portion) | Rust→MSP430→COR24 pipeline (experimental) |
| `sw-cor24-fortran` | fork `f24a` | Fortran compiler (future) |
| `sw-cor24-apl` | fork `a24a` | APL interpreter (future) |

### Web companion repos

| New Repo | Source | Companion To |
|----------|--------|--------------|
| `web-sw-cor24-assembler` | `cor24-rs` (web app portion) | `sw-cor24-assembler` + `sw-cor24-emulator` |
| `web-sw-cor24-tinyc` | `web-tc24r` | `sw-cor24-tinyc` |
| `web-sw-cor24-forth` | `web-tf24a` | `sw-cor24-forth` |
| `web-sw-cor24-macrolisp` | `web-tml24c` | `sw-cor24-macrolisp` |
| `web-sw-cor24-pascal` | `web-p24c` | `sw-cor24-pascal` |
| `web-sw-cor24-pcode` | `web-dv24r` | `sw-cor24-pcode` |

### New live demo URLs (all under sw-embed org)

| Demo | URL |
|------|-----|
| Hub / intro site | `sw-embed.github.io/sw-cor24-project/` |
| Assembler + emulator IDE | `sw-embed.github.io/web-sw-cor24-assembler/` |
| Tiny C compiler | `sw-embed.github.io/web-sw-cor24-tinyc/` |
| Forth debugger | `sw-embed.github.io/web-sw-cor24-forth/` |
| Macro Lisp REPL | `sw-embed.github.io/web-sw-cor24-macrolisp/` |
| Pascal IDE | `sw-embed.github.io/web-sw-cor24-pascal/` |
| P-code debugger | `sw-embed.github.io/web-sw-cor24-pcode/` |
| Rust pipeline | *(no web demo yet — CLI-only experimental tool)* |

---

## 3. Canonical Metadata Table

This table replaces implementation-language suffixes. It belongs in
`sw-cor24-project` as both human-readable docs and machine-readable
`data/projects.yaml`.

| Repo | Display Name | Purpose | Implemented In | Emits / Runs On | Runs Where Today | Direction |
|------|-------------|---------|----------------|-----------------|------------------|-----------|
| sw-cor24-assembler | COR24 Assembler | Assemble COR24 source | Rust | COR24 binaries | Host, browser | Stable core tool |
| sw-cor24-emulator | COR24 Emulator | Emulate COR24 board (implements ISA) | Rust | Executes COR24 binaries | Host, browser | Stable core tool |
| sw-cor24-tinyc | Tiny C for COR24 | Small C compiler | Rust | COR24 asm | Host, browser | Educational |
| sw-cor24-forth | Forth for COR24 | DTC Forth system | COR24 asm | Native/emulated | Emulator, hardware | Fuller Forth |
| sw-cor24-macrolisp | Tiny Macro Lisp for COR24 | Lisp-1 with macros, GC | C | COR24/native | Host, emulator | OS/tooling basis |
| sw-cor24-pcode | P-code Tools for COR24 | VM + assembler + linker | COR24 asm + Rust | Executes p-code | Host, emulator, browser | Substrate for Pascal/BASIC |
| sw-cor24-pascal | Pascal for COR24 | Compiler + runtime | C + Pascal + .spc | P-code | Host, browser | Turbo-Pascal-inspired |
| sw-cor24-rust | Rust for COR24 | Rust→MSP430→COR24 pipeline | Rust | COR24 asm via MSP430 IR | Host (CLI) | Experimental |
| sw-cor24-fortran | Fortran for COR24 | Simple Fortran compiler | TBD | COR24 native | Planned | Research |
| sw-cor24-apl | APL for COR24 | APL interpreter | TBD | TBD | Planned | Research |

---

## 4. The cor24-rs Split

`cor24-rs` is a Rust workspace with tightly coupled crates. It becomes
**four** new repos via rename + fork + clone+push. All four preserve
the full `cor24-rs` git history, then each is trimmed to its scope.

**Method:**
1. **Rename** `cor24-rs` → `sw-cor24-emulator` (primary successor)
2. **Fork** `sw-cor24-emulator` → `sw-cor24-assembler` (gets fork badge)
3. **Clone+push** → `web-sw-cor24-assembler`
4. **Clone+push** → `sw-cor24-rust`

GitHub auto-redirects `sw-embed/cor24-rs` → `sw-embed/sw-cor24-emulator`
permanently. The fork slot is used for the assembler (most closely related).
The remaining two get full history via clone+push (no fork badge).

### Current workspace layout

```
cor24-rs/
├── Cargo.toml          # workspace: [".", "components", "cli", "isa"]
├── isa/                # cor24-isa — ISA definitions (shared, no deps)
├── src/
│   ├── assembler.rs    # 52KB — full assembler
│   ├── cpu/            # CPU state machine + executor (65KB + 29KB)
│   ├── emulator.rs     # EmulatorCore orchestration (26KB)
│   ├── wasm.rs         # WASM bindings
│   ├── app.rs          # Yew web app (87KB)
│   ├── challenge.rs    # Challenges + examples
│   └── loader.rs       # LGO file loader
├── components/         # Yew UI component library
├── cli/                # cor24-dbg CLI debugger
├── rust-to-cor24/      # wasm2cor24, cor24-run, msp430 translator
├── pages/              # Trunk build output → GitHub Pages
└── styles/             # CSS source
```

### Split plan

All four repos start with the full `cor24-rs` history.
After creation, each is trimmed to its scope and restructured.

**`sw-cor24-emulator`** — the foundation (owns the ISA):
- `isa/` (cor24-isa crate — ISA definitions live here because the
  emulator *is* the ISA implementation; no FPGA hardware yet)
- `src/cpu/` (executor, state, decode_rom)
- `src/emulator.rs` (EmulatorCore orchestration)
- `src/loader.rs` (LGO file loader)
- `cli/` → `cor24-dbg` CLI debugger
- Library API for assembler, web repos, and language tools to consume
- `scripts/build.sh`, `scripts/serve.sh`

**`sw-cor24-assembler`** — depends on emulator (for ISA + test execution):
- `src/assembler.rs` (52KB assembler)
- Assembler-specific tests
- A thin CLI (`cor24-asm` binary)
- Library API for web repos and compiler tools to consume
- Path dep on `sw-cor24-emulator` (for `cor24-isa` re-export)
- `scripts/build.sh`

**`sw-cor24-rust`** — experimental, standalone:
- `rust-to-cor24/` (Rust→MSP430→COR24 translation pipeline)
- `cor24-run` binary (assemble + load + run orchestrator)
- `msp430-to-cor24` binary
- Path deps on `sw-cor24-assembler` + `sw-cor24-emulator`
- `scripts/build.sh`
- Note: `wasm2cor24` (Rust→WASM→COR24) was a failed experiment;
  the MSP430 path replaced it. Keep both in the repo for history
  but mark WASM path as deprecated.

**`web-sw-cor24-assembler`** — the web IDE:
- `src/app.rs` (the Yew web IDE — combines assembly editing + emulation)
- `components/` (Yew UI component library)
- `src/challenge.rs` (challenges + examples)
- `src/wasm.rs` (WASM bindings)
- `styles/`, `index.html`, `Trunk.toml`
- `pages/` build output
- GitHub Actions deploy workflow (copied from `cor24-rs`)
- Path deps on both `sw-cor24-assembler` and `sw-cor24-emulator`
- `scripts/build-pages.sh`, `scripts/serve.sh`

> **Note:** The web app uses both assembler and emulator in one UI.
> `web-sw-cor24-assembler` is the name because the primary user-facing
> function is "write assembly and run it."

### ISA crate ownership

**Decision: `cor24-isa` lives inside `sw-cor24-emulator`.**

The emulator implements the ISA — it *is* the reference platform until
FPGA hardware exists. The ISA crate is a workspace member of the
emulator repo. Other repos (`sw-cor24-assembler`, web repos, language
tools) depend on `sw-cor24-emulator` and get `cor24-isa` re-exported
through it.

If this coupling becomes awkward later (e.g., the assembler shouldn't
need the full emulator just for ISA types), the ISA crate can be
extracted to its own repo (`sw-cor24-isa`) at that time.

---

## 5. The P-code Consolidation

Four old repos → one new repo with subdirectories.

The primary repo (`pv24a`) is forked to `sw-cor24-pcode`, then the
contents of `pa24r` and `pl24r` are copied in as subdirectories.
This preserves `pv24a`'s git history as the main line. The absorbed
repos (`pa24r`, `pl24r`) keep their own history in the old locations.

### Source repos

| Old Repo | What | Impl |
|----------|------|------|
| `pv24a` | P-code VM (30+ opcodes, interrupt handling) | COR24 asm |
| `pa24r` | P-code assembler (.spc → .p24, two-pass) | Rust |
| `pl24r` | P-code linker (merges .spc files) | Rust |
| `web-dv24r` | P-code debugger (browser, two-level) | Rust/Yew/WASM |

### Target structure

```
sw-cor24-pcode/
├── vm/           ← from pv24a (COR24 asm source, tests) — fork base
├── assembler/    ← from pa24r (Rust crate) — copied in
├── linker/       ← from pl24r (Rust crate) — copied in
├── docs/
├── tests/        (integration tests spanning components)
├── scripts/
│   └── build.sh
└── Cargo.toml    (Rust workspace for assembler + linker)

web-sw-cor24-pcode/
├── src/          ← fork of web-dv24r (Yew app)
├── scripts/
│   ├── build-pages.sh
│   └── serve.sh
├── ...
```

### Pipeline preserved

```
.pas → p24p → .spc → pl24r → pa24r → .p24 → pv24a (VM)
```

All tools in this pipeline except p24p (Pascal compiler) belong in
`sw-cor24-pcode`. The linker and assembler are language-agnostic and
serve Pascal, BASIC, and any future p-code-targeting language.

---

## 6. The Pascal Consolidation

Three old repos → one new repo.

The primary repo (`p24p`) is forked to `sw-cor24-pascal`, then `p24c`
and `pr24p` contents are copied in as subdirectories. This preserves
`p24p`'s git history as the main line.

### Source repos

| Old Repo | What | Impl |
|----------|------|------|
| `p24p` | Pascal compiler (emits .spc) | C (compiled by tc24r) |
| `p24c` | Pascal compiler II (next-gen, early) | C |
| `pr24p` | Pascal runtime (32 routines) | Hand-coded .spc |

### Target structure

```
sw-cor24-pascal/
├── compiler/     ← from p24p — fork base
├── compiler-v2/  ← from p24c (research/WIP) — copied in
├── runtime/      ← from pr24p (.spc source + Pascal doc source) — copied in
├── docs/
├── tests/
├── examples/
└── scripts/
    └── build.sh

web-sw-cor24-pascal/
├── src/          ← fork of web-p24c (Yew app, 13 demo programs)
├── scripts/
│   ├── build-pages.sh
│   └── serve.sh
├── ...
```

---

## 7. Phased Execution

### Phase 1 — Hub and documentation (this repo)

**Goal:** Establish `sw-cor24-project` as the central map before anything else changes.

- [ ] Write `README.md` with positioning statement, disclaimer, repo map
- [ ] Write `data/projects.yaml` with canonical metadata
- [ ] Write `docs/naming-policy.md` explaining `sw-`, `cor24`, no suffixes
- [ ] Write `docs/migration-status.md` with old→new mapping table
- [ ] Create dependency diagram (text or SVG)
- [ ] Set up GitHub Pages site (Trunk or static) as intro/portal
  - ISA overview
  - Tutorials / learning paths
  - Language references
  - Links to each `web-sw-cor24-*` live demo
- [ ] Add links to all old repos (current names, current URLs)

**Deliverable:** A stable landing page people can follow during the transition.

### Phase 2 — Create core repos (emulator + assembler + Rust pipeline)

**Goal:** Split `cor24-rs` into four repos preserving full history.

#### Step 2a — Rename `cor24-rs` → `sw-cor24-emulator`
- [ ] Rename via GitHub UI or `gh repo rename sw-cor24-emulator -R sw-embed/cor24-rs`
  - GitHub auto-redirects `sw-embed/cor24-rs` URLs permanently
  - Preserves stars, issues, GH Pages, Actions history
- [ ] Clone locally: `git clone git@github.com:sw-embed/sw-cor24-emulator.git`
- [ ] Trim: remove assembler-only code, web app, components, styles, pages
- [ ] Keep `isa/`, `src/cpu/`, `src/emulator.rs`, `src/loader.rs`, `cli/`
- [ ] Add `scripts/build.sh`
- [ ] Update/adapt GitHub Actions CI workflow (`cargo test`, `cargo clippy`)
- [ ] Ensure all emulator tests pass independently

#### Step 2b — Fork `sw-cor24-emulator` → `sw-cor24-assembler`
- [ ] Fork via GitHub UI or `gh repo fork sw-embed/sw-cor24-emulator --org sw-embed --fork-name sw-cor24-assembler`
  - Gets GitHub fork badge + full history
- [ ] Clone locally
- [ ] Trim: remove emulator internals, web app, components, styles, pages
- [ ] Keep `src/assembler.rs`, assembler tests
- [ ] Add path dep on `sw-cor24-emulator` (for `cor24-isa` re-export)
- [ ] Add `scripts/build.sh`
- [ ] Copy/adapt CI workflow
- [ ] Ensure all assembler tests pass independently

#### Step 2c — Clone+push → `web-sw-cor24-assembler`
- [ ] Create empty repo: `gh repo create sw-embed/web-sw-cor24-assembler --public`
- [ ] Clone `sw-cor24-emulator`, change remote, push full history
- [ ] Trim: remove CLI, rust-to-cor24, emulator internals
- [ ] Keep `src/app.rs`, `components/`, `src/wasm.rs`, `src/challenge.rs`
- [ ] Keep `styles/`, `index.html`, `Trunk.toml`
- [ ] Update path deps to `../sw-cor24-assembler` + `../sw-cor24-emulator`
- [ ] Update `Trunk.toml` public_url to `/web-sw-cor24-assembler/`
- [ ] Add `scripts/build-pages.sh`, `scripts/serve.sh`
- [ ] Copy/adapt GitHub Actions deploy workflow
- [ ] Verify live demo works at new URL

#### Step 2d — Clone+push → `sw-cor24-rust`
- [ ] Create empty repo: `gh repo create sw-embed/sw-cor24-rust --public`
- [ ] Clone `sw-cor24-emulator`, change remote, push full history
- [ ] Trim: remove everything except `rust-to-cor24/`
- [ ] Restructure as top-level crate
- [ ] Add path deps on `../sw-cor24-assembler` + `../sw-cor24-emulator`
- [ ] Mark `wasm2cor24` path as deprecated; `msp430-to-cor24` is active
- [ ] Add `scripts/build.sh`
- [ ] Copy/adapt CI workflow

#### Step 2e — Deprecation note (not needed for cor24-rs)
- GitHub auto-redirects `cor24-rs` → `sw-cor24-emulator`, so no
  deprecation notice is needed. The old name simply resolves to the
  new one.

### Phase 3 — Create p-code repo

**Goal:** Consolidate the p-code substrate.

- [ ] Fork `pv24a` → `sw-cor24-pcode` under `sw-embed`
  - Move existing content into `vm/` subdirectory
  - Copy `pa24r` contents into `assembler/`
  - Copy `pl24r` contents into `linker/`
  - Set up Rust workspace for assembler + linker crates
  - Add `scripts/build.sh`
  - Copy/adapt CI workflow
  - Ensure all tests pass (52 assembler tests, 12 VM tests, linker tests)
- [ ] Fork `web-dv24r` → `web-sw-cor24-pcode` under `sw-embed`
  - Update path deps to point to `../sw-cor24-pcode`
  - Update `Trunk.toml` public_url to `/web-sw-cor24-pcode/`
  - Add `scripts/build-pages.sh`, `scripts/serve.sh`
  - Copy/adapt deploy workflow, verify live demo
- [ ] Add deprecation notices to `pv24a`, `pa24r`, `pl24r`, `web-dv24r`

### Phase 4 — Create Pascal repo

**Goal:** Consolidate Pascal toolchain.

- [ ] Fork `p24p` → `sw-cor24-pascal` under `sw-embed`
  - Move existing content into `compiler/` subdirectory
  - Copy `p24c` contents into `compiler-v2/`
  - Copy `pr24p` contents into `runtime/`
  - Update paths referencing p-code tools to `../sw-cor24-pcode`
  - Add `scripts/build.sh`
  - Copy/adapt CI workflow
  - Ensure compiler tests pass (35+ test cases)
  - Ensure runtime tests pass (11 test suites)
- [ ] Fork `web-p24c` → `web-sw-cor24-pascal` under `sw-embed`
  - Update path deps (pcode tools, assembler, emulator — all `../sw-cor24-*`)
  - Update `Trunk.toml` public_url to `/web-sw-cor24-pascal/`
  - Add `scripts/build-pages.sh`, `scripts/serve.sh`
  - Copy/adapt deploy workflow, verify live demo (13 demo programs)
- [ ] Add deprecation notices to `p24p`, `p24c`, `pr24p`, `web-p24c`

### Phase 5 — Create language repos (C, Forth, Macro Lisp)

**Goal:** Fork the three language systems + their web companions.

Each library repo and its web companion are forked separately.
All web repos get `scripts/build-pages.sh` and `scripts/serve.sh`.
All library repos get `scripts/build.sh`. CI workflows are copied
and adapted from the source repos.

#### Tiny C
- [ ] Fork `tc24r` → `sw-cor24-tinyc` under `sw-embed`
  - Update path deps to `../sw-cor24-assembler`, `../sw-cor24-emulator`
  - Add `scripts/build.sh`, copy/adapt CI
- [ ] Fork `web-tc24r` → `web-sw-cor24-tinyc` under `sw-embed`
  - Update path deps, `Trunk.toml` public_url, deploy workflow
  - Add `scripts/build-pages.sh`, `scripts/serve.sh`
- [ ] Add deprecation notices to `tc24r`, `web-tc24r`

#### Forth
- [ ] Fork `tf24a` → `sw-cor24-forth` under `sw-embed`
  - Update path deps to `../sw-cor24-assembler`, `../sw-cor24-emulator`
  - Add `scripts/build.sh`, copy/adapt CI
- [ ] Fork `web-tf24a` → `web-sw-cor24-forth` under `sw-embed`
  - Update path deps, `Trunk.toml` public_url, deploy workflow
  - Add `scripts/build-pages.sh`, `scripts/serve.sh`
- [ ] Add deprecation notices to `tf24a`, `web-tf24a`

#### Macro Lisp
- [ ] Fork `tml24c` → `sw-cor24-macrolisp` under `sw-embed`
  - Update path deps to `../sw-cor24-assembler`, `../sw-cor24-emulator`
  - Add `scripts/build.sh`, copy/adapt CI
- [ ] Fork `web-tml24c` → `web-sw-cor24-macrolisp` under `sw-embed`
  - Update path deps, `Trunk.toml` public_url, deploy workflow
  - Add `scripts/build-pages.sh`, `scripts/serve.sh`
- [ ] Add deprecation notices to `tml24c`, `web-tml24c`

### Phase 6 — Create research/future repos

**Goal:** Give canonical homes to early-stage projects.

- [ ] Fork `f24a` → `sw-cor24-fortran` under `sw-embed`
  - Add `scripts/build.sh`, copy/adapt CI
- [ ] Fork `a24a` → `sw-cor24-apl` under `sw-embed`
  - Add `scripts/build.sh`, copy/adapt CI
- [ ] Add deprecation notices to `f24a`, `a24a`

### Phase 7 — Portal site build-out

**Goal:** Make `sw-cor24-project` GitHub Pages site the definitive entry point.

- [ ] ISA reference page (instruction set, registers, memory model)
- [ ] Getting started tutorial (assembler → first program → run in browser)
- [ ] Language tutorials (one page per language: C, Forth, Lisp, Pascal)
- [ ] Architecture diagram (interactive or SVG)
- [ ] Learning paths ("I want to try something in the browser", "I want to
      understand bootstrapping", etc.)
- [ ] Links to every `web-sw-cor24-*` live demo with descriptions
- [ ] Project status dashboard (active / experimental / research / archived)
- [ ] Link all new repos; remove links to old repos

### Phase 8 — Verify and sweep

**Goal:** Ensure nothing is broken and all references are updated.

- [ ] Every new repo builds and tests pass
- [ ] Every web demo deploys and loads at new URL
- [ ] All cross-repo path dependencies point to new locations
- [ ] All Cargo.toml package names updated
- [ ] All README cross-links use new repo names/URLs
- [ ] `sw-cor24-project` migration-status.md updated to "complete"
- [ ] GitHub topics applied to all repos (cor24, emulator, compiler, etc.)
- [ ] Old repos have clear deprecation banners in README

### Phase 9 — Deprecate and archive old repos

**Goal:** Wind down old locations gracefully.

#### Step 1 — Replace old live demos with redirects
- [ ] For each old `web-*` repo with a live GH Pages demo:
  - Replace `pages/index.html` (or equivalent) with the redirect template
    (see Section 9) pointing to the new `sw-embed.github.io` URL
  - Push and verify the redirect works
  - Old URLs now forward to new demos automatically

#### Step 2 — Strip old READMEs to redirect-only
- [ ] For each old repo:
  - Replace README with deprecation notice + link to new repo
  - Remove all other content from README (the full history is in git)

#### Step 3 — Archive
- [ ] Archive each old repo on GitHub (read-only, visible, searchable)
  - `cor24-rs`, `tc24r`, `tf24a`, `tml24c`, `pv24a`, `old-cc24`
  - `web-tc24r`, `web-tf24a`, `web-tml24c`
  - `p24p`, `p24c`, `pa24r`, `pl24r`, `pr24p`
  - `web-p24c`, `web-dv24r`
  - `f24a`, `a24a`
  - Note: archiving disables GH Pages, so redirects stop working.
    Only archive after traffic to old URLs has dropped off.

---

## 8. Path Dependency Update Map

All web repos use path dependencies to library crates. After the copy,
these paths must be updated. Current and new paths assuming repos are
cloned as siblings under `~/github/sw-embed/`:

| Web Repo | Old Path Dep | New Path Dep |
|----------|-------------|--------------|
| `web-sw-cor24-assembler` | `../../sw-embed/cor24-rs` | `../sw-cor24-assembler` + `../sw-cor24-emulator` |
| `web-sw-cor24-tinyc` | `../../sw-embed/cor24-rs` | `../sw-cor24-assembler` + `../sw-cor24-emulator` |
| `web-sw-cor24-forth` | `../../sw-embed/cor24-rs` | `../sw-cor24-assembler` + `../sw-cor24-emulator` |
| `web-sw-cor24-macrolisp` | `../../sw-embed/cor24-rs` | `../sw-cor24-assembler` + `../sw-cor24-emulator` |
| `web-sw-cor24-pascal` | `../pa24r`, `../pl24r`, `../../sw-embed/cor24-rs` | `../sw-cor24-pcode`, `../sw-cor24-assembler`, `../sw-cor24-emulator` |
| `web-sw-cor24-pcode` | (TBD from web-dv24r) | `../sw-cor24-pcode`, `../sw-cor24-assembler`, `../sw-cor24-emulator` |

---

## 9. Deprecation Notice Template

Add this to the top of each old repo's README:

```markdown
> **This repository has been superseded.**
>
> Development continues at [sw-cor24-XXXX](https://github.com/sw-embed/sw-cor24-XXXX)
> under the [sw-embed](https://github.com/sw-embed) organization.
>
> This repo remains for historical reference. No further development will
> occur here. It will eventually be archived.
```

For old repos with live GitHub Pages demos, the final step before
archiving is to replace the demo with a redirect page:

```html
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="refresh" content="0; url=https://sw-embed.github.io/web-sw-cor24-XXXX/">
  <title>Moved</title>
</head>
<body>
  <p>This demo has moved to
  <a href="https://sw-embed.github.io/web-sw-cor24-XXXX/">sw-embed.github.io/web-sw-cor24-XXXX</a>.</p>
</body>
</html>
```

---

## 10. Risk Register

| Risk | Impact | Mitigation |
|------|--------|------------|
| cor24-rs split breaks shared code | High | Fork all four from same base; trim carefully; run full test suite after each trim |
| Path deps break across repos | Medium | All repos assume sibling checkout under `~/github/sw-embed/`; document in each README |
| Old GitHub Pages URLs go dead on archive | Medium | Before archiving: replace old GH Pages with redirect page pointing to new URL |
| p-code consolidation: absorbed repos lose history | Low | Absorbed repos (`pa24r`, `pl24r`, `pr24p`, `p24c`) keep their history in old (deprecated) locations; primary repo history preserved in fork |
| Web build.rs scripts depend on external tools (tc24r) | Medium | Fork tc24r → sw-cor24-tinyc in Phase 5 before sw-cor24-pascal needs it; or update build to use new name |
| Trunk public_url mismatch after fork | Low | Update Trunk.toml in each web repo immediately after forking |
| GitHub fork limits (one fork per source per org) | Low | Mitigated: rename cor24-rs first (uses no fork slot), then fork once for assembler, clone+push for the remaining two. Only assembler gets fork badge; all four get full history. |

---

## 11. Resolved Decisions

These questions were raised during planning and have been answered:

1. **ISA crate ownership** → Lives in `sw-cor24-emulator`. The emulator
   implements the ISA and is the reference platform (no FPGA yet). Other
   repos depend on emulator and get ISA re-exported. Can be extracted to
   `sw-cor24-isa` later if coupling becomes painful.

2. **Git history** → Always preserved. For `cor24-rs`: rename to emulator
   (primary successor), fork once for assembler, clone+push for the rest.
   For other repos: fork to new names under `sw-embed`. For consolidation
   repos (pcode, pascal), the primary repo is forked and absorbed repos
   are copied in.

3. **CI approach** → Standard `cargo test` / `cargo clippy` / `trunk build`,
   encapsulated in `scripts/build.sh` (library repos) and
   `scripts/build-pages.sh` + `scripts/serve.sh` (web repos) so ports
   and build commands are not guessed. GitHub Actions workflows are
   copied from source repos and adapted.

4. **Rust-to-COR24 pipeline** → Gets its own repo: `sw-cor24-rust`.
   Forked from `cor24-rs`, trimmed to `rust-to-cor24/` contents.
   Experimental. The WASM→COR24 path was a failed experiment replaced
   by Rust→MSP430→COR24. Both kept for history, WASM path marked
   deprecated.

5. **Web assembler+emulator name** → `web-sw-cor24-assembler`. The
   primary user-facing function is "write assembly and run it."
