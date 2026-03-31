# sw-cor24-project

Softwarewrighter's independent, educational, and experimental toolchain
projects targeting the [MakerLisp COR24](https://makerlisp.com/) ISA.

> These are **not** official MakerLisp tools. This is independent work by
> [Softwarewrighter](https://github.com/softwarewrighter) exploring
> language bootstrapping, browser-based demos, FPGA-hosted development,
> and vibe-coding workflows.

## Overview

This repository is the hub for the COR24 software ecosystem under the
[sw-embed](https://github.com/sw-embed) organization. It maps the
projects, explains their relationships, and hosts the portal site.

The ecosystem includes:

- **Assembler + Emulator** — the foundation, implementing the COR24 ISA
- **Tiny C compiler** — a small educational C compiler
- **Macro Lisp** — a Lisp-1 with macros, GC, and closures
- **Forth** — a direct-threaded-code Forth system
- **P-code tools** — VM, assembler, and linker for a p-code substrate
- **Pascal** — a Turbo-Pascal-inspired compiler, runtime, and linker
- **Browser demos** — each tool has a companion web IDE/debugger

## Repos

### Cross-tools (Rust, run on host)

| Repo | Purpose | Status |
|------|---------|--------|
| [sw-cor24-emulator](https://github.com/sw-embed/sw-cor24-emulator) | COR24 emulator + ISA definitions | Active |
| [sw-cor24-x-assembler](https://github.com/sw-embed/sw-cor24-x-assembler) | COR24 cross-assembler (Rust) | Active |
| [sw-cor24-x-tinyc](https://github.com/sw-embed/sw-cor24-x-tinyc) | COR24 cross C compiler (Rust) | Active |
| [web-sw-cor24-assembler](https://github.com/sw-embed/web-sw-cor24-assembler) | Browser-based assembly IDE | Active |
| [web-sw-cor24-tinyc](https://github.com/sw-embed/web-sw-cor24-tinyc) | Browser-based C IDE | Active |
| [sw-cor24-rust](https://github.com/sw-embed/sw-cor24-rust) | Rust-to-COR24 via MSP430 IR (experimental) | Experimental |

### Native tools (C, run on COR24)

| Repo | Purpose | Status |
|------|---------|--------|
| [sw-cor24-assembler](https://github.com/sw-embed/sw-cor24-assembler) | COR24 native assembler (C) | In development |
| [sw-cor24-tinyc](https://github.com/sw-embed/sw-cor24-tinyc) | COR24 native C compiler (C) | Future |

### Language toolchains

| Repo | Purpose | Status |
|------|---------|--------|
| [sw-cor24-forth](https://github.com/sw-embed/sw-cor24-forth) | Forth system | Active |
| [sw-cor24-macrolisp](https://github.com/sw-embed/sw-cor24-macrolisp) | Macro Lisp system | Active |
| [sw-cor24-pascal](https://github.com/sw-embed/sw-cor24-pascal) | Pascal compiler + runtime | Active |
| [sw-cor24-pcode](https://github.com/sw-embed/sw-cor24-pcode) | P-code VM + assembler + linker | Active |
| [sw-cor24-apl](https://github.com/sw-embed/sw-cor24-apl) | APL interpreter | Active |
| [sw-cor24-plsw](https://github.com/sw-embed/sw-cor24-plsw) | PL/SW compiler | In development |
| [sw-cor24-fortran](https://github.com/sw-embed/sw-cor24-fortran) | Fortran (research) | Research |

## Documentation

- [Refactoring Plan](docs/refactoring-plan.md) — detailed 9-phase migration plan
- [Research Notes](docs/research.txt) — naming, org structure, and branding decisions
- [Process](docs/process.md) — development workflow
- [Tools](docs/tools.md) — tooling reference
- [AI Agent Instructions](docs/ai_agent_instructions.md) — agent workflow guidance

## Why This Exists

1. **Vibe-coding and personal software** — a laboratory for improving
   AI-assisted software creation, incremental tool-building, and
   educationally useful implementations.

2. **Complete toolchain on FPGA hardware** — a path toward a self-hosting
   development environment on custom FPGA-based systems.

3. **Browser-based education** — the same tooling explorable in the browser
   for tutorials, blog posts, and video demonstrations.

## License

See [LICENSE](LICENSE).
