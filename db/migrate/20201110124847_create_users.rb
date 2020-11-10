class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.password :password
      t.enum [:admin, :user]
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
