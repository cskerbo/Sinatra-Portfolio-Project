class CreatePerks < ActiveRecord::Migration
  def change
    create_table :perks do |e|
      e.string :name
      e.string :description
      e.string :character
      e.integer :teachable
      e.integer :character_id
      e.integer :user_id
    end
  end
end
