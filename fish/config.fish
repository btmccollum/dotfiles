if status is-interactive
    # Commands to run in interactive sessions can go here
  if command -qs zoxide
    zoxide init fish >~/.config/fish/conf.d/zoxide.fish
  end
end


