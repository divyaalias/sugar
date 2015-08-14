class CreateDiabetics < ActiveRecord::Migration
  def change
    create_table :diabetics do |t|
      t.integer :user_id
      t.integer :blood_level
      t.timestamps
    end
  end
end
