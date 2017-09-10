module Services

  class ApiService < BusinessService

    def get_news
      news1 = api_storage.get_news(source: 'bbc-news')
      news2 = api_storage.get_news(source: 'cnn')
      news3 = api_storage.get_news(source: 'new-york-magazine')
      news1 + news2 + news3
    end

  end

end