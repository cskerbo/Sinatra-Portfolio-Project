class CreatePerks < ActiveRecord::Migration
  def change
    create_table :perks do |e|
      e.string :name
      e.string :description
      e.string :role
      e.integer :count
      e.integer :build_id
    end
  end
end
