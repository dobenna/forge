# Forge - Aliases

# Navegación
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# Utilidades modernas
alias grep='grep --color=auto'
alias cat='batcat'
alias tree='tree -C'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gl='git log --oneline --graph --decorate --all'
alias gp='git push'
alias gpl='git pull'

# Docker
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias di='docker images'
alias dlog='docker logs -f'

# Kubernetes
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgn='kubectl get nodes'
alias kctx='kubectl config current-context'

# Terraform
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
