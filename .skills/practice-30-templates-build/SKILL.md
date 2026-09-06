---
name: practice-30-templates-build
description: Use practice template and example conventions, placeholders, null bodies, latexmk builds, and quiz print mode.
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

## Template Conventions

Templates use the same preamble style as `template.seminar.tex`:

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

## Example Conventions

Examples should mirror the template style but remain compilable:

- Use concrete metadata values, not `PLACEHOLDER-*`.
- Use `recordsfile={records.lua}`.
- Keep `\null` after `\begin{document}`.
- Preserve sample exercise content.

Example preamble pattern:

```latex
\documentclass[homework, recordsfile={records.lua}]{practice}

\SetHomeworkNumber{1}
\SetHomeworkDeadline{Deadline}
```

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

## Rules

- Do not remove `\null` from templates or examples.
- Keep templates unresolved when they are intended for generation workflows.
- Keep examples concrete and compilable.
- Do not compile raw placeholder templates as a verification step.
- Use `latexmk` with the repository-provided `latexmkrc` files for normal checks.
