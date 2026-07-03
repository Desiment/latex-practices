\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{teachfile}[2026/01/01 Desiment LaTeX class for seminars, homeworks and test files]

% ============================================================================
% INITIAL SETUP
% ============================================================================

\RequirePackage{etoolbox}  % different LaTeX2e neats
\RequirePackage{xparse}
\RequirePackage{kvoptions} % Key-value options


\SetupKeyvalOptions{prefix=practice@}
\DeclareStringOption[{records.lua}]{recordsfile}     % Filename for title configuration

\DeclareBoolOption{ru}
\DeclareComplementaryOption{en}

\DeclareBoolOption{practice}
\DeclareBoolOption{homework}
\DeclareBoolOption{testpaper}
\DeclareBoolOption{testsheet}
\DeclareBoolOption{quiz}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*
\LoadClass[a4paper]{article}


%\CreateField{SetterControlSequence, FieldName}
\NewDocumentCommand{\CreateField}{mm}{
	\exp_args:NN\tl_new:{\use:c{g_user_field_#2}}
	\NewDocumentCommand{#1}{m}{
		\exp_args:NN\tl_gseq_eq:NN{\use:c{g_user_field_#2}}{##1}
	}
}

% Доступ к полям комманд \author{...} и \date{...}
\title{Unknown} % Инициализируем \@title и \@date
\date{Unknown}  % чтобы \edef работал корректно
\def\strtitle{\@title}
\def\strdate{\@date}

% ============================================================================
% FONTS & LOCALIZATION
% ============================================================================

\RequirePackage{fontspec}
\setmainfont{CMU Serif}
\setsansfont{CMU Sans Serif}
\setmonofont{CMU Typewriter Text}
%\setmonofont{Fira Code}[Contextuals=Alternate,Scale=0.9]
%\setmonofont{Inconsolata}


\if@teachfile@ru
	% Русский язык
	\RequirePackage[babelshorthands]{polyglossia}
	\setmainlanguage{russian}
	\setotherlanguage{english}
\fi

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

\directlua{records = require('\practice@recordsfile')}
\newcommand{\PracticeSubject}{\directlua{tex.sprint(records.subject)}}
\newcommand{\PracticeSpeciality}{\directlua{tex.sprint(records.speciality)}}
\newcommand{\PracticeCourse}{\directlua{tex.sprint(records.course)}}
\newcommand{\PracticeUni}{\directlua{tex.sprint(records.uni)}}

\RequirePackage{fancyhdr}

% ============================================================================
% PREAMBLE
% ============================================================================

\RequirePackage[tikz,listings,memoization]{flsuite}
\definecolor{deepblue}{RGB}{53,102,161}

\RequirePackage[theorems]{tssuite}

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

% ============================================================================
% TABLES (XSIM)
% ============================================================================


\RequirePackage{xsim}
\RequirePackage{tasks}


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

\DeclareExerciseEnvironmentTemplate{ex-custom-template-points}
{%
	\par\vspace{\baselineskip}
	\noindent
	\textbf{\XSIMmixedcase{\GetExerciseName}~\GetExerciseProperty{counter}.}%
	\GetExercisePropertyT{subtitle}{ \textit{#1}}%
	\ %\hfill\par\noindent%
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
	\ %\hfill\par%
}%
{}

\DeclareExerciseEnvironmentTemplate{sol-custom-template}
{%
  \par\vspace{\baselineskip}%
  \noindent\textit{\XSIMmixedcase{\GetExerciseName}.\ }{}
}%
{}
\xsimsetup{
  solution/template = sol-custom-template,
  grading-table/template = sheetgr
}

\settasks{
label = \theexercise.\arabic* ,
item-indent = 2em ,
label-width = 2em ,
label-offset = 0pt
}

%% Utils
\newcommand{\addpt}[1]{(\textit{\addpoints{#1}})}
\NewDocumentCommand{\PrintTotalPoints}{}{\vspace{0.5ex}\hrule\vspace{0.5ex}\hfill Сумма баллов \TotalExerciseTypeGoal{exercise}{points}{}{}}

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

\AtEndOfClass{%
  \if@seminar\RequirePackage{seminar}\fi
  \if@homework\RequirePackage{homework}\fi
  \if@examproblems\RequirePackage{exam-problems}\fi
}



