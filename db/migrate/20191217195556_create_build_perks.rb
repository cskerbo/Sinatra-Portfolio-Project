class CreateBuildPerks < ActiveRecord::Migration
  def change
    create_table :build_perks do |b|
      b.string :perk_name
      b.string :build_name
      b.integer :build_id
      b.integer :perk_id
    end
  end
end
