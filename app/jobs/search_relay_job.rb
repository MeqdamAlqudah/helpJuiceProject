class SearchRelayJob < ApplicationJob
  queue_as :default

  def perform(_search)
    html_data = ''
    most_search_items.each do |item|
      html_data += ApplicationController.render partial: 'shared/search',
                                                locals: { search: item }, formats: [:html]
    end
    ActionCable.server.broadcast('search_channel', { html: html_data })
  end

  def most_search_items
    most_searched_text = Search.all.sort { |a, b| a.search_count <=> b.search_count }
    searched_items = []
    return most_searched_text unless most_searched_text.length > 3

    most_searched_text[most_searched_text.length - 3, most_searched_text.length - 1].each do |item|
      searched_items.push(item.search_text)
    end

    searched_items.reverse
  end
end
