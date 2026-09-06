---
name: practice-20-exercises-grading
description: Use for practice exercise, question, solution, answer, points, bonus-points, \addpt, \PrintTotalPoints, gradingtable, and solutions builds.
license: MIT
compatibility: opencode
metadata:
  package: practice
  topic: exercises-grading
---

# practice: Exercises And Grading

## When To Use

Use this skill when writing exercises in `practice` documents, assigning points,
adding solutions, printing totals, or working with assessment and quiz grading
headers.

Trigger examples: `exercise`, `question`, `solution`, `answer`, `points`,
`bonus-points`, `\addpt`, `\PrintTotalPoints`, `\gradingtable`, `--solutions`,
grading header.

## Mode-To-Environment Map

- `seminar`: use `exercise`; point headings are hidden by mode setup.
- `homework`: use graded `exercise`; print totals with `\PrintTotalPoints`.
- `assessment`: use graded `exercise`; grading header is printed automatically.
- `quiz`: use graded `question`; print totals with `\PrintTotalPoints[question]`.
- `test`: use `question`; point headings are hidden by mode setup.

## Exercise Basics

The class loads `xsim` and configures `exercise`/`solution` plus
`question`/`answer` types.

Seminar exercise without points:

```latex
\begin{exercise}
Problem statement.
\end{exercise}
```

Graded exercise:

```latex
\begin{exercise}[points=4]
Problem statement.
\end{exercise}
```

Quiz question with points:

```latex
\begin{question}[points=2]
Problem statement.
\end{question}
```

Ungraded test question:

```latex
\begin{question}
Problem statement.
\end{question}
```

Exercise with subtitle and bonus points:

```latex
\begin{exercise}[subtitle={Optional topic}, points=4, bonus-points=1]
Problem statement.
\end{exercise}
```

## Points Inside Exercises

Use `\addpt{<points>}` when assigning points to a part of an exercise body. It
adds points to the current item goal and prints them in italic parentheses.

```latex
\begin{exercise}
First part \addpt{1}. Second part \addpt{1}.
\end{exercise}
```

If you already pass `points=...` on the environment, do not also use `\addpt`
for the same points unless the intended total should include both.

Use `\PrintTotalPoints` after graded exercises to print the total score line:

```latex
\PrintTotalPoints
```

For graded quiz questions, pass the question type:

```latex
\PrintTotalPoints[question]
```

## Solutions

Exercises use the standard XSIM `solution` environment. Questions use the
`answer` environment. The class configures a compact italic solution heading for
both.

```latex
\begin{solution}
Solution text.
\end{solution}

\begin{answer}
Answer text.
\end{answer}
```

Solution printing is controlled by `\printsolutionbool`, which defaults to
`false` in the class. Override it in the preamble when generating a solution
version manually before XSIM setup runs:

```latex
\renewcommand{\printsolutionbool}{true}
```

When building from a directory with the local `latexmkrc`, prefer the equivalent
command-line flag:

```sh
latexmk --solutions example.homework.tex
```

Use `--solutions` for quiz answers too:

```sh
latexmk --solutions example.quiz.tex
```

## Tasks Lists

The class loads `tasks` and configures labels as `<current item>.<task>`. Use it
for answer choices or exercise/question parts.

```latex
\begin{exercise}[points=3]
Choose the correct answer.
\begin{tasks}(1)
  \task Answer option.
  \task Answer option.
  \task Answer option.
\end{tasks}
\end{exercise}
```

## Grading Headers

The `assessment` and `quiz` modes automatically print a grading header at the
start of the document after XSIM has restored saved item metadata. It includes:

- A grading table using the `sheetgr` XSIM table template (`exercise` for assessment, `question` for quiz).
- Student fields for name, group, and date.
- Total points in the footer.

The `sheetgr` template can be used manually when needed:

```latex
\gradingtable[type=exercise, template=sheetgr]
\gradingtable[type=question, template=sheetgr]
```

Automatic grading headers use `exercise` for `assessment` and `question` for
`quiz`. Do not switch the type unless the document deliberately uses the other
XSIM item type.

## Complete Patterns

Homework:

```latex
\begin{exercise}[points=2]
Problem statement.
\end{exercise}

\begin{solution}
Solution text.
\end{solution}

\PrintTotalPoints
```

Quiz:

```latex
\begin{question}[points=1]
Problem statement.
\end{question}

\begin{answer}
Answer text.
\end{answer}

\PrintTotalPoints[question]
```

## Rules

- Use `points=...` for homework and assessment exercises and for quiz questions.
- Do not assign points to ordinary test questions unless the test mode is intentionally being used as a graded sheet.
- Seminar mode switches exercise headings to the no-points template automatically.
- Test mode switches question headings to the no-points template automatically.
- Put `\PrintTotalPoints` after all graded exercises, not before them.
- Put `\PrintTotalPoints[question]` after all graded quiz questions, not before them.
- Do not redefine the built-in exercise templates in ordinary documents unless the task specifically requires a layout change.
- Keep solution printing controlled with `\printsolutionbool`, not by deleting solution or answer environments.
- Use `solution` with `exercise`; use `answer` with `question`.
- Keep `tasks` labels as configured unless the task is specifically about list layout.

## Avoid

```latex
% Wrong total type for quiz questions.
\PrintTotalPoints

% Use this in quiz mode instead.
\PrintTotalPoints[question]
```
