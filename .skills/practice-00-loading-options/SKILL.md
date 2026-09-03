---
name: practice-00-loading-options
description: Load the practice class with the right mode, records file, and build setup for teaching sheets.
license: MIT
compatibility: opencode
metadata:
  package: practice
  topic: loading-options
---

# practice: Loading And Options

## When To Use

Use `practice` for Russian-language teaching sheets: seminars, homework sheets,
assessments, quizzes, and tests with shared course metadata, XSIM exercises,
grading tables, and consistent headers/footers.

## Required Setup

Basic seminar document:

```latex
\documentclass[seminar]{practice}
```

Select another mode:

```latex
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

- `seminar`: practice/seminar sheet, no exercise points in headings.
- `homework`: homework sheet with points and total score support.
- `assessment`: control-work sheet with points and a grading header.
- `quiz`: A5 quiz sheet with points, grading header, and optional print imposition.
- `test`: test sheet with points and a student-name header.
- `recordsfile=<file>`: Lua file with course metadata. Defaults to `records.lua`.

Default mode is `seminar`.

## Records File

The class requires LuaLaTeX and loads course metadata from `records.lua` or the
file selected with `recordsfile`.

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

## Build Requirements

- Use LuaLaTeX; the class calls `\RequireLuaTeX`.
- Enable shell escape because `flsuite` loads minted/listings and memoization support.
- Ensure the class root and `.dependencies//` are on `TEXINPUTS` when compiling from `examples/` or `templates/`.
- Use the local `latexmkrc` files in `examples/` and `templates/` when possible.

Example `latexmkrc` setup:

```perl
$pdf_mode  = 4;
$aux_dir   = '.build';
$out_dir   = '.';
$lualatex = 'lualatex %O -halt-on-error --shell-escape %S';

ensure_path('TEXINPUTS', '../.dependencies//');
ensure_path('TEXINPUTS', '..//');
```

## Rules

- Do not load `flsuite`, `tssuite`, `xamsmath`, `xsim`, or `tasks` manually in ordinary documents; the class loads them.
- Put per-document course metadata in `records.lua` unless intentionally using another `recordsfile`.
- Compile from `examples/` or `templates/` with their local `latexmkrc` so paths and shell escape are correct.
