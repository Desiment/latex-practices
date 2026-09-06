---
name: practice-maintenance
description: Use for editing practice.cls code/practice.<mode>.tex public modes class API README examples templates XSIM setup metadata fields and repo conventions.
license: MIT
compatibility: opencode
metadata:
  package: practice
  task: maintenance
---

# practice: Class Maintenance

## When To Use

Use this skill when changing repository source files rather than only authoring a
single teaching sheet. This includes edits to `practice.cls`, files under
`code/`, public commands/options, mode behavior, examples, templates, README
documentation, and OpenCode skills.

Trigger examples: `practice.cls`, `code/practice.quiz.tex`, new mode, class
option, public command, XSIM template, grading table, README, examples,
templates, `.skills`.

## Source Layout

- `practice.cls`: public class entrypoint.
- `code/practice.<mode>.tex`: mode-specific geometry, metadata fields, headers, and begin-document setup.
- `examples/example.<mode>.tex`: concrete, compilable smoke-test documents.
- `templates/template.<mode>.tex`: generator-oriented starter documents.
- `README.md`: public behavior and usage documentation.
- `CONTRIBUTING.md`: repository conventions and verification expectations.
- `.skills/practice-*`: tracked OpenCode skill source.
- `.opencode/skills/`: local ignored sync target; do not treat it as source.

Supported public modes are `seminar`, `homework`, `assessment`, `quiz`, and
`test`.

## Shared Versus Mode-Specific Code

Keep shared behavior in `practice.cls`:

- Class options and option processing.
- Records loading and course metadata fields.
- Package loading, localization, theorem/math setup.
- Shared XSIM exercise/question/solution templates.
- `\PrintTotalPoints`, `\addpt`, grading table template, and shared grading header helper.
- Mode dispatch to `code/practice.<mode>.tex`.

Keep mode-specific behavior in `code/practice.<mode>.tex`:

- Geometry overrides.
- Mode metadata setters and printable commands.
- Headers and footers.
- Mode-specific begin-document setup.
- Quiz print imposition.
- Automatic grading header calls for assessment and quiz.

Do not require users to input files from `code/` directly.

## Public API Checklist

When adding or changing a public option, mode, command, environment, counter,
length, or documented behavior, update the matching public surfaces:

- `practice.cls` for shared setup and mode dispatch.
- `code/practice.<mode>.tex` for mode-only layout and metadata.
- `examples/example.<mode>.tex` for a concrete compilable smoke test.
- `templates/template.<mode>.tex` for generator starter coverage.
- `README.md` for user-facing documentation.
- `.skills/practice-*` if OpenCode guidance would become stale.

Do not add backward-compatibility aliases unless there is a concrete persisted
document, shipped behavior, external consumer, or explicit user requirement.

## LaTeX Style Rules

- Use `\RequirePackage` in `.cls` files, not `\usepackage`.
- Process class options before `\LoadClass` when options affect setup.
- Load the base class exactly once.
- Pass unknown document options to `article` unless intentionally rejecting them.
- End class files with `\endinput` and do not put code after it.
- Use class-prefixed internal names such as `\practice@...`.
- Use descriptive PascalCase for public class commands such as `\PrintTotalPoints`.
- Keep metadata setters in the preamble; do not redefine printable metadata commands.
- Preserve intentional Russian text and localization strings.

## XSIM And Hook Rules

- `practice.cls` configures `exercise`/`solution` and declares the separate `question`/`answer` type.
- Seminar switches `exercise` headings to the no-points template.
- Test switches `question` headings to the no-points template.
- Assessment grades `exercise` and prints `\practice@printgradingheader` after XSIM initialization.
- Quiz grades `question` and prints `\practice@printgradingheader[question]` after XSIM initialization.
- Use `\practice@AtBeginDocumentAfterXSIM` for setup that depends on XSIM-restored item metadata.
- Keep solution printing controlled by `\printsolutionbool`.
- Keep quiz print imposition controlled by `\printmodebool`, which must be defined before quiz mode loads.

## Verification

Use `practice-build` for detailed build guidance. Select the smallest relevant
checks:

- Single mode changes: compile the matching example.
- Shared class changes: compile multiple representative examples.
- Solution behavior changes: include `--solutions`.
- Quiz print changes: include `--print`.
- Template-only placeholder changes: inspect raw templates and compile only after placeholder replacement.

## Skill Maintenance

Project skills live in `.skills/`. Run `just skills` after adding, deleting, or
renaming skills so `.opencode/skills/` reflects the tracked sources.

Skill names must be lowercase hyphen-separated and match their folder names.
Each skill needs a `description` that says both what it does and when to use it.

## Generated Artifacts

Do not commit generated artifacts unless explicitly requested:

- `examples/.build/`
- `templates/.build/`
- PDFs
- SyncTeX files
- XSIM/index/output helper files

## Avoid

```latex
% Wrong in practice.cls.
\usepackage{xsim}

% Use this in class files.
\RequirePackage{xsim}
```
