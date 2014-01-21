# `$ foreman start` to start server and other processes listed here
# `$ foreman start -e .env.test` to specify an environment
# `$ foreman start -e .env,.env.production` to override default .env
# `$ foreman run [command]` to preload env variables before a command
# `$ foreman export ...` to export scripts
# `foreman run rails s --debugger` to debug app

web:    bundle exec rails server -p $PORT
log:    tail -f log/development.log
