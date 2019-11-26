class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |c|
      c.string :name
      c.string :bio
      c.string :user_id
  end
end
