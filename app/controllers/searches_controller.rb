class SearchesController < ApplicationController
  def index
    @search_text = most_search_items
    @search_text = search_for_data if @search_text.empty?
    render :index
  end

  def create
    exist_search = Search.find_by(search_param)
    if exist_search
      exist_search.update(search_count: exist_search.search_count + 1)
      @search_text = search_for_data(exist_search.search_text || 'a')
      render :index

    else
      search = Search.new(search_param)
      @search_text = search_for_data(search.search_text || 'a')
      if iff(search)
        render :index
      else
        render json: search.errors.full_messages
      end
    end
  end

  private

  def search_param
    params.permit(:search_text)
  end

  def most_search_items
    most_searched_text = Search.all.sort { |a, b| a.search_count <=> b.search_count }
    searched_items = []
    return most_searched_text unless most_searched_text.length > 3

    most_searched_text[most_searched_text.length - 3, most_searched_text.length - 1].each do |item|
      searched_items = [*searched_items, *search_for_data(item.search_text)]
    end

    searched_items
  end

  def include_in_other_search_text(item)
    Search.all.each do |i|
      item1 = item.search_text.gsub(' ', '').downcase
      item2 = i.search_text.gsub(' ', '').downcase
      if item1.length >= item2.length
        if item1.include?(item2)
          i.update(search_text: item.search_text, search_count: i.search_count + 1)
          return true
        end
      elsif item2.include?(item1)
        i.update(search_count: i.search_count + 1)
        return true
      end
    end
    false
  end

  def iff(search)
    return 'included' if include_in_other_search_text(search)

    search.save
    'saved'
  end
end
