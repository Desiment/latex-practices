\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{practice}[2026/07/05 v0.2.0 Desiment LaTeX class for practice, homeworks and tests]
\RequirePackage{kvoptions}  % Key-value options
\SetupKeyvalOptions{prefix=practice@}
\DeclareStringOption[{records.lua}]{recordsfile}     % Filename for title configuration

\def\practice@mode{seminar}
\DeclareOption{seminar}{\def\practice@mode{seminar}}
\DeclareOption{homework}{\def\practice@mode{homework}}
\DeclareOption{assessment}{\def\practice@mode{assessment}}
\DeclareOption{quiz}{\def\practice@mode{quiz}}
\DeclareOption{test}{\def\practice@mode{test}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*
\ProcessOptions\relax
\LoadClass[a4paper]{article}

\RequirePackage{iftex}
\RequireLuaTeX

% Доступ к полям комманд \author{...} и \date{...}
\title{Unknown} % Инициализируем \@title и \@date
\date{Unknown}  % чтобы \edef работал корректно
\def\strtitle{\@title}
\def\strdate{\@date}

% ============================================================================
% LOCALIZATION
% ============================================================================

\RequirePackage{fontspec}
\setmainfont{CMU Serif}
\setsansfont{CMU Sans Serif}
\setmonofont{CMU Typewriter Text}
%\setmonofont{Fira Code}[Contextuals=Alternate,Scale=0.9]
%\setmonofont{Inconsolata}

% Русский язык
\RequirePackage[babelshorthands]{polyglossia}
\setmainlanguage{russian}
\setotherlanguage{english}

% Smart quotes based on current language
\RequirePackage[autostyle]{csquotes}


% ============================================================================
% LAYOUT
% ============================================================================
\RequirePackage{geometry} % Настройка страницы
\geometry{%
  a4paper,
  margin=1cm,
  includefoot,
  includehead
}

\directlua{
  local recordsfile = [[\practice@recordsfile]]
  local recordspath = kpse.find_file(recordsfile, "lua") or recordsfile
  records = dofile(recordspath)
}

\RequirePackage{fancyhdr}
\setlength{\headheight}{14pt}

% ============================================================================
% PREAMBLE
% ============================================================================

\RequirePackage[tikz,listings,memoization]{flsuite}
\definecolor{deepblue}{RGB}{53,102,161}

\RequirePackage[theorems]{tssuite}

\CreateTextField{\SetPracticeSubject}{practicesubject}
\CreateTextField{\SetPracticeSpeciality}{practicespeciality}
\CreateTextField{\SetPracticeCourse}{practicecourse}
\CreateTextField{\SetPracticeUni}{practiceuni}

\SetPracticeSubject{\directlua{tex.sprint(records.subject)}}
\SetPracticeSpeciality{\directlua{tex.sprint(records.speciality)}}
\SetPracticeCourse{\directlua{tex.sprint(records.course)}}
\SetPracticeUni{\directlua{tex.sprint(records.uni)}}

\newcommand{\PracticeSubject}{\PrintTextField{practicesubject}}
\newcommand{\PracticeSpeciality}{\PrintTextField{practicespeciality}}
\newcommand{\PracticeCourse}{\PrintTextField{practicecourse}}
\newcommand{\PracticeUni}{\PrintTextField{practiceuni}}

\NewStarredTheorem{theorem}{Теорема}
\NewStarredTheorem{lemma}{Лемма}
\NewStarredTheorem{corollary}{Следствие}
\NewStarredTheorem{proposition}{Предложение}
\NewStarredTheorem{definition}{Определение}
\NewStarredTheorem{example}{Пример}
\NewStarredTheorem{remark}{Замечание}
\NewStarredTheorem{notation}{Нотация}

\RequirePackage[all]{xamsmath}
\XAMSMathLoadPlugin{foundations}
\XAMSMathLoadPlugin{algebra}
\XAMSMathLoadPlugin{calculus}
\XAMSMathLoadPlugin{combinatorics}
\XAMSMathLoadPlugin{probability}

\RequirePackage{xsim}
\RequirePackage{tasks}

\providecommand{\printsolutionbool}{false}

\newcommand{\practice@AtBeginDocumentAfterXSIM}[2]{%
  \AddToHook{begindocument}[practice-#1]{#2}%
  \DeclareHookRule{begindocument}{practice-#1}{after}{xsim}%
}

\DeclareExerciseEnvironmentTemplate{ex-custom-template-points}
{%
	\par\vspace{\baselineskip}
	\noindent
	\textbf{\XSIMmixedcase{\GetExerciseName}~\GetExerciseProperty{counter}.}%
	\GetExercisePropertyT{subtitle}{ \textit{#1}}%
	\hfill\par\noindent%
	(%
	\printgoal{\GetExerciseProperty{points}}%
	\GetExercisePropertyT{bonus-points}{+\printgoal{#1}}%
	\,\XSIMtranslate{point-abbr}%
	)
}%
{}

\DeclareExerciseEnvironmentTemplate{ex-custom-template-no-points}
{%
	\par\vspace{\baselineskip}
	\noindent
	\textbf{\XSIMmixedcase{\GetExerciseName}~\GetExerciseProperty{counter}.}%
	\GetExercisePropertyT{subtitle}{ \textit{#1}}%
	\hfill\par%
}%
{}

\DeclareExerciseEnvironmentTemplate{sol-custom-template}
{%
  \par\vspace{\baselineskip}%
  \noindent\textit{\GetExerciseName.\ }{}
}%
{}

\DeclareExerciseType{question}{%
  exercise-env = question,
  solution-env = answer,
  exercise-name = \XSIMtranslate{question},
  exercises-name = \XSIMtranslate{questions},
  solution-name = \XSIMtranslate{solution},
  solutions-name = \XSIMtranslate{solutions},
  exercise-template = ex-custom-template-points,
  solution-template = sol-custom-template,
  exercise-heading = \subsection*,
  solution-heading = \subsection*
}

\ExplSyntaxOn
\cs_new_protected:cpn {practice@setsolutionprint}
  {
    \exp_args:Nx \xsimsetup
      {
        solution/print = \printsolutionbool,
        answer/print = \printsolutionbool
      }
  }
\ExplSyntaxOff

\AddToHook{begindocument/before}[practice-solutions]{\practice@setsolutionprint}

\xsimsetup{
  exercise/template = ex-custom-template-points,
  solution/template = sol-custom-template
}

\settasks{
label = \GetExerciseProperty{counter}.\arabic* ,
item-indent = 2em ,
label-width = 2em ,
label-offset = 0pt
}

\NewDocumentCommand{\PrintTotalPoints}{O{exercise}}{\vspace{0.5ex}\hrule\vspace{0.5ex}\hfill Сумма баллов \TotalExerciseTypeGoal{#1}{points}{}{}}
\newcommand{\addpt}[1]{(\textit{\addpoints{#1}})}

\ExplSyntaxOn
\DeclareExerciseTableTemplate {sheetgr}
  {
    \XSIMputright \ExerciseTableCode
      {
        \toprule
        \XSIMifblankF { \ExerciseType }
          { \XSIMmixedcase { \GetExerciseParameter {exercise-name} } }
        &
      }
    \ForEachUsedExerciseByOrder
      {
        \XSIMifeqT {#1} { \ExerciseTableType {#1} }
          {
            \XSIMifblankT { \ExerciseTableType {} }
              {
                \XSIMputright \ExerciseTableCode
                  {
                    \XSIMmixedcase
                      { \ExerciseParameterGet {#1} {exercise-name} ~ }
                  }
              }
            \XSIMputright \ExerciseTableCode { #3 & }
          }
      }
    \XSIMputright \ExerciseTableCode
      {
        \XSIMtranslate {total} \\
        \midrule \XSIMmixedcase { Максимум } &
      }
    \ForEachUsedExerciseByOrder
      {
        \XSIMifeqT {#1} { \ExerciseTableType {#1} }
          {
            \XSIMputright \ExerciseTableCode
              { \XSIMifblankTF {#5} {\printgoal{0}} {\printgoal{#5}} & }
          }
      }
    \XSIMputright \ExerciseTableCode
      {
        \XSIMifblankTF { \ExerciseType }
          { \TotalExerciseGoal {points} {} {} }
          { \TotalExerciseTypeGoal { \ExerciseType } {points} {} {} }
        \\ \midrule
        \XSIMmixedcase { \XSIMtranslate { reached }} &
      }
    \ForEachUsedExerciseByOrder
      {
        \XSIMifeqT {#1} { \ExerciseTableType {#1} }
          { \XSIMputright \ExerciseTableCode {&} }
      }
    \XSIMputright \ExerciseTableCode { \\ \bottomrule }
    \edef \numberofcolumns
      {
        \XSIMifblankTF { \ExerciseType }
          {\numberofusedexercises}
          {\csname numberof \ExerciseType s\endcsname}
      }
    \XSIMifeqF {\numberofcolumns} {0}
      {
        \begin {tabular} {l*{\numberofcolumns}{c}c}
        \ExerciseTableCode
        \end {tabular}
      }
  }
\ExplSyntaxOff

\newcommand{\practice@printgradingheader}[1][exercise]{%
  \par\noindent
  \begin{minipage}[c]{0.49\textwidth}%
    \gradingtable[type=#1, template=sheetgr]%
  \end{minipage}\hfill
  \begin{minipage}[c]{0.45\textwidth}%
    \noindent ФИО:\enspace\hrulefill\par
    \vspace{0.5em}%
    \noindent Группа:\enspace\hrulefill\par
    \vspace{0.5em}%
    \noindent Дата:\enspace\hrulefill\par
  \end{minipage}%
  \par\vspace{3em}%
}

% ============================================================================
% LOCALIZATION (XSIM)
% ============================================================================

\DeclareExerciseTranslation{russian}{exercise}{упражнение}
\DeclareExerciseTranslation{russian}{exercises}{упражнения}
\DeclareExerciseTranslation{russian}{question}{вопрос}
\DeclareExerciseTranslation{russian}{questions}{вопросы}
\DeclareExerciseTranslation{russian}{solution}{решение}
\DeclareExerciseTranslation{russian}{solutions}{решения}
\DeclareExerciseTranslation{russian}{point-abbr}{б.}
\DeclareExerciseTranslation{russian}{point}{балл}
\DeclareExerciseTranslation{russian}{points}{балла}
\DeclareExerciseTranslation{russian}{reached}{получено}
\DeclareExerciseTranslation{russian}{total}{всего}
\DeclareExerciseTranslation{russian}{default-heading}{\XSIMmixedcase{\GetExerciseParameter{solutions-name}} к \XSIMmixedcase{\GetExerciseParameter{exercises-name}}}
\DeclareExerciseTranslation{russian}{collection-heading}{\XSIMmixedcase{\GetExerciseParameter{exercises-name}}}
\DeclareExerciseTranslation{russian}{per-section-heading}{\XSIMmixedcase{\GetExerciseParameter{solutions-name}} к \XSIMmixedcase{\GetExerciseParameter{exercises-name}} Раздела \nobreakspace \ExerciseSection}
\DeclareExerciseTranslation{russian}{per-chapter-heading}{\XSIMmixedcase{\GetExerciseParameter{solutions-name}} к \XSIMmixedcase{\GetExerciseParameter{exercises-name}} Главы \nobreakspace \ExerciseChapter}

% ============================================================================
% MODE SETUP
% ============================================================================

\edef\practice@modefile{code/practice.\practice@mode.tex}
\InputIfFileExists{\practice@modefile}{}{%
  \ClassError{practice}{Unknown practice mode `\practice@mode'}{%
    Supported modes are seminar, homework, assessment, quiz, and test.%
  }%
}

\endinput
