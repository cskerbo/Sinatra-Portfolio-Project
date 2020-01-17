class CreateBuilds < ActiveRecord::Migration[4.2]
  def change
    create_table :builds do |b|
      b.string :name
      b.integer :user_id
      b.integer :character_id
      b.string :build_type
    end
  end
end
