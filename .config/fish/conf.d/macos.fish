if test (uname) = Darwin
    fish_add_path \
        /opt/homebrew/bin/ \
        /opt/homebrew/opt/curl/bin \
        $HOME/.poetry/bin \
        $HOME/.local/bin \
        $HOME/Library/pnpm

    if command -q brew
        brew shellenv | source
    end

    set -gx LDFLAGS "-L/opt/homebrew/lib"
    set -gx CPPFLAGS "-I/opt/homebrew/include"
    set -gx LIBRARY_PATH "$LIBRARY_PATH:"(brew --prefix)"/lib"
end

