set shell := ["sh", "-eu", "-c"]

default:
    @just --list

install: deps skills

update: install

deps:
    @mkdir -p .dependencies
    @install_dep() { \
        name="$1"; \
        url="$2"; \
        dir=".dependencies/$name"; \
        if [ -d "$dir/.git" ]; then \
            git -C "$dir" pull --ff-only; \
        elif [ -e "$dir" ]; then \
            printf '%s\n' "Refusing to replace existing non-git path: $dir" >&2; \
            exit 1; \
        else \
            git clone "$url" "$dir"; \
        fi; \
    }; \
    install_dep flsuite https://github.com/Desiment/latex-flsuite; \
    install_dep tssuite https://github.com/Desiment/latex-tssuite; \
    install_dep xamsmath https://github.com/Desiment/latex-xamsmath

skills:
    @skills_dir=.opencode/skills; \
    mkdir -p "$skills_dir"; \
    link_skill() { \
        name="$1"; \
        source="$2"; \
        target="$skills_dir/$name"; \
        if [ -L "$target" ]; then \
            current=$(readlink "$target"); \
            [ "$current" = "$source" ] && return 0; \
            rm "$target"; \
        elif [ -e "$target" ]; then \
            printf '%s\n' "Refusing to replace existing non-symlink: $target" >&2; \
            exit 1; \
        fi; \
        ln -s "$source" "$target"; \
    }; \
    count=0; \
    if [ -d .skills ]; then \
        for skill_dir in .skills/*; do \
            [ -d "$skill_dir" ] || continue; \
            skill_name=$(basename "$skill_dir"); \
            link_skill "$skill_name" "../../.skills/$skill_name"; \
            count=$((count + 1)); \
        done; \
    fi; \
    for pkg_dir in .dependencies/*; do \
        [ -d "$pkg_dir/.skills" ] || continue; \
        pkg_name=$(basename "$pkg_dir"); \
        for skill_dir in "$pkg_dir"/.skills/*; do \
            [ -d "$skill_dir" ] || continue; \
            skill_name=$(basename "$skill_dir"); \
            link_skill "$skill_name" "../../.dependencies/$pkg_name/.skills/$skill_name"; \
            count=$((count + 1)); \
        done; \
    done; \
    printf 'Synced %s OpenCode skill symlinks.\n' "$count"
