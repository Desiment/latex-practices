---
name: practice-build
description: Use for building or verifying practice TeX examples templates with latexmk LuaLaTeX --solutions --print TEXINPUTS LUAINPUTS and generated artifact rules.
license: MIT
compatibility: opencode
metadata:
  package: practice
  task: build
---

# practice: Build And Verify

## When To Use

Use this skill when compiling, smoke-testing, debugging build commands, checking
solution output, checking quiz print imposition, or explaining `latexmkrc` setup
for the `practice` class.

Trigger examples: build, compile, smoke test, `latexmk`, LuaLaTeX,
`--solutions`, `--print`, `TEXINPUTS`, `LUAINPUTS`, `.build`, generated PDF.

## Build Requirements

- Use LuaLaTeX; `practice.cls` calls `\RequireLuaTeX`.
- Use shell escape; the local `latexmkrc` files configure it.
- Build from the directory containing the relevant `latexmkrc`.
- Use local dependencies under `.dependencies/` through configured search paths.
- Run `just install` in a fresh checkout to clone/update dependencies and sync skills.

## Example Smoke Tests

Run these from `examples/`:

```sh
latexmk example.seminar.tex
latexmk example.homework.tex
latexmk example.assessment.tex
latexmk example.quiz.tex
latexmk example.test.tex
```

## Template Builds

Raw files in `templates/` are generator inputs and may not compile while they
contain `PLACEHOLDER-*` values or references such as `records-PLACEHOLDER.lua`.

After replacing placeholders and providing referenced files, run from
`templates/`:

```sh
latexmk template.seminar.tex
latexmk template.homework.tex
latexmk template.assessment.tex
latexmk template.quiz.tex
latexmk template.test.tex
```

Do not require unresolved raw templates to compile.

## Flags

The local `latexmkrc` files inject boolean commands before document loading:

```sh
latexmk --solutions example.homework.tex
latexmk --solutions example.quiz.tex
latexmk --print example.quiz.tex
latexmk --print --solutions example.quiz.tex
```

- `--solutions` enables `solution` and `answer` output.
- `--print` enables quiz print mode and imposes two identical A5 copies on one A4 landscape page.
- `--print` matters only for quiz-style output.
- `--print` and `--solutions` can be combined.

`\printmodebool` is read while quiz mode loads, so define it before
`\documentclass` if not using `latexmk --print`.

## Search Paths

The local `latexmkrc` files configure paths for the repository layout.

- `examples/latexmkrc` adds the repo root and `.dependencies//` to `TEXINPUTS` and `LUAINPUTS`.
- `templates/latexmkrc` adds the repo root and `.dependencies//` to `TEXINPUTS`, and the repo root to `LUAINPUTS`.

Avoid invoking `latexmk examples/example.quiz.tex` from the repo root because it
does not use `examples/latexmkrc` in the intended way.

## Verification Selection

- Edited one example: compile that example.
- Edited one mode file: compile `examples/example.<mode>.tex`.
- Edited shared class loading or XSIM setup: compile multiple representative examples.
- Edited solutions: include a `--solutions` build.
- Edited quiz print mode: include `latexmk --print example.quiz.tex`.
- Edited templates only: inspect placeholders; compile only generated/replaced files.

## Generated Artifacts

Do not commit generated artifacts unless explicitly requested:

- PDFs.
- SyncTeX files.
- `.build/` directories.
- XSIM/index/output helper files.

## Avoid

```sh
# Wrong directory for normal checks.
latexmk examples/example.quiz.tex

# Preferred from examples/.
latexmk example.quiz.tex
```
