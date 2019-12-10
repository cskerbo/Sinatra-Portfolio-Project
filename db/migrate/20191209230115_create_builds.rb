class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |b|
      b.string :character_id
      b.string :perk_id
      b.string :User_id
    end
  end
end
