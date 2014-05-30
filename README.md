## Puma Stats Logger

#### For Rack apps (including Rails)

This Rack middleware gathers statistics from [Puma](http://puma.io/) web server and logs them to the logging destination of your choice. It uses Puma's built in control server to query Puma's stats after every request in your production application. Currently, Puma provides two metrics that are output to your logs:

  * __running__ - the number of threads currently running
  * __backlog__ - the number of requests waiting to be processed by a thread

The actual log entry looks like this:

    measure#puma.backlog=0 measure#puma.running=6
    
    
## Getting Started

Add the gem to your gemfile:

    gem 'puma-stats-logger'
    
##### Enable Puma's control/stats server & state file

If you use a Puma configuration file, add the following two lines:

    # in config/puma.rb
    
    activate_control_app
    state_path 'tmp/puma.state'
    
OR ... if you don't use a Puma config file and you start Puma via command line, add these options:

    puma --control auto --state "tmp/puma.state"
    
##### Activate the Middleware in your app

In your application and/or environment config:

    config.middleware.use PumaStatsLogger::Middleware
   
or in a Rails initializer:

    Rails.application.middleware.use PumaStatsLogger
   
   
##### Changing the logging destination

By default, the Puma stats are logged to standard output `$stdout`. This works great out of the box for Heroku users. You can customize this by passing an option hash:
    
    config.middleware.use PumaStatsLogger::Middleware, logger: Logger.new('destination/puma-stats.log')
    

## Visualizing Results

We use the Librato add-on on Heroku to make nice charts of this data. You may have noticed that the log output is already formatted for Librato, so if you're already using Librato, Puma metrics should show up automatically under Metrics.

![Puma stats in Librato](https://files.slack.com/files-pri/T0280858R-F02APTGPG/screen_shot_2014-05-29_at_5.07.16_pm.png "Puma stats in Librato")
