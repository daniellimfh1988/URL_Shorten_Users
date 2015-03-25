class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.integer  :user_id
      t.string  :long_url
      t.string  :short_url
      t.integer :click_count
      t.timestamp null: false
    end
  end
end
