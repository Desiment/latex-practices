---
name: practice-10-modes-metadata
description: Use practice modes and metadata fields for seminars, homework, assessments, quizzes, and tests.
license: MIT
compatibility: opencode
metadata:
  package: practice
  topic: modes-metadata
---

# practice: Modes And Metadata

## When To Use

Use this skill when authoring or editing a `practice` document preamble,
choosing a document mode, setting sheet metadata, or inserting metadata values
inside document text.

## Mode Selection

Each mode is a class option:

```latex
\documentclass[seminar]{practice}
\documentclass[homework]{practice}
\documentclass[assessment]{practice}
\documentclass[quiz]{practice}
\documentclass[test]{practice}
```

Mode behavior:

- `seminar`: practice sheet, section heading from seminar name, no point display in exercise headings.
- `homework`: homework sheet with deadline in the header.
- `assessment`: control-work sheet with grading table and student fields.
- `quiz`: compact A5 quiz with grading table and optional print layout.
- `test`: test sheet with title/date header and student-name line.

## Public Metadata Setters

Set document metadata in the preamble with `\Set...` commands.

Seminar:

```latex
\SetSeminarName{Seminar Topic}
\SetSeminarDate{Date}
```

Homework:

```latex
\SetHomeworkNumber{1}
\SetHomeworkDeadline{Deadline}
```

Assessment:

```latex
\SetAssessmentNumber{1}
\SetAssessmentDate{Date}
\SetAssessmentTitle{Контрольная работа №\AssessmentNumber}
```

Quiz:

```latex
\SetQuizNumber{1}
\SetQuizDate{Date}
\SetQuizTitle{Летучка №\QuizNumber}
```

Test:

```latex
\SetTestTitle{Test Title}
\SetTestDate{Date}
```

## Printable Metadata Commands

These commands print the current metadata values and can be used in document text:

- Seminar: `\SeminarName`, `\SeminarDate`.
- Homework: `\HomeworkNumber`, `\HomeworkDeadline`.
- Assessment: `\AssessmentNumber`, `\AssessmentDate`, `\AssessmentTitle`.
- Quiz: `\QuizNumber`, `\QuizDate`, `\QuizTitle`.
- Test: `\TestTitle`, `\TestDate`.
- Course: `\PracticeSubject`, `\PracticeSpeciality`, `\PracticeCourse`, `\PracticeUni`.

## Generated Template Style

Use the public `\Set...` setters in handwritten documents, examples, and
generated templates. Placeholder values can be passed to setters directly:

```latex
\SetSeminarName{PLACEHOLDER-TITLE}
\SetSeminarDate{PLACEHOLDER-DATE}
```

Do not redefine printable metadata commands such as `\SeminarName` or
`\QuizDate`; those commands are backed by the class text-field mechanism.

## Rules

- Choose exactly one mode option per document.
- Put metadata commands before `\begin{document}`.
- Prefer `\Set...` commands in examples, templates, and real documents.
- Keep placeholders as setter values in generator-owned templates.
- Use printable metadata commands in text instead of duplicating values manually.
