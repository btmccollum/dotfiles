if status is-interactive
    # Commands to run in interactive sessions can go here
  if command -qs zoxide
    zoxide init fish >~/.config/fish/conf.d/zoxide.fish
  end
end

# general git usage
alias ga="git add"
alias gcmsg="git commit -m"

# work commands
alias build_local="bundle && yarn clean && yarn && puma restart"
alias run_fe_checks="yarn test -u && yarn run lint --fix && yarn run lint:css"

