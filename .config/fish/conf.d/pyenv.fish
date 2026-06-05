if test -d ~/.pyenv
    set -gx PYENV_ROOT ~/.pyenv
    fish_add_path $PYENV_ROOT/bin

    if command -q pyenv
        pyenv init - | source
    end
end
