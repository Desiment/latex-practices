# Contributing

This repository maintains the `practice` LuaLaTeX class for teaching sheets.
Keep changes small, document public behavior, and verify with the examples or
generated templates that cover the edited feature.

## Project Scope
- `practice.cls` is the only public class entrypoint.
- Mode implementation belongs in `code/practice.<mode>.tex`.
- Supported modes are `seminar`, `homework`, `assessment`, `quiz`, and `test`.
- `examples/` contains concrete, compilable smoke-test documents.
- `templates/` contains generator-oriented starter documents; unresolved placeholders may intentionally be uncompilable.
- Local package dependencies live under `.dependencies/` and are found through the `latexmkrc` files in `examples/` and `templates/`.

## Class File Rules
- Start class files with `\NeedsTeXFormat{LaTeX2e}` and `\ProvidesClass` including date, version, and a short description.
- Use `\RequirePackage` inside `.cls` files; do not use `\usepackage` there.
- Process class options before `\LoadClass` when options affect class setup.
- Load the base class exactly once.
- Pass unknown document options to the base class unless the class intentionally rejects them.
- End class files with `\endinput`; do not put code after it.
- Keep shared options, metadata, XSIM setup, localization, theorem/math loading, and public shared commands in `practice.cls`.
- Keep mode geometry, headers, mode metadata fields, and mode-only begin-document setup in `code/practice.<mode>.tex`.
- Do not require users to input files from `code/` directly.

## Modes And Public API
- Every public mode or option must be documented in `README.md`.
- Adding or changing a public mode requires matching updates in `practice.cls`, `code/practice.<mode>.tex`, `examples/example.<mode>.tex`, `templates/template.<mode>.tex`, and `README.md`.
- Prefer lowercase option names such as `seminar`, `homework`, and `recordsfile`.
- Use descriptive PascalCase for class-specific user commands such as `\PrintTotalPoints`.
- Use class-prefixed internal LaTeX2e names such as `\practice@...`.
- Keep documented commands, environments, options, counters, lengths, and hooks stable once examples, templates, or README rely on them.
- Do not add backward-compatibility aliases unless there is a concrete user or persisted-document need.

## Metadata And Records
- Course metadata is loaded from `records.lua` by default or from the `recordsfile=...` class option.
- Records files must provide `subject`, `speciality`, `course`, and `uni` fields.
- Set mode metadata in the preamble with public setters such as `\SetQuizDate{...}`.
- Do not redefine printable metadata commands such as `\QuizDate`; they are backed by `tssuite` text fields.
- Keep placeholders as values passed to setters in generator-owned templates.

## Examples And Templates
- Examples must be concrete and compilable with `recordsfile={records.lua}`.
- Templates may contain `PLACEHOLDER-*` values and `records-PLACEHOLDER.lua` references when they are generator inputs.
- Preserve the `\null` immediately after `\begin{document}` in examples and templates.
- Keep templates self-contained unless demonstrating an intentional external input.
- Do not compile unresolved raw templates as a required verification step.
- Do not commit generated PDFs, SyncTeX files, index outputs, or `.build/` contents unless explicitly requested.

## Build And Verification
- Use LuaLaTeX; `practice.cls` calls `\RequireLuaTeX`.
- Use the local `latexmkrc` in `examples/` or `templates/`; they configure LuaLaTeX, shell escape, `.build/`, `TEXINPUTS`, and `LUAINPUTS`.
- Compile examples from `examples/`:

```sh
latexmk example.seminar.tex
latexmk example.homework.tex
latexmk example.assessment.tex
latexmk example.quiz.tex
latexmk example.test.tex
```

- Compile generated templates from `templates/` only after replacing placeholders:

```sh
latexmk template.seminar.tex
latexmk template.homework.tex
latexmk template.assessment.tex
latexmk template.quiz.tex
latexmk template.test.tex
```

- Use `latexmk --solutions <file>.tex` to print `solution` and `answer` environments.
- Use `latexmk --print example.quiz.tex` to impose two identical A5 quiz copies on one A4 landscape page.
- If a change touches quiz print mode, check `--print`; if it touches solutions, check `--solutions`.
- If a README command, environment, or option is changed, verify it exists in source or is clearly external.
- If a build cannot run because a dependency is unavailable, state the missing dependency in the summary.

## Comments And Style
- Use ASCII by default, but preserve existing Russian text and other intentional non-ASCII content.
- Do not use emoji in repository files.
- Keep public-command documentation near definitions when the purpose or parameters are not obvious.
- Document load-order rationale when a package, hook, option, or mode module must appear in a specific place.
- Avoid comments that merely restate the next line.
- Prefer minimal, direct changes over broad rewrites.
