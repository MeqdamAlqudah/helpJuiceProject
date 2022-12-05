module SearchesHelper
  def most_searched_text
    searched_items = []
    Search.all.each do |i|
      searched_items.push({ search_text: i.search_text, search_count: i.search_count })
    end
    searched_items.sort do |a, b|
      a.search_count <=> b.search_count
    end[searched_items.length - 3, searched_items.length - 1]
  end

  def valid_img(url)
    if url
      begin
        RestClient.get(url)
      rescue StandardError => e
        return 'https://picsum.photos/536/354', e
      end
      url
    else
      'https://picsum.photos/536/354'

    end
  end
end
