---
name: practice-format-items
description: Use for converting already-written math/science tasks statements choices derivations case definitions and scoring into practice-compatible TeX using exercise/question/tasks/points and appropriate math layout.
license: MIT
compatibility: opencode
metadata:
  package: practice
  task: format-items
---

# practice: Format Items

## Scope

Use this skill when the mathematical or scientific content already exists and
the task is to format it as `practice`-compatible TeX. This skill is
discipline-agnostic and applies to mathematics, statistics, logic, physics, and
similar courses. Course-specific notation, methods, and local style preferences
belong in the project's `AGENTS.md`.

Use `practice-format-solutions` for planning or writing solutions. Use
`practice-plan-sheet` for planning a sheet or session before writing TeX. Use
`practice-create-sheet` for a complete document scaffold.

## When To Use

Trigger examples: format tasks, convert to practice, TeX exercises, TeX
questions, add points, add choices, `exercise`, `question`, `tasks`, `points`,
`bonus-points`, `\addpt`, `cases`, `align*`, `multline*`.

## Output Contract

Default to TeX snippets that can be pasted into a `practice` document body. Do
not include `\documentclass`, metadata setters, or package imports unless the
user asks for a complete sheet.

Match the user's requested language. If the source material is in Russian, keep
Russian text. If it is in English, keep English text.

## Notation Skill Routing

When formatting mathematical or scientific TeX, also load the relevant notation
skills. Do not rely only on existing source style.

- Use `xamsmath-60-probability` for probability measures, laws, expectations,
  variance/dispersion, covariance, stochastic notation, and implemented
  distributions.
- Use `xamsmath-10-braces-and-operators` for delimiter policy, upgraded
  operators, `\mathbx`, compact math microtype, and function/operator argument
  braces.
- Use `xamsmath-20-foundations` for set notation, logic, relations, mappings,
  number systems, and `\set`.
- Use `xamsmath-30-algebra` for `\abs`, norms, scalar products, complex numbers,
  vector notation, matrix operators, and algebraic notation.
- Use `xamsmath-40-calculus` for derivatives, differentials, integrals, and
  calculus notation.
- Use `xamsmath-50-combinatorics` for binomial, multinomial, partitions, and
  counting notation.

## Mode-To-Item Map

- Seminar: use `exercise`, usually without points.
- Homework: use `exercise` with `points=...` when graded.
- Assessment: use `exercise` with `points=...`.
- Quiz: use `question` with `points=...`.
- Test: use `question`, usually without points.

## Exercise And Question Environments

Use `exercise` for seminar, homework, and assessment items:

```latex
\begin{exercise}[points=4]
Problem statement.
\end{exercise}
```

For ungraded seminar work, omit points:

```latex
\begin{exercise}
Problem statement.
\end{exercise}
```

Use `question` for quiz and test items:

```latex
\begin{question}[points=2]
Problem statement.
\end{question}
```

For seminar problems with a named topic, use `subtitle`:

```latex
\begin{exercise}[subtitle={Лемма Слуцкого}]
Problem statement.
\end{exercise}
```

## Solution And Answer Environment Compatibility

When only formatting existing solution text, keep the compatible environment
pair:

```latex
\begin{exercise}
Problem statement.
\end{exercise}

\begin{solution}
Solution text.
\end{solution}
```

```latex
\begin{question}
Problem statement.
\end{question}

\begin{answer}
Answer text.
\end{answer}
```

Use `practice-format-solutions` if the solution content itself needs to be
planned, written, reviewed, or substantially changed.

## Reference And Theory Environments

Use semantic theorem-like environments for reference material in `practice`
sheets: `definition`, `theorem`, `lemma`, `corollary`, `proposition`, `example`,
`remark`, and `notation`.

```latex
\begin{definition}[note={Эмпирическая функция распределения}]
Definition text.
\end{definition}
```

For seminars with local definitions and a short reference, the desired general
format is: tasks and local definitions first, then a separate reference page.

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

## Math Layout

Use multiline math environments such as `align*`, `multline*`, or `aligned` for
long derivations instead of forcing one overlong display line. Choose the
environment by layout need:

- Use `align*` when aligning several equations at relation symbols.
- Use `multline*` for one long expression broken across lines.
- Use `aligned` inside another display when a compact aligned block is needed.

For objects defined by cases, use structured notation such as `cases`, a table,
or a system of conditions when it improves readability:

```latex
\[
  X=
  \begin{cases}
    1, & \text{if } A,\\
    0, & \text{otherwise.}
  \end{cases}
\]
```

For delimiter-specific decisions, follow `xamsmath-10-braces-and-operators`.

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

## Rules

- Keep generated snippets compatible with LuaLaTeX.
- Do not add package imports inside snippets.
- Use `solution` with `exercise` and `answer` with `question`.
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
