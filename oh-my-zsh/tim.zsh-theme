# Custom-made
RESET_COLOR='%{$reset_color%}'

PROMPT_USER="%{$FG[209]%}%m$RESET_COLOR"
PROMPT_DIR="%{$FG[035]%}%c$RESET_COLOR"
PROMPT_GIT='$(git_prompt_info)'
PROMPT_GIT="$PROMPT_GIT$RESET_COLOR"
PROMPT_END='%(!.#.$) '

# The prompt
PROMPT="$PROMPT_USER:$PROMPT_DIR|$PROMPT_GIT$PROMPT_END"

# Rprompt: Display time on on the far right
# RPROMPT="%{$FG[058]%}[%*]$RESET_COLOR"

# Git theme
ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[068]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$FG[068]%})"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}*"
