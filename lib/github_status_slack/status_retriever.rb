module GithubStatusSlack
  class StatusRetriever
    attr_accessor :uri, :json

    def initialize(api_url)
      @uri = URI(api_url)
    end

    def request
      begin
        response = Net::HTTP.get(uri)
      rescue Errno::ETIMEDOUT => e
        puts "Couldn't hit the status page."
        puts "Retrying..."
        retry
      end
      @json = JSON.parse(response)
    end

  end
end
