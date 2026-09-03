\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{practice}[2026/07/05 v0.2.0 Compatibility entrypoint for teachfile]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{teachfile}}
\ProcessOptions\relax
\LoadClass{teachfile}

\endinput
