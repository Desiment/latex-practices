---
name: practice-author-problems
description: Use for writing practice-compatible TeX exercises questions problems solutions answers points tasks choices and problem snippets for seminar homework assessment quiz test sheets.
license: MIT
compatibility: opencode
metadata:
  package: practice
  task: author-problems
---

# practice: Author Problems

## When To Use

Use this skill when generating or editing problem statements, exercise snippets,
questions, solutions, answers, point values, answer choices, or task lists for a
`practice` document.

Trigger examples: write problems, create exercises, add solutions, seminar
problems, homework problems, quiz questions, answer choices, points, `tasks`,
`solution`, `answer`, `\addpt`.

If the user asks for a complete document scaffold, also use
`practice-create-sheet`.

## Output Contract

Default to TeX that can be pasted into a `practice` document body. Do not include
`\documentclass` or metadata unless the user asks for a full sheet.

Match the user's requested language. If the user writes in Russian, write problem
statements and solutions in Russian. If the user writes in English, use English.

When asked for solutions, place each `solution` or `answer` immediately after its
matching `exercise` or `question`.

## Mode-To-Item Map

- Seminar: use `exercise`, usually without points.
- Homework: use `exercise` with `points=...` when graded.
- Assessment: use `exercise` with `points=...`.
- Quiz: use `question` with `points=...`.
- Test: use `question`, usually without points.

## Exercise And Solution

Use this pair for seminar, homework, and assessment items:

```latex
\begin{exercise}[points=4]
Problem statement.
\end{exercise}

\begin{solution}
Solution text.
\end{solution}
```

For ungraded seminar work, omit points:

```latex
\begin{exercise}
Problem statement.
\end{exercise}
```

## Question And Answer

Use this pair for quiz and test items:

```latex
\begin{question}[points=2]
Problem statement.
\end{question}

\begin{answer}
Answer text.
\end{answer}
```

For ungraded test work, omit points:

```latex
\begin{question}
Problem statement.
\end{question}
```

## Points

Use environment-level points for ordinary graded items:

```latex
\begin{exercise}[points=3]
Problem statement.
\end{exercise}
```

Use `bonus-points` only when the item has explicit bonus credit:

```latex
\begin{exercise}[points=4, bonus-points=1]
Problem statement.
\end{exercise}
```

Use `\addpt{<points>}` for scoring individual parts inside an item. It adds to
the current item total and prints the point marker:

```latex
\begin{exercise}
Prove the estimate \addpt{2}. Give an example \addpt{1}.
\end{exercise}
```

Do not combine `points=...` and `\addpt` for the same scoring unless the desired
total should include both.

## Choices And Parts

Use `tasks` for choices or compact parts. The class already loads and configures
the package.

```latex
\begin{question}[points=1]
Choose the correct answer.
\begin{tasks}(1)
  \task First option.
  \task Second option.
  \task Third option.
\end{tasks}
\end{question}
```

Use `\begin{tasks}(2)` or another column count only when it improves layout.

## Totals

If generating a full graded homework body, put totals after all exercises:

```latex
\PrintTotalPoints
```

If generating a full graded quiz body, put totals after all questions:

```latex
\PrintTotalPoints[question]
```

Do not include totals for snippets unless the user asks for a complete body or
sheet.

## Math And Notation

`practice.cls` loads `xamsmath` with common plugins. Prefer project notation from
the available `xamsmath-*` skills when writing mathematical content.

Common examples:

```latex
\set{x \in \R | x > 0}
\dd{x}
\E X
\binom{n}{k}
```

## Rules

- Keep generated snippets compatible with LuaLaTeX.
- Do not add package imports inside snippets.
- Use `solution` with `exercise` and `answer` with `question`.
- Put solutions immediately after their matching problem when solutions are requested.
- Use points only in graded modes or when explicitly requested.
- Preserve the user-requested number of problems and point totals.
- Avoid external image/code/data files unless the user asks for them.
- Prefer clear, compilable TeX over clever formatting.

## Avoid

```latex
% Wrong: answer belongs to question, not exercise.
\begin{exercise}
Problem.
\end{exercise}
\begin{answer}
Answer.
\end{answer}

% Wrong: solution belongs to exercise, not question.
\begin{question}
Problem.
\end{question}
\begin{solution}
Solution.
\end{solution}
```
