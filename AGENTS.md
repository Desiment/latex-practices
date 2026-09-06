# AGENTS.md

## Repo Shape
- This is a LuaLaTeX class repo; `practice.cls` is the public entrypoint.
- Mode-specific layout, fields, headers, and begin-document setup live in `code/practice.<mode>.tex`.
- Supported modes are `seminar`, `homework`, `assessment`, `quiz`, and `test`.
- When adding or changing a public mode, update `practice.cls`, `code/`, matching `examples/example.<mode>.tex`, matching `templates/template.<mode>.tex`, and `README.md`.
- Detailed OpenCode guidance already exists in `.skills/practice-*`; preserve those conventions when editing examples, templates, exercises, grading, or metadata.

## Build And Verification
- Run `just install` in a fresh checkout to clone/update `.dependencies/` and link repo/dependency skills into `.opencode/skills/`.
- Use the local `latexmkrc` from `examples/` or `templates/`; it sets LuaLaTeX, shell escape, `.build/`, and TeX/Lua search paths.
- Example smoke tests from `examples/`: `latexmk example.seminar.tex`, `latexmk example.homework.tex`, `latexmk example.assessment.tex`, `latexmk example.quiz.tex`, `latexmk example.test.tex`.
- Raw files in `templates/` are generator inputs and may not compile until `PLACEHOLDER-*` values and `records-PLACEHOLDER.lua` are replaced.
- After placeholder replacement, compile generated template files from `templates/`.
- `latexmk --solutions <file>.tex` enables `solution` and `answer` output.
- `latexmk --print example.quiz.tex` builds quiz print imposition: two identical A5 copies on one A4 landscape page.
- `--print` and `--solutions` can be combined for quiz builds.

## LaTeX Gotchas
- `practice.cls` requires LuaLaTeX via `\RequireLuaTeX`; do not test with pdfLaTeX.
- Local dependencies are under hidden `.dependencies/{flsuite,tssuite,xamsmath}`; examples/templates rely on `latexmkrc` to add them to `TEXINPUTS`/`LUAINPUTS`.
- `recordsfile` defaults to `records.lua`; the Lua table must provide `subject`, `speciality`, `course`, and `uni`.
- `\printmodebool` is read while quiz mode loads, so define it before `\documentclass` or use `latexmk --print`.
- Keep shared options, metadata, XSIM setup, localization, and math loading in `practice.cls`; keep mode-only geometry and headers in mode files.

## Conventions
- Follow `CONTRIBUTING.md` for class-file conventions and verification expectations.
- In `.cls` files use `\RequirePackage`, not `\usepackage`.
- Keep metadata setters such as `\SetQuizDate{...}` in the preamble; do not redefine printable metadata commands such as `\QuizDate`.
- Examples should be concrete and compilable; templates may keep placeholders.
- Preserve the `\null` immediately after `\begin{document}` in examples and templates.
- Do not commit generated artifacts from `examples/.build/`, `templates/.build/`, PDFs, SyncTeX, or index outputs unless explicitly requested.
- `.opencode/` is local/ignored; do not treat it as repository source.
