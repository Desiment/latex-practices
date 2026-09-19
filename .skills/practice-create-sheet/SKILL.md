---
name: practice-create-sheet
description: Use for creating full practice seminar homework assessment quiz test TeX sheets with \documentclass, recordsfile, metadata setters, \null, totals, and solution flags.
license: MIT
compatibility: opencode
metadata:
  package: practice
  task: create-sheet
---

# practice: Create Sheet

## When To Use

Use this skill when creating a complete `practice` document or scaffold for a
seminar, homework, assessment, quiz, or test.

Trigger examples: create seminar, create homework, create quiz, full sheet,
`\documentclass`, `recordsfile`, `records.lua`, metadata, title, date, deadline.

If the user asks only to format problem statements as snippets, use
`practice-format-items` instead. If the user asks only for solution strategy or
solution text, use `practice-format-solutions` instead. If the user asks for a
complete sheet with problems, use this skill plus `practice-format-items`; add
`practice-format-solutions` when final solutions or answers are part of the
sheet.

## Mode Choice

| Mode | Use For | Main Item | Grading |
| --- | --- | --- | --- |
| `seminar` | Practice session handout | `exercise` | Ungraded |
| `homework` | Homework assignment | `exercise` | Graded |
| `assessment` | Control work | `exercise` | Graded with automatic header |
| `quiz` | Short A5 quiz | `question` | Graded with automatic header |
| `test` | Ungraded test sheet | `question` | Ungraded |

Choose exactly one mode option. Default mode is `seminar`, but explicit mode is
preferred in examples, templates, and generated files.

## Required Document Shape

Every complete sheet should have this shape:

```latex
\documentclass[<mode>, recordsfile={records.lua}]{practice}

<mode metadata setters>

\begin{document}

\null

<items>

<totals if needed>

\end{document}
```

Preserve `\null` immediately after `\begin{document}`.

## Mode Skeletons

Seminar:

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

## Preferred Seminar Layout

For seminar sheets with local definitions and a short reference, the desired
format is: tasks and local definitions first, then a separate reference page.
Use semantic environments for definitions and reference material, put task topics
in `exercise` subtitles, and do not use a two-column layout by default.

Homework:

```latex
\documentclass[homework, recordsfile={records.lua}]{practice}

\SetHomeworkNumber{1}
\SetHomeworkDeadline{DEADLINE}

\begin{document}

\null

\begin{exercise}[points=2]
Problem statement.
\end{exercise}

\PrintTotalPoints

\end{document}
```

Assessment:

```latex
\documentclass[assessment, recordsfile={records.lua}]{practice}

\SetAssessmentNumber{1}
\SetAssessmentDate{DATE}

\begin{document}

\null

\begin{exercise}[points=4]
Problem statement.
\end{exercise}

\end{document}
```

Quiz:

```latex
\documentclass[quiz, recordsfile={records.lua}]{practice}

\SetQuizNumber{1}
\SetQuizDate{DATE}

\begin{document}

\null

\begin{question}[points=1]
Problem statement.
\end{question}

\PrintTotalPoints[question]

\end{document}
```

Test:

```latex
\documentclass[test, recordsfile={records.lua}]{practice}

\SetTestTitle{TEST TITLE}
\SetTestDate{DATE}

\begin{document}

\null

\begin{question}
Problem statement.
\end{question}

\end{document}
```

## Metadata Commands

- Seminar: `\SetSeminarName{...}`, `\SetSeminarDate{...}`.
- Homework: `\SetHomeworkNumber{...}`, `\SetHomeworkDeadline{...}`.
- Assessment: `\SetAssessmentNumber{...}`, `\SetAssessmentDate{...}`, `\SetAssessmentTitle{...}`.
- Quiz: `\SetQuizNumber{...}`, `\SetQuizDate{...}`, `\SetQuizTitle{...}`.
- Test: `\SetTestTitle{...}`, `\SetTestDate{...}`.

Printable metadata commands are available when needed: `\SeminarName`,
`\SeminarDate`, `\HomeworkNumber`, `\HomeworkDeadline`, `\AssessmentNumber`,
`\AssessmentDate`, `\AssessmentTitle`, `\QuizNumber`, `\QuizDate`,
`\QuizTitle`, `\TestTitle`, and `\TestDate`.

Course metadata comes from `records.lua` and prints with `\PracticeSubject`,
`\PracticeSpeciality`, `\PracticeCourse`, and `\PracticeUni`.

## Records File

Use `recordsfile={records.lua}` for examples and normal sheets unless the user
asks for another records file.

Minimal records file:

```lua
return {
  subject = "Математический анализ",
  speciality = "Прикладная математика",
  course = "1",
  uni = "Университет"
}
```

## Solution And Print Variants

- Use `latexmk --solutions <file>.tex` to print `solution` and `answer` environments.
- Use `latexmk --print example.quiz.tex` for quiz A5-to-A4 print imposition.
- `\printmodebool` must be defined before `\documentclass` if not using `latexmk --print`.
- Prefer command-line flags over manually redefining booleans in generated documents.

## Rules

- Use `exercise` in seminar, homework, and assessment.
- Use `question` in quiz and test.
- Put `\PrintTotalPoints` after all graded homework exercises.
- Put `\PrintTotalPoints[question]` after all graded quiz questions.
- Do not add points to ordinary seminar or test items unless explicitly requested.
- Do not redefine printable metadata commands such as `\QuizDate`; use setters.
- Do not load `flsuite`, `tssuite`, `xamsmath`, `xsim`, or `tasks` manually for ordinary sheets; `practice.cls` loads them.
- For seminar reference material, prefer semantic environments already provided
  by `practice.cls` over bold inline labels like `\textbf{Definition}`.
- For seminar task topics, use `subtitle` in the `exercise` options rather than
  standalone section headings before exercises.
- For seminars with a reference page, place tasks before the reference unless the
  user requests another order.

## Avoid

```latex
% Too late for quiz print layout.
\documentclass[quiz]{practice}
\newcommand{\printmodebool}{true}

% Wrong total command for quiz questions.
\PrintTotalPoints
```
