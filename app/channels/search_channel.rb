class SearchChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'search_channel'
    perform
  end

  def unsubscribed; end

  private

  def perform()
    html_data = ''
    Search.all.each do |item|
      html_data += ApplicationController.render partial: 'shared/search',
                                                locals: { search: item }, formats: [:html]
    end
    ActionCable.server.broadcast('search_channel', { html: html_data })
  end
end
