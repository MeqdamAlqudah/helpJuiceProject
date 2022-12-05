class SearchRelayJob < ApplicationJob
  queue_as :default

  def perform(_search)
    html_data = ''
    Search.all.each do |item|
      html_data += ApplicationController.render partial: 'shared/search',
                                                locals: { search: item }, formats: [:html]
    end
    ActionCable.server.broadcast('search_channel', { html: html_data })
  end
end
