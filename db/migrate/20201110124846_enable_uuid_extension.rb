class EnableUuidExtension < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'uuid-ossp'
    enable_extension 'pgcrypto' unless extension_enabled?('uuid-ossp')
  end
end
