after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"

# If you want to use command line options, for example to start multiple workers,
# define a Capistrano variable delayed_job_args:
#
#   set :delayed_job_args, "-n 2"