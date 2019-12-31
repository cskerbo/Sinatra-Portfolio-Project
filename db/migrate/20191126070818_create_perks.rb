class CreatePerks < ActiveRecord::Migration
  def change
    create_table :perks do |e|
      e.string :name
      e.string :description
      e.string :character
      e.string :role
      e.integer :count
      e.string :raw_html
      e.integer :build_id
    end
  end
end
