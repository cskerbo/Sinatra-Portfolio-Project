class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |c|
      c.string :name
      c.string :bio
      c.string :overview
      c.string :character_type
      c.string :build_id
    end
  end
end
