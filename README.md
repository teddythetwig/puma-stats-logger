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

    Rails.application.middleware.use PumaStatsLogger::Middleware
   
   
##### Changing the logging destination

By default, the Puma stats are logged to standard output `$stdout`. This works great out of the box for Heroku users. You can customize this by passing an option hash:
    
    config.middleware.use PumaStatsLogger::Middleware, logger: Logger.new('destination/puma-stats.log')
    

## Visualizing Results

We use the Librato add-on on Heroku to make nice charts of this data. You may have noticed that the log output is already formatted for Librato, so if you're already using Librato, Puma metrics should show up automatically under Metrics.

![Puma stats in Librato](https://dmrxx81gnj0ct.cloudfront.net/public/Screen+Shot+2014-05-29+at+5.19.18+PM.png "Puma stats in Librato")

## Open Source by Hired

[Hired](https://hired.com/?utm_source=opensource&utm_medium=puma-stats-logger&utm_campaign=readme) is a marketplace for top engineering talent to find full-time technology jobs. Talented Ruby developers (like yourself) are in extremely high demand! On Hired, apply once and receive 5 to 15 competing job offers in one week from 800+ technology companies. Average Ruby engineer salaries on Hired are around $120,000 per year!

<a href="https://hired.com/?utm_source=opensource&utm_medium=puma-stats-logger&utm_campaign=readme-banner" target="_blank">
<img src="https://dmrxx81gnj0ct.cloudfront.net/public/hired-banner-light-1-728x90.png" alt="Hired" width="728" height="90"/>
</a>

We are Ruby developers ourselves, and we use all of our open source projects in production. We always encourge forks, pull requests, and issues. Get in touch with the Hired Engineering team at _opensource@hired.com_.

