module GithubStatusSlack
  class SlackCommunicator
    attr_accessor :notifier
    def initialize(webhook_url)
      @notifier = Slack::Notifier.new(webhook_url, channel: '#robots', username: 'github_status')
    end
  end
end
