module GithubStatusSlack
  class GithubStatus
    attr_accessor :time, :body, :status

    def initialize(json)
      @time = Time.parse(json['created_on'])
      @body = json['body']
      @status = json['status']
    end

  end
end
