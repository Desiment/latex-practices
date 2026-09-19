---
name: practice-author-problems
description: Routing skill for practice material authoring requests. Use to choose between planning sheets, formatting items, formatting solutions, creating full sheets, templates, builds, and maintenance.
license: MIT
compatibility: opencode
metadata:
  package: practice
  task: author-problems-routing
---

# practice: Author Problems Router

## Scope

This is a routing skill for `practice` material authoring. It is shared across
different mathematical and scientific courses, including but not limited to
mathematics, statistics, logic, and physics.

Keep this skill discipline-agnostic. Course-specific methods, notation
preferences, and formatting conventions belong in the project's `AGENTS.md`.

## When To Use

Use this skill when the user asks broadly about writing, editing, planning, or
formatting practice-compatible exercises, questions, problems, solutions,
answers, points, choices, or sheets, and a narrower `practice-*` skill should be
selected.

Trigger examples: write problems, create exercises, add solutions, plan seminar,
format homework, quiz questions, answer choices, points, `tasks`, `solution`,
`answer`, `\addpt`.

## Routing

- Use `practice-plan-sheet` for planning a seminar, homework, assessment, quiz,
  test, or practice session before writing final TeX.
- Use `practice-format-items` for converting already-written tasks, statements,
  choices, scoring, derivations, and case definitions into `practice`-compatible
  TeX snippets.
- Use `practice-format-solutions` for planning, reviewing, writing, or editing
  solutions, proofs, counterexamples, and answers.
- Use `practice-create-sheet` for complete document scaffolds with
  `\documentclass`, `recordsfile`, metadata setters, `\null`, and totals.
- Use `practice-templates` for templates, examples, placeholders, generated
  starter files, and body-input conventions.
- Use `practice-build` for compiling or debugging `practice` documents,
  `latexmk`, LuaLaTeX, `--solutions`, `--print`, search paths, and generated
  artifacts.
- Use `practice-maintenance` only when maintaining `practice.cls`, mode files,
  class APIs, README examples, templates, XSIM setup, or public behavior.

## Default Behavior

If the user asks for a concrete edit, route to the narrow skill and perform the
edit. If the user asks for planning or solution strategy, do not jump to final
TeX; use the interview-first workflow from the appropriate narrow skill.

When multiple skills apply, use the smallest correct combination. Examples:

- Complete sheet with existing problems: `practice-create-sheet` plus
  `practice-format-items`.
- Complete sheet with final solutions: `practice-create-sheet` plus
  `practice-format-items` plus `practice-format-solutions`.
- Generated template body: `practice-templates` plus `practice-format-items`.

## Rules

- Do not duplicate detailed instructions from narrower skills here.
- Prefer narrow skills once the task type is clear.
- Preserve the user's language and the local project instructions from
  `AGENTS.md`.
