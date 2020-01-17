class CreateUsers < ActiveRecord::Migration[4.2]
  create_table :users do |u|
    u.string :username
    u.string :email
    u.string :password_digest
  end
end
