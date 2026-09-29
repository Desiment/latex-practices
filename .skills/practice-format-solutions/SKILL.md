---
name: practice-format-solutions
description: Use for planning reviewing or writing solutions proofs counterexamples and answers for practice materials. Interview per problem and propose strategies before final TeX unless the user explicitly asks for final output.
license: MIT
compatibility: opencode
metadata:
  package: practice
  task: format-solutions
---

# practice: Format Solutions

## Scope

Use this skill for solution content: proofs, computations, counterexamples,
answers, explanations, and solution review for `practice` materials. This skill
is discipline-agnostic and applies to mathematics, statistics, logic, physics,
and similar courses. Course-specific methods, notation, and local solution style
belong in the project's `AGENTS.md`.

Use `practice-format-items` when the task is only to format existing material as
TeX. Use `practice-plan-sheet` when planning a sheet or session before selecting
solution strategies.

## Interaction Mode

Do not write final solutions immediately by default. First work problem by
problem:

- Clarify the goal of each problem or subpart when it is ambiguous.
- Propose several viable solution strategies.
- Briefly compare the strategies by length, prerequisites, elegance, and fit for
  the course level.
- Ask for the user's choice when the intended strategy is not clear.

Write final solutions only after an explicit user signal such as `давай
финальный план`, `пиши решение`, `оформи итог`, `да, делай`, `write the final
solution`, or an equivalent instruction.

If the user explicitly asks to add or edit final solutions in files, proceed with
the edit while preserving the expected pedagogical route from context.

## Output Contract

For final TeX output, place each `solution` or `answer` immediately after its
matching `exercise` or `question` unless the existing document structure clearly
uses another convention.

Use `solution` with `exercise`:

```latex
\begin{exercise}
Problem statement.
\end{exercise}

\begin{solution}
Solution text.
\end{solution}
```

Use `answer` with `question`:

```latex
\begin{question}
Problem statement.
\end{question}

\begin{answer}
Answer text.
\end{answer}
```

Match the user's requested language and the language of the source material.
For `.tex` source layout, follow the source-formatting policy from
`practice-format-items`: do not hard-wrap prose; keep intentional line breaks
for TeX structure, display math, lists, cases, tables, figures, and aligned
derivations.

## Solution Structure

Mirror the structure of the problem. If the problem has parts `(a)`, `(b)`,
`(c)` or a list of statements, the solution should normally use the same part
structure.

Each solution part should explicitly answer the matching problem part. Avoid
merging multiple parts into a single narrative when that makes the answer harder
to verify.

For prove-or-disprove tasks, state the status at the start of each part, for
example `The statement is true` or `The statement is false`, then give the proof
or counterexample.

For counterexamples, explicitly check all assumptions in the original statement,
not only the conclusion being falsified.

After changing a problem statement, re-check that the solution proves the updated
statement and that examples still satisfy all hypotheses.

## References To Results

Do not write references such as `as shown above`, `by the theorem above`, or
`as already recorded` unless the referenced fact is actually present earlier in
the current document or current solution.

If using a theorem, lemma, inference rule, or standard fact, make the application
self-contained: state what objects it applies to and why its assumptions hold.

Avoid pedagogical jumps: when a new object, notation, or result appears in a
solution, give a minimal explanation before using it.

## Pedagogical Route

Preserve the expected pedagogical route when context makes it clear. Do not
replace an intended method with a different correct method unless the user asks
for an alternative or there is a clear reason.

Before writing new solutions or substantially rewriting existing solutions,
infer the local style from the current document and nearby materials. Preserve
conventions for how standard methods are introduced, how parameter conditions
are displayed, how much routine calculation is shown, and whether the course
prefers direct derivation or motivation before a method.

When several strategies are plausible, present them before writing final text.
Examples of strategy distinctions include direct proof vs contradiction,
syntactic derivation vs semantic argument, computation vs invariant, and local
calculation vs general theorem.

## Solution Audit

Before finalizing a solution edit, audit each nontrivial implication. Check for
hidden assumptions and exceptional cases when the argument uses properties such
as nonzero denominators, positivity, invertibility, uniqueness, monotonicity,
injectivity, independence, continuity, convergence, or equality cases.

When constants or parameters are determined from several conditions, make the
conditions and their consequences easy to verify using the local style: systems,
cases, aligned equations, tables, or concise prose as appropriate.

Avoid meta-commentary about the proof. Prefer stating the actual verification
over phrases such as `it is important to note`, `we should not forget`,
`obviously`, or `clearly` when they stand in for an argument.

Show computations at the level needed for a student to reproduce the step. Do
not compress a substitution, cancellation, reduction, limit, integral,
derivative, probability calculation, or parameter fit to only its result when it
is the main work of the problem.

## Formatting Boundary

Use `practice-format-items` for purely typographic choices such as whether a
long formula should be `align*` or `multline*`, or whether a case definition
should be `cases` or a table. This skill may apply those conventions in final
solutions, but it should not be triggered solely for TeX layout work.

## Rules

- Keep final snippets compatible with LuaLaTeX.
- Do not add package imports inside snippets.
- Use `solution` with `exercise` and `answer` with `question`.
- Preserve problem numbering and part labels unless the user asks to change them.
- Keep explanations concise enough for course materials but complete enough to
  verify each step.
