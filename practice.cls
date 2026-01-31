\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{practice}[2026/01/01 Desiment LaTeX class for practice,  homeworks and test files]
\RequirePackage{kvoptions}  % Key-value options
\SetupKeyvalOptions{prefix=practice@}
\DeclareStringOption[{records.lua}]{recordsfile}     % Filename for title configuration

\DeclareOption{seminar}{%
  \newcommand{\SeminarName}{}
  \newcommand{\SeminarDate}{}
  \AtBeginDocument{%
    % Метаданные:
    \title{\SeminarName}%
    \date{\SeminarDate}%
    % Настраиваем колонтитулы
    \pagestyle{fancy}%
    \lhead{\PracticeSpeciality, \PracticeUni, курс \PracticeCourse}%
    \chead{\PracticeSubject. Практика}%
    \rhead{\SeminarDate}%
    % Название практики
    \section*{\SeminarName}%
  }
}

\DeclareOption{homework}{%
  \newcommand{\HomeworkNumber}{}
  \newcommand{\HomeworkDeadline}{}
  \AtBeginDocument{%
    % Метаданные:
    \title{Д.З. \HomeworkNumber}%
    \date{\HomeworkDeadline}%
    % Настраиваем колонтитулы
    \pagestyle{fancy}%
    \lhead{\PracticeSpeciality, \PracticeUni, курс \PracticeCourse}%
    \chead{\PracticeSubject. Д.З. №\HomeworkNumber}%
    \rhead{Дедлайн: \HomeworkDeadline}%
  }
}

% TODO: implement option "test" for exam template
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*
\ProcessOptions\relax
\LoadClass[a4paper]{article}

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

\RequirePackage{xsim}
\RequirePackage{tasks}


\DeclareExerciseEnvironmentTemplate{ex-custom-template}
{%
	\par\vspace{\baselineskip}
	\noindent
	\textbf{\XSIMmixedcase{\GetExerciseName}~\GetExerciseProperty{counter}}%
	\GetExercisePropertyT{subtitle}{ \textit{#1}}%
	\hfill\par\noindent%
	(%
	\printgoal{\GetExerciseProperty{points}}%
	\GetExercisePropertyT{bonus-points}{+\printgoal{#1}}%
	\,\XSIMtranslate{point-abbr}%
	)
}
{}
%
\DeclareExerciseEnvironmentTemplate{sol-custom-template}
{%
  \par\vspace{\baselineskip}%
  \noindent\textit{\GetExerciseName.\ }{}
}%

\xsimsetup{
exercise/template = ex-custom-template,
solution/template = sol-custom-template
}

\settasks{
label = \theexercise.\arabic* ,
item-indent = 2em ,
label-width = 2em ,
label-offset = 0pt
}

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



