class ApplicationController < ActionController::Base
  def search_for_data(item = 'a')
    url = "https://newsapi.org/v2/everything?q=\"#{item}\"&apiKey=e172dc71056c4c6b99c8237d71458a40"
    begin
      JSON.parse(RestClient.get(url).body)['articles']
    rescue RestClient::TooManyRequests
      []
    end
  end
end
