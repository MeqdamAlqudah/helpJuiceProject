class CreateSearches < ActiveRecord::Migration[7.0]
  def change
    create_table :searches do |t|
      t.text :search_text
      t.timestamps
    end
  end
end
