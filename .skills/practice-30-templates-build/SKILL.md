---
name: practice-30-templates-build
description: Use for practice templates/, examples/, PLACEHOLDER values, \null bodies, latexmk builds, --solutions, --print, and generated sheet smoke tests.
license: MIT
compatibility: opencode
metadata:
  package: practice
  topic: templates-build
---

# practice: Templates And Build Workflows

## When To Use

Use this skill when editing `templates/`, `examples/`, generated starter files,
or build commands for the `practice` class.

Trigger examples: `templates/`, `examples/`, `PLACEHOLDER`, `\null`,
`latexmk`, `--solutions`, `--print`, generated sheet, smoke test.

## Template Conventions

Templates are generator inputs. They use the same preamble style as
`template.seminar.tex`:

- TeX/LTeX editor comments at the top.
- The package license header.
- `\documentclass[<mode>, recordsfile={...}]{practice}`.
- Placeholder metadata passed through public `\Set...` setters.
- Optional `\renewcommand{\printsolutionbool}{true}` only when generating a solution version manually. Prefer `latexmk --solutions` with the local `latexmkrc` when building from the command line.
- `\null` immediately after `\begin{document}`.

Template skeleton:

```latex
\documentclass[seminar, recordsfile={records-PLACEHOLDER.lua}]{practice}

\SetSeminarName{PLACEHOLDER-TITLE}
\SetSeminarDate{PLACEHOLDER-DATE}

\begin{document}

\null

\input{PLACEHOLDER-BODY.tex}

\end{document}
```

Templates may intentionally have no sample exercise body. Do not add example
content to raw templates unless the generator contract needs it.

## Placeholder Policy

Raw templates are intentionally generation inputs and may be uncompilable until
placeholders are replaced. Common placeholders include:

- `PLACEHOLDER-NUMBER`
- `PLACEHOLDER-TITLE`
- `PLACEHOLDER-DATE`
- `PLACEHOLDER-DEADLINE`
- `PLACEHOLDER-BODY.tex`
- `records-PLACEHOLDER.lua`

Use placeholders only in `templates/` or other generator-owned starter files.

Before compiling a generated template, replace placeholders with real values and
provide the referenced body/records files.

## Example Conventions

Examples should mirror the template style but remain compilable:

- Use concrete metadata values, not `PLACEHOLDER-*`.
- Use `recordsfile={records.lua}`.
- Keep `\null` after `\begin{document}`.
- Preserve sample exercise content.
- Keep examples small enough to serve as smoke tests.

Example preamble pattern:

```latex
\documentclass[homework, recordsfile={records.lua}]{practice}

\SetHomeworkNumber{1}
\SetHomeworkDeadline{Deadline}
```

Mode-specific example content:

- `example.seminar.tex`: ungraded `exercise` items.
- `example.homework.tex`: graded `exercise` items and `\PrintTotalPoints`.
- `example.assessment.tex`: graded `exercise` items; automatic grading header.
- `example.quiz.tex`: graded `question` items and `\PrintTotalPoints[question]`.
- `example.test.tex`: ungraded `question` items, optionally with `tasks` choices.

## Build Commands

Compile examples from `examples/`:

```sh
latexmk example.seminar.tex
latexmk example.homework.tex
latexmk example.assessment.tex
latexmk example.quiz.tex
latexmk example.test.tex
```

Raw templates may fail until placeholders are resolved. When testing generated
documents from templates, replace placeholders first and compile from the correct
directory with the local `latexmkrc`.

Do not compile unresolved raw templates as a required verification step.

## Latexmk Flags

The local `latexmkrc` files map custom flags to boolean commands injected before
document loading. Use `--solutions` to enable `solution` and `answer`
environments. Quiz mode uses A5 pages for editing; use `--print` to impose two
identical A5 copies on one A4 landscape sheet:

```sh
latexmk --print example.quiz.tex
latexmk --solutions example.homework.tex
latexmk --print --solutions example.quiz.tex
```

Flag behavior:

- `--solutions` injects `\newcommand{\printsolutionbool}{true}` before document loading.
- `--print` injects `\newcommand{\printmodebool}{true}` before document loading.
- Flagged builds force a rebuild because they share the normal output filename.
- The first normal build after a flagged build is also forced by the saved flag state.

## Search Paths

Use the repository-provided `latexmkrc` files. They configure LuaLaTeX, shell
escape, `.build/`, and the search paths needed to find `practice.cls`, local
dependencies, and Lua records files.

- `examples/latexmkrc` sets `TEXINPUTS` and `LUAINPUTS` for the repo root and `.dependencies//`.
- `templates/latexmkrc` sets `TEXINPUTS` for the repo root and `.dependencies//`, and `LUAINPUTS` for the repo root.

## Verification Choices

Pick the smallest relevant verification:

- Edited class loading or shared setup: compile at least one representative example.
- Edited a mode file: compile the matching `examples/example.<mode>.tex`.
- Edited grading or solutions: compile with `latexmk --solutions` on a relevant example.
- Edited quiz print mode: compile `latexmk --print example.quiz.tex`.
- Edited examples: compile the edited examples.
- Edited raw templates only: inspect placeholder policy; compile only a generated/replaced file.

## Rules

- Do not remove `\null` from templates or examples.
- Keep templates unresolved when they are intended for generation workflows.
- Keep examples concrete and compilable.
- Do not compile raw placeholder templates as a verification step.
- Use `latexmk` with the repository-provided `latexmkrc` files for normal checks.
- Do not commit generated PDFs, SyncTeX files, `.build/`, `.xsim`, or other build artifacts unless explicitly requested.

## Avoid

```sh
# Wrong directory: misses the local latexmkrc search paths.
latexmk examples/example.quiz.tex

# Prefer running from examples/.
latexmk example.quiz.tex
```
