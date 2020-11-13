class AddDataToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :status, :boolean, :default => true
    add_column :users, :avatar, :string, :null => false, :default => ""
  end
end
