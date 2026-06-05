# Disable greeting
set -g fish_greeting

abbr -a gs git status
abbr -a gc git commit
abbr -a ga git add
abbr -a gd git diff
abbr -a gds git diff --staged
abbr -a gp git push
abbr -a gpo git push origin
abbr -a gpl git pull
abbr -a gplrb git pull --rebase
abbr -a gl git log
abbr -a gv "git log --graph --decorate --oneline"
abbr -a gch git checkout
abbr -a gcb "git checkout -b"

abbr -a l "ls -al"

function auto_venv --on-variable PWD
  if test -n "$VIRTUAL_ENV"
    set parentdir (dirname "$VIRTUAL_ENV")
    if not string match -q "$parentdir/*" "$PWD"
      if functions -q deactivate
        deactivate
      end
    end
  end
  if test -z "$VIRTUAL_ENV"
    if test -f "$PWD/.venv/bin/activate.fish"
      source "$PWD/.venv/bin/activate.fish"
    end
  end
end
