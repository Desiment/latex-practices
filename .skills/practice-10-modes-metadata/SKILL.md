---
name: practice-10-modes-metadata
description: Use for practice modes, \SetSeminarName, \SetHomeworkNumber, \SetAssessmentTitle, \SetQuizTitle, \SetTestTitle, and printable metadata fields.
license: MIT
compatibility: opencode
metadata:
  package: practice
  topic: modes-metadata
---

# practice: Modes And Metadata

## When To Use

Use this skill when editing mode-specific metadata, setting titles/dates/numbers
in the preamble, or deciding which public printable command to use in document
text or class layouts.

Trigger examples: `\SetSeminarName`, `\SetHomeworkDeadline`,
`\SetAssessmentTitle`, `\SetQuizDate`, `\SetTestTitle`, `\SeminarName`,
`\QuizTitle`, metadata, title, date, deadline.

## Mode Selection

Each mode is a class option. Choose exactly one mode for each document:

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

Default mode is `seminar` if no mode option is provided.

## Public Metadata Setters

Set document metadata in the preamble with public `\Set...` commands. The mode
files create these fields with `\CreateTextField`, so repeated setter calls
replace the stored value globally.

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

Course metadata comes from `records.lua` by default:

```lua
return {
  subject = "Математический анализ",
  speciality = "Прикладная математика",
  course = "1",
  uni = "Университет"
}
```

## Printable Metadata Commands

These commands print the current metadata values and can be used in document text:

- Seminar: `\SeminarName`, `\SeminarDate`.
- Homework: `\HomeworkNumber`, `\HomeworkDeadline`.
- Assessment: `\AssessmentNumber`, `\AssessmentDate`, `\AssessmentTitle`.
- Quiz: `\QuizNumber`, `\QuizDate`, `\QuizTitle`.
- Test: `\TestTitle`, `\TestDate`.
- Course: `\PracticeSubject`, `\PracticeSpeciality`, `\PracticeCourse`, `\PracticeUni`.

## Defaults And Headers

Mode defaults are intentionally sparse; examples and templates should set the
visible values explicitly.

- `seminar`: empty `\SeminarName` and `\SeminarDate`; begins with `\section*{\SeminarName}`.
- `homework`: empty `\HomeworkNumber` and `\HomeworkDeadline`; header shows homework number and deadline.
- `assessment`: empty number/date; default title is `Контрольная работа №\AssessmentNumber`.
- `quiz`: empty number/date; default title is `Летучка №\QuizNumber`.
- `test`: empty date; default title is `Тест`.

## Generated Template Style

Use the public `\Set...` setters in handwritten documents, examples, and
generated templates. Placeholder values can be passed to setters directly:

```latex
\SetSeminarName{PLACEHOLDER-TITLE}
\SetSeminarDate{PLACEHOLDER-DATE}
```

Do not redefine printable metadata commands such as `\SeminarName` or
`\QuizDate`; those commands are backed by the class text-field mechanism.

## Mode Skeletons

Seminar:

```latex
\documentclass[seminar, recordsfile={records.lua}]{practice}
\SetSeminarName{SEMINAR TOPIC}
\SetSeminarDate{DATE}
```

Homework:

```latex
\documentclass[homework, recordsfile={records.lua}]{practice}
\SetHomeworkNumber{1}
\SetHomeworkDeadline{DEADLINE}
```

Assessment:

```latex
\documentclass[assessment, recordsfile={records.lua}]{practice}
\SetAssessmentNumber{1}
\SetAssessmentDate{DATE}
```

Quiz:

```latex
\documentclass[quiz, recordsfile={records.lua}]{practice}
\SetQuizNumber{1}
\SetQuizDate{DATE}
```

Test:

```latex
\documentclass[test, recordsfile={records.lua}]{practice}
\SetTestTitle{TEST TITLE}
\SetTestDate{DATE}
```

## Rules

- Choose exactly one mode option per document.
- Put metadata commands before `\begin{document}`.
- Prefer `\Set...` commands in examples, templates, and real documents.
- Keep placeholders as setter values in generator-owned templates.
- Use printable metadata commands in text instead of duplicating values manually.
- Keep metadata setters in mode files (`code/practice.<mode>.tex`) when changing the public API.

## Avoid

```latex
% Do not redefine printable metadata commands.
\renewcommand{\QuizDate}{2026-09-15}

% Use the setter instead.
\SetQuizDate{2026-09-15}
```
