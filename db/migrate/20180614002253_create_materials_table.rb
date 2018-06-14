class CreateMaterialsTable < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.integer :wood
      t.integer :brick
      t.integer :steel
    end
  end

  def down
    drop_table :materials
  end
end
