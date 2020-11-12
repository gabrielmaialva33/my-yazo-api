class CreateUsers < ActiveRecord::Migration[6.0]
  def up
    create_table :users, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      create_enum "role", %w[admin user]
      t.enum :role, as: "role", default: "user"
      t.boolean :status, default: true
      t.string :avatar, null: false, default: ""

      t.timestamps
    end
  end

  def down
    drop_table :users
    drop_enum "role"
  end
end
