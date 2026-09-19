---
name: practice-plan-sheet
description: Use for planning seminar homework assessment sheets or practice sessions including goals sequence difficulty problem mix scoring and lesson flow. Interview first and produce final plan only after user approval.
license: MIT
compatibility: opencode
metadata:
  package: practice
  task: plan-sheet
---

# practice: Plan Sheet

## Scope

Use this skill for planning a practice session or sheet before writing final
TeX. It applies to seminars, homework, assessments, quizzes, tests, and similar
teaching materials across mathematics, statistics, logic, physics, and other
scientific courses. Course-specific methods, notation, and local style
preferences belong in the project's `AGENTS.md`.

Use `practice-create-sheet` for a complete document scaffold. Use
`practice-format-items` after the content is selected and needs TeX formatting.
Use `practice-format-solutions` when planning or writing solution strategies.

## Interaction Mode

Do not produce the final plan immediately by default. First interview the user
to identify constraints and intent.

Ask only the questions needed for the current request. Useful dimensions:

- Topic or section of the course.
- Learning goals.
- Student level and prerequisites.
- Session duration or expected workload.
- Sheet mode: seminar, homework, assessment, quiz, or test.
- Desired number of problems or pages.
- Desired difficulty mix.
- Whether solutions, hints, answers, or grading are needed.
- Whether the sheet should include reference material or definitions.

After gathering enough context, propose several planning strategies. Compare
them briefly and ask the user which one to use if the choice is not obvious.

Produce the final plan only after an explicit user signal such as `давай
финальный план`, `утверждаю`, `да, делай`, `write the final plan`, or an
equivalent instruction.

## Planning Strategies

Common structures include:

- Theory-to-practice: definitions or facts first, then guided problems.
- Warm-up-to-proof: computations or simple checks before conceptual tasks.
- Problem-first: start with motivating tasks, then extract theory.
- Mixed difficulty: interleave routine, medium, and challenge tasks.
- Assessment-oriented: align tasks to points, learning outcomes, and time.
- Spiral review: revisit old concepts while introducing a new one.

Choose structures based on the user's goals and local course conventions.

## Output Contract

For planning output, prefer a concise outline with:

- Goals.
- Assumptions about student background.
- Problem sequence.
- Intended method or concept for each problem.
- Difficulty or timing notes when helpful.
- Optional grading or points distribution for graded modes.

Do not write TeX unless the user asks to proceed to formatting or sheet
creation. When TeX is requested, route to `practice-format-items` or
`practice-create-sheet` as appropriate.

## Rules

- Keep the plan discipline-agnostic unless project instructions or the user give
  course-specific preferences.
- Do not invent course metadata such as dates, deadlines, or official titles
  unless the user provides them.
- Prefer a small number of coherent tasks over a large undifferentiated list.
- Make prerequisites and intended learning outcomes explicit when useful.
