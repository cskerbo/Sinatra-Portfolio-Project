class CreatePerks < ActiveRecord::Migration
  def change
    create_table :perks do |e|
      e.string :name
      e.string :description
      e.string :perk_owner
      e.string :role
      e.string :character_id
      e.integer :teachable
      e.integer :user_id
    end
  end
end
