---
name: practice-00-loading-options
description: Use for practice \documentclass, recordsfile, records.lua, LuaLaTeX, local dependencies, and class-loading setup for teaching sheets.
license: MIT
compatibility: opencode
metadata:
  package: practice
  topic: loading-options
---

# practice: Loading And Options

## When To Use

Use this skill when creating or reviewing a `practice` document preamble,
choosing the class options, wiring `records.lua`, or fixing compile failures
related to class loading and search paths.

Trigger examples: `\documentclass`, `recordsfile`, `records.lua`, LuaLaTeX,
`TEXINPUTS`, `.dependencies`, `latexmkrc`, seminar, homework, assessment, quiz,
test.

## Required Setup

Minimal document:

```latex
\documentclass[seminar, recordsfile={records.lua}]{practice}

\SetSeminarName{SEMINAR TOPIC}
\SetSeminarDate{DATE}

\begin{document}

\null

\begin{exercise}
Problem statement.
\end{exercise}

\end{document}
```

Select exactly one public mode:

```latex
\documentclass[seminar, recordsfile={records.lua}]{practice}
\documentclass[homework]{practice}
\documentclass[assessment]{practice}
\documentclass[quiz]{practice}
\documentclass[test]{practice}
```

Use a non-default records file:

```latex
\documentclass[seminar, recordsfile={records.lua}]{practice}
```

## Class Options

- `seminar`: ungraded practice sheet using `exercise`; no points in exercise headings.
- `homework`: graded homework sheet using `exercise`; supports totals.
- `assessment`: graded control-work sheet using `exercise`; prints grading header.
- `quiz`: graded A5 quiz using `question`; supports print imposition.
- `test`: ungraded test sheet using `question`; prints student-name block.
- `recordsfile=<file>`: Lua file with course metadata. Defaults to `records.lua`.

Default mode is `seminar`.

Pass unknown options through to the base `article` class.

## Records File

The class requires LuaLaTeX and loads course metadata from `records.lua` or the
file selected with `recordsfile=...`. The class resolves the file with `kpse` and
then executes it with Lua `dofile`.

Minimal records file:

```lua
return {
  subject = "Математический анализ",
  speciality = "Прикладная математика",
  course = "1",
  uni = "Университет"
}
```

Course metadata is exposed through these printable commands:

- `\PracticeSubject`
- `\PracticeSpeciality`
- `\PracticeCourse`
- `\PracticeUni`

These values are backed by `tssuite` text fields. Do not redefine the printable
commands in documents; change the records file or use the corresponding class
setters only when intentionally overriding metadata.

## Loaded Packages

Ordinary `practice` documents should not load these packages manually just to use
the class features; `practice.cls` already loads them:

- `flsuite` with `tikz`, `listings`, and `memoization`.
- `tssuite` with `theorems`.
- `xamsmath` with `all`, plus `foundations`, `algebra`, `calculus`, `combinatorics`, and `probability` plugins.
- `xsim` and `tasks` for exercises, questions, solutions, answers, and task lists.

## Build Requirements

- Use LuaLaTeX; the class calls `\RequireLuaTeX`.
- Enable shell escape for the configured `flsuite`/memoization workflow.
- Ensure the class root and `.dependencies//` are on `TEXINPUTS`.
- Ensure the class root and `.dependencies//` are on `LUAINPUTS` when records or dependency Lua files are involved.
- Use the local `latexmkrc` in `examples/` or `templates/` when possible.

Example `latexmkrc` essentials:

```perl
$pdf_mode  = 4;
$aux_dir   = '.build';
$out_dir   = '.';
$lualatex = 'lualatex %O -halt-on-error --shell-escape %S';

ensure_path('TEXINPUTS', '../.dependencies//');
ensure_path('TEXINPUTS', '..//');
ensure_path('LUAINPUTS', '..//');
```

From a fresh checkout, run `just install` to clone/update `.dependencies/` and
link project/dependency skills into `.opencode/skills/`.

## Build Flags

The local `latexmkrc` files support class booleans through pre-TeX injection:

```sh
latexmk --solutions example.homework.tex
latexmk --print example.quiz.tex
latexmk --print --solutions example.quiz.tex
```

- `--solutions` defines `\printsolutionbool` before loading the document.
- `--print` defines `\printmodebool` before loading the document; quiz mode reads this while the mode file is loaded.
- If not using `latexmk --print`, define `\printmodebool` before `\documentclass` for quiz print imposition.

## Rules

- Prefer `\documentclass[<mode>, recordsfile={records.lua}]{practice}` in examples.
- Use `recordsfile={records-PLACEHOLDER.lua}` only in generator templates or generated documents that really have that file.
- Put per-document course metadata in `records.lua` unless intentionally using another `recordsfile`.
- Compile from `examples/` or `templates/` with their local `latexmkrc` so paths and shell escape are correct.
- Do not test this class with pdfLaTeX.
- Do not compile raw templates with unresolved placeholders as a required verification step.

## Avoid

```latex
% Missing mode-specific records file in templates unless generated first.
\documentclass[quiz, recordsfile={records-PLACEHOLDER.lua}]{practice}

% Too late for quiz print layout; quiz mode has already loaded.
\documentclass[quiz]{practice}
\newcommand{\printmodebool}{true}
```
