class CreatePerks < ActiveRecord::Migration[6.0]
  def change
    create_table :perks do |e|
      e.string :name
      e.string :description
      e.integer :character_id
      e.integer :user_id
  end
end
