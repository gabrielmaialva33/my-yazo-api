class CreateComments < ActiveRecord::Migration[6.0]
  def up
    create_table :comments, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.references :user, type: "uuid", foreign_key: true
      t.references :post, type: "uuid", foreign_key: true
      t.text :message
      t.integer :rate, null: true
      t.timestamps
    end
  end

  def down
    drop_table :comments
  end
end
