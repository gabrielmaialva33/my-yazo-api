class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|

      t.string :title
      t.string :author
      t.string :co_author, null: true
      t.string :downlaod_link, null: true
      t.text :body

      t.timestamps
    end
  end
end
