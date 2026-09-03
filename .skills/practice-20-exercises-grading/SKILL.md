---
name: practice-20-exercises-grading
description: Use practice exercises, points, solutions, grading totals, and grading headers.
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
adds points to the exercise goal and prints them in italic parentheses.

```latex
\begin{exercise}[points=2]
First part \addpt{1}. Second part \addpt{1}.
\end{exercise}
```

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
version:

```latex
\renewcommand{\printsolutionbool}{true}
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

## Rules

- Use `points=...` for homework and assessment exercises and for quiz questions.
- Do not assign points to ordinary test questions unless the test mode is intentionally being used as a graded sheet.
- Seminar mode switches exercise headings to the no-points template automatically.
- Test mode switches question headings to the no-points template automatically.
- Put `\PrintTotalPoints` after all graded exercises, not before them.
- Put `\PrintTotalPoints[question]` after all graded quiz questions, not before them.
- Do not redefine the built-in exercise templates in ordinary documents unless the task specifically requires a layout change.
- Keep solution printing controlled with `\printsolutionbool`, not by deleting solution or answer environments.
