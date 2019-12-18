class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |b|
      b.string :name
      b.integer :user_id
      b.integer :character_id

    end
  end
end
