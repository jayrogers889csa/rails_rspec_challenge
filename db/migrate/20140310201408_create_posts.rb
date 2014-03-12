class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string   :slug
      t.string   :title
      t.text     :content
      t.boolean  :is_published, :default => false
      t.timestamps
    end
  end
end
