if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # tried and true
    abbr --add gits git status
    abbr --add gita git add
    abbr --add gitc git commit
    abbr --add gitm git commit -m
    
    # new ones
    abbr --add gitca git commit --amend
    abbr --add gitad git add .
    
    # eza
    abbr --add lz eza
    abbr --add tz eza -T -L
    abbr --add tz2 eza -T -L 2
    abbr --add tz3 eza -T -L 3
end
