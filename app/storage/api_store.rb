module Storage

  class ApiStore
    def get_news(source:)
      api_client = ApiClient.new(url: ENV_PROPS['news_feed'])
      api_client.get(url: '/v1/articles', params: {source: source, sortBy: 'top', apiKey: ENV_PROPS['api_key']}) do |response|
        process_news(response)
      end
    end

    private

    def process_news(response)
      body = response.body
      if body.present?
        parsed_resp = JSON.parse(response.body)
        parsed_resp['articles']
      end
    end
  end

  class ApiClient
    def initialize(url:)
      @url = url
    end

    def get(url:, params: nil)
      response = conn.get do |req|
        req.url  url
        req.params = params
      end
      response = yield response if block_given?
      response
    end

    private

    attr_accessor :url

    def conn
      Faraday.new(url,ssl: {verify: false})
    end
  end

end