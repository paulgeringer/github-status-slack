module GithubStatusSlack
  class StatusRetriever
    attr_accessor :uri, :json

    def initialize(api_url)
      @uri = URI(api_url)
    end

    def request
      response = Net::HTTP.get(uri)
      @json = JSON.parse(response)
    end

  end
end
