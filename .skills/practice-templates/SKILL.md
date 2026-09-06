---
name: practice-templates
description: Use for editing practice templates/ examples/ PLACEHOLDER values generated starter TeX files records-PLACEHOLDER.lua body inputs and template conventions.
license: MIT
compatibility: opencode
metadata:
  package: practice
  task: templates
---

# practice: Templates And Examples

## When To Use

Use this skill when editing `templates/`, `examples/`, generated starter files,
placeholder policy, example smoke-test files, or generator-owned document shapes.

Trigger examples: `templates/`, `examples/`, `PLACEHOLDER`, generated starter,
`records-PLACEHOLDER.lua`, `PLACEHOLDER-BODY.tex`, `\null`, example sheet.

For compiling examples or generated templates, also use `practice-build`.

## Template Contract

Templates are generator inputs. They may contain placeholders and may be
uncompilable until a generator replaces those placeholders.

Template files should keep this shape:

```latex
\documentclass[<mode>, recordsfile={records-PLACEHOLDER.lua}]{practice}

<metadata setters with PLACEHOLDER values>

\begin{document}

\null

<optional generated body input>

\end{document}
```

Common placeholders:

- `PLACEHOLDER-NUMBER`
- `PLACEHOLDER-TITLE`
- `PLACEHOLDER-DATE`
- `PLACEHOLDER-DEADLINE`
- `PLACEHOLDER-BODY.tex`
- `records-PLACEHOLDER.lua`

Use placeholders only in `templates/` or other generator-owned starter files.

## Example Contract

Examples are concrete smoke-test documents. They should compile without
generation.

- Use `recordsfile={records.lua}`.
- Use concrete metadata values, not `PLACEHOLDER-*`.
- Preserve the license/editor comment block already used by examples.
- Preserve `\null` immediately after `\begin{document}`.
- Keep sample content minimal and representative.

Mode-specific examples:

- `example.seminar.tex`: ungraded `exercise` items.
- `example.homework.tex`: graded `exercise` items and `\PrintTotalPoints`.
- `example.assessment.tex`: graded `exercise` items with automatic grading header.
- `example.quiz.tex`: graded `question` items and `\PrintTotalPoints[question]`.
- `example.test.tex`: ungraded `question` items, optionally with `tasks` choices.

## Metadata In Templates

Pass placeholders through public setters:

```latex
\SetSeminarName{PLACEHOLDER-TITLE}
\SetSeminarDate{PLACEHOLDER-DATE}
```

Do not redefine printable metadata commands such as `\SeminarName`,
`\HomeworkDeadline`, or `\QuizDate`.

## Body Inputs

If a template references a generated body file, keep the body as a normal TeX
input after `\null`:

```latex
\input{PLACEHOLDER-BODY.tex}
```

Generated body files should contain only body content unless the generator
explicitly owns the full document.

## Rules

- Do not remove `\null` from templates or examples.
- Keep raw templates unresolved when they are intended for generation workflows.
- Keep examples concrete and compilable.
- Do not add sample exercises to raw templates unless the generator contract needs them.
- Do not compile unresolved raw templates as verification.
- Update matching examples, templates, README, and skills when public behavior changes.

## Avoid

```latex
% Wrong in examples: examples must be concrete.
\SetQuizDate{PLACEHOLDER-DATE}

% Wrong in ordinary generated bodies: body snippets should not open a document.
\begin{document}
```
