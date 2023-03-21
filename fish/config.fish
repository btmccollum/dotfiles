set -x FZF_DEFAULT_COMMAND 'ag --ignore node_modules -g ""'

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
alias build_local="bundle && yarn clean && yarn"
alias run_fe_checks="yarn test -u && yarn run lint --fix && yarn run lint:css"
alias fix_test_db="set RAILS_ENV test
                   bundle exec rake db:drop &&
                   set RAILS_ENV test bundle exec
                   rake db:schema:cache:clear &&
                   set RAILS_ENV test bundle exec rake db:create &&
                   set RAILS_ENV test bundle exec rake db:structure:load &&
                   set RAILS_ENV test bundle exec rake db:migrate &&
                   set RAILS_ENV test bundle exec rake db:seed"
alias fix_dev_db="set RAILS_ENV development bundle exec rake db:drop! &&
                  set RAILS_ENV development bundle exec rake db:schema:cache:clear &&
                  set RAILS_ENV development bundle exec rake db:create &&
                  set RAILS_ENV development bundle exec rake db:structure:load &&
                  set RAILS_ENV development bundle exec rake db:migrate &&
                  set RAILS_ENV development bundle exec rake db:seed"

rvm default
fish_add_path /usr/local/opt/postgresql@12/bin
export USER=bradmccollum
export EDITOR="nvim"
