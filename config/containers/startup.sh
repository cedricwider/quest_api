
#!/usr/bin/env bash
# Prefix `bundle` with `exec` so unicorn shuts down gracefully on SIGTERM (i.e. `docker stop`)
exec bundle exec rails server --port=3000 --binding=0.0.0.0 --environment=$RAILS_ENV;
