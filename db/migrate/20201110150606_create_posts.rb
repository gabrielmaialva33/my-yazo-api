class CreatePosts < ActiveRecord::Migration[6.0]
  def up
    create_table :posts, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.references :user, index: true, foreign_key: true, type: "uuid"
      t.string :title
      t.string :author
      t.string :co_author, null: true
      t.string :downlaod_link, null: true
      t.text :body

      t.timestamps
    end
  end

  def down
    drop_table :posts
  end
end
