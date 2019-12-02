class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |c|
      c.string :name
      c.string :bio
      c.byte :image
      c.string :user_id
    end
  end
end
