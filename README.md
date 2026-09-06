# practices - LaTeX Class for Teaching Sheets

Desiment's class for seminars, homework sheets, assessments, quizzes, and tests.

## Requirements

- LuaLaTeX.
- Class dependencies used by `practice.cls`: `fontspec`, `polyglossia`, `fancyhdr`, `geometry`, `xsim`, `tasks`, `flsuite`, `tssuite`, and `xamsmath`.
- Local class dependencies are expected under `.dependencies/`; templates and examples add `.dependencies//` to `TEXINPUTS`.
- A `records.lua` file, or another Lua records file selected with `recordsfile=...`.

Minimal `records.lua`:

```lua
return {
  subject = "Математический анализ",
  speciality = "Прикладная математика",
  course = "1",
  uni = "Университет"
}
```

## Modes

Each mode is selected as a class option and loaded from a separate source file.

| Mode | Source | Purpose | Grading |
| --- | --- | --- | --- |
| `seminar` | `code/practice.seminar.tex` | Практика | Ungraded `exercise` |
| `homework` | `code/practice.homework.tex` | Домашнее задание | Graded `exercise` |
| `assessment` | `code/practice.assessment.tex` | Контрольная работа | Graded `exercise` |
| `quiz` | `code/practice.quiz.tex` | Летучка | Graded `question` |
| `test` | `code/practice.test.tex` | Тест | Ungraded `question` |

Default mode is `seminar`.

## Metadata Fields

The class stores document metadata with `tssuite` text fields. Set field values in the document preamble with the `\Set...` commands.

- `seminar`: `\SetSeminarName{...}`, `\SetSeminarDate{...}`.
- `homework`: `\SetHomeworkNumber{...}`, `\SetHomeworkDeadline{...}`.
- `assessment`: `\SetAssessmentNumber{...}`, `\SetAssessmentDate{...}`, `\SetAssessmentTitle{...}`.
- `quiz`: `\SetQuizNumber{...}`, `\SetQuizDate{...}`, `\SetQuizTitle{...}`.
- `test`: `\SetTestTitle{...}`, `\SetTestDate{...}`.

The corresponding printable commands remain available for document text and class layouts: `\SeminarName`, `\SeminarDate`, `\HomeworkNumber`, `\HomeworkDeadline`, `\AssessmentNumber`, `\AssessmentDate`, `\AssessmentTitle`, `\QuizNumber`, `\QuizDate`, `\QuizTitle`, `\TestTitle`, and `\TestDate`.

Course metadata from `records.lua` is also exposed through printable commands backed by fields: `\PracticeSubject`, `\PracticeSpeciality`, `\PracticeCourse`, and `\PracticeUni`.

## Latexmk Flags

The local `latexmkrc` files support custom flags by injecting boolean commands before the document is loaded. `--solutions` enables `solution` and `answer` environments. In `quiz` mode, `--print` imposes each A5 quiz page as two identical copies on one A4 landscape sheet.

Example commands from `examples/`:

```sh
latexmk example.quiz.tex
latexmk --print example.quiz.tex
latexmk --solutions example.homework.tex
latexmk --print --solutions example.quiz.tex
```

## Templates

The `templates/` directory contains generator-oriented starter documents for new sheets. Raw templates may contain placeholders and are not required to compile before those placeholders are replaced.

After generating or replacing placeholders, compile from `templates/`:

```sh
latexmk template.seminar.tex
latexmk template.homework.tex
latexmk template.assessment.tex
latexmk template.quiz.tex
latexmk template.test.tex
```

The template `latexmkrc` adds the parent directory and `.dependencies//` to `TEXINPUTS`, then uses LuaLaTeX with shell escape.

## Repository Layout

- `practice.cls` is the public class entrypoint.
- `code/practice.<mode>.tex` contains mode-specific geometry, fields, headers, and setup.
- `examples/` contains compilable demonstrations with sample exercises.
- `templates/` contains generator-oriented starter documents; raw placeholders may be uncompilable until replaced.
- `.dependencies/` contains local package dependencies used by examples and templates.
- `CONTRIBUTING.md` documents repository conventions; `AGENTS.md` contains compact OpenCode guidance.

## Examples

The `examples/` directory contains compilable demonstrations with sample exercises. Compile examples from `examples/`:

```sh
latexmk example.seminar.tex
latexmk example.homework.tex
latexmk example.assessment.tex
latexmk example.quiz.tex
latexmk example.test.tex
```

## Public Commands

- `question`/`answer` provide a separate XSIM question type for quizzes and tests.
- `\PrintTotalPoints` prints the total score for graded `exercise` sheets. Use `\PrintTotalPoints[question]` for graded questions.
- `\addpt{<points>}` adds points inside an exercise part and prints them in italic parentheses.
- `\printsolutionbool` defaults to `false`; redefine it to `true` in the preamble or use `latexmk --solutions` to print `solution` and `answer` environments.
- `\printmodebool` defaults to `false` and is read while loading quiz mode; use `latexmk --print` or define it before `\documentclass`.

## Grading Tables

The `assessment` and `quiz` modes print an answer-sheet style header before the body: a grading table on the left and student fields on the right. Assessment grades `exercise` items; quiz grades `question` items.

The built-in XSIM table template is named `sheetgr` and can be used directly. It uses table rule commands provided through `flsuite`:

```latex
\gradingtable[type=exercise, template=sheetgr]
\gradingtable[type=question, template=sheetgr]
```
