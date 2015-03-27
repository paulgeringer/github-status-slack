require 'time'
require 'json'
require 'slack-notifier'
require 'net/http'
require 'rufus-scheduler'

require 'github_status_slack/github_status.rb'
require 'github_status_slack/status_retriever.rb'
require "github_status_slack/version"

module GithubStatusSlack
  class Notifier
    attr_accessor :interval, :interval_method, :scheduler, :status_retriever, :slack_notifier

    def initialize( webhook_url, api_url, options={} )
      @slack_notifier = Slack::Notifier.new( webhook_url, channel: options[:channel], username: options[:username] )
      @status_retriever = GithubStatusSlack::StatusRetriever.new(api_url)
      @scheduler = Rufus::Scheduler.new
      @interval_method = options[:interval_type] || 'every'
      @interval = options[:interval] || '10s'
    end

    def notify_slack 
      slack_notifier.ping "Tracking Github status..."
      old_status = GithubStatus.new(status_retriever.request)
      msg = "#{old_status.body} Posted @ #{old_status.time}."
      slack_notifier.ping msg
      scheduler.send(interval_method.to_sym, interval) do
        current_status = GithubStatus.new(status_retriever.request)
        if current_status.time > old_status.time
          msg = "#{current_status.body} Posted @ #{current_status.time}."
          slack_notifier.ping msg
        end
        old_status = current_status.dup
      end
      scheduler.join
    end
  end

end
