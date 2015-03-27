require 'time'
require 'json'
require 'slack-notifier'
require 'net/http'
require 'timers'

require 'github_status_slack/github_status.rb'
require 'github_status_slack/status_retriever.rb'
require 'github_status_slack/slack_communicator.rb'
require "github_status_slack/version"

module GithubStatusSlack
  class Notifier
    attr_accessor :interval, :timers, :status_retriever, :slack_notifier
    def initialize( webhook_url, api_url, interval=10 )
      @slack_notifier = GithubStatusSlack::SlackCommunicator.new(webhook_url).notifier
      @status_retriever = GithubStatusSlack::StatusRetriever.new(api_url)
      @timers = Timers::Group.new
      @interval = interval
    end

    def looper
      puts "hi1"
      slack_notifier.ping "Tracking Github status..."
      old_status = GithubStatus.new(status_retriever.request)
      msg = "#{old_status.body} Posted @ #{old_status.time}."
      slack_notifier.ping msg
      puts "hi2"
      timers.every(interval) do
        current_status = GithubStatus.new(status_retriever.request)
        puts "in the loop"
        if current_status.time > old_status.time
          msg = "#{current_status.body} Posted @ #{current_status.time}."
          slack_notifier.ping msg
        end
        old_status = current_status.dup
      end
      loop do
        timers.wait
      end
    end
  end

end
